Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F3C4B777E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243425AbiBOTMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:12:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243402AbiBOTMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:12:00 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726AB7A9AD;
        Tue, 15 Feb 2022 11:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644952290;
        bh=piF//2eS4Ky3pAJp+1bPy+qGO6OmU+pXfnFC9nwV+0w=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=IP8roPnJPfL5+Bg2kmmogQT6GRIAypuF2Qxja2WPE38sGinjxzUzaU7/ATnQsPiTz
         QwlVGxTUQ18BqDfzjmLeJ4SRZuNPiYS0Kf0TTkq8/WWrghqJ0XZYF+E6bOUfVO8vCt
         Yv+LqDfqUmanZYfEgf2zqsKur036YISVJKwVvmo4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MrhQ6-1o7MXu0e8a-00nkXG; Tue, 15 Feb 2022 20:11:30 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] hwmon: (dell-smm) Improve assembly code
Date:   Tue, 15 Feb 2022 20:11:11 +0100
Message-Id: <20220215191113.16640-6-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220215191113.16640-1-W_Armin@gmx.de>
References: <20220215191113.16640-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TPkHDCY2XjIMWm7XLGt0M2XcEpZdlfGfNupt6prvJ0b3/F7j8Ku
 /ZstF8pTeB+xIp9bwmvuXXUXFHEJkKu4cWpY0Gz/bg5MC86eDp2CCUeRK2yUyqTnJm/Aqzu
 ZGkfqnjpR3T+c5wJkQTK9z5jbTDhefl8ZXQ2cqiyegax6ayTxjExnTW2ucvqlz9MjGqxd9N
 2DeLBZY8QwcJeHEhtfQCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LyH3HjHAY2k=:LFypqImYl+lS8Zu1DCUzc6
 w1f8vECAfAG+wAONXZZ+1lqNS4897wWN+zwT+5yIb1wD/AcsbEG9+5gMcHqqY6g9/8fup3KSg
 iA0tXrsX3ulbPOper8gWpSEguPKwnWBel1O2l3UEmVIoT70ASJDMCLfWXVTM0TNaqASOBetPd
 9M2HoPGgxB1hTAuBoAnJnCDCtBhQLSORzPe278etp2fzU2p0gt8ZeWqntkn0TVL86l6gz6wtf
 O+OITwvrv7EKbF3tSynz3rvkS0AraOPuc2syu9uQi+dzNRSP9P/V373s/myMjV+QDSxbWtaX1
 0SQ4AtJIHGq9032LXhPcXELvRuxpL7+piLnDQ7tkzFtJMU0HOIVHGktAFCxy9cvs/LWo3kq1O
 tqWWPdGkzljV5Br0ppjBh6tFWOG8vbMiu+F7wYZXns64icg4Qtz9e7b9QIJ3a4yFsdSXISmB1
 dahr9qOABEDEfUcfAvTnx+DfPEKJw5SDSJXBYEw8RoOcEUI1GtVaS3jy3cFienbAM4Flq/0CN
 LzC2iqYNf+YvDy53Mm/uPFKdf01w6Y4/Mk4BTT3lnMUW9Qb7IkIvN9kHLM0fm4+EYaW5mFuHU
 jNf7KvA2nSXm6Bd9PAINDih9zz5+5gTNFmOgJ0kAzXCSu+zFytdOgBCtNU9+mIfzxt3/C+oTD
 L/SWQh4jjpq8+RsYbCMkU+4WOEhR8jPdCg4poIi0J60awtXYujSrf33nUq10Jd7K8GNejp7JC
 w0Atz16tE0HEga7DoJhycA3GTr6iABIQoNH1yIT1RTCI/cihmhDI/dPRSmtEviyEhCblDQyG7
 hYmQdHEZ2p6x3aqlz09yAM9Oxs9fUvaEi+Y3qtCC6NngUPSBXFSnm5bJSz8f4A8/us4l533Vi
 cyxoJv0cqLPMXgxYq4Ex5UYQx9EAYYHVxBBIYGldd2F81yOc0593RJ19/8ABDXlecy4m11J1o
 PDlGhzamTGhkQ5mZE+/q850nncGYv+34JKHeYVyjGKUsL6vhe7Ab6bLr5cbxLiwt+0tatYOQm
 3k7tU8SMp5slNJxqyvrByWvpG3JHqwuF6lUN6sU5yn4vjmz4qVq978kO3/P2i2JAFn9s4SVkP
 J484sr4P11Muls=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new assembly code works on both 32bit and 64bit cpus
