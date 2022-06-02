Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AFA53B136
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 03:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbiFBA4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 20:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbiFBA4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 20:56:31 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3695DBD8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 17:56:30 -0700 (PDT)
Date:   Wed, 1 Jun 2022 17:56:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654131388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i79wvp76OiIYOLKqDZYcYc/T0i24O+GSaS7sm2OWB/M=;
        b=j+JPBgvBaaua+vNMCMdMZ5X5XzVSRgaR1RnIcwwmw1AM0EleT8pcqSL08DSE9KmBsol2jC
        Vr8KGXftfDKjqOqnj9iuJ1s9LCU81KWFl1Bq+v/+O7w+jpnU14vepNwKb/P7SLZtbzcLa4
        Qyd/l01y+H1vMUJxycE+HJyWkPkC+dU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v5 6/6] mm: shrinkers: add scan interface for shrinker
 debugfs
Message-ID: <YpgKttTowT22mKPQ@carbon>
References: <20220601032227.4076670-1-roman.gushchin@linux.dev>
 <20220601032227.4076670-7-roman.gushchin@linux.dev>
 <20220601142351.5e04fea5586ca51898d8785f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601142351.5e04fea5586ca51898d8785f@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 02:23:51PM -0700, Andrew Morton wrote:
> On Tue, 31 May 2022 20:22:27 -0700 Roman Gushchin <roman.gushchin@linux.dev> wrote:
> 
> > Add a scan interface which allows to trigger scanning of a particular
> > shrinker and specify memcg and numa node. It's useful for testing,
> > debugging and profiling of a specific scan_objects() callback.
> > Unlike alternatives (creating a real memory pressure and dropping
> > caches via /proc/sys/vm/drop_caches) this interface allows to interact
> > with only one shrinker at once. Also, if a shrinker is misreporting
> > the number of objects (as some do), it doesn't affect scanning.
> > 
> > ..
> >
> > --- a/mm/shrinker_debug.c
> > +++ b/mm/shrinker_debug.c
> > @@ -99,6 +99,78 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
> >  }
> >  DEFINE_SHOW_ATTRIBUTE(shrinker_debugfs_count);
> >  
> > +static int shrinker_debugfs_scan_open(struct inode *inode, struct file *file)
> > +{
> > +	file->private_data = inode->i_private;
> > +	return nonseekable_open(inode, file);
> > +}
> > +
> > +static ssize_t shrinker_debugfs_scan_write(struct file *file,
> > +					   const char __user *buf,
> > +					   size_t size, loff_t *pos)
> > +{
> > +	struct shrinker *shrinker = file->private_data;
> > +	unsigned long nr_to_scan = 0, ino;
> > +	struct shrink_control sc = {
> > +		.gfp_mask = GFP_KERNEL,
> > +	};
> > +	struct mem_cgroup *memcg = NULL;
> > +	int nid;
> > +	char kbuf[72];
> > +	int read_len = size < (sizeof(kbuf) - 1) ? size : (sizeof(kbuf) - 1);
> 
> size_t or ulong would be more appropriate.

I agree.

> 
> > +	ssize_t ret;
> > +
> > +	if (copy_from_user(kbuf, buf, read_len))
> > +		return -EFAULT;
> > +	kbuf[read_len] = '\0';
> > +
> > +	if (sscanf(kbuf, "%lu %d %lu", &ino, &nid, &nr_to_scan) < 2)
> 
> Was it intentional to permit more than three args?

Good catch! No, of course it wasn't intentional.

Below is an updated version of this patch.

Thank you for taking a look!

--

From b8f0b0fd5bcbc907dfedf2609743713ba8093e31 Mon Sep 17 00:00:00 2001
From: Roman Gushchin <roman.gushchin@linux.dev>
Date: Fri, 6 May 2022 11:40:36 -0700
Subject: [PATCH v5 6/6] mm: shrinkers: add scan interface for shrinker debugfs

Add a scan interface which allows to trigger scanning of a particular
shrinker and specify memcg and numa node. It's useful for testing,
debugging and profiling of a specific scan_objects() callback.
Unlike alternatives (creating a real memory pressure and dropping
caches via /proc/sys/vm/drop_caches) this interface allows to interact
with only one shrinker at once. Also, if a shrinker is misreporting
the number of objects (as some do), it doesn't affect scanning.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Muchun Song <songmuchun@bytedance.com>
---
 .../admin-guide/mm/shrinker_debugfs.rst       | 39 +++++++++-
 mm/shrinker_debug.c                           | 74 +++++++++++++++++++
 2 files changed, 109 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/shrinker_debugfs.rst b/Documentation/admin-guide/mm/shrinker_debugfs.rst
index 1e0e5bdb8179..3887f0b294fe 100644
--- a/Documentation/admin-guide/mm/shrinker_debugfs.rst
+++ b/Documentation/admin-guide/mm/shrinker_debugfs.rst
@@ -5,14 +5,16 @@ Shrinker Debugfs Interface
 ==========================
 
 Shrinker debugfs interface provides a visibility into the kernel memory
-shrinkers subsystem and allows to get information about individual shrinkers.
+shrinkers subsystem and allows to get information about individual shrinkers
+and interact with them.
 
 For each shrinker registered in the system a directory in **<debugfs>/shrinker/**
 is created. The directory's name is composed from the shrinker's name and an
 unique id: e.g. *kfree_rcu-0* or *sb-xfs:vda1-36*.
 
-Each shrinker directory contains the **count** file, which allows to trigger
-the *count_objects()* callback for each memcg and numa node (if applicable).
+Each shrinker directory contains **count** and **scan** files, which allow to
+trigger *count_objects()* and *scan_objects()* callbacks for each memcg and
+numa node (if applicable).
 
 Usage:
 ------
@@ -43,7 +45,7 @@ Usage:
 
     $ cd sb-btrfs\:vda2-24/
     $ ls
-    count
+    count            scan
 
 3. *Count objects*
 
@@ -102,3 +104,32 @@ Usage:
     2877 84 0
     293 1 0
     735 8 0
+
+4. *Scan objects*
+
+  The expected input format::
+
+    <cgroup inode id> <numa id> <number of objects to scan>
+
+  For a non-memcg-aware shrinker or on a system with no memory
+  cgrups **0** should be passed as cgroup id.
+  ::
+
+    $ cd /sys/kernel/debug/shrinker/
+    $ cd sb-btrfs\:vda2-24/
+
+    $ cat count | head -n 5
+    1 212 0
+    21 97 0
+    55 802 5
+    2367 2 0
+    225 13 0
+
+    $ echo "55 0 200" > scan
+
+    $ cat count | head -n 5
+    1 212 0
+    21 96 0
+    55 752 5
+    2367 2 0
+    225 13 0
diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 781ecbd3d608..12026472daae 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -99,6 +99,78 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(shrinker_debugfs_count);
 
+static int shrinker_debugfs_scan_open(struct inode *inode, struct file *file)
+{
+	file->private_data = inode->i_private;
+	return nonseekable_open(inode, file);
+}
+
+static ssize_t shrinker_debugfs_scan_write(struct file *file,
+					   const char __user *buf,
+					   size_t size, loff_t *pos)
+{
+	struct shrinker *shrinker = file->private_data;
+	unsigned long nr_to_scan = 0, ino, read_len;
+	struct shrink_control sc = {
+		.gfp_mask = GFP_KERNEL,
+	};
+	struct mem_cgroup *memcg = NULL;
+	int nid;
+	char kbuf[72];
+	ssize_t ret;
+
+	read_len = size < (sizeof(kbuf) - 1) ? size : (sizeof(kbuf) - 1);
+	if (copy_from_user(kbuf, buf, read_len))
+		return -EFAULT;
+	kbuf[read_len] = '\0';
+
+	if (sscanf(kbuf, "%lu %d %lu", &ino, &nid, &nr_to_scan) != 2)
+		return -EINVAL;
+
+	if (nid < 0 || nid >= nr_node_ids)
+		return -EINVAL;
+
+	if (nr_to_scan == 0)
+		return size;
+
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
+		memcg = mem_cgroup_get_from_ino(ino);
+		if (!memcg || IS_ERR(memcg))
+			return -ENOENT;
+
+		if (!mem_cgroup_online(memcg)) {
+			mem_cgroup_put(memcg);
+			return -ENOENT;
+		}
+	} else if (ino != 0) {
+		return -EINVAL;
+	}
+
+	ret = down_read_killable(&shrinker_rwsem);
+	if (ret) {
+		mem_cgroup_put(memcg);
+		return ret;
+	}
+
+	sc.nid = nid;
+	sc.memcg = memcg;
+	sc.nr_to_scan = nr_to_scan;
+	sc.nr_scanned = nr_to_scan;
+
+	shrinker->scan_objects(shrinker, &sc);
+
+	up_read(&shrinker_rwsem);
+	mem_cgroup_put(memcg);
+
+	return size;
+}
+
+static const struct file_operations shrinker_debugfs_scan_fops = {
+	.owner	 = THIS_MODULE,
+	.open	 = shrinker_debugfs_scan_open,
+	.write	 = shrinker_debugfs_scan_write,
+};
+
 int shrinker_debugfs_add(struct shrinker *shrinker)
 {
 	struct dentry *entry;
@@ -128,6 +200,8 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
 
 	debugfs_create_file("count", 0220, entry, shrinker,
 			    &shrinker_debugfs_count_fops);
+	debugfs_create_file("scan", 0440, entry, shrinker,
+			    &shrinker_debugfs_scan_fops);
 	return 0;
 }
 
-- 
2.35.3

