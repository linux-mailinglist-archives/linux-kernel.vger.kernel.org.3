Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4E44D2E35
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiCILg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiCILg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:36:56 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A71154D31
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 03:35:58 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 229BJ10F030689;
        Wed, 9 Mar 2022 11:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=O2BUNUTzGb+7cQ8rm8DHMyjnM+LWM5EfmcO0Tz4pHzw=;
 b=Xjv54iykDrpDbsZcGuj81AUJEypYqnHR1rz8TI+lyQAewWuFK9fxoso/EO3KdJA6grAw
 5YrgU/9v/HZ+9HDbgFacb20zYwfuR9uBPjMQzE1nzYUz/V1N3iRIPWKvKiLEcQbumj3O
 OHqFADbes+gvcjgtT34s5k4pvZ3NFE01i2pbYp7Td8QMPsgzcEi1fXAkCRW/GXHNLYK7
 TehAImu6qsW5fHNIgQ+pdSZ/uMl6TUaQox/pnzwUgpeiFgs7dCBQTxE3BgtbL4LCIA6N
 +JlGmY5NeBqXseK5+0QjMuiwhVJWWTv4zGsPeMnI/PNwnIkSOR5Ew9LHDitbafgBUEXI Ug== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3enww82uda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 11:35:36 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 229BXlLq014484;
        Wed, 9 Mar 2022 11:35:33 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3ekyg90h15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 11:35:33 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 229BZVXD50397678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Mar 2022 11:35:31 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DF9042047;
        Wed,  9 Mar 2022 11:35:31 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E74E442042;
        Wed,  9 Mar 2022 11:35:30 +0000 (GMT)
Received: from localhost (unknown [9.43.9.116])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Mar 2022 11:35:30 +0000 (GMT)
Date:   Wed, 09 Mar 2022 17:05:29 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 2/4] powerpc/ftrace: Refactor ftrace_{regs_}caller
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <ec286d2cc6989668a96f14543275437d2f3f0e3a.1645099283.git.christophe.leroy@csgroup.eu>
        <9d7df9e4fc98a86051489f61d3c9bc67f92f7e27.1645099283.git.christophe.leroy@csgroup.eu>
        <1646326634.jzerx009p9.naveen@linux.ibm.com>
        <5c0a3a26-ee52-a4f7-9bc2-b38f27a12a76@csgroup.eu>
In-Reply-To: <5c0a3a26-ee52-a4f7-9bc2-b38f27a12a76@csgroup.eu>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1646825481.p25t8oi12m.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EuvBYT_Q0yDRCRNv2BxaO7OCSMM--y8m
X-Proofpoint-GUID: EuvBYT_Q0yDRCRNv2BxaO7OCSMM--y8m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-09_04,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 mlxlogscore=986 phishscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203090063
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy wrote:
>=20
>=20
> Le 03/03/2022 =C3=A0 17:59, Naveen N. Rao a =C3=A9crit=C2=A0:
>> Christophe Leroy wrote:
>>
>> The ability to disable ftrace in certain code paths through=20
>> paca_struct->ftrace_enabled will also be relevant on ppc32 - it will be=20
>> nice if it can be introduced there.
>=20
> Ah ? I understood from commit ea678ac627e0 ("powerpc64/ftrace: Add a=20
> field in paca to disable ftrace in unsafe code paths") that it was for=20
> when it runs in real mode. PPC32 doesn't run any C code in real mode.

It likely isn't necessary in that case.

>=20
> Are there any other situations that real_mode where we'd like to disable=20
> it ? If so we could use the thread_struct as we don't have paca on PPC32.

For ppc64, we use this flag to disable certain paths in kvm, kexec,=20
mce/hmi and idle/hotplug. If none of those are problematic on ppc32,=20
then this isn't necessary.


Thanks,
- Naveen

