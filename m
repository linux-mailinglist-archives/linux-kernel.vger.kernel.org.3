Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627ED4D99BB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347652AbiCOK5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242648AbiCOK5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:57:09 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4C96550
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 03:55:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V7HTLPm_1647341751;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V7HTLPm_1647341751)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Mar 2022 18:55:53 +0800
Date:   Tue, 15 Mar 2022 18:55:50 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Huang Jianan <jnhuang95@gmail.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-erofs@lists.ozlabs.org,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: erofs: remember if kobject_init_and_add was done
Message-ID: <YjBwtqsEOZ5JbqvS@B-P7TQMD6M-0146.local>
References: <20220315075152.63789-1-dzm91@hust.edu.cn>
 <bca8f865-bc3e-44d7-7298-c2c7e8973580@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bca8f865-bc3e-44d7-7298-c2c7e8973580@gmail.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 06:43:01PM +0800, Huang Jianan wrote:
> 在 2022/3/15 15:51, Dongliang Mu 写道:
> > From: Dongliang Mu <mudongliangabcd@gmail.com>
> > 
> > Syzkaller hit 'WARNING: kobject bug in erofs_unregister_sysfs'. This bug
> > is triggered by injecting fault in kobject_init_and_add of
> > erofs_unregister_sysfs.
> > 
> > Fix this by remembering if kobject_init_and_add is successful.
> > 
> > Note that I've tested the patch and the crash does not occur any more.
> > 
> > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >   fs/erofs/internal.h | 1 +
> >   fs/erofs/sysfs.c    | 9 ++++++---
> >   2 files changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> > index 5aa2cf2c2f80..9e20665e3f68 100644
> > --- a/fs/erofs/internal.h
> > +++ b/fs/erofs/internal.h
> > @@ -144,6 +144,7 @@ struct erofs_sb_info {
> >   	u32 feature_incompat;
> >   	/* sysfs support */
> > +	bool s_sysfs_inited;
> 
> Hi Dongliang,
> 
> How about using sbi->s_kobj.state_in_sysfs to avoid adding a extra member in
> sbi ?

Ok, I have no tendency of these (I'm fine with either ways).
I've seen some usage like:

static inline int device_is_registered(struct device *dev)
{
        return dev->kobj.state_in_sysfs;
}

But I'm still not sure if we need to rely on such internal
interface.. More thoughts?

Thanks,
Gao Xiang

> 
> Thanks,
> Jianan
> 
> >   	struct kobject s_kobj;		/* /sys/fs/erofs/<devname> */
> >   	struct completion s_kobj_unregister;
> >   };
> > diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> > index dac252bc9228..2b48a4df19b4 100644
> > --- a/fs/erofs/sysfs.c
> > +++ b/fs/erofs/sysfs.c
> > @@ -209,6 +209,7 @@ int erofs_register_sysfs(struct super_block *sb)
> >   				   "%s", sb->s_id);
> >   	if (err)
> >   		goto put_sb_kobj;
> > +	sbi->s_sysfs_inited = true;
> >   	return 0;
> >   put_sb_kobj:
> > @@ -221,9 +222,11 @@ void erofs_unregister_sysfs(struct super_block *sb)
> >   {
> >   	struct erofs_sb_info *sbi = EROFS_SB(sb);
> > -	kobject_del(&sbi->s_kobj);
> > -	kobject_put(&sbi->s_kobj);
> > -	wait_for_completion(&sbi->s_kobj_unregister);
> > +	if (sbi->s_sysfs_inited) {
> > +		kobject_del(&sbi->s_kobj);
> > +		kobject_put(&sbi->s_kobj);
> > +		wait_for_completion(&sbi->s_kobj_unregister);
> > +	}
> >   }
> >   int __init erofs_init_sysfs(void)
