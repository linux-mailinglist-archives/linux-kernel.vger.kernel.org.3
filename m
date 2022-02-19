Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064864BCAB0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 22:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243154AbiBSVLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 16:11:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238606AbiBSVLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 16:11:10 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5444439F;
        Sat, 19 Feb 2022 13:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645305031;
        bh=0D93HE4+O6LrB7ZYPDqyxAa1GaDjNt3dwc9ICtBeLdM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=fDX8ewye54MMX3fE6F2p3W0GvzAOTJXno6gSeMzpxMvOt+6HdPB8FdXLxYvc7VSp/
         3n2Jj3DeoECii01s3M3oMDbVKl+L1bzBkrczXA1RAG0XYPiobdevk3NxcqO0XDFULM
         RRwsZkjyujesl9J0Oz0iXdpcn20c8bH8H8YaZv4M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MplXp-1o2IPr3LAL-00q9dk; Sat, 19 Feb 2022 22:10:30 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-assembly@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: (dell-smm) Improve assembly code
Date:   Sat, 19 Feb 2022 22:10:11 +0100
Message-Id: <20220219211011.16600-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Dv69kyWeVbaMWJX+U9eD2MP9rRHJ4LjBogS6Q99RXel5/UADoKy
 7g7HJLAsyhJvPBmyj5c1ylgF+AVIGYmJP9C5IThT+q/EJnLupNy2ZvCWjxs9xxroW6vw3DH
 8qJZ4WwVZpI+OlHCRpHKU/HOxe+KOerU6YpQnJPK7q0Wp2aONWgPBFWn9E1mRLaRLmpM1WN
 71osLvPJHbmu1bfb9zTfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+ktvkrsO0e8=:CzljAVYfOK1tAggScCk8q4
 oCYskL5eTF4SAL/QrKpigU23Yd2TYAlOrFcZLy9CeETx1jD6vve9FmqWGbWxXHC+iZxymlgmY
 USEhydHUs8i4IWcxkfmRuqMa4R1z9jILoQ52bCLBaeiY+RgJTk+k34PnqVQnLp+nr2iqEe7yT
 a1VmEhdCqoQ6L5+2QT1eIBI1mObhRnk0gT+/JmubjOnNUaPmQxCkapX8lGbHyQGLLLELB+07T
 ybd2ZlRPTJyLwroxvQnNFP8982gMD4euTFx/4bfh03ttVHZ+OIorQt/SwQI8wnQGZTLz9l6a1
 5t7NgUu9RW70ZkBZTAti/MKMeDK/tSVFGXleRIYcc1tbEyufIfhgy21jYi0jcKNqPArJYR7vM
 t5YBKns6fIhbPH9wX8kU3Q1QsJs+42P+p9sJa5AA6K6h3hFAa8DqCEXngyJXe4yER6s/bOxze
 H1ooxGZ7O7XETnk3tg8ROCzElv1qCIr+v+l70pg6zTc2MOIgK4am+8rXCoeK4BR55JSI+EUXf
 NfgRevxBuwc5bs+J5D41KOAN9ThqCy73XuQTeLFBSG8OB/0awV8uaLzSSx0lIsNkDqpbyzvkz
 7TelKBPPjbItwoBN1iyTI7GBpk+gJGRLMNBfXwWGoXDYlV06KTSPRYBjqPoVDeWhwDRgUU6dg
 FHXDEhnGWqTxbvyrN5zJAz4E5EsUB2ywE4pO6QsRc8S7JLhAe8QfLFBwGncJB4bJtt6OUsJTZ
 W8fl9Px8apfGqbxpKtsFJYcLqz0SrvbuaCuMznEf1a/+p/4QbSHxJDVqFvUG32aefK13s4jzk
 NVXA957i4vDMdEMh04QByoLwe8sMRN4mSKA7nMGEs6ERnWGgHxhliCqDke7mNi+HDywE+ZBid
 ac1USjw5M2F2O5mH31yE9PNNjvpk9ixLxn1+4dFvPqZbhANXUWpmT4DOao0S9qgbEqq1XkBhQ
 tfuwSCaWuV+cDcB+DWp3gupmEBngPFJPDRwP84Ptkf8HI3Dh3nPrP0UHXfHhowIzAOetCOGW2
 8jtA3T2O+r0uzj8z9SQoOZ1lJixhVBJgWnPXXNkXjOGbs3oFFIuCHlV10CI4toEW7fk8nm9kI
 nogOX4OBqetqvE=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new assembly code works on both 32 bit and 64 bit
cpus and allows for more compiler optimisations by not
requiring smm_regs to be packed. Also since the
SMM handler seems to modify the carry flag, the new
code informs the compiler that the flags register
needs to be saved/restored. Since clang runs out of
registers on 32 bit x86 when using CC_OUT, we need
to execute "setc" ourself.
Also modify the debug message so we can still see
the result (eax) when the carry flag was set.

Tested with 32 bit and 64 bit kernels on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes in v2:
- fix clang running out of registers on 32 bit x86
- modify debug message
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 85 ++++++++++------------------------
 1 file changed, 25 insertions(+), 60 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index c5939e68586d..f1538a46bfc9 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -119,7 +119,7 @@ struct smm_regs {
 	unsigned int edx;
 	unsigned int esi;
 	unsigned int edi;
-} __packed;
+};

 static const char * const temp_labels[] =3D {
 	"CPU",
@@ -165,73 +165,38 @@ static int i8k_smm_func(void *par)
 	int eax =3D regs->eax;
 	int ebx =3D regs->ebx;
 	long long duration;
-	int rc;
+	bool carry;

 	/* SMM requires CPU 0 */
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
-	if (rc !=3D 0 || (regs->eax & 0xffff) =3D=3D 0xffff || regs->eax =3D=3D =
eax)
-		rc =3D -EINVAL;
+	asm volatile("out %%al,$0xb2\n\t"
+		     "out %%al,$0x84\n\t"
+		     "setc %0\n"
+		     : "=3Dmr" (carry),
+		       "=3Da" (regs->eax),
+		       "=3Db" (regs->ebx),
+		       "=3Dc" (regs->ecx),
+		       "=3Dd" (regs->edx),
+		       "=3DS" (regs->esi),
+		       "=3DD" (regs->edi)
+		     : "a" (regs->eax),
+		       "b" (regs->ebx),
+		       "c" (regs->ecx),
+		       "d" (regs->edx),
+		       "S" (regs->esi),
+		       "D" (regs->edi)
+		     : "cc");

 	duration =3D ktime_us_delta(ktime_get(), calltime);
-	pr_debug("smm(0x%.4x 0x%.4x) =3D 0x%.4x  (took %7lld usecs)\n", eax, ebx=
,
-		 (rc ? 0xffff : regs->eax & 0xffff), duration);
+	pr_debug("smm(0x%.4x 0x%.4x) =3D 0x%.4x carry: %d (took %7lld usecs)\n",
+		 eax, ebx, regs->eax & 0xffff, carry, duration);

-	return rc;
+	if (carry || (regs->eax & 0xffff) =3D=3D 0xffff || regs->eax =3D=3D eax)
+		return -EINVAL;
+
+	return 0;
 }

 /*
=2D-
2.30.2

