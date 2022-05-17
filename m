Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E9C529F5B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344320AbiEQKXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344598AbiEQKVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:21:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C090C4D27D
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:19:59 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24H8jZ6g011328;
        Tue, 17 May 2022 10:19:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=PdP/vPSqJqgm2nNKPy/B91D5+/a0Nyurp+7QonVFxWI=;
 b=QdJqlPATnP5SI6+AqxqrzGu9s5vC/TbIUKUB3LAOl6lGYCOEKuJtQXrv9h6P66vDLbAI
 ZNRXSIp1AHqF/15k+4AtVXo1lanYmAWOKvpWAKFjoxAfKn8JRIQjZ3tINzswwb18QmhJ
 nj3LLFeBwu545Dwzf8getZScTHg3OSmb5Bs2ZFb2yGUUBL/Er3MaKRBN9W42qBgREMni
 48GWSVcF1wND2HrFo/kLp4eyiAkGzyws7kU/Sn+NJcx4GUJFxn1Nk40F/kyP6C7Xu0XE
 AP2J9JNpbFHBFo0anMatosO/UADR0YmItDOKqATd2eZTmx+bRBm20RRUAkN4BL4BLf8p Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g48fu9xsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 10:19:47 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24HAGbYk024944;
        Tue, 17 May 2022 10:19:47 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g48fu9xru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 10:19:47 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24HAHXVb028860;
        Tue, 17 May 2022 10:19:45 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3g2429c1et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 10:19:45 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24HA5rhq41353560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 10:05:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17EB6A405B;
        Tue, 17 May 2022 10:19:43 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0607A4054;
        Tue, 17 May 2022 10:19:42 +0000 (GMT)
Received: from localhost (unknown [9.43.12.56])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 17 May 2022 10:19:42 +0000 (GMT)
Date:   Tue, 17 May 2022 15:49:41 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] kexec_file: Drop pr_err in weak implementations of
 arch_kexec_apply_relocations[_add]
To:     Baoquan He <bhe@redhat.com>
Cc:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20220425174128.11455-1-naveen.n.rao@linux.vnet.ibm.com>
        <YoNqJ/MOSIVwKP/o@MiWiFi-R3L-srv>
In-Reply-To: <YoNqJ/MOSIVwKP/o@MiWiFi-R3L-srv>
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1652782155.56t7mah8ib.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3VF1AMtnPOAhP9HZz_RcBqZuj551GDIq
X-Proofpoint-GUID: GMmMoVdAmJIpiPaER6o347wEx1mnozOB
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_01,2022-05-17_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 adultscore=0 malwarescore=0 impostorscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205170060
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan He wrote:
> On 04/25/22 at 11:11pm, Naveen N. Rao wrote:
>> kexec_load_purgatory() can fail for many reasons - there is no need to
>> print an error when encountering unsupported relocations.
>>=20
>> This solves a build issue on powerpc with binutils v2.36 and newer [1].
>> Since commit d1bcae833b32f1 ("ELF: Don't generate unused section
>> symbols") [2], binutils started dropping section symbols that it thought
>=20
> I am not familiar with binutils, while wondering if this exists in other
> ARCHes except of ppc. Arm64 doesn't have the ARCH override either, do we
> have problem with it?

I'm not aware of this specific file causing a problem on other=20
architectures - perhaps the config options differ enough. There are=20
however more reports of similar issues affecting other architectures=20
with the llvm integrated assembler:
https://github.com/ClangBuiltLinux/linux/issues/981

>=20
>> were unused.  This isn't an issue in general, but with kexec_file.c, gcc
>> is placing kexec_arch_apply_relocations[_add] into a separate
>> .text.unlikely section and the section symbol ".text.unlikely" is being
>> dropped. Due to this, recordmcount is unable to find a non-weak symbol
>=20
> But arch_kexec_apply_relocations_add is weak symbol on ppc.

Yes. Note that it is just the section symbol that gets dropped. The=20
section is still present and will continue to hold the symbols for the=20
functions themselves.

>=20
>> in .text.unlikely to generate a relocation record against. Dropping
>> pr_err() calls results in these functions being left in .text section,
>=20
> Why dropping pr_err() can make arch_kexec_apply_relocations_add put in
> .text?

I'm not actually sure, though Josh suspected that printk() might be=20
cold:
http://lkml.kernel.org/r/20210214155147.3owdimqv2lyhu6by@treble


- Naveen

