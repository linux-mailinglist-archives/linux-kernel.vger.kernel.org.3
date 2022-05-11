Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAF1523B0E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345272AbiEKRCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237247AbiEKRCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:02:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F4862BC8;
        Wed, 11 May 2022 10:02:13 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BESnxr027991;
        Wed, 11 May 2022 17:02:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=8s5rkaVXoRu/HCmOcYXClgG+6sD0OJWx7GGHwkIIgm0=;
 b=f9UzhAhf+kHnRKGIdlG11bHT9Npf9wMLUhNwQAWXuxDqiQCyIlC69cblQpSJXllQeM1T
 QeIPZ2ohqV4tS1PP92x5ve6DgN/oA4Iaykvn6UjHF9/YEkTafZlQ0RvG/0mFkQDrd4c0
 g6FaXBlB0Ht2PH8R2J8Z+j8FvxzL47auuU6eCAHxacoLjy5c+DSTgIOW+ZDOsV3nn8RD
 fwpRo9Nz7jXrLe0y2pEiSPiSvqdEKo7IJUNPRxSQq3sd5g6PC0cZCRiHJNF8eNj4nBBI
 Z707lwpWWTKrhXc7Dhgb0jz0eZGP1lqhss+wNslMcUmEkgYMfgnsH0Neg8gvgJi80NSs 9Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0etx3e1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 17:02:10 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24BGSjap012046;
        Wed, 11 May 2022 17:02:09 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0etx3e07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 17:02:09 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24BGpT1q031504;
        Wed, 11 May 2022 17:02:06 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3fyrkk1p4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 17:02:06 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24BH22nM42991896
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 17:02:02 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 214A611C052;
        Wed, 11 May 2022 17:02:02 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 989BF11C04C;
        Wed, 11 May 2022 17:02:01 +0000 (GMT)
Received: from osiris (unknown [9.145.80.150])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 11 May 2022 17:02:01 +0000 (GMT)
Date:   Wed, 11 May 2022 19:02:00 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jonas Paulsson <paulsson@linux.vnet.ibm.com>,
        Ulrich Weigand <ulrich.weigand@de.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/8] s390/alternatives: remove padding generation code
Message-ID: <YnvsCPIXmCmzlDlX@osiris>
References: <20220511120532.2228616-1-hca@linux.ibm.com>
 <20220511120532.2228616-3-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511120532.2228616-3-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y3pLf4oX4VlR0d1A5vV4-CIkXXhZXjdl
X-Proofpoint-ORIG-GUID: SsEsAkTMGBmucMXo4udQSFa5IEc14j85
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=703 bulkscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2205110078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 02:05:26PM +0200, Heiko Carstens wrote:
> clang fails to handle ".if" statements in inline assembly which are heavily
> used in the alternatives code.

FWIW, I missed to add error message(s) to the changelog:

In file included from ./include/linux/spinlock.h:93:
./arch/s390/include/asm/spinlock.h:81:3: error: expected absolute expression
                ALTERNATIVE("", ".insn rre,0xb2fa0000,7,0", 49) /* NIAI 7 */
                ^
./arch/s390/include/asm/alternative.h:118:2: note: expanded from macro 'ALTERNATIVE'
        ALTINSTR_REPLACEMENT(altinstr, 1)                               \
        ^
./arch/s390/include/asm/alternative.h:113:2: note: expanded from macro 'ALTINSTR_REPLACEMENT'
        INSTR_LEN_SANITY_CHECK(altinstr_len(num))
        ^
./arch/s390/include/asm/alternative.h:62:3: note: expanded from macro 'INSTR_LEN_SANITY_CHECK'
        ".if " len " > 254\n"                                           \
         ^
<inline asm>:5:5: note: instantiated into assembly here
.if 6651b-6641b > 254
    ^