and allows for more compiler optimisations by not
requiring smm_regs to be packed. Also since the
SMM handler seems to modify the carry flag, the new
code informs the compiler that the flags register
needs to be saved/restored.

Tested with 32 bit and 64 bit kernels on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 71 ++++++++--------------------------
 1 file changed, 17 insertions(+), 54 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index b7016971bb2e..04a41d59da60 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -123,7 +123,7 @@ struct smm_regs {
 	unsigned int edx;
 	unsigned int esi;
 	unsigned int edi;
-} __packed;
+};

 static const char * const temp_labels[] =3D {
 	"CPU",
@@ -175,59 +175,22 @@ static int i8k_smm_func(void *par)
 	if (smp_processor_id() !=3D 0)
 		return -EBUSY;

-#if defined(CONFIG_X86_64)
-	asm volatile("pushq %%rax\n\t"
-		"movl 0(%%rax),%%edx\n\t"
-		"pushq %%rdx\n\t"
-		"movl 4(%%rax),%%ebx\n\t"
-		"movl 8(%%rax),%%ecx\n\t"
-		"movl 12(%%rax),%%edx\n\t"
-		"movl 16(%%rax),%%esi\n\t"
-		"movl 20(%%rax),%%edi\n\t"
-		"popq %%rax\n\t"
-		"out %%al,$0xb2\n\t"
-		"out %%al,$0x84\n\t"
-		"xchgq %%rax,(%%rsp)\n\t"
-		"movl %%ebx,4(%%rax)\n\t"
-		"movl %%ecx,8(%%rax)\n\t"
-		"movl %%edx,12(%%rax)\n\t"
-		"movl %%esi,16(%%rax)\n\t"
-		"movl %%edi,20(%%rax)\n\t"
-		"popq %%rdx\n\t"
-		"movl %%edx,0(%%rax)\n\t"
-		"pushfq\n\t"
-		"popq %%rax\n\t"
-		"andl $1,%%eax\n"
-		: "=3Da"(rc)
-		:    "a"(regs)
-		:    "%ebx", "%ecx", "%edx", "%esi", "%edi", "memory");
-#else
-	asm volatile("pushl %%eax\n\t"
-	    "movl 0(%%eax),%%edx\n\t"
-	    "push %%edx\n\t"
-	    "movl 4(%%eax),%%ebx\n\t"
-	    "movl 8(%%eax),%%ecx\n\t"
-	    "movl 12(%%eax),%%edx\n\t"
-	    "movl 16(%%eax),%%esi\n\t"
-	    "movl 20(%%eax),%%edi\n\t"
-	    "popl %%eax\n\t"
-	    "out %%al,$0xb2\n\t"
-	    "out %%al,$0x84\n\t"
-	    "xchgl %%eax,(%%esp)\n\t"
-	    "movl %%ebx,4(%%eax)\n\t"
-	    "movl %%ecx,8(%%eax)\n\t"
-	    "movl %%edx,12(%%eax)\n\t"
-	    "movl %%esi,16(%%eax)\n\t"
-	    "movl %%edi,20(%%eax)\n\t"
-	    "popl %%edx\n\t"
-	    "movl %%edx,0(%%eax)\n\t"
-	    "lahf\n\t"
-	    "shrl $8,%%eax\n\t"
-	    "andl $1,%%eax\n"
-	    : "=3Da"(rc)
-	    :    "a"(regs)
-	    :    "%ebx", "%ecx", "%edx", "%esi", "%edi", "memory");
-#endif
+	asm volatile("out %%al,$0xb2\n\t"
+		     "out %%al,$0x84\n"
+		     : "=3Da" (regs->eax),
+		       "=3Db" (regs->ebx),
+		       "=3Dc" (regs->ecx),
+		       "=3Dd" (regs->edx),
+		       "=3DS" (regs->esi),
+		       "=3DD" (regs->edi),
+		       CC_OUT(c) (rc)
+		     : "a" (regs->eax),
+		       "b" (regs->ebx),
+		       "c" (regs->ecx),
+		       "d" (regs->edx),
+		       "S" (regs->esi),
+		       "D" (regs->edi));
+
 	if (rc !=3D 0 || (regs->eax & 0xffff) =3D=3D 0xffff || regs->eax =3D=3D =
eax)
 		rc =3D -EINVAL;

=2D-
2.30.2

