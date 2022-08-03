Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7166A588875
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 10:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237419AbiHCIHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 04:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbiHCIHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 04:07:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE7B2181C
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 01:07:04 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2737CGgG005901;
        Wed, 3 Aug 2022 08:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=cD/HLOT1RCr5FLze4xYHuh82tvZmGK0k7ghWRsfmnMs=;
 b=s7VdRk7u/VPgZX+3zRnI5WEBcaEr49EVC9har418PaXIytMUYVl3Z3KmOfxJIUmzvpnn
 IZICnARoFMQEKx0JoHxtdFJMrWwRIYUrCUBwz/WICyuI+vdpRzGrV3ZZ6w9/oNpibLlJ
 ubGoesRJ5TnWxAFJ1NucRrDjTfpbWQqvqgQQ5RLjd/vUyJoy+w2Egg0w2OetFbXcTSto
 vLviHrZ1/Fs92jzv20jzTqK80h6LufA0ilQ7if22I32sGtQIdGJsulcRTz6qiGJCFUPn
 S313xNuwe/0TzqQ6SxdZh9Ohihl/ERzr0/y/NRGcQE2UrUvlDG0CU2Ke6sWQVMgvcSDI EA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hqmdu1bx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Aug 2022 08:06:41 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27386GEr017991;
        Wed, 3 Aug 2022 08:06:39 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3hmv98vgnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Aug 2022 08:06:39 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27386qMM31326540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Aug 2022 08:06:52 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E7DF42041;
        Wed,  3 Aug 2022 08:06:36 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D93E84203F;
        Wed,  3 Aug 2022 08:06:35 +0000 (GMT)
Received: from localhost (unknown [9.43.94.156])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  3 Aug 2022 08:06:35 +0000 (GMT)
Date:   Wed, 03 Aug 2022 13:36:34 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH 2/3] powerpc/ppc-opcode: Define and use PPC_RAW_TRAP() and
 PPC_RAW_TW()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <b2d762191b095530789ac8b71b167c6740bb6aed.1657205708.git.christophe.leroy@csgroup.eu>
        <52c7e522e56a38e3ff0363906919445920005a8f.1657205708.git.christophe.leroy@csgroup.eu>
In-Reply-To: <52c7e522e56a38e3ff0363906919445920005a8f.1657205708.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1659513939.dxqqwb8mat.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 91osUYcya-v8DiiS0T0UMNk2AIlwaNzq
X-Proofpoint-GUID: 91osUYcya-v8DiiS0T0UMNk2AIlwaNzq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_03,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=898 lowpriorityscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208030037
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy wrote:
> Add and use PPC_RAW_TRAP() instead of opencoding.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/ppc-opcode.h | 2 ++
>  arch/powerpc/include/asm/probes.h     | 3 ++-
>  arch/powerpc/xmon/xmon.c              | 2 +-
>  3 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include=
/asm/ppc-opcode.h
> index 89beabf5325c..5527a955fb4a 100644
> --- a/arch/powerpc/include/asm/ppc-opcode.h
> +++ b/arch/powerpc/include/asm/ppc-opcode.h
> @@ -581,6 +581,8 @@
> =20
>  #define PPC_RAW_BRANCH(offset)		(0x48000000 | PPC_LI(offset))
>  #define PPC_RAW_BL(offset)		(0x48000001 | PPC_LI(offset))
> +#define PPC_RAW_TW(t0, a, b)		(0x7f000008 | ___PPC_RS(t0) | ___PPC_RA(a)=
 | ___PPC_RB(b))

Shouldn't that be 0x7c000008 ?

- Naveen


> +#define PPC_RAW_TRAP()			PPC_RAW_TW(31, 0, 0)
> =20
>  /* Deal with instructions that older assemblers aren't aware of */
>  #define	PPC_BCCTR_FLUSH		stringify_in_c(.long PPC_INST_BCCTR_FLUSH)
> diff --git a/arch/powerpc/include/asm/probes.h b/arch/powerpc/include/asm=
/probes.h
> index 00634e3145e7..e77a2ed7d938 100644
> --- a/arch/powerpc/include/asm/probes.h
> +++ b/arch/powerpc/include/asm/probes.h
> @@ -9,8 +9,9 @@
>   */
>  #include <linux/types.h>
>  #include <asm/disassemble.h>
> +#include <asm/ppc-opcode.h>
> =20
> -#define BREAKPOINT_INSTRUCTION	0x7fe00008	/* trap */
> +#define BREAKPOINT_INSTRUCTION	PPC_RAW_TRAP()	/* trap */
> =20
>  /* Trap definitions per ISA */
>  #define IS_TW(instr)		(((instr) & 0xfc0007fe) =3D=3D 0x7c000008)
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index f80c714f1d49..26ef3388c24c 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -116,7 +116,7 @@ struct bpt {
>  static struct bpt bpts[NBPTS];
>  static struct bpt dabr[HBP_NUM_MAX];
>  static struct bpt *iabr;
> -static unsigned bpinstr =3D 0x7fe00008;	/* trap */
> +static unsigned int bpinstr =3D PPC_RAW_TRAP();
> =20
>  #define BP_NUM(bp)	((bp) - bpts + 1)
> =20
> --=20
> 2.36.1
>=20
>=20
>=20
