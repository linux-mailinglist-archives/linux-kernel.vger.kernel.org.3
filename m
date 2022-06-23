Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F42C557266
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 06:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiFWE7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 00:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiFWE7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 00:59:05 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E98488A4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 21:44:46 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o18so10092767plg.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 21:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7pClNYW6GdD+bqk4AvhY2s+uNLxh13CkOSP1D9SdCxo=;
        b=GBcPP7Ll2QRHafRvhbKwUuaUPed1y5SmfgxoASMwl0H56+Nm+vVEL9yTIPa5sd+RKV
         JbcY/Ag+jXQjrX7OlP+Ejl8DM+/nnfprWgZRysFIGwaaSi0BvYFDgOyJxV5mPr0uegxD
         glV+TH+YobBHYRsmXXaNTBklROr70CkUJjGBNrScqShDrTF7kihFZ5KIuFUOh3WUIQ9m
         meEz2w5nvDIj4+k8vKWOHzkmMBvbSFTLGnWZsRTUjcXBIlHCCfmQD4gU1U051FhboojK
         mce+85K/Me/0MbXdOSQ81ZaJztHz17sPP5FaXroT1TfRdVvnJBd837Dje7//fhcZ98In
         YiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7pClNYW6GdD+bqk4AvhY2s+uNLxh13CkOSP1D9SdCxo=;
        b=A617Enat0LDdcWVDwruH2v8D5I6jPjjijHJSy1ozCOvEnO9QpDptdvEepLoiUpAOli
         N1yv9aib+eFxi3HaCD1nr+8cIkU/Ojxf3E8HK7sbPvp75Ts1/tuDdsVHMJySi869TO1/
         W0jeePZ/UP+uuc6t1/HzHzKAVUjZQMeti3hh2ebQO1NOstGeP5UU30IpKtavCjuxq8Zh
         toGu4ty5z3MUorgAse2cwNQ4sYUagA2kN1QeqFXidShgmc5tkYeY4t/hcx5L+e/nLxjh
         KFr6XflJy6TXP6EWPxecyJeZBr0EU+NqgAxuHHnTh0aSeyLJcvkrk9WSKa4nv9f6BxCa
         XdNA==
X-Gm-Message-State: AJIora8i+dIIlRTc8869aVct5uX5Vee3zPoptYMrkrTOW8Xxn0L+cDs7
        SLV1n938HOfw/UbK4deHvLg=
X-Google-Smtp-Source: AGRyM1sEivVnKKU+jYUVm/emg72A4m98rAYAEGOrUi4aHojJC9oiKNl0bvHdKMVI/LJOqmWWpAqAwA==
X-Received: by 2002:a17:902:aa4b:b0:164:11ad:af0f with SMTP id c11-20020a170902aa4b00b0016411adaf0fmr37768944plr.54.1655959485115;
        Wed, 22 Jun 2022 21:44:45 -0700 (PDT)
Received: from liuchao-VM ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id x6-20020a63aa46000000b003f24d67d226sm14066795pgo.92.2022.06.22.21.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 21:44:44 -0700 (PDT)
Date:   Thu, 23 Jun 2022 12:44:40 +0800
From:   Chao Liu <chaoliu719@gmail.com>
To:     Chao Yu <chao@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>,
        Xiaoyu Qi <qxy65535@gmail.com>, Chao Liu <liuchao@coolpad.com>
Subject: Re: [PATCH] f2fs: fix to remove F2FS_COMPR_FL and tag F2FS_NOCOMP_FL
 at the same time
Message-ID: <YrPvuPLze3QoCkPJ@liuchao-VM>
References: <20220621064833.1079383-1-chaoliu719@gmail.com>
 <0771b00b-e781-cd29-896a-4b6ebc948c2e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0771b00b-e781-cd29-896a-4b6ebc948c2e@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 09:42:13PM +0800, Chao Yu wrote:
