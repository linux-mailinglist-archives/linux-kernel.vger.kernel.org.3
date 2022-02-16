Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1734B84F5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiBPJwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:52:31 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiBPJwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:52:24 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3514E08B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:51:55 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21G976Ah026432;
        Wed, 16 Feb 2022 09:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=yf4t3ShCrKuXwWCOP4KRr37srROtug739mg8Yy/Gjss=;
 b=mZpIrIE0Bk1S2N/RUsao3D779LfpndDPcd0mz+IJdNryTTJL7oOfhszSYXLDdvyUeoOF
 dUPZDoid7eNypkPWO8sbgOsh4I79ZxRCu7wd0Fm+yA+65b4b/axIbosMEZdMdL3xL8bT
 nKjLQFKMjFWyRBskmT+JT0LfGpFulHfdtFZkVbUC4R1xyHaXhygnHzIfPrwIDjv8Q0To
 qkG2bZjro6FkkioblICM1E07o5tPwSEbdwAjD6aE5oEK4xPBFdwoyQTL24O9GxxOmSKL
 zQfbtoTRdCV5WMLm5vN5pgce/nRu+x44QLRl3q8N6g/HJh1pwgL9IfXFDs9CmkN9hg8A Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e8spgebjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 09:51:25 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21G9YCXc029763;
        Wed, 16 Feb 2022 09:51:24 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e8spgebhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 09:51:24 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21G9gfmx027926;
        Wed, 16 Feb 2022 09:51:22 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3e645jxvvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 09:51:22 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21G9pJXM39518630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 09:51:19 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C8A2A4066;
        Wed, 16 Feb 2022 09:51:19 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C334AA405B;
        Wed, 16 Feb 2022 09:51:18 +0000 (GMT)
Received: from localhost (unknown [9.43.36.29])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Feb 2022 09:51:18 +0000 (GMT)
Date:   Wed, 16 Feb 2022 15:21:17 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH kernel] trace: Make FTRACE_MCOUNT_USE_RECORDMCOUNT
 configurable
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Ingo Molnar <mingo@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>
References: <20220211014313.1790140-1-aik@ozlabs.ru>
        <CAKwvOdkKsoYw9KOfwdHYg7OkTz0TQ6YgZZcqQ5PNg+_O1Q5bgg@mail.gmail.com>
        <CABCJKudj5VJ-f+QU0qmnODoadEzpVME2rXhtUZbzrEV8o69hqQ@mail.gmail.com>
        <5b021d73-51c1-164f-6136-483eeebef6fb@ozlabs.ru>
In-Reply-To: <5b021d73-51c1-164f-6136-483eeebef6fb@ozlabs.ru>
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1645004616.cxeynmpwuy.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FPBhCMV6JrxnCylzAp7nmoDIStgx8mBy
X-Proofpoint-ORIG-GUID: n4IDfE2iqmYzbW99sdWTVmaLfXbGssWw
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_04,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxscore=0 clxscore=1011
 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0 mlxlogscore=981
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160054
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Kardashevskiy wrote:
>=20
>=20
> On 2/15/22 03:10, Sami Tolvanen wrote:
>> On Fri, Feb 11, 2022 at 4:11 PM Nick Desaulniers
>> <ndesaulniers@google.com> wrote:
>>>
>>> + Sami, Kees
>>>
>>> Do you guys remember why we don't support
>>> FTRACE_MCOUNT_USE_RECORDMCOUNT with LTO?
>>=20
>> It's because recordmcount cannot distinguish between calls and other
>> references to mcount/fentry, which is a problem with LTO where we have
>> to process the entire vmlinux.o and cannot ignore individual
>> translation units. Instead of resorting to workarounds, Peter was kind
>> enough to implement a smarter mcount pass in objtool, which we now use
>> on x86_64 with LTO.

I had responded on a different thread about this:
http://lkml.kernel.org/r/1644579444.bal9kji6uc.naveen@linux.ibm.com

We are working on enabling 'objtool check --mcount' on powerpc.

>=20
>=20
> So can x86_64 have both FTRACE_MCOUNT_USE_RECORDMCOUNT and LTO?

No. x86_64 now supports HAVE_OBJTOOL_MCOUNT, which enables=20
FTRACE_MCOUNT_USE_OBJTOOL. That allows LTO to be used.


- Naveen
