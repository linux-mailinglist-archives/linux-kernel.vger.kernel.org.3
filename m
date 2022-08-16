Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABDA5960CE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 19:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbiHPRGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 13:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbiHPRGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:06:09 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACEA79609
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 10:06:07 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27GGiLUQ005227;
        Tue, 16 Aug 2022 17:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=GjjxBkmOT7kfjjNUvdcUnZZdNAdgE5EWLferPMUXAnA=;
 b=YL3OJlfJ14C/KPkJRH8fKhPKtxIOlqOJCCgFbLlBfYmMkMVlPwl1iHQEcGvVjiGMJsXo
 yO9JGi5Mip9t30SQtzLm7bG2lseHrj967Kdgd5+z0DoVUkLuqBmERm+owzOgze1gPTci
 bUn1XWIJ9+3/wtPDjt2/OWXJvXD9bqeKpK6XqSYRKn9RYfPr+FHHd9GtLEj0/1pnHNdW
 ml8JmcSALUfRyXMglrSbQtCMj56n2OeR9UImqhMG3DmpdYe8g0/D75pGT7LWK1sOYczT
 pUwR1/hJD7YS1iTDHzA1y/2gDaQ+rWpgipepo4Qcf1UO35BDDeUoiK/tMe4XbTh9Bd7J Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j0f0y0kd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 17:05:41 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27GGjE2Q008425;
        Tue, 16 Aug 2022 17:05:41 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j0f0y0kc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 17:05:40 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27GH5LZN002388;
        Tue, 16 Aug 2022 17:05:38 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3hx37jbgk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 17:05:38 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27GH5a8b26608022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Aug 2022 17:05:36 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5780611C04A;
        Tue, 16 Aug 2022 17:05:36 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E38E011C04C;
        Tue, 16 Aug 2022 17:05:35 +0000 (GMT)
Received: from localhost (unknown [9.43.58.12])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 16 Aug 2022 17:05:35 +0000 (GMT)
Date:   Tue, 16 Aug 2022 22:35:34 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] ftrace/recordmcount: Handle object files without
 section symbols
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        llvm@lists.linux.dev, Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <cover.1651047542.git.naveen.n.rao@linux.vnet.ibm.com>
        <20220816100423.5ee2e17c@gandalf.local.home>
In-Reply-To: <20220816100423.5ee2e17c@gandalf.local.home>
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1660668823.oegvwl2214.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OzR97rxPfkN_j2hNnQzGXDMJE-1aixqM
X-Proofpoint-ORIG-GUID: PYoTJVUk2zunDwCz72cxwia_qgxH99mO
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 malwarescore=0 spamscore=0 mlxscore=0 impostorscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

Steven Rostedt wrote:
> On Wed, 27 Apr 2022 15:01:20 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> This solves a build issue on powerpc with binutils v2.36 and newer [1].
>> Since commit d1bcae833b32f1 ("ELF: Don't generate unused section
>> symbols") [2], binutils started dropping section symbols that it thought
>> were unused. Due to this, in certain scenarios, recordmcount is unable=20
>> to find a non-weak symbol to generate a relocation record against.
>>=20
>> Clang integrated assembler is also aggressive in dropping section=20
>> symbols [3].
>>=20
>> In the past, there have been various workarounds to address this. See=20
>> commits 55d5b7dd6451b5 ("initramfs: fix clang build failure") and=20
>> 6e7b64b9dd6d96 ("elfcore: fix building with clang") and a recent patch:
>> https://lore.kernel.org/linuxppc-dev/20220425174128.11455-1-naveen.n.rao=
@linux.vnet.ibm.com/T/#u
>>=20
>> Fix this issue by using the weak symbol in the relocation record. This=20
>> can result in duplicate locations in the mcount table if those weak=20
>> functions are overridden, so have ftrace skip dupicate entries.
>>=20
>> Objtool already follows this approach, so patch 2 updates recordmcount=20
>> to do the same. Patch 1 updates ftrace to skip duplicate entries.
>>=20
>> - Naveen
>>=20
>>=20
>> [1] https://github.com/linuxppc/issues/issues/388
>> [2] https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommit;h=3Dd1bc=
ae833b32f1
>> [3] https://github.com/ClangBuiltLinux/linux/issues/981
>>=20
>>
>=20
> There's been work to handle weak functions, but I'm not sure that work
> handled the issues here. Are these patches still needed, or was there
> another workaround to handle the problems this addressed?

I'm afraid these patches are still needed to address issues in=20
recordmcount.

I submitted patches to remove use of weak functions in the kexec=20
subsystem, but those have only enabled building ppc64le defconfig=20
without errors:
https://lore.kernel.org/all/20220519091237.676736-1-naveen.n.rao@linux.vnet=
.ibm.com/
https://lore.kernel.org/all/cover.1656659357.git.naveen.n.rao@linux.vnet.ib=
m.com/

The patch adding support for FTRACE_MCOUNT_MAX_OFFSET to powerpc only=20
helps ignore weak functions during runtime:
https://lore.kernel.org/all/20220809105425.424045-1-naveen.n.rao@linux.vnet=
.ibm.com/

We still see errors from recordmcount when trying to build certain=20
powerpc configs.

We are pursuing support for objtool, which doesn't have the same issues:
https://lore.kernel.org/all/20220808114908.240813-1-sv@linux.ibm.com/


- Naveen