> On 2022/6/21 14:48, Chao Liu wrote:
> > From: Chao Liu <liuchao@coolpad.com>
> >
> > If the inode has the compress flag, it will fail to use
> > 'chattr -c +m' to remove its compress flag and tag no compress flag.
> > However, the same command will be successful when executed again,
> > as shown below:
> >
> >    $ touch foo.txt
> >    $ chattr +c foo.txt
> >    $ chattr -c +m foo.txt
> >    chattr: Invalid argument while setting flags on foo.txt
> >    $ chattr -c +m foo.txt
> >    $ f2fs_io getflags foo.txt
> >    get a flag on foo.txt ret=0, flags=nocompression,inline_data
> >
> > Fix this by removing some checks in f2fs_setflags_common()
> > that do not affect the original logic. I go through all the
> > possible scenarios, and the results are as follows. Bold is
> > the only thing that has changed.
> >
> > +---------------+-----------+-----------+----------+
> > |               |            file flags            |
> > + command       +-----------+-----------+----------+
> > |               | no flag   | compr     | nocompr  |
> > +---------------+-----------+-----------+----------+
> > | chattr +c     | compr     | compr     | -EINVAL  |
> > | chattr -c     | no flag   | no flag   | nocompr  |
> > | chattr +m     | nocompr   | -EINVAL   | nocompr  |
> > | chattr -m     | no flag   | compr     | no flag  |
> > | chattr +c +m  | -EINVAL   | -EINVAL   | -EINVAL  |
> > | chattr +c -m  | compr     | compr     | compr    |
> > | chattr -c +m  | nocompr   | *nocompr* | nocompr  |
> > | chattr -c -m  | no flag   | no flag   | no flag  |
> > +---------------+-----------+-----------+----------+
> >
> > Fixes: 4c8ff7095bef ("f2fs: support data compression")
> > Signed-off-by: Chao Liu <liuchao@coolpad.com>
> > ---
> >
> > This patch depends on the the patch
> > "f2fs: allow compression of files without blocks" sent earlier this day.
> >
> >   fs/f2fs/file.c | 9 +--------
> >   1 file changed, 1 insertion(+), 8 deletions(-)
> >
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index daaa0dfd2d2e..0c3ae5993b7a 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -1873,10 +1873,7 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
> >   		if (masked_flags & F2FS_COMPR_FL) {
> >   			if (!f2fs_disable_compressed_file(inode))
> >   				return -EINVAL;
> > -		}
> > -		if (iflags & F2FS_NOCOMP_FL)
> > -			return -EINVAL;
> > -		if (iflags & F2FS_COMPR_FL) {
> > +		} else {
> >   			if (!f2fs_may_compress(inode))
> >   				return -EINVAL;
> >   			if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
> > @@ -1885,10 +1882,6 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
> >   			set_compress_context(inode);
> >   		}
> >   	}
> > -	if ((iflags ^ masked_flags) & F2FS_NOCOMP_FL) {
> > -		if (masked_flags & F2FS_COMPR_FL)
> > -			return -EINVAL;
> > -	}
>
> Without above check condition, can we return -EINVAL for the case:
>
> chattr +c on file w/ nocompr flag
>
> |               | no flag   | compr     | nocompr  |
> +---------------+-----------+-----------+----------+
> | chattr +c     | compr     | compr     | *-EINVAL*  |

Yes, we can.

chattr(1) grabs flags via GETFLAGS, modifies the result,
and passes that to SETFLAGS. If we execute 'chattr +c'
on the file with nocompr flag, the iflags will
contain both compr and nocompr flags, then be refused by:

    if ((iflags & F2FS_COMPR_FL) && (iflags & F2FS_NOCOMP_FL))
        return -EINVAL;

In addition, if iflags has only compr flag, while masked_flags
has only nocompr flag for some reason
(either because of concurrency of chattr(1) or by a user),
I think we need remove nocompr flag and tag compr flag on the file,
similar to the following.

|               | no flag   | compr     | nocompr  |
+---------------+-----------+-----------+----------+
| chattr +c -m  | compr     | compr     | *compr*  |

Thanks,
