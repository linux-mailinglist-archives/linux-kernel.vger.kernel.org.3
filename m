Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B675327B5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 12:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiEXKcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 06:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbiEXKcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 06:32:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8FA4DF6E
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 03:32:12 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24OATmLh014169;
        Tue, 24 May 2022 10:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=/m8DhKGVtcR8HLvGNjWIfJFBuZl41fbk66nEHHNCGxw=;
 b=WTagwtfop5txy6h9hvg2ZMvxQp4LenUuqrabBpIyvztBJKg91VRTZcF1JS2TNAYpy6V4
 cX910lmH6uwLoZPytyCMJyj8hcyrlnH7wE6OQ52AOQdngoeGTtGBJlx1tml06jtIurQv
 LuWN27zFFpD1oMzMg7EjagMMK7jISrCLWkqJygamWK79yPBDEcd47QTo23nLWDGK5AsN
 LcPSdCShp/H2jpJYhbwMXTItdo5ijt591J3Mumwq6H+VjNvGGscK+OCF0TSsQLW6v6iP
 vqAtOulyAuplXaMSM7XU9n/910VeJP1XgdXxL/1tPW51O0izFNY9kUCgln6Z3hx9q6lt 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g8wnjg1cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 10:31:56 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24OAVtIW025010;
        Tue, 24 May 2022 10:31:55 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g8wnjg1by-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 10:31:55 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24OASOcR031884;
        Tue, 24 May 2022 10:31:53 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3g6qq9c950-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 10:31:52 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24OAVoVS57082274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 10:31:50 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5ECA042041;
        Tue, 24 May 2022 10:31:50 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 138054203F;
        Tue, 24 May 2022 10:31:50 +0000 (GMT)
Received: from localhost (unknown [9.199.154.182])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 24 May 2022 10:31:50 +0000 (GMT)
Date:   Tue, 24 May 2022 16:01:48 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/4] objtool: Add --mnop as an option to --mcount
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
References: <20220523175548.922671-1-sv@linux.ibm.com>
        <20220523175548.922671-2-sv@linux.ibm.com>
        <26c7bfc8-3089-034a-70c0-8857d7cd3a99@csgroup.eu>
        <1653386854.o7nss9hzc9.naveen@linux.ibm.com>
        <d45030be-3f6b-ebeb-3d63-bf7a96d3ff3b@csgroup.eu>
In-Reply-To: <d45030be-3f6b-ebeb-3d63-bf7a96d3ff3b@csgroup.eu>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1653388084.w21cyb07gc.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NtPwJkaJymo2Fqfbgp7Zemx2kODiyhSG
X-Proofpoint-ORIG-GUID: SHgXzlRC-NVmY8hXFYbnJn5_4LFuYefY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-24_06,2022-05-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0 mlxlogscore=879
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205240053
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
> Le 24/05/2022 =C3=A0 12:15, Naveen N. Rao a =C3=A9crit=C2=A0:
>> Christophe Leroy wrote:
>>>
>>>
>>> Le 23/05/2022 =C3=A0 19:55, Sathvika Vasireddy a =C3=A9crit=C2=A0:
>>>> Architectures can select HAVE_NOP_MCOUNT if they choose
>>>> to nop out mcount call sites. If that config option is
>>>> selected, then --mnop is passed as an option to objtool,
>>>> along with --mcount.
>>>>
>>>
>>> Is there a reason not to nop out mcount call sites on powerpc as well ?
>>=20
>> Yes, if there are functions that are out of range of _mcount(), then the=
=20
>> linker would have inserted long branch trampolines. We detect such cases=
=20
>> during boot. But, if we nop out the _mcount call sites during build=20
>> time, we will need some other way to identify these.
>>=20
>=20
> But does it really matter whether _mcount is reachable or not ?
>=20
> _mcount is never used, and the function we want to call in lieu of=20
> _mcount might be reachable while _mcount is not or might be unreachable=20
> while _mcount is.

For the most part, we will end up having to go to ftrace_caller or=20
ftrace_regs_caller, both of which will usually be close to _mcount.

We need to know for sure either way. Nop'ing out the _mcount locations=20
at boot allows us to discover existing long branch trampolines. If we=20
want to avoid it, we need to note down those locations during build=20
time.

Do you have a different approach in mind?


- Naveen

