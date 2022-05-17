Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC0D529F80
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238711AbiEQKca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344270AbiEQKcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:32:15 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDA222B35;
        Tue, 17 May 2022 03:32:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VDUBXsC_1652783528;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VDUBXsC_1652783528)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 17 May 2022 18:32:09 +0800
Date:   Tue, 17 May 2022 18:32:07 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao.yu@oppo.com>
Subject: Re: [PATCH] erofs: support idmapped mounts
Message-ID: <YoN5pwgj340Ct4Ye@B-P7TQMD6M-0146.local>
References: <20220517073210.3569589-1-chao@kernel.org>
 <20220517090622.4wrtrjmzknh66bci@wittgenstein>
 <YoNnlpGBFm7dh6yD@B-P7TQMD6M-0146.local>
 <20220517092203.6dlcxynvpokqrfzg@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220517092203.6dlcxynvpokqrfzg@wittgenstein>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 11:22:03AM +0200, Christian Brauner wrote:
> On Tue, May 17, 2022 at 05:15:02PM +0800, Gao Xiang wrote:
> > Hi Christian,
> > 
> > On Tue, May 17, 2022 at 11:06:22AM +0200, Christian Brauner wrote:
> > > On Tue, May 17, 2022 at 03:32:10PM +0800, Chao Yu wrote:
> > > > This patch enables idmapped mounts for erofs, since all dedicated helpers
> > > > for this functionality existsm, so, in this patch we just pass down the
> > > > user_namespace argument from the VFS methods to the relevant helpers.
> > > > 
> > > > Simple idmap example on erofs image:
> > > > 
> > > > 1. mkdir dir
> > > > 2. touch dir/file
> > > > 3. mkfs.erofs erofs.img dir
> > > > 4. mount -t erofs -o loop erofs.img  /mnt/erofs/
> > > > 
> > > > 5. ls -ln /mnt/erofs/
> > > > total 0
> > > > -rw-rw-r-- 1 1000 1000 0 May 17 15:26 file
> > > > 
> > > > 6. mount-idmapped --map-mount b:0:1001:1 /mnt/erofs/ /mnt/scratch_erofs/
> > > > 
> > > > 7. ls -ln /mnt/scratch_erofs/
> > > > total 0
> > > > -rw-rw-r-- 1 65534 65534 0 May 17 15:26 file
> > > 
> > > Your current example maps id 0 in the filesystem to id 1001 in the
> > > mount. But since no files with id 0 exist in the filesystem you're
> > > illustrating that unmapped ids are correctly reported as overflow{g,u}id.
> > > 
> > > I think what you'd rather want to show is something like this:
> > > 
> > > 5. ls -ln /mnt/erofs/
> > > total 0
> > > -rw-rw-r-- 1 1000 1000 0 May 17 15:26 file
> > > 
> > > 6. mount-idmapped --map-mount b:1000:1001:1 /mnt/erofs/ /mnt/scratch_erofs/
> > > 
> > > 7. ls -ln /mnt/scratch_erofs/
> > > total 0
> > > -rw-rw-r-- 1 1001 1001 0 May 17 15:26 file
> > > 
> > > where id 1000 in the filesystem maps to id 1001 in the mount.

Yeah, I just manually tested, although some steps assume user 1000
and some steps assume the root user. But it works.

I will rephrase such commit messages when applying later...

Thanks,
Gao Xiang
