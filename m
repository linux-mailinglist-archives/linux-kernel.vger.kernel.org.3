Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A26486EA0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 01:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344011AbiAGAUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 19:20:33 -0500
Received: from mout.gmx.net ([212.227.17.21]:34589 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343988AbiAGAU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 19:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641514824;
        bh=p1b7wAO7GiySvUynDsX7sMMM63WbWqelJ0kA4G/mEhM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=FGV2ihuqoxK3uQM/d6S2JKWoP8YEs8g6uLBd+wxgWJlxSMEE3v0Vrzp7p3JDBxqfQ
         btbhW7V8iWx9ChxwYE3sGMEJjREV495vpTFzbEjKnv320DsTJW1TCfzv9KuZ0H/WwC
         c304WWrC7uJ5qqpgftVn5ZGLQwK7KjIVJ0e5J46s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.152.191]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNbox-1ml5yO3KPL-00P1fX; Fri, 07
 Jan 2022 01:20:23 +0100
Date:   Fri, 7 Jan 2022 01:19:24 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-parisc@vger.kernel.org
Subject: [PATCH] usercopy: Do not fail on memory from former init sections
Message-ID: <YdeHDDAP+TY5wNeT@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:J678O3gfzGmPwfd41abDjWTRi2G6E7NS5C1gZ88lcYOQRYh7DNM
 FHzG/SMP5Q+prn5lsiKGAeVQpjsD2g0WEnj17ZxpRm9wLS8Sl5n2gJLmf9K+D9x8TSEWqkK
 YSPQuNJTe2OG1V8TRNxn39nqUXRwEi2gEQKcbbw0F6h9uk93tdinx0Xizso6icwj+vkTxa7
 Fdg4GdwMWxzP6fOvEmngQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OT7CU3w6s4Y=:KN+L6myiVw68C/EZgp78rn
 uXM/TEb5xr5Wy2Wz58cAhIvFSsqUoOE3aUl4jVuz5C7sqXhPJaTUR20DHAcJAw2qoTVyDSFQl
 m8EWYAXp1+Fxe1Qyy5ZGFNPzXdM6qB5ZcJjgxJ1lt7rK0u5NzY8fngWcaeKdyEyqywRu6zLso
 2SRG4LrCguc7u1FbZrb+giokYBiZ+BaT1Wus/llWUs8d5CTeQaAXK6iuu7YghGPiKrRFNnDFc
 LirD1qsVNCKk2D2SrP4s+NU4DxBFE6oVGfZOKvR7q2D67KoBfcEM3IWxYtSowuD708aZKbaat
 lgMvXwUR/5P2Wen3RjvB3JDrBqvwd1w+GsiqhjXL2z6LaE9dlme4A91Jgw9iILukJdl59cKNc
 nCeXJ14hAgtcbJBq4PVOKzrnvwS6Ve56qQ9bnZ++EgbNQfudaEB32CjGBypQruFUOO5gCu4a2
 4boKRdMMMwK67BTu4+3xBzpGrTt8vapY4+cO7TJeOsd4Fa1LAqjVsjBG/rsoG/GIjjWDqh9TU
 WL6swWpASzxRLMHYtSszpQlVnCiy12XkdU47PClALwt39Q4W0+vkLWsOPQ6X6V55yhaN4ANNg
 RYx4LdslpXd03qejFLEBK6vfYekzbn/1PqtRzR3TSSVCtYvefWD8/1zQFs/OY5BD7oB9y/qxl
 7vi9KOiqV9qdEJGR8cP6UAJZ8p6DUSCTl7H02Bh9jgtFiNgpcmgVO9yfY+CtfRJ+M5G3aTCCf
 YQAMTryoGuCjQZ5mjHohC+43fIdfgs4Y/l4yFO+MSxeGUn29ANBmnDOOlvb82zRcTcaPNGEC3
 I8QicQb8tU+ZCW1CHEOVxWTtu3vGKeXko9asZdgn2FqgIRd4gTTRIBxCaNUiRfR0SFyTU9pLX
 fl5k7K9SPL5M3UZJ+0X/UbYx/3LbRm66rkuvPC81HaWHpYoUUdj/F4me7Smun/Eu8OubyRLXF
 cIwT9WT7Puf6HXs9LzO/ppJPOByKylUMW3kWqjo/1V5sOhCw+YsxmSDS3xPemeelk5QEhTpbf
 YsyAnkJuf88TQpMwk8Tg3xryjzUNqyfQqScuuzkQdInZTc+763o92OiCqxPJ0DwHivtHguaUs
 7397Q8R0IYHzYU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms the memory area between the _stext and the _etext
symbols includes the init sections (parisc and csky). If the init
sections are freed after bootup, the kernel may reuse this memory.

In one test the usercopy checks if the given address is inside the .text
section (from _stext to _etext), and it wrongly fails on the mentioned
platforms if the memory is from the former init section.

Fix this failure by first checking against the init sections before
checking against the _stext/_etext section.

Signed-off-by: Helge Deller <deller@gmx.de>
Fixes: 98400ad75e95 ("parisc: Fix backtrace to always include init funtion=
 names")

diff --git a/mm/usercopy.c b/mm/usercopy.c
index b3de3c4eefba..37a35c6051bc 100644
=2D-- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -113,6 +113,15 @@ static bool overlaps(const unsigned long ptr, unsigne=
d long n,
 	return true;
 }

+static bool inside_init_area(const unsigned long ptr, unsigned long n,
+		char *start, char *end)
+{
+	unsigned long initlow =3D (unsigned long) start;
+	unsigned long inithigh =3D (unsigned long) end;
+
+	return (ptr >=3D initlow && (ptr + n) < inithigh);
+}
+
 /* Is this address range in the kernel text area? */
 static inline void check_kernel_text_object(const unsigned long ptr,
 					    unsigned long n, bool to_user)
@@ -121,6 +130,12 @@ static inline void check_kernel_text_object(const uns=
igned long ptr,
 	unsigned long texthigh =3D (unsigned long)_etext;
 	unsigned long textlow_linear, texthigh_linear;

+	/* Ok if inside the former init sections */
+	if (inside_init_area(ptr, n, __init_begin, __init_end))
+		return;
+	if (inside_init_area(ptr, n, _sinittext, _einittext))
+		return;
+
 	if (overlaps(ptr, n, textlow, texthigh))
 		usercopy_abort("kernel text", NULL, to_user, ptr - textlow, n);

