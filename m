Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03069588F9C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 17:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238128AbiHCPp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 11:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiHCPpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:45:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA00AE6D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 08:45:24 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 273Ek7xs014156;
        Wed, 3 Aug 2022 15:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=GrhgNkXy9Vfs11JQtPyk91zeffHKSJ6dYKP3uyUWsCA=;
 b=hu6+/pil35px81haZf2/MQZuQmzQBEKcH71pDeyl2M/iCcKwGSbOiguUEAMrU7L2tvcx
 hHw1RcMH0IDPspjMKN9UujuSST+DvStLklrSDj1AnRgVtqqV+QSm0wIa52Tz4PMrf7SH
 woHwNWFYyGn2kr+U6Y6T4iHrJH0AOaphNtZTtOni1vggZcUUug8Uxe3yr2sDfINzWMav
 B/yfbGWzhNSvbYil1qfcxMZH7PudmOdRzSXyLK/vUe86VZXEn7PClBj7AFkqAnzVVCNy
 gs57l3RSLdZ+Q1OYgREt9ico8DVxLNdCBQ5bfEYCdW+cAlnYWkMpkUr13DlMXA7rwqll BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hqsr0wt0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Aug 2022 15:45:14 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 273FeKVN029367;
        Wed, 3 Aug 2022 15:45:14 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hqsr0wsxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Aug 2022 15:45:13 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 273FZodu022401;
        Wed, 3 Aug 2022 15:45:11 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3hmv98w45b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Aug 2022 15:45:11 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 273FgrON28442926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Aug 2022 15:42:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1ACDCA4060;
        Wed,  3 Aug 2022 15:45:09 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9BE5A405C;
        Wed,  3 Aug 2022 15:45:08 +0000 (GMT)
Received: from localhost (unknown [9.43.94.156])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  3 Aug 2022 15:45:08 +0000 (GMT)
Date:   Wed, 03 Aug 2022 21:15:06 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH] powerpc/ppc-opcode: Fix PPC_RAW_TW()
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <eca9251f1e1f82c4c46ec6380ddb28356ab3fdfe.1659527244.git.christophe.leroy@csgroup.eu>
In-Reply-To: <eca9251f1e1f82c4c46ec6380ddb28356ab3fdfe.1659527244.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1659541432.y9rey7qhxm.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ijKNSpjW8z-QTTXwOl7R4MbyMdscKlHI
X-Proofpoint-ORIG-GUID: jtGXpCJ08l8x186Yh2o2Q8nxISKmJS-t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_03,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 spamscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208030070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy wrote:
> PPC_RAW_TW() is erroneously defined with base code 0x7f000008
> instead of 0x7c000008.
>=20
> That's invisible because its only user is PPC_RAW_TRAP() which is
> 0x7fe00008, but fix it anyway to avoid any risk of future bug.
>=20
> Reported-by: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
> Fixes: d00d762daf12 ("powerpc/ppc-opcode: Define and use PPC_RAW_TRAP() a=
nd PPC_RAW_TW()")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/ppc-opcode.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks.
Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

>=20
> diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include=
/asm/ppc-opcode.h
> index d9703c5fd713..c6d724104ed1 100644
> --- a/arch/powerpc/include/asm/ppc-opcode.h
> +++ b/arch/powerpc/include/asm/ppc-opcode.h
> @@ -571,7 +571,7 @@
> =20
>  #define PPC_RAW_BRANCH(offset)		(0x48000000 | PPC_LI(offset))
>  #define PPC_RAW_BL(offset)		(0x48000001 | PPC_LI(offset))
> -#define PPC_RAW_TW(t0, a, b)		(0x7f000008 | ___PPC_RS(t0) | ___PPC_RA(a)=
 | ___PPC_RB(b))
> +#define PPC_RAW_TW(t0, a, b)		(0x7c000008 | ___PPC_RS(t0) | ___PPC_RA(a)=
 | ___PPC_RB(b))
>  #define PPC_RAW_TRAP()			PPC_RAW_TW(31, 0, 0)
>  #define PPC_RAW_SETB(t, bfa)		(0x7c000100 | ___PPC_RT(t) | ___PPC_RA((bf=
a) << 2))
> =20
> --=20
> 2.36.1
>=20
>=20
