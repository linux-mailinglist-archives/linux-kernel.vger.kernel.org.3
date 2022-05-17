Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58C7529DB5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244968AbiEQJQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244480AbiEQJPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:15:11 -0400
Received: from out199-9.us.a.mail.aliyun.com (out199-9.us.a.mail.aliyun.com [47.90.199.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498B437A0D;
        Tue, 17 May 2022 02:15:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VDTPyuR_1652778903;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VDTPyuR_1652778903)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 17 May 2022 17:15:05 +0800
Date:   Tue, 17 May 2022 17:15:02 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Chao Yu <chao@kernel.org>, xiang@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Chao Yu <chao.yu@oppo.com>, fsdevel@vger.kernel.org
Subject: Re: [PATCH] erofs: support idmapped mounts
Message-ID: <YoNnlpGBFm7dh6yD@B-P7TQMD6M-0146.local>
References: <20220517073210.3569589-1-chao@kernel.org>
 <20220517090622.4wrtrjmzknh66bci@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220517090622.4wrtrjmzknh66bci@wittgenstein>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On Tue, May 17, 2022 at 11:06:22AM +0200, Christian Brauner wrote:
> On Tue, May 17, 2022 at 03:32:10PM +0800, Chao Yu wrote:
> > This patch enables idmapped mounts for erofs, since all dedicated helpers
> > for this functionality existsm, so, in this patch we just pass down the
> > user_namespace argument from the VFS methods to the relevant helpers.
> > 
> > Simple idmap example on erofs image:
> > 
> > 1. mkdir dir
> > 2. touch dir/file
> > 3. mkfs.erofs erofs.img dir
> > 4. mount -t erofs -o loop erofs.img  /mnt/erofs/
> > 
> > 5. ls -ln /mnt/erofs/
> > total 0
> > -rw-rw-r-- 1 1000 1000 0 May 17 15:26 file
> > 
> > 6. mount-idmapped --map-mount b:0:1001:1 /mnt/erofs/ /mnt/scratch_erofs/
> > 
> > 7. ls -ln /mnt/scratch_erofs/
> > total 0
> > -rw-rw-r-- 1 65534 65534 0 May 17 15:26 file
> 
> Your current example maps id 0 in the filesystem to id 1001 in the
> mount. But since no files with id 0 exist in the filesystem you're
> illustrating that unmapped ids are correctly reported as overflow{g,u}id.
> 
> I think what you'd rather want to show is something like this:
> 
> 5. ls -ln /mnt/erofs/
> total 0
> -rw-rw-r-- 1 1000 1000 0 May 17 15:26 file
> 
> 6. mount-idmapped --map-mount b:1000:1001:1 /mnt/erofs/ /mnt/scratch_erofs/
> 
> 7. ls -ln /mnt/scratch_erofs/
> total 0
> -rw-rw-r-- 1 1001 1001 0 May 17 15:26 file
> 
> where id 1000 in the filesystem maps to id 1001 in the mount.
> 
> > 
> > Signed-off-by: Chao Yu <chao.yu@oppo.com>
> > ---
> 
> Overall this is currently the smallest patch to support idmapped mounts.
> 
> Is erofs integrated with xfstests in any way?
> For read-only filesystems we probably only need to verify that {g,u}id
> are correctly reported. All the writable aspects are irrelevant.

Currently most generic xfstests test cases are unsuitable for erofs.

Instead we have regression testcases for EROFS specific since it needs
to generate images with care,
 https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/log/?h=experimental-tests

Also we have an erofsstress to do long time random stress workloads,
https://github.com/erofs/erofsstress

But yeah, it's some awkward that fstests idmapped mount testcases may
be unsuitable for EROFS for now. I will add some new testcases to build
images and test for this behavior.

> 
> Looks good,
> Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Thanks for your review!

Thanks,
Gao Xiang

> 
> >  fs/erofs/inode.c | 2 +-
> >  fs/erofs/super.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> > index e8b37ba5e9ad..5320bf52c1ce 100644
> > --- a/fs/erofs/inode.c
> > +++ b/fs/erofs/inode.c
> > @@ -370,7 +370,7 @@ int erofs_getattr(struct user_namespace *mnt_userns, const struct path *path,
> >  	stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
> >  				  STATX_ATTR_IMMUTABLE);
> >  
> > -	generic_fillattr(&init_user_ns, inode, stat);
> > +	generic_fillattr(mnt_userns, inode, stat);
> >  	return 0;
> >  }
> >  
> > diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> > index 0c4b41130c2f..7dc5f2e8ddee 100644
> > --- a/fs/erofs/super.c
> > +++ b/fs/erofs/super.c
> > @@ -781,7 +781,7 @@ static struct file_system_type erofs_fs_type = {
> >  	.name           = "erofs",
> >  	.init_fs_context = erofs_init_fs_context,
> >  	.kill_sb        = erofs_kill_sb,
> > -	.fs_flags       = FS_REQUIRES_DEV,
> > +	.fs_flags       = FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
> >  };
> >  MODULE_ALIAS_FS("erofs");
> >  
> > -- 
> > 2.25.1
> > 
