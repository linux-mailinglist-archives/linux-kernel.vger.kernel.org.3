Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6484B4EF5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245262AbiBNLmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:42:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353940AbiBNLmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:42:05 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A653E673E6;
        Mon, 14 Feb 2022 03:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644838406;
        bh=l0MId2ooioe9nhI8ydZZddkQWWaIGBE574K+uHgUpuI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=A2LNuKntQMEkGCFnYD7TVHURXPujekwDJjHaU4Ab1f6o/YaPUIwSmb8jbL/i65RwJ
         BUC4HebW/iH1lxZ/G37Gdx+siqtH/lYV4jcki7eW1DotdV8gm4DEXqGnt/A0pEDw53
         eihs0JuRWJUKr3NI3oOdgbytKFKHVY1iRC13F/ww=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100 ([92.116.168.11]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfpOT-1nvML908EL-00gDvH; Mon, 14
 Feb 2022 12:33:26 +0100
Date:   Mon, 14 Feb 2022 12:33:23 +0100
From:   Helge Deller <deller@gmx.de>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org,
        David Laight <David.Laight@aculab.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas Schwab <schwab@linux-m68k.org>
Cc:     linux-parisc@vger.kernel.org
Subject: [PATCH v2] fat: Use pointer to simple type in put_user()
Message-ID: <Ygo+A9MREmC1H3kr@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6VtQofOaDIt+6iCeywwAg3EM05gYptORwCwQO6QaD16L6NNbGSk
 faH/tRWWzIG05lHz2ajmbbyv20IkzFoqX2uJ54ZY0nAfU3IXkpC6vG/qaqCIFpJGmqAK5MA
 jg36avzJjIm6KCxILXxlgUpvdkOYlwdGcAWH1z14POYziyZVAkmc+f1B0AAg5/7Q1gt/kPt
 6YA7S7vjC8VFiMIiQl3lQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1SDUOhDczFs=:yfH/Gjw6hI+2r5fxYBDdtz
 7znt6IV6ZExhqbalPWIAgpXi9ze8Na0N5AfKZAxyqeFYOqBQUcRTtBR5dGDEKCz36XJQtDblm
 YfZplPONsF5bwGG56Gr4pSpmQs/V9TM/o158LDgMGlnzoX2RgJcRAIW0qmM+xKg3Y8obZ+0ZT
 ONRe8VM62LOmiZYSQF6IrKEg4dgU8aM8kkJ8W3k8vEFjqJPNGTQx2VMFArg5mgKZhu882PTOA
 qD5hNlHcw9cK7XQLcxPmtG8VBQKu/x6WCOzo2W6S2TVl+weEhR8CpunsESxZ9DHYLD7KnU9g9
 zSkE2e7DtnAHxE9J91a4mAcKt4wN1LL4fhMmlifmiybAeULucegU52QvE4XzC+FHVVSnTFiBS
 Vy4e5UX+WhsICc43K1HrsGnjqBJV8wRmG2/AFwsi5EEtRW3zcCneWVcAKuLttGGBlCHaoUC+r
 P2J42ppcJr6AKwSjc1H3u6GswlO/udTe5SdcresE2MLNm/eLgUwYoGgEa74GQHTHB+PLMjaYd
 /r3ify9Lleid7/sONPUuktzhvzFeoMWNcfrS+Vr26k1C+SpUMPPECXD0OdBCW4qU6xHZXZTwo
 dhiXd0ZoKAG28l2gErYQ1Q0bDGL9AkalLujlusRab/m5KQhKbTkikMTYqNpewkeN7IKaDWRFV
 wMGShI/jKwmrdKEsVv6rS/98lCN2pw/aLD8UwdJtgQdYhKFui3IttwzNMc2SMdV8tVeAZHrJJ
 mCGnQmXQAh8BQXGdqt4VxAvvzU6jMiB+K2QzazaQJC0IeNa07t+odIaYfnRK3QOJvAwjVNnMj
 wNp2Gti9oNvCQM1rj7C1FeUcoKhPW31UWZUexRjXFnm9xk6Ivi/FRJltuQROWlhVKPg2Hir+c
 AyAxD0p2VWyCfdMUgrGCTj7050Ze49OEe6FMfZxzbFHATCK0dBLq2eOyc1BxO7ZHs3ZT13qbo
 BXxAS2ZS/7k/6QCO3YZeuRU3NlhyeU9w4YSXMVUaqr/SpyCmmfTwRusFt/jPV3Ndyq8RNgLNC
 39lsItA6/hQowFrKXVsKDvjZkgyZnsgbW9n3kHzkM75StXmUKw4PepcTy9yTLiLkuIsqkf+sm
 HZ+cwaviMjn74Q=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The put_user(val,ptr) macro wants a pointer to a simple type, but in
fat_ioctl_filldir() the d_name field references an "array of chars".
Be more accurate and explicitly give the pointer to the first character
of the d_name[] array.

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


Andreas Schwab <schwab@linux-m68k.org> suggested to use
   __typeof__(&*(ptr)) __ptr =3D ptr;
instead. This works, but nevertheless it's probably reasonable to
fix the original caller too.

Signed-off-by: Helge Deller <deller@gmx.de>

__
v2: Adjusted the description with input from David Laight
    <David.Laight@ACULAB.COM> and Andreas Schwab <schwab@linux-m68k.org>.

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
