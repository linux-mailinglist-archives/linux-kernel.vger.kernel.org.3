Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7013F5320EC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbiEXCX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiEXCX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:23:56 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A7D880FE
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:23:55 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id h186so15176610pgc.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=imqsWHcVz1x3U/e/rDDis/IuDhHm/2O5Z9DNKRPykt4=;
        b=WyOkLilJunDPIRLV5CIPabmtUHndgCWzDzEUkYf/sX0mQMP2sA8hnmBRgH0S0FP1lW
         0XJHqEHz2N4A6fSbzdea1rYKd3/h4soHXWGQrSgAOJknDMRly7t5vccn1Oy4gKb7BjED
         06cEJtl6Yw8bzS2QhE1iHzt7hQrYM5+h3JABKH1szxPjCmAdMRaNiggNt/a9/BvGplZh
         DtnZ2/mMoTpI3P08ZnUsBNm94nQaHXDRS5WC6LqUtjljHF1OpHJM6lD9s/2C+ADqZG+o
         asoX2IhGQhY5P6HffdkamMxmuRY/BgTIjUbDhiFlDdxrVbVjKyIzrh2e5VslEMuOKDa4
         EIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=imqsWHcVz1x3U/e/rDDis/IuDhHm/2O5Z9DNKRPykt4=;
        b=GYXDUmXxsyScvWowgfRLi3DBsoVZdFByqrKWrMQ0jeQhMqTMbnGGg2My3cPd0cFhBq
         kFp0uwVucxyu0U9I6fYq6oTPyN1u2Sv7XgDqRyTflazCwBS1jAzyXxdV8ROZiUTezchS
         ddU3EWa+hygaQA9ALq2swxfo2uW430oNOVia7XsSejdLs2Zw1I5o1U4Z7D9UXWNnPM5j
         8dcp/yMLfPwhBT585rlHrKDh2HWe5nSN/8JX8VAoMZhB7Ty7k66kzdbycKY68KGJg1Ym
         Y4Anaimdt7HoyalCx4w2pj/Z4xmSd5X2JkCH66tMPVQG7VD2D5/J2Z3km5kh2wQw3rqU
         mK6w==
X-Gm-Message-State: AOAM531lgtXWlfXGHSdCN291WwpWJeYKrCe2bwiUBksxU0OpEC/Owm2+
        x92gB9bRzfKBQc7SBJmsvKgN6g==
X-Google-Smtp-Source: ABdhPJxy+TLffbrAi+1PuvGcI7Kr5+KjaHgQ9Bi5SLdLKCC4xZs4IXaazkcagw41+iZkQjgy0EtPZQ==
X-Received: by 2002:a63:c10:0:b0:3da:fb56:648d with SMTP id b16-20020a630c10000000b003dafb56648dmr22365773pgl.590.1653359035312;
        Mon, 23 May 2022 19:23:55 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:f940:af17:c2f5:8656])
        by smtp.gmail.com with ESMTPSA id be11-20020a056a001f0b00b00518764d09cdsm6767281pfb.164.2022.05.23.19.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 19:23:55 -0700 (PDT)
Date:   Tue, 24 May 2022 10:23:50 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v3 6/6] mm: shrinkers: add scan interface for shrinker
 debugfs
Message-ID: <YoxBtp8ZCeobyGFb@FVFYT0MHHV2J.googleapis.com>
References: <20220509183820.573666-1-roman.gushchin@linux.dev>
 <20220509183820.573666-7-roman.gushchin@linux.dev>
 <YoogHykrHEdJpqta@FVFYT0MHHV2J.usts.net>
 <Yov0gNdi0+Q3UY2E@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yov0gNdi0+Q3UY2E@carbon>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 01:54:24PM -0700, Roman Gushchin wrote:
