Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A824B3DED
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 23:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbiBMWKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 17:10:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238553AbiBMWKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 17:10:44 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829FB54199;
        Sun, 13 Feb 2022 14:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644790230;
        bh=4UNYbRzhi/YcdTi4VTb2dKrOemdjk4GOFtfpCuSIxMk=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=YLkCSHr/K7TjZj9IpVn3PpLsObd+hk98j9xxjYvJdjpiRLmYiPjHBobzwpmtkyyQx
         J0OdxdSSs2RyrXE8Z4XdXdqVqRaUEscaj0hA9TA2KLNeHWVFDKxJEFFH21d54ARCgM
         IKH+oXlCrDM+N8f4u92DKrTuC9aPuTnpt5dXXsSY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100 ([92.116.190.238]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOiDd-1nee0w3cBr-00QFz6; Sun, 13
 Feb 2022 23:10:29 +0100
Date:   Sun, 13 Feb 2022 23:10:27 +0100
From:   Helge Deller <deller@gmx.de>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-parisc@vger.kernel.org
Subject: [PATCH] fat: Use pointer to d_name[0] in put_user() for compat case
Message-ID: <YgmB01p+p45Cihhg@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E12ICo73xWG4DDvZRiAxdDZIaode5BSNu8/1BOKsz2rk3PJunay
 N3Lk2Dn4+r7IY461XkyLk61W+8gZS75sQwU+RtrVlLZP6FDjBHnjN6Ej4tQkuuU6EKhvRtP
 +ol1SszrjwmoBA6Ge/8ut5fHMh87aqpsSWjD2BCpbv7f8/momn17EBV/ZLdI1YdjB1yJm0r
 K9S6oPsmyf2QtdQdTMx1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/60Iao04bx0=:yJrNxom32DP5LEYAsbIArt
 Q84p2yEqqFgKkWnzZNIgE+LQQbirFK2ulzm37ix6ERbK9XuJz8hGYONt7VUpHHtXHSxmDF/OZ
 C2FQ7O8elIm1WGjjKyGTDTz8QALLf3BrmMbBrT24AozcHuKD2rznzVxOOVFzgrNDAEBdC9jTl
 mAxW3cYDoKves4r7dQuKGNXC5kIsou87znvMWQ/j0NkVELf4QjkFilHz9WJW3LbEVqxBqxOLz
 koacfnnUoiHpzkYlqe9B9BXiccs4PfGqO9SkQ240L8/DJvzcKVlxf9Rg7ipONJsqMj9ZYusQK
 Zx9ElqVhraVFHx/5lVnSsw5zTc0EYCtR4Zm8MzBXcoYOebrx5AYR2otA8t3CrlUNePrMm7MUD
 wLy4rmGJt8sMaXAQD10ZNZnwNyJYYyqg/+kl5hbt4P8hi305nMFJbg/8ASXliJZQDCNvsVs5a
 HW2eZk7cuTiaKOnTSo/SN7f/GhF3el0Ez3ItJuhIrfkpe03PrK+Tzh4RVBfQzUCMB3Z1a+qTf
 tb9lvJRBYBrB5Dw859vEzM+yfDGIegdT2pBSiylcSE6GODIoHnIngBzKRH0igOa04cRw6Fx0V
 3Fj234j0g1RqZm7t3WQ9Los0PH7kPv2XS/TSCZFPDRiX7EjRpzIzjimpq+fqeXQ+L0fy6XNSh
 WfgZhllIhfKCTjLAJAMI1X1TIR/ywbbOhliiwHoVmnJGl8NJ/ljRMQrYd0LI5NeXiBPtMf+1t
 Baly0uj+Lidh5iLIgOFDt/C6LMooblVaCSOIvvb4ru7QJtwLcqRTZQAxzTCINO/s/bPmHXH0K
 rNTPHkfIsgxoZLz5w9ERp9RIjGrwd1rYGCZt39wri7/9DzcrxbHI5qoM7Ig1AYnqxoI0HJhBA
 g3/XG5itXKOZkWrUORrBe+D/98jhjeXP8EnqryklJdSJVDiFKVQm6ojpUGKrW4o9xkLu8Y5gd
 hu7nOJTWm8v5H/L82DeVb0gE+I6wwsct4Jdq2qgoxXungpCwDwr1lzXB5D/ZZV6SJ0ceFSCaP
 aFoqtAvDGeIwGrjbqCVKBz+/TjIKLvYRt+2ezjQXkHvfvcE4wvrVvmHLZwXYlqRG5hTmJm0C2
 grVcQjp00zs1tw=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The put_user(val,ptr) macro wants a pointer in the second parameter, but i=
n
fat_ioctl_filldir() the d_name field references a whole "array of chars".
Usually the compiler automatically converts it and uses a pointer to that
array, but it's more clean to explicitly give the real pointer to where so=
meting
is put, which is in this case the first character of the d_name[] array.

I noticed that issue while trying to optimize the parisc put_user() macro
and used an intermediate variable to store the pointer. In that case I
got this error:

In file included from include/linux/uaccess.h:11,
                 from include/linux/compat.h:17,
                 from fs/fat/dir.c:18:
fs/fat/dir.c: In function =E2=80=98fat_ioctl_filldir=E2=80=99:
fs/fat/dir.c:725:33: error: invalid initializer
  725 |                 if (put_user(0, d2->d_name)                     ||=
         \
      |                                 ^~
include/asm/uaccess.h:152:33: note: in definition of macro =E2=80=98__put_=
user=E2=80=99
  152 |         __typeof__(ptr) __ptr =3D ptr;                            =
\
      |                                 ^~~
fs/fat/dir.c:759:1: note: in expansion of macro =E2=80=98FAT_IOCTL_FILLDIR=
_FUNC=E2=80=99
  759 | FAT_IOCTL_FILLDIR_FUNC(fat_ioctl_filldir, __fat_dirent)

The patch below cleans it up.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index c4a274285858..249825017da7 100644
=2D-- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -722,7 +722,7 @@ static int func(struct dir_context *ctx, const char *n=
ame, int name_len,   \
 		if (name_len >=3D sizeof(d1->d_name))			   \
 			name_len =3D sizeof(d1->d_name) - 1;		   \
 									   \
-		if (put_user(0, d2->d_name)			||	   \
+		if (put_user(0, &d2->d_name[0])			||	   \
 		    put_user(0, &d2->d_reclen)			||	   \
 		    copy_to_user(d1->d_name, name, name_len)	||	   \
 		    put_user(0, d1->d_name + name_len)		||	   \
