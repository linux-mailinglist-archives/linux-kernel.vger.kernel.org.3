Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9724E209A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 07:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344565AbiCUG2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 02:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241560AbiCUG14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 02:27:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41A11A3B4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 23:26:22 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22L3fxNH023145;
        Mon, 21 Mar 2022 06:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=lHG4gvtN3vri3JiV8+qPPfosk4XAtywS64mVIaCnmMY=;
 b=UOQbH1VpWX1N8QbQOv+0VNjLHS6kuCTAFZGet/lOfrk2VdNT1akzGCow3WVs5FUPbO0W
 1yVcqtjZ+ptmNir6feRp+E+zWQqGvmx5zOYhls/w0Iksi1oo5HvH1jd9o2plv9t8KA8A
 kl085J14hcVT3loPN4EeSTGzF/bRqqZNnvV3MhRChmanzjhKaaD4Ek3Vwl5Hiqk652R/
 EkCUCizEgUkOjyc78pW61I9qQyIXtZijQXQRTGetewsoluczAzdDmfyl5ASMLSRRMM/+
 HTBrZbOO402RcioyZUlepXgrOpZwyrtRuFibZYytLolZJadlljqLu7ebY9dQIUVduAng JA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3exhpcj729-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 06:25:48 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22L6Mi3n010483;
        Mon, 21 Mar 2022 06:25:47 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3exhpcj71v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 06:25:47 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22L6C8ZI013865;
        Mon, 21 Mar 2022 06:25:45 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3ew6t8u4a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 06:25:45 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22L6E5dq49021422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 06:14:05 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91132AE051;
        Mon, 21 Mar 2022 06:25:43 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26681AE045;
        Mon, 21 Mar 2022 06:25:43 +0000 (GMT)
Received: from localhost (unknown [9.43.115.88])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 21 Mar 2022 06:25:43 +0000 (GMT)
Date:   Mon, 21 Mar 2022 11:55:41 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 3/3] objtool/mcount: Add powerpc specific functions
To:     Peter Zijlstra <peterz@infradead.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     aik@ozlabs.ru, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        rostedt@goodmis.org
References: <20220318105140.43914-1-sv@linux.ibm.com>
        <20220318105140.43914-4-sv@linux.ibm.com>
        <YjR6kHq4c/rjCTpr@hirez.programming.kicks-ass.net>
In-Reply-To: <YjR6kHq4c/rjCTpr@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1647843607.5vkv4b5tvk.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 34J3O1aoWHDG4aGJm3jALdU7jgra_4ws
X-Proofpoint-GUID: WJzRE_49EOLLkYwlkToirVo4TrnOPTKg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-21_02,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 spamscore=0 impostorscore=0 phishscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2203210039
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> On Fri, Mar 18, 2022 at 04:21:40PM +0530, Sathvika Vasireddy wrote:
>> This patch adds powerpc specific functions required for
>> 'objtool mcount' to work, and enables mcount for ppc.
>=20
> I would love to see more objtool enablement for Power :-)
>=20
>=20
>> diff --git a/tools/objtool/arch/powerpc/include/arch/elf.h b/tools/objto=
ol/arch/powerpc/include/arch/elf.h
>> new file mode 100644
>> index 000000000000..3c8ebb7d2a6b
>> --- /dev/null
>> +++ b/tools/objtool/arch/powerpc/include/arch/elf.h
>> @@ -0,0 +1,8 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +
>> +#ifndef _OBJTOOL_ARCH_ELF
>> +#define _OBJTOOL_ARCH_ELF
>> +
>> +#define R_NONE R_PPC_NONE
>> +
>> +#endif /* _OBJTOOL_ARCH_ELF */
>> diff --git a/tools/objtool/utils.c b/tools/objtool/utils.c
>> index d1fc6a123a6e..c9c14fa0dfd7 100644
>> --- a/tools/objtool/utils.c
>> +++ b/tools/objtool/utils.c
>> @@ -179,11 +179,29 @@ int create_mcount_loc_sections(struct objtool_file=
 *file)
>>  		loc =3D (unsigned long *)sec->data->d_buf + idx;
>>  		memset(loc, 0, sizeof(unsigned long));
>> =20
>> -		if (elf_add_reloc_to_insn(file->elf, sec,
>> -					  idx * sizeof(unsigned long),
>> -					  R_X86_64_64,
>> -					  insn->sec, insn->offset))
>> -			return -1;
>> +		if (file->elf->ehdr.e_machine =3D=3D EM_X86_64) {
>> +			if (elf_add_reloc_to_insn(file->elf, sec,
>> +						  idx * sizeof(unsigned long),
>> +						  R_X86_64_64,
>> +						  insn->sec, insn->offset))
>> +				return -1;
>> +		}
>> +
>> +		if (file->elf->ehdr.e_machine =3D=3D EM_PPC64) {
>> +			if (elf_add_reloc_to_insn(file->elf, sec,
>> +						  idx * sizeof(unsigned long),
>> +						  R_PPC64_ADDR64,
>> +						  insn->sec, insn->offset))
>> +				return -1;
>> +		}
>> +
>> +		if (file->elf->ehdr.e_machine =3D=3D EM_PPC) {
>> +			if (elf_add_reloc_to_insn(file->elf, sec,
>> +						  idx * sizeof(unsigned long),
>> +						  R_PPC_ADDR32,
>> +						  insn->sec, insn->offset))
>> +				return -1;
>> +		}
>=20
> It appears to me that repeating this code 3 times doesn't really scale
> well, how about we introduce a helper like:
>=20
>=20
> int elf_reloc_type_long(struct elf *elf)
> {
> 	switch (elf->ehdr.e_machine) {
> 	case EM_X86_64:
> 		return R_X86_64_64;
> 	case EM_PPC64:
> 		return R_PPC64_ADDR64;
> 	case EM_PPC:
> 		return R_PPC_ADDR32;
> 	default:
> 		WARN("unknown machine...")
> 		exit(-1);
> 	}
> }
>=20
> 		if (elf_add_reloc_to_insn(file->elf, sec,
> 					  idx * sizeof(unsigned long),
> 					  elf_reloc_type_long(file->elf),
> 					  insn->sec, insn->offset))
> 			return -1;

Good point. I suppose we'll need a similar helper, say,=20
elf_reloc_type_none(), to replace R_NONE usage if we want to have=20
objtool work for cross-arch builds.


- Naveen