> On Sun, May 22, 2022 at 07:35:59PM +0800, Muchun Song wrote:
> > On Mon, May 09, 2022 at 11:38:20AM -0700, Roman Gushchin wrote:
> > > Add a scan interface which allows to trigger scanning of a particular
> > > shrinker and specify memcg and numa node. It's useful for testing,
> > > debugging and profiling of a specific scan_objects() callback.
> > > Unlike alternatives (creating a real memory pressure and dropping
> > > caches via /proc/sys/vm/drop_caches) this interface allows to interact
> > > with only one shrinker at once. Also, if a shrinker is misreporting
> > > the number of objects (as some do), it doesn't affect scanning.
> > > 
> > > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > > ---
> > >  .../admin-guide/mm/shrinker_debugfs.rst       | 39 +++++++++-
> > >  mm/shrinker_debug.c                           | 73 +++++++++++++++++++
> > >  2 files changed, 108 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/Documentation/admin-guide/mm/shrinker_debugfs.rst b/Documentation/admin-guide/mm/shrinker_debugfs.rst
> > > index 6783f8190e63..8fecf81d60ee 100644
> > > --- a/Documentation/admin-guide/mm/shrinker_debugfs.rst
> > > +++ b/Documentation/admin-guide/mm/shrinker_debugfs.rst
> > > @@ -5,14 +5,16 @@ Shrinker Debugfs Interface
> > >  ==========================
> > >  
> > >  Shrinker debugfs interface provides a visibility into the kernel memory
> > > -shrinkers subsystem and allows to get information about individual shrinkers.
> > > +shrinkers subsystem and allows to get information about individual shrinkers
> > > +and interact with them.
> > >  
> > >  For each shrinker registered in the system a directory in **<debugfs>/shrinker/**
> > >  is created. The directory's name is composed from the shrinker's name and an
> > >  unique id: e.g. *kfree_rcu-0* or *sb-xfs:vda1-36*.
> > >  
> > > -Each shrinker directory contains the **count** file, which allows to trigger
> > > -the *count_objects()* callback for each memcg and numa node (if applicable).
> > > +Each shrinker directory contains **count** and **scan** files, which allow to
> > > +trigger *count_objects()* and *scan_objects()* callbacks for each memcg and
> > > +numa node (if applicable).
> > >  
> > >  Usage:
> > >  ------
> > > @@ -43,7 +45,7 @@ Usage:
> > >  
> > >      $ cd sb-btrfs\:vda2-24/
> > >      $ ls
> > > -    count
> > > +    count            scan
> > >  
> > >  3. *Count objects*
> > >  
> > > @@ -98,3 +100,32 @@ Usage:
> > >      2877 84 0
> > >      293 1 0
> > >      735 8 0
> > > +
> > > +4. *Scan objects*
> > > +
> > > +  The expected input format::
> > > +
> > > +    <cgroup inode id> <numa id> <number of objects to scan>
> > > +
> > > +  For a non-memcg-aware shrinker or on a system with no memory
> > > +  cgrups **0** should be passed as cgroup id.
> > > +  ::
> > > +
> > > +    $ cd /sys/kernel/debug/shrinker/
> > > +    $ cd sb-btrfs\:vda2-24/
> > > +
> > > +    $ cat count | head -n 5
> > > +    1 212 0
> > > +    21 97 0
> > > +    55 802 5
> > > +    2367 2 0
> > > +    225 13 0
> > > +
> > > +    $ echo "55 0 200" > scan
> > > +
> > > +    $ cat count | head -n 5
> > > +    1 212 0
> > > +    21 96 0
> > > +    55 752 5
> > > +    2367 2 0
> > > +    225 13 0
> > > diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
> > > index 28b1c1ab60ef..8f67fef5a643 100644
> > > --- a/mm/shrinker_debug.c
> > > +++ b/mm/shrinker_debug.c
> > > @@ -101,6 +101,77 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
> > >  }
> > >  DEFINE_SHOW_ATTRIBUTE(shrinker_debugfs_count);
> > >  
> > > +static int shrinker_debugfs_scan_open(struct inode *inode, struct file *file)
> > > +{
> > > +	file->private_data = inode->i_private;
> > > +	return nonseekable_open(inode, file);
> > > +}
> > > +
> > > +static ssize_t shrinker_debugfs_scan_write(struct file *file,
> > > +					   const char __user *buf,
> > > +					   size_t size, loff_t *pos)
> > > +{
> > > +	struct shrinker *shrinker = (struct shrinker *)file->private_data;
> > 
> > Seems we could drop the cast since ->private_data is void * type.
> 
> Yep, fixed. Thanks!
> 
> > 
> > > +	unsigned long nr_to_scan = 0, ino;
> > > +	struct shrink_control sc = {
> > > +		.gfp_mask = GFP_KERNEL,
> > > +	};
> > > +	struct mem_cgroup *memcg = NULL;
> > > +	int nid;
> > > +	char kbuf[72];
> > > +	int read_len = size < (sizeof(kbuf) - 1) ? size : (sizeof(kbuf) - 1);
> > > +	ssize_t ret;
> > > +
> > > +	if (copy_from_user(kbuf, buf, read_len))
> > > +		return -EFAULT;
> > > +	kbuf[read_len] = '\0';
> > > +
> > > +	if (sscanf(kbuf, "%lu %d %lu", &ino, &nid, &nr_to_scan) < 2)
> > > +		return -EINVAL;
> > > +
> > > +	if (nid < 0 || nid >= nr_node_ids)
> > > +		return -EINVAL;
> > > +
> > 
> > Should we break here if nr_to_scan is zero?
> 
> Not a very likely scenario, but ok.
>

Agree.
 
> > 
> > > +	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
> > > +		memcg = mem_cgroup_get_from_ino(ino);
> > > +		if (!memcg || IS_ERR(memcg))
> > 
> > Should we drop the check of "!memcg" since mem_cgroup_get_from_ino
> > cannot return NULL?
> 
> It can if !CONFIG_MEMCG. You might argue that then shrinker can not have
> the SHRINKER_MEMCG_AWARE flag, but since it's not a hot path at all,
> I'll keep it for extra safety.
>

Make sense.

> > 
> > > +			return -ENOENT;
> > > +
> > > +		if (!mem_cgroup_online(memcg)) {
> > > +			mem_cgroup_put(memcg);
> > > +			return -ENOENT;
> > > +		}
> > > +	} else {
> > > +		if (ino != 0)
> > > +			return -EINVAL;
> > > +		memcg = NULL;
> > 
> > IIUC, memcg is already NULL if we reach here, right?  Then the
> > assignment is not necessary.  Or we cound remove the initialization
> > of 'memcg' where it is definned.
> 
> Right, removed.
> 
> > 
> > > +	}
> > > +
> > > +	ret = down_read_killable(&shrinker_rwsem);
> > > +	if (ret) {
> > > +		mem_cgroup_put(memcg);
> > > +		return ret;
> > > +	}
> > > +
> > > +	sc.nid = nid;
> > > +	sc.memcg = memcg;
> > > +	sc.nr_to_scan = nr_to_scan;
> > > +	sc.nr_scanned = nr_to_scan;
> > > +
> > > +	shrinker->scan_objects(shrinker, &sc);
> > > +
> > > +	up_read(&shrinker_rwsem);
> > > +	mem_cgroup_put(memcg);
> > > +
> > > +	return ret ? ret : size;
> > 
> > Seems "ret" is always equal to 0 here, should we simplify this
> > to "return size"?
> 
> Right.
> 
> Thank you for the review!
>

My pleasure.

Thanks.
