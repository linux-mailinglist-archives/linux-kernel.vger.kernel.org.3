Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEC05B10D4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 02:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiIHAPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 20:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiIHAPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 20:15:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFA79FA96
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 17:15:37 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 287MUmXb013190;
        Thu, 8 Sep 2022 00:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version; s=pp1; bh=ZEltXJ56ajhUe2tIEoizWRKaA2A7xzVX9vMtFnTCcUk=;
 b=nm3sF/ubaDQHSZnoepWKhACJdPV8Se9tvfgXmYb4JjlGY20Tj7/yOs+gw1je5aoUsmKg
 VG+yH/oI6EHeTc+cJRCBhUXEStfdGjqcq5LWhmciyisj9CUtILJbWNWFAFpEXRx96XPd
 kdBjXkNUT5qjVRhbvsoFD+ceHG0BYrkHjLUr4KpF4jmsA4CKo9rnOycf+DoIe4bJ5CVX
 Qj2575SoiL9qy9hPJ48rDZ3nMyQSi91pXNJjlpXETK6OAscC23Cm2XXbKbQdgD3QH/ND
 wrE2vvcPl5VqbBlhdl9EHMHLUtJkkzyeckX5qRDsnakZj7nJ71XEhOjiz0+LLQaELbHH 0Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jf45majq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 00:14:18 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28800KPf023627;
        Thu, 8 Sep 2022 00:14:17 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jf45majnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 00:14:17 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28806W9R006965;
        Thu, 8 Sep 2022 00:14:14 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3jbxj8wt6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 00:14:14 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2880ECIV35717464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Sep 2022 00:14:12 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 046A14203F;
        Thu,  8 Sep 2022 00:14:12 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A113342041;
        Thu,  8 Sep 2022 00:14:11 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  8 Sep 2022 00:14:11 +0000 (GMT)
Received: from [10.61.2.107] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 18F1A602EB;
        Thu,  8 Sep 2022 10:14:10 +1000 (AEST)
Message-ID: <47772b9ae10be6dbe5b0cfcd0bc14efc8fb22c0c.camel@linux.ibm.com>
Subject: Re: [PATCH v2 0/7] Implement inline static calls on PPC32 - v2
From:   Benjamin Gray <bgray@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Jason Baron <jbaron@akamai.com>,
        Ingo Molnar <mingo@redhat.com>,
        "sv@linux.ibm.com" <sv@linux.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "agust@denx.de" <agust@denx.de>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Date:   Thu, 08 Sep 2022 10:13:57 +1000
In-Reply-To: <d35a2039-1755-b0be-6733-bb7ec19b2ea8@csgroup.eu>
References: <cover.1657301423.git.christophe.leroy@csgroup.eu>
         <CAMj1kXFqs=YAbTDJOgzpse9ZkggSxPNNJJphEA=J94FQzF55qg@mail.gmail.com>
         <d35a2039-1755-b0be-6733-bb7ec19b2ea8@csgroup.eu>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-WWbX6z7r0y1yL9TfB4uB"
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v3GAZKU5SsXjG5pDxd9t9HvtEndSIvEp
X-Proofpoint-ORIG-GUID: u1UdbCCnobYiCQCXwPq0onbnLvlzB0-F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_10,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 impostorscore=0 phishscore=0 mlxscore=0 priorityscore=1501 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209070088
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WWbX6z7r0y1yL9TfB4uB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2022-09-01 at 16:46 +0000, Christophe Leroy wrote:
> Surprisingly, I get worst performance with inline static call than
> with=20
> out of line static call:

I'm not sure what hackbench is doing, but when microbenchmarking 64 bit
out-of-line calls in a loop I saw a similar thing where adding more
indirection improved the performance despite doing more work. The cause
seemed to be a combination of using older hardware and the target being
too short (just an integer increment). Moving to a newer machine and
adding a lot of NOPs to the target made the performance make sense.

--=-WWbX6z7r0y1yL9TfB4uB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZBU/uXBOXyOcthtB2V5JPzcRbYwUCYxkzxQAKCRB2V5JPzcRb
Y5ANAQCtq5gqxsuqsnj4PNcdhDxdIwjJ1xWdzadoauMrpaeTkAEA+PFvFtRbb4pe
33Eb8TrRhen+BbD9crA5+UmCQX2ZKAM=
=TVgb
-----END PGP SIGNATURE-----

--=-WWbX6z7r0y1yL9TfB4uB--

