Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688794C568B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 16:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiBZPES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 10:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiBZPER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 10:04:17 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410DC1B0BE9;
        Sat, 26 Feb 2022 07:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645887810;
        bh=DSb0lEeTpjM7J4efhrIsH0DXeRqkzTuM+XHUKL3rF0g=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=S+La3e3AsKZnZVAqHjnBe44rjGPEDo0YSQF6/ShTDeW6xXN0l2POkSnu1WVbDA3EF
         sSwGYTwejCAZSmGrjRkcr8hNl6/EuJHi3Jqe7lp31Cf0aGCG0mU01rHU0i9otDwt/M
         0BIBoy0D2Z4/+P4Ggqhjz/JA3DAACT8aMCvXCmbw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.186.89]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGhyS-1nRsdH3y9i-00DliT; Sat, 26
 Feb 2022 16:03:30 +0100
Date:   Sat, 26 Feb 2022 16:03:25 +0100
From:   Helge Deller <deller@gmx.de>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fbdev@vger.kernel.org
Subject: Re: [BUG] fbdev: sm712fb: Page fault in smtcfb_read
Message-ID: <YhpBPQuqPNmqasxE@ls3530>
References: <CAMhUBjmetJqbERvQ8513b-wHuV68hqLTuUVWiORyJyXP26gO7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhUBjmetJqbERvQ8513b-wHuV68hqLTuUVWiORyJyXP26gO7Q@mail.gmail.com>
X-Provags-ID: V03:K1:LnGMEHu6wxSEB6+CkUurDbbkEanquKYqoNNJCKjmc0JEt6OW8JN
 40wpn25x97ZY/F3o6uH6XRNf+P9IT7MmmIbjWrN96qGASU3QD9yVFb3jfg14Kyl4nzCIG2f
 4U52gppB7r2y7C/CQTa3OLdnL/Et7/0No5scoRb3+eQBqJky7UHYrUywd5mVvWl8TqhYNRB
 UhRSdnXGlTKMevaGiwnrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WJ5qryZ6sZA=:24enygESSOZJNQDigBU9LM
 cleqzsFtD3MWsGBrZ6vxonoE0+xD+LWzEhTvfvIs/MivMz/7tM5EvSYponkTMwRdFVmqJ//A4
 AQ/DhkJ0VcuFHhtG+KLI09iFsIia+V4lkHIYTlusvUGCoNOiDNGn66jcqLHDPe6O5aUDacCVD
 BV/6RvRgVUNfhlhgcEZTGUpMZWSAbXjAIOdP76BUFpOPDB0zthTFHTRBTYFzdiJPcRJ7ZNAGP
 Q53gcno4JRm3+/3dADbDi5ovbzEXJTUAHSuUnLWFpsiPGaz8cvQombX06N2o00MYEvTs3RdQk
 vq0iauKk4rvrjG6xTc3QBCEb2/O/+nllu7KiXFtO6TQC/VO94JZR/NQIp0N42w3qWyeB6wgiO
 AL7YxMcdCH9Qz6GRiC8fIIaq2EF/qKpJW0GZkwcp6t0hDEMecAvWsE0JluRTvoWaSSMlSy5VJ
 TPssAhMQRQcdOAQgqvR4SZ5RT65N7Xh/UWX8jyr+O056M/2jpOz4a5PLKtSarAVk47Pw0IqUo
 f7lXsDfNz2iWWhNQQsd7O64AGrm897bMh6M6/rdI3hoovV+x8xjeLiyeHnWpsxdeaABW7ZyY2
 y9yqh5CW2jKq8DuQSObkKtJ2F6J7Dzj02CTS3sJZd73OamcuNsAarKNL5RbX2K+SnvKzqz6AP
 FFujKyJ4c9u+xloPyBfHyhAKWlyUvE4bnNcDoC0m3mxANez/XbnwklUFSlNu/ztDKpMKy8mlD
 xD37OAySgnO3EBr6qjDSSZIWL6cWMxBjYgu9GOrV/OW0Fb/9V2+WGIbhEcj7Kll0F392xMufk
 hNIaybjoKx8eLxYAVXwpzVczFgfaL5yBGcd+c/h4wJagfRgIdnnPE6OyjuDUrnyT5/fKpgj1f
 lslFVjkyvjLyJTF6N5+AvWgxA7ZbGxMiWtMFzZdYPTmn3yG907qeDN+9I6qvJuaEq0s2hUis9
 4RTKu0wJ85CgawkwBmNo99JdZIcpdm1kE+jY4nWPkyh/gl9Dfruym8zfEfi7J+a2+LpdaFsUt
 CL5vdU4iry8TZNnMRtunOjliWIyiOMaNsYwlc0Zp1DbZC893DTXGOtBITVJebyiAREhRfY5DF
 BgMjfjWxZPKiOg=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Zheyu Ma <zheyuma97@gmail.com>:
> I found a minor in the smtcfb_read() function of the driver sm712fb.
>
> This read function can not handle the case that the size of the
> buffer is 3 and does not check for it, which may cause a page fault.
>
> The following log reveals it:
>
> [ 2432.614490] BUG: unable to handle page fault for address: ffffc90001f=
fffff
> [ 2432.618474] RIP: 0010:smtcfb_read+0x230/0x3e0
> [ 2432.626551] Call Trace:
> [ 2432.626770]  <TASK>
> [ 2432.626950]  vfs_read+0x198/0xa00
> [ 2432.627225]  ? do_sys_openat2+0x27d/0x350
> [ 2432.627552]  ? __fget_light+0x54/0x340
> [ 2432.627871]  ksys_read+0xce/0x190
> [ 2432.628143]  do_syscall_64+0x43/0x90

Could you try the attached patch ?


diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 0dbc6bf8268a..ab45212ccf66 100644
=2D-- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1047,7 +1047,7 @@ static ssize_t smtcfb_read(struct fb_info *info, cha=
r __user *buf,
 	if (count + p > total_size)
 		count =3D total_size - p;

-	buffer =3D kmalloc((count > PAGE_SIZE) ? PAGE_SIZE : count, GFP_KERNEL);
+	buffer =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;

@@ -1059,25 +1059,11 @@ static ssize_t smtcfb_read(struct fb_info *info, c=
har __user *buf,
 	while (count) {
 		c =3D (count > PAGE_SIZE) ? PAGE_SIZE : count;
 		dst =3D buffer;
-		for (i =3D c >> 2; i--;) {
-			*dst =3D fb_readl(src++);
-			*dst =3D big_swap(*dst);
+		for (i =3D (c + 3) >> 2; i--;) {
+			u32 val =3D fb_readl(src++);
+			*dst =3D big_swap(val);
 			dst++;
 		}
-		if (c & 3) {
-			u8 *dst8 =3D (u8 *)dst;
-			u8 __iomem *src8 =3D (u8 __iomem *)src;
-
-			for (i =3D c & 3; i--;) {
-				if (i & 1) {
-					*dst8++ =3D fb_readb(++src8);
-				} else {
-					*dst8++ =3D fb_readb(--src8);
-					src8 +=3D 2;
-				}
-			}
-			src =3D (u32 __iomem *)src8;
-		}

 		if (copy_to_user(buf, buffer, c)) {
 			err =3D -EFAULT;
