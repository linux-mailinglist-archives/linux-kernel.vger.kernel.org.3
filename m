Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E29B5A7BDA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 13:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiHaLEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 07:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiHaLES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 07:04:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEA29F8D4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 04:04:17 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27V8ja3C006870;
        Wed, 31 Aug 2022 11:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : from :
 date : subject : to : cc; s=corp-2022-7-12;
 bh=6SXXBybf0Upt3qTKeZCZXzMIP41uMlfYtChskMKRoLE=;
 b=Bn6rmefh+Fe7KRGWxCg+8R8qDL1eYnbDZovH+H4fqQzTMY/ApklmASX0SvzKeWuFyAmM
 DilACgs1usNEqE8NcH71X+akcCgiF5ZksMFEi1oBHCHUAAmlDd9isyJOdD9/0P30N+JG
 M6X8bq5HxwByCQbmhL1IPf/8E11MJiDlspw1r9c+CUXexb+dkB6zd3JkQu06D3I2tRtM
 DmL5cVdzsHOwI+ru07kH9SwensQYVxB1kISgNG148kpJ8IamPSBOXV4F5SlPMqTI0mC0
 O5ktjX3wTjDsgGFBqP9kP7h/UYUlE02t95I/0vyKT6NpU4utVoQMAFtpebZTrkZMnc4/ Tg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7btt8v6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 11:03:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27VAruCR013034;
        Wed, 31 Aug 2022 11:03:36 GMT
Received: from oracle.com (dhcp-10-175-18-16.vpn.oracle.com [10.175.18.16])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3j79q501j0-1;
        Wed, 31 Aug 2022 11:03:36 +0000
Message-Id: <ed7a508717bb8bec6273c2740418f0dc2df9eeba.1661943721.git.julian.pidancet@oracle.com>
From:   Julian Pidancet <julian.pidancet@oracle.com>
Date:   Tue, 30 Aug 2022 09:42:37 +0200
Subject: [PATCH] x86/alternative: Consistently patch SMP locks in vmlinux and
 modules
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_06,2022-08-31_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208310054
X-Proofpoint-ORIG-GUID: uZtfzGXumc8d34qbDwPJcrd5nVm3r1GL
X-Proofpoint-GUID: uZtfzGXumc8d34qbDwPJcrd5nVm3r1GL
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The alternatives_smp_module_add() function restricts patching of SMP
lock prefixes to the text address range passed as an argument.

For vmlinux, patching all the instructions located between the _text and
_etext symbols is allowed. That includes the .text section but also
other sections such as .text.hot and .text.unlikely.

As per the comment inside the 'struct smp_alt_module' definition, the
original purpose of this restriction is to avoid patching the init code
which may have been deallocated when the alternatives code run.

For modules, the current code only allows patching instructions located
inside the .text segment, excluding other sections such as .text.hot or
.text.unlikely, which may need patching.

This change aims to make patching of the kernel core and modules more
consistent, by allowing all text sections of modules except .init.text
to be patched in module_finalize().

For that we use mod->core_layout.base/mod->core_layout.text_size as the
address range allowed to be patched, which include all the code sections
except the init code.

Signed-off-by: Julian Pidancet <julian.pidancet@oracle.com>
---
Public tests: https://gist.github.com/jpidancet/1ee457623426f3e3902a28edaf2c80d0 
Related thread: https://marc.info/?t=130864398400006

 arch/x86/kernel/module.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index b1abf663417c..da22193eb5e0 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -251,14 +251,12 @@ int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)
 {
-	const Elf_Shdr *s, *text = NULL, *alt = NULL, *locks = NULL,
-		*para = NULL, *orc = NULL, *orc_ip = NULL,
-		*retpolines = NULL, *returns = NULL, *ibt_endbr = NULL;
+	const Elf_Shdr *s, *alt = NULL, *locks = NULL, *para = NULL,
+		*orc = NULL, *orc_ip = NULL, *retpolines = NULL,
+		*returns = NULL, *ibt_endbr = NULL;
 	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 
 	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
-		if (!strcmp(".text", secstrings + s->sh_name))
-			text = s;
 		if (!strcmp(".altinstructions", secstrings + s->sh_name))
 			alt = s;
 		if (!strcmp(".smp_locks", secstrings + s->sh_name))
@@ -302,12 +300,13 @@ int module_finalize(const Elf_Ehdr *hdr,
 		void *iseg = (void *)ibt_endbr->sh_addr;
 		apply_ibt_endbr(iseg, iseg + ibt_endbr->sh_size);
 	}
-	if (locks && text) {
+	if (locks) {
 		void *lseg = (void *)locks->sh_addr;
-		void *tseg = (void *)text->sh_addr;
+		void *text = me->core_layout.base;
+		void *text_end = text + me->core_layout.text_size;
 		alternatives_smp_module_add(me, me->name,
 					    lseg, lseg + locks->sh_size,
-					    tseg, tseg + text->sh_size);
+					    text, text_end);
 	}
 
 	if (orc && orc_ip)
-- 
2.37.1

