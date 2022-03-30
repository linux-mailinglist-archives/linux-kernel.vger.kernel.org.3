Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8314EBD76
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244712AbiC3JTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243487AbiC3JTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:19:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BFEBE13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:17:30 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22U7cMSJ007168;
        Wed, 30 Mar 2022 09:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=sm0sKW1W9X+c/EuoDOAoBv4EHRB6yK0AJ74dh57gRc4=;
 b=rvxVqFhHqfJ3O3l3CmPXFwzhRKdLMonBgSMraDwdXbwNPWPtt54j4lIHWfV7Lk5lo+Kq
 dKzt9b7kE/LWDqUczl7IOPiCbnfd6yqiAENte0nl+xkjJNKDg+H915IoPkzeREdLPo/w
 CxjvWtpZu3W9KP73dbh8WhtutKEqAIpYFDxP9QqpaQdLrvKIgUlvIbiGnS+aFOA3LaQA
 olu89Aqjclkq+g1OIvW4uejIvlACZAXBdBz3yRFYl4IJwLFg/TBycF6fDdTYcXSD6+fp
 acuY0FtBmkdPC7aZT3ejAr8C4IYw1Czjl8peHUHUVVRJOMRFoff0nhBaB8vV+RwNWEQK nQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f3y91jghm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 09:17:20 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22U98M6f023778;
        Wed, 30 Mar 2022 09:17:18 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3f1tf903du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 09:17:18 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22U9HGWQ42729840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 09:17:16 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A51342042;
        Wed, 30 Mar 2022 09:17:16 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D80AE42041;
        Wed, 30 Mar 2022 09:17:15 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 30 Mar 2022 09:17:15 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] entry: fix compile error in
 dynamic_irqentry_exit_cond_resched()
References: <20220330084328.1805665-1-svens@linux.ibm.com>
        <YkQdMDlIt1iHWS3U@FVFF77S0Q05N>
Date:   Wed, 30 Mar 2022 11:17:15 +0200
In-Reply-To: <YkQdMDlIt1iHWS3U@FVFF77S0Q05N> (Mark Rutland's message of "Wed,
        30 Mar 2022 10:04:48 +0100")
Message-ID: <yt9dilrvztno.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain; charset=utf-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IfvpzcPtNn2l-hgvewgpB3qvGiFSUBGz
X-Proofpoint-GUID: IfvpzcPtNn2l-hgvewgpB3qvGiFSUBGz
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-30_03,2022-03-29_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203300046
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Rutland <mark.rutland@arm.com> writes:

> On Wed, Mar 30, 2022 at 10:43:28AM +0200, Sven Schnelle wrote:
>> kernel/entry/common.c: In function =E2=80=98dynamic_irqentry_exit_cond_r=
esched=E2=80=99:
>> kernel/entry/common.c:409:14: error: implicit declaration of
>> function =E2=80=98static_key_unlikely=E2=80=99; did you mean =E2=80=98st=
atic_key_enable=E2=80=99?
>> [-Werror=3Dimplicit-function-declaration]
>>   409 |         if (!static_key_unlikely(&sk_dynamic_irqentry_exit_cond_=
resched))
>>       |              ^~~~~~~~~~~~~~~~~~~
>>       |              static_key_enable
>>=20
>> static_key_unlikely() should be static_branch_unlikely().
>>=20
>> Fixes: 99cf983cc8bca ("sched/preempt: Add PREEMPT_DYNAMIC using static k=
eys")
>> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
>
> Sorry about this. FWIW:
>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
>
> For context for others, this'll only show up on architectures which both =
use
> the generic entry code and select CONFIG_HAVE_PREEMPT_DYNAMIC_KEY. Today,=
 only
> arm64 selects CONFIG_HAVE_PREEMPT_DYNAMIC_KEY, and it doesn't use the gen=
eric
> entry code.
>
> Sven, I assume you're looking at wiring this up on s390 or parisc?

Yes, i'm looking whether we can use the same implementation on s390. :)

I reported it already on 03/18, but looks like that Mail was lost
somehow:

https://www.spinics.net/lists/kernel/msg4283802.html

I was wondering whether we can make dynamic_irqentry_exit_cond_resched()
static, so it gets inlined. On s390 the compiler generates a branch to
that function just to return immediately if the static key isn't enabled.
With static it would get inlined, and therefore save one function call.
What do you think?

Thanks
Sven

