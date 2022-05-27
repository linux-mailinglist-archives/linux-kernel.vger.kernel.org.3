Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A425366CE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 20:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353638AbiE0SAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 14:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236195AbiE0SA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 14:00:26 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3453550B12
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 11:00:24 -0700 (PDT)
Date:   Fri, 27 May 2022 11:00:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653674423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AaaAMzLpeI48jX20qadDEE94Y5QgilfKbSZgSl/Mg04=;
        b=WgGWiCdDkR17PNNmWrPNLcWUAjlERKTL2FiPPNCewH8GcKY1d+hbVdm9ms+2QpSeBpMc0g
        ge7HpZJh3TJcC8qK66q1oOVlCFXgohOpE7nPzpF1akuVaUy7K4YL7zkq0k1FGeFxnADG0F
        lJlhCW/iDMNlWLI1Qu/vGjc395PNvyw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Dave Chinner <dchinner@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v4 3/6] mm: shrinkers: provide shrinkers with names
Message-ID: <YpERsTsgjlGYEnDv@carbon>
References: <20220525202600.2910982-1-roman.gushchin@linux.dev>
 <20220525202600.2910982-4-roman.gushchin@linux.dev>
 <YpCaOmL2NfcLEAHi@rh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpCaOmL2NfcLEAHi@rh>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 07:30:34PM +1000, Dave Chinner wrote:
> On Wed, May 25, 2022 at 01:25:57PM -0700, Roman Gushchin wrote:
> > Currently shrinkers are anonymous objects. For debugging purposes they
> > can be identified by count/scan function names, but it's not always
> > useful: e.g. for superblock's shrinkers it's nice to have at least
> > an idea of to which superblock the shrinker belongs.
> > 
> > This commit adds names to shrinkers. register_shrinker() and
> > prealloc_shrinker() functions are extended to take a format and
> > arguments to master a name.
> > 
> > In some cases it's not possible to determine a good name at the time
> > when a shrinker is allocated. For such cases shrinker_debugfs_rename()
> > is provided.
> > 
> > After this change the shrinker debugfs directory looks like:
> >   $ cd /sys/kernel/debug/shrinker/
> >   $ ls
> >     dqcache-16          sb-hugetlbfs-17  sb-rootfs-2      sb-tmpfs-49
> >     kfree_rcu-0         sb-hugetlbfs-33  sb-securityfs-6  sb-tracefs-13
> >     sb-aio-20           sb-iomem-12      sb-selinuxfs-22  sb-xfs:vda1-36
> >     sb-anon_inodefs-15  sb-mqueue-21     sb-sockfs-8      sb-zsmalloc-19
> >     sb-bdev-3           sb-nsfs-4        sb-sysfs-26      shadow-18
> >     sb-bpf-32           sb-pipefs-14     sb-tmpfs-1       thp_deferred_split-10
> >     sb-btrfs:vda2-24    sb-proc-25       sb-tmpfs-27      thp_zero-9
> >     sb-cgroup2-30       sb-proc-39       sb-tmpfs-29      xfs_buf-vda1-37
> >     sb-configfs-23      sb-proc-41       sb-tmpfs-35      xfs_inodegc-vda1-38
> 
> sb-xfs:vda1-36
> xfs_buf-vda1-37
> xfs_inodegc-vda1-38
> 
> That's a parsing nightmare right there. Please use the same format
> for everything. You have <subsystem>-<type>:<instance>-<id> for
> superblock stuff, but <subsys>_<type>-<instance>-<id> for the XFS
> stuff. Make it consistent so we aren't reduced to pulling out our
> hair trying to parse this in any useful way:
> 
> sb-xfs:vda1-36
> xfs-buf:vda1-37
> xfs-inodegc:vda1-38

Ok, good point, will do in the next version.

> 
> FWIW, how we are supposed to know what actually owns these:
> 
> sb-tmpfs-1
> sb-tmpfs-27
> sb-tmpfs-29
> sb-tmpfs-35
> sb-tmpfs-49
> 
> tmpfs-27 might own all the memory - how do we link that back to a
> mount point, container, user, workload, etc?

I agree, but I've no good idea what to use as an id. We can't put the mount
point, user, group etc together in the file name - it will be too lengthy
(and mount namespaces are making it even more complicated).

Maybe we can add a symlink to the mount point from within the directory?

Do you have any ideas here?

Thanks!
