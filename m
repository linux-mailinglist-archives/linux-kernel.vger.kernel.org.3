Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28135AD04C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbiIEKjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbiIEKj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:39:29 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901CF13DCD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:39:28 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2858uIq9028977;
        Mon, 5 Sep 2022 10:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=GBTY4FYcuHfI5ueJVBWzYH7Pdxgm9BwW83RFqwxuwTM=;
 b=B/aniOivLHgu+Gt43dEPhqyrNK0eExt7f+Bfswv7tYF09LJWiSI6ocEq5taoGZfyZW2X
 CC2CscMXFaLppEALKf4Ctqt4miTp34L7nuTqD1usNYW6fQEpU8JX6TVafBUaxuxUHQYK
 pSy+pKnu+gmkV/cNFuC66g9qzHyCk6vm0+Z8c3KX6JKjbVnWzDnE4/CLpKycH9cOy0i3
 +0xwFi3IBAj5IeQUmr8HqRW5vlQcF9qgoHcHyebc6aji/G4EagT8i6ZuLq8CCxcAMPp5
 /Z75U2SYHWsIy6Sf5ypUTtVW4dVKcDICEbpRQQGPa1yRgYQATK7Cju7yoIA/jqqi+k/r mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jde1sb5dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 10:38:02 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2859pIaZ026973;
        Mon, 5 Sep 2022 10:38:02 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jde1sb5c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 10:38:01 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 285Aa3Ma030440;
        Mon, 5 Sep 2022 10:38:00 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3jbxj8spn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 10:37:59 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 285AYVtT38601170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Sep 2022 10:34:31 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A7A0A405B;
        Mon,  5 Sep 2022 10:37:57 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5AEBA4059;
        Mon,  5 Sep 2022 10:37:56 +0000 (GMT)
Received: from localhost (unknown [9.43.114.209])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  5 Sep 2022 10:37:56 +0000 (GMT)
Date:   Mon, 05 Sep 2022 16:07:55 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 15/16] objtool/powerpc: Enable objtool to be built on
 ppc
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "chenzhongjin@huawei.com" <chenzhongjin@huawei.com>,
        "Elliott, Robert (Servers)" <elliott@hpe.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
References: <20220829055223.24767-1-sv@linux.ibm.com>
        <20220829055223.24767-16-sv@linux.ibm.com>
        <33924523-5437-eb9a-116a-8e249ce99bd2@csgroup.eu>
In-Reply-To: <33924523-5437-eb9a-116a-8e249ce99bd2@csgroup.eu>
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1662373828.xrnduc1uco.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jgjlZb4ObY8iiB9fAnBgAt3jhZYYSwtD
X-Proofpoint-GUID: iF1ZGt_6bnuxfTVL8qnCUkP4fSCCh0Tv
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-05_07,2022-09-05_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=939
 adultscore=0 clxscore=1011 mlxscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209050051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy wrote:
>=20
>=20
> Le 29/08/2022 =C3=A0 07:52, Sathvika Vasireddy a =C3=A9crit=C2=A0:
>>=20
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 4c466acdc70d..dc05cd23c233 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -237,6 +237,7 @@ config PPC
>>   	select HAVE_MOD_ARCH_SPECIFIC
>>   	select HAVE_NMI				if PERF_EVENTS || (PPC64 && PPC_BOOK3S)
>>   	select HAVE_OPTPROBES
>> +	select HAVE_OBJTOOL			if PPC32 || MPROFILE_KERNEL
>=20
> Why restrict it to MPROFILE_KERNEL ? In your RFC it was for all PPC64.
>=20
> Recent discussion on the list shows new problem with recordmcount, see=20
> https://lore.kernel.org/all/MW5PR84MB184250EA1CAE04497C1E7CE9AB769@MW5PR8=
4MB1842.NAMPRD84.PROD.OUTLOOK.COM/
>=20
> Those ones are with ppc64 big endian, so objtool would be welcome here=20
> as well.

I don't think adding support for objtool on ppc64 elfv1 is a good idea.=20
While it might solve the immediate issue with recordmcount, I worry that=20
the function descriptors and dot symbols in ppc64 elfv1 might throw up=20
issues in the future causing maintenance overhead.


- Naveen
