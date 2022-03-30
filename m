Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F95C4EBE3D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245096AbiC3KD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245084AbiC3KDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:03:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952CEBAB9E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 03:01:40 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22U8HXxo027709;
        Wed, 30 Mar 2022 10:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=kQW9mPizhJGzxYMtGJ7PDAB33c2sE1FSIhgbNgA2hx8=;
 b=PjS1EFIyw/zW70ClbaX5YxFi6Qb8vvcd1pf/M+F72PWXDA7AyjjhQhf7z67TRisE8uWY
 BHwEaZKM+EzEWsAxA2QbG7B3sAWByiDJ1ztPREd7hLp6yFxMgagqTp/o7bCdNQ7RQRCV
 9pbeKKQVa9TLBRtVHut7OTKvxkMfK5XjYsG2+Zhel4z/5vc7rROBE7TVNr5cyjB2PlFR
 QVyzMwWW6WrEDAxOQhCgOiS2D8/+qNhG81O+yYYeCIIu+7LGbrNMH5Zm6elfp16HLwCQ
 yUSdi93Fftdpe+FgcJqlGwG4jiaY8vPpoPFvsbr72sv1nSC3xpzxPT1/L31JAY5xfHMc xg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f3yqmk3ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 10:01:21 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22U9rPHN032506;
        Wed, 30 Mar 2022 10:01:18 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3f3rs3k5w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 10:01:18 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22UA1GSc37683576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 10:01:16 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3170AA405F;
        Wed, 30 Mar 2022 10:01:16 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3570A404D;
        Wed, 30 Mar 2022 10:01:15 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 30 Mar 2022 10:01:15 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] entry: fix compile error in
 dynamic_irqentry_exit_cond_resched()
References: <20220330084328.1805665-1-svens@linux.ibm.com>
        <YkQdMDlIt1iHWS3U@FVFF77S0Q05N> <yt9dilrvztno.fsf@linux.ibm.com>
        <YkQog3+80izN1e1q@FVFF77S0Q05N>
Date:   Wed, 30 Mar 2022 12:01:15 +0200
In-Reply-To: <YkQog3+80izN1e1q@FVFF77S0Q05N> (Mark Rutland's message of "Wed,
        30 Mar 2022 10:53:07 +0100")
Message-ID: <yt9dee2jzrmc.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0C4c2wXXIdyfI4nJnqzU8vwqXEeISIRm
X-Proofpoint-ORIG-GUID: 0C4c2wXXIdyfI4nJnqzU8vwqXEeISIRm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-30_03,2022-03-29_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=709 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203300049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Rutland <mark.rutland@arm.com> writes:

>> I was wondering whether we can make dynamic_irqentry_exit_cond_resched()
>> static, so it gets inlined. On s390 the compiler generates a branch to
>> that function just to return immediately if the static key isn't enabled.
>> With static it would get inlined, and therefore save one function call.
>> What do you think?
>
> I appreciate that it saves one call, but does that actually matter in practice,
> given this is called only once per interrupt?
>
> I'm not fundamentally opposed to changing it, but doing so would make it
> different from all the other dynamic_*() cases which need the check to be
> out-of-line to avoid bloating the callers, and it's not clear to me that we'd
> gain much by doing so.
>
> FWIW, on arm64 we had some additional conditions we have to check, so we roll
> our own (out-of-line) implementation anyway. So doing something arch-specific
> is also an option.

I didn't measure it, i just noticed it by looking at the generated code.
Given your argument about consistency with the other functions i think
we leave it that way.

Thanks!
Sven
