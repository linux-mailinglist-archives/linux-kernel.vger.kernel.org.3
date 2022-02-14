Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4462B4B5E11
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 00:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiBNXNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 18:13:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiBNXNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 18:13:07 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E5116C4E6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644880377; x=1676416377;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hleKJXrUDhmmOrMMCvBDlVg74DPqUhOtXuvUOdPHjK0=;
  b=HqJ3k34e3QvV1IJ/eRcLJh2mGgw36BEcF8tv8oZtnw87xzOYbqqjy4u/
   J6wKRV9rW5GHcE+0eUxfP4EbbVyir4kK/bb1EHGySqp+JdxyoRfr3qPRH
   clUO8Bi/i92t83nfsxvXBy5T6opL/n9To4FtIFL4Ed2ONcI05Xax/Q/cl
   JiwLXEkgiOckyD6vHtK73RZv3/lqWAKlknQv70+xVG5frnKDqcS2pAVHs
   gdLFakVQYmE7580CjJ6xt4ZsauEi2SQsRiKIXqLbdXvdbdU8ohtG5Bmk8
   qjpLaUBqIV0SrZUvmvoZnYf2ZsKntf6maOYmkETDN7J1uHZY7MlP34ABU
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="230843424"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="230843424"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 15:12:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="680755418"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 15:12:56 -0800
Date:   Mon, 14 Feb 2022 15:12:56 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Tong Zhang <ztong0001@gmail.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dax: make sure inodes are flushed before destroy cache
Message-ID: <20220214231256.GX785175@iweiny-DESK2.sc.intel.com>
Mail-Followup-To: Dan Williams <dan.j.williams@intel.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220212071111.148575-1-ztong0001@gmail.com>
 <20220214175905.GV785175@iweiny-DESK2.sc.intel.com>
 <CAPcyv4jrh5Xr3AnOj-YrOr3i4HTm=wVBuaQ1VBAxCoszHjHdfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jrh5Xr3AnOj-YrOr3i4HTm=wVBuaQ1VBAxCoszHjHdfA@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 12:09:54PM -0800, Dan Williams wrote:
> On Mon, Feb 14, 2022 at 9:59 AM Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > On Fri, Feb 11, 2022 at 11:11:11PM -0800, Tong Zhang wrote:
> > > A bug can be triggered by following command
> > >
> > > $ modprobe nd_pmem && modprobe -r nd_pmem
> > >
> > > [   10.060014] BUG dax_cache (Not tainted): Objects remaining in dax_cache on __kmem_cache_shutdown()
> > > [   10.060938] Slab 0x0000000085b729ac objects=9 used=1 fp=0x000000004f5ae469 flags=0x200000000010200(slab|head|node)
> > > [   10.062433] Call Trace:
> > > [   10.062673]  dump_stack_lvl+0x34/0x44
> > > [   10.062865]  slab_err+0x90/0xd0
> > > [   10.063619]  __kmem_cache_shutdown+0x13b/0x2f0
> > > [   10.063848]  kmem_cache_destroy+0x4a/0x110
> > > [   10.064058]  __x64_sys_delete_module+0x265/0x300
> > >
> > > This is caused by dax_fs_exit() not flushing inodes before destroy cache.
> > > To fix this issue, call rcu_barrier() before destroy cache.
> >
> > I don't doubt that this fixes the bug.  However, I can't help but think this is
> > hiding a bug, or perhaps a missing step, in the kmem_cache layer?  As far as I
> > can see dax does not call call_rcu() and only uses srcu not rcu?  I was tempted
> > to suggest srcu_barrier() but dax does not call call_srcu() either.
> 
> This rcu_barrier() is associated with the call_rcu() in destroy_inode().

Ok yea.

> 
> While kern_unmount() does a full sycnrhonize_rcu() after clearing
> ->mnt_ns. Any pending destroy_inode() callbacks need to be flushed
> before the kmem_cache is destroyed.
> 
> > So I'm not clear about what is really going on and why this fixes it.  I know
> > that dax is not using srcu is a standard way so perhaps this helps in a way I
> > don't quite grok?  If so perhaps a comment here would be in order?
> 
> Looks like a common pattern I missed that all filesystem exit paths implement.

I think a comment would be in order, especially since since it looks like every
other FS has one:

fs/ext4/super.c:

...
        /*
         * Make sure all delayed rcu free inodes are flushed before we
         * destroy cache.
         */
        rcu_barrier();  
...

Anyway ok.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Thanks for looking Dan,
Ira
