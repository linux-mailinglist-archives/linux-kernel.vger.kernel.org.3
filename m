Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44D652B6E6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbiERJqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbiERJqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:46:19 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13340B1C
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:46:09 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24I9gi64006451;
        Wed, 18 May 2022 09:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=QQVA55xALZqqZ0+UCK4bbILmJo0n4KksKg2EVFGHGDc=;
 b=O2XfT2w/1QSCq2fRsAeHDD4Lny+5Gr1CjxkRjxnEKhfvxEw+zWL8x2ZTWlcbGyjuzKcY
 560KMV4uKAPGrP+aG+cckHCeWw1vjjpT4mEdwMfKiepjCjxe+8aB30fowMNV2d5LW2jm
 zOxOcgKJbNLoq9RinCKSNyFlaICVxNg1xHQ0G7qkvPPKg6ehgTP9Pon+FxYUikUrgPvZ
 gVuJl/ajoycDn1fDVSUNSWJjpgKei8mYf2xzkjB04vdHFmCvTaRtIUvYPQB0j64hAMpn
 esH6k2Qm9zD7/ljWsvQVN8HCQmQ7NULIsboWLzyCAJiLlWTxlcJPCreselHQUBUsMwTn iA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g4xdh8238-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 09:45:47 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24I9gbcq020274;
        Wed, 18 May 2022 09:45:45 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3g2429dfwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 09:45:45 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24I9jh6A42336578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 09:45:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E45CAE04D;
        Wed, 18 May 2022 09:45:43 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D830EAE045;
        Wed, 18 May 2022 09:45:42 +0000 (GMT)
Received: from localhost (unknown [9.43.19.36])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 18 May 2022 09:45:42 +0000 (GMT)
Date:   Wed, 18 May 2022 15:15:40 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 19/25] powerpc/ftrace: Minimise number of #ifdefs
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1652074503.git.christophe.leroy@csgroup.eu>
        <18ce6708d6f8c71d87436f9c6019f04df4125128.1652074503.git.christophe.leroy@csgroup.eu>
In-Reply-To: <18ce6708d6f8c71d87436f9c6019f04df4125128.1652074503.git.christophe.leroy@csgroup.eu>
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1652866821.cdcfe8bs78.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -xXV3WEQRZy-1nk7o9MuDv6wx1WAzkTW
X-Proofpoint-ORIG-GUID: -xXV3WEQRZy-1nk7o9MuDv6wx1WAzkTW
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_03,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 adultscore=0 clxscore=1011 suspectscore=0 malwarescore=0 mlxlogscore=928
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205180052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy wrote:
> A lot of #ifdefs can be replaced by IS_ENABLED()
>=20
> Do so.
>=20
> This requires to have kernel_toc_addr() defined at all time
> as well as PPC_INST_LD_TOC and PPC_INST_STD_LR.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v2: Moved the setup of pop outside of the big if()/else() in __ftrace_mak=
e_nop()
> ---
>  arch/powerpc/include/asm/code-patching.h |   2 -
>  arch/powerpc/include/asm/module.h        |   2 -
>  arch/powerpc/include/asm/sections.h      |  24 +--
>  arch/powerpc/kernel/trace/ftrace.c       | 182 +++++++++++------------
>  4 files changed, 103 insertions(+), 107 deletions(-)
>=20

<snip>

> @@ -710,6 +707,9 @@ void arch_ftrace_update_code(int command)
>=20
>  #ifdef CONFIG_PPC64
>  #define PACATOC offsetof(struct paca_struct, kernel_toc)
> +#else
> +#define PACATOC 0
> +#endif

This conflicts with my fix for the ftrace init tramp:
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20220516071422.4637=
38-1-naveen.n.rao@linux.vnet.ibm.com/

It probably makes sense to retain #ifdef CONFIG_PPC64, so that we can=20
get rid of the PACATOC. Here is an incremental diff:

diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace=
/ftrace.c
index da1a2f8ebb72f3..28169a1ccc7377 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -701,11 +701,6 @@ void arch_ftrace_update_code(int command)
 }
=20
 #ifdef CONFIG_PPC64
-#define PACATOC offsetof(struct paca_struct, kernel_toc)
-#else
-#define PACATOC 0
-#endif
-
 extern unsigned int ftrace_tramp_text[], ftrace_tramp_init[];
=20
 void ftrace_free_init_tramp(void)
@@ -724,7 +719,7 @@ int __init ftrace_dyn_arch_init(void)
 	int i;
 	unsigned int *tramp[] =3D { ftrace_tramp_text, ftrace_tramp_init };
 	u32 stub_insns[] =3D {
-		PPC_RAW_LD(_R12, _R13, PACATOC),
+		PPC_RAW_LD(_R12, _R13, offsetof(struct paca_struct, kernel_toc)),
 		PPC_RAW_ADDIS(_R12, _R12, 0),
 		PPC_RAW_ADDI(_R12, _R12, 0),
 		PPC_RAW_MTCTR(_R12),
@@ -733,9 +728,6 @@ int __init ftrace_dyn_arch_init(void)
 	unsigned long addr;
 	long reladdr;
=20
-	if (IS_ENABLED(CONFIG_PPC32))
-		return 0;
-
 	addr =3D ppc_global_function_entry((void *)FTRACE_REGS_ADDR);
 	reladdr =3D addr - kernel_toc_addr();
=20
@@ -754,6 +746,7 @@ int __init ftrace_dyn_arch_init(void)
=20
 	return 0;
 }
+#endif
=20
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
=20

- Naveen
