Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56034B433E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241557AbiBNIHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:07:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiBNIHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:07:00 -0500
X-Greylist: delayed 419 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 00:06:52 PST
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 848B75F27B;
        Mon, 14 Feb 2022 00:06:52 -0800 (PST)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 5364915F93A;
        Mon, 14 Feb 2022 16:59:52 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 21E7xoRZ051364
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 16:59:51 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 21E7xoWK253761
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 16:59:50 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 21E7xoEx253760;
        Mon, 14 Feb 2022 16:59:50 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH] fat: Use pointer to d_name[0] in put_user() for compat
 case
References: <YgmB01p+p45Cihhg@p100>
Date:   Mon, 14 Feb 2022 16:59:50 +0900
In-Reply-To: <YgmB01p+p45Cihhg@p100> (Helge Deller's message of "Sun, 13 Feb
        2022 23:10:27 +0100")
Message-ID: <87y22dho95.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Deller <deller@gmx.de> writes:

> The put_user(val,ptr) macro wants a pointer in the second parameter, but in
> fat_ioctl_filldir() the d_name field references a whole "array of chars".
> Usually the compiler automatically converts it and uses a pointer to that
> array, but it's more clean to explicitly give the real pointer to where someting
> is put, which is in this case the first character of the d_name[] array.
>
> I noticed that issue while trying to optimize the parisc put_user() macro
> and used an intermediate variable to store the pointer. In that case I
> got this error:
>
> In file included from include/linux/uaccess.h:11,
>                  from include/linux/compat.h:17,
>                  from fs/fat/dir.c:18:
> fs/fat/dir.c: In function ‘fat_ioctl_filldir’:
> fs/fat/dir.c:725:33: error: invalid initializer
>   725 |                 if (put_user(0, d2->d_name)                     ||         \
>       |                                 ^~
> include/asm/uaccess.h:152:33: note: in definition of macro ‘__put_user’
>   152 |         __typeof__(ptr) __ptr = ptr;                            \
>       |                                 ^~~
> fs/fat/dir.c:759:1: note: in expansion of macro ‘FAT_IOCTL_FILLDIR_FUNC’
>   759 | FAT_IOCTL_FILLDIR_FUNC(fat_ioctl_filldir, __fat_dirent)
>
> The patch below cleans it up.
>
> Signed-off-by: Helge Deller <deller@gmx.de>

Looks good.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
> index c4a274285858..249825017da7 100644
> --- a/fs/fat/dir.c
> +++ b/fs/fat/dir.c
> @@ -722,7 +722,7 @@ static int func(struct dir_context *ctx, const char *name, int name_len,   \
>  		if (name_len >= sizeof(d1->d_name))			   \
>  			name_len = sizeof(d1->d_name) - 1;		   \
>  									   \
> -		if (put_user(0, d2->d_name)			||	   \
> +		if (put_user(0, &d2->d_name[0])			||	   \
>  		    put_user(0, &d2->d_reclen)			||	   \
>  		    copy_to_user(d1->d_name, name, name_len)	||	   \
>  		    put_user(0, d1->d_name + name_len)		||	   \

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
