Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033D44D9B22
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 13:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348243AbiCOM1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 08:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348238AbiCOM1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:27:07 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F05532E0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:25:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V7I11eB_1647347151;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V7I11eB_1647347151)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Mar 2022 20:25:53 +0800
Date:   Tue, 15 Mar 2022 20:25:51 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Huang Jianan <jnhuang95@gmail.com>,
        Dongliang Mu <dzm91@hust.edu.cn>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-erofs@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: erofs: remember if kobject_init_and_add was done
Message-ID: <YjCFz1dxVJZnF3M/@B-P7TQMD6M-0146.local>
References: <20220315075152.63789-1-dzm91@hust.edu.cn>
 <bca8f865-bc3e-44d7-7298-c2c7e8973580@gmail.com>
 <YjBwtqsEOZ5JbqvS@B-P7TQMD6M-0146.local>
 <8d832e7a-c8da-d2fa-571a-ea150b8deb1b@gmail.com>
 <CAD-N9QX2cajf0LXKcOji_Em26-0bw9wfhx7KDV_TLDWhgQ90hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD-N9QX2cajf0LXKcOji_Em26-0bw9wfhx7KDV_TLDWhgQ90hQ@mail.gmail.com>
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

Hi Dongliang,

On Tue, Mar 15, 2022 at 07:59:26PM +0800, Dongliang Mu wrote:
> On Tue, Mar 15, 2022 at 7:05 PM Huang Jianan <jnhuang95@gmail.com> wrote:
> >
> > 在 2022/3/15 18:55, Gao Xiang 写道:
> > > On Tue, Mar 15, 2022 at 06:43:01PM +0800, Huang Jianan wrote:
> > >> 在 2022/3/15 15:51, Dongliang Mu 写道:
> > >>> From: Dongliang Mu <mudongliangabcd@gmail.com>
> > >>>
> > >>> Syzkaller hit 'WARNING: kobject bug in erofs_unregister_sysfs'. This bug
> > >>> is triggered by injecting fault in kobject_init_and_add of
> > >>> erofs_unregister_sysfs.
> > >>>
> > >>> Fix this by remembering if kobject_init_and_add is successful.
> > >>>
> > >>> Note that I've tested the patch and the crash does not occur any more.
> > >>>
> > >>> Reported-by: syzkaller <syzkaller@googlegroups.com>
> > >>> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > >>> ---
> > >>>    fs/erofs/internal.h | 1 +
> > >>>    fs/erofs/sysfs.c    | 9 ++++++---
> > >>>    2 files changed, 7 insertions(+), 3 deletions(-)
> > >>>
> > >>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> > >>> index 5aa2cf2c2f80..9e20665e3f68 100644
> > >>> --- a/fs/erofs/internal.h
> > >>> +++ b/fs/erofs/internal.h
> > >>> @@ -144,6 +144,7 @@ struct erofs_sb_info {
> > >>>     u32 feature_incompat;
> > >>>     /* sysfs support */
> > >>> +   bool s_sysfs_inited;
> > >> Hi Dongliang,
> > >>
> > >> How about using sbi->s_kobj.state_in_sysfs to avoid adding a extra member in
> > >> sbi ?
> > > Ok, I have no tendency of these (I'm fine with either ways).
> > > I've seen some usage like:
> > >
> > > static inline int device_is_registered(struct device *dev)
> > > {
> > >          return dev->kobj.state_in_sysfs;
> > > }
> > >
> > > But I'm still not sure if we need to rely on such internal
> > > interface.. More thoughts?
> >
> > Yeah... It seems that it is better to use some of the interfaces
> > provided by kobject,
> > otherwise we should still maintain this state in sbi.
> >
> 
> I am fine with either way. Let me know if you reach to an agreement.

If you have time, would you mind sending another patch by using
state_in_sysfs? I'd like to know Chao's perference later, and
apply one of them...

Thanks,
Gao Xiang

