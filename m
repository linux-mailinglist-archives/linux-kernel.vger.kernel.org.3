Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12356498721
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244748AbiAXRlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:41:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57120 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244736AbiAXRlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:41:21 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20OGkZJH011608;
        Mon, 24 Jan 2022 17:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=KBtcrcZN2Dj1v8WNpi2XQD0gccBGNu2VLbHvNql5mQQ=;
 b=kWq6BwqQPrt9psLLDQhNXPT/oJp8kerdsRRIvrOqU/rnVAaAEGAUGEHvfFeSxt5w0g8d
 fSDdWLfw5ljLhcEmUfzwgM+o8leZTNktc5SRea0fHjieEfnXx78JNI0f/NF+Q+Ti4aYP
 qsDOdBqFzKHmv/lJK8ZRDg2RdkmKJxQAf4Embrv2Kyjjqf2dIx7xI78HHmrmN4tI4wlz
 nbCGCufm50/2Q0eVBWmRE4wUoKXplcD7O2jxyhtJrTxmiGbqwmobpnEt9lC+s6c3vasz
 HU5RgutDx0RjFxsHpnBDxpXAWz6VCAmMJfvuSDv7+ycASs93lMZywadZWo2vG1e+bgqf qg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dsyx9sgct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jan 2022 17:41:19 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20OHcGG3010220;
        Mon, 24 Jan 2022 17:41:17 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3dr96j71t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jan 2022 17:41:17 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20OHVhDt43712958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 17:31:43 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21477A4054;
        Mon, 24 Jan 2022 17:41:14 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE476A405C;
        Mon, 24 Jan 2022 17:41:13 +0000 (GMT)
Received: from osiris (unknown [9.145.65.174])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 24 Jan 2022 17:41:13 +0000 (GMT)
Date:   Mon, 24 Jan 2022 18:41:12 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] uaccess: Add mechanism for key checked access to
 user memory
Message-ID: <Ye7kuJ51QWFBGoJ4@osiris>
References: <YerCfDceDszqbdHU@osiris>
 <20220124103812.2340666-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124103812.2340666-1-scgl@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rj8QOKdQUuEwR0-vuUm2njUYNKDE0nSx
X-Proofpoint-ORIG-GUID: rj8QOKdQUuEwR0-vuUm2njUYNKDE0nSx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-24_09,2022-01-24_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201240116
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 11:38:12AM +0100, Janis Schoetterl-Glausch wrote:
> KVM on s390 needs a mechanism to do accesses to guest memory
> that honors storage key protection.
> __copy_from/to_user_with_key is implemented by introducing
> raw_copy_from/to_user_with_key.
> Since the existing uaccess implementation on s390 makes use of move
> instructions that support having an additional access key supplied,
> we can implement raw_copy_from/to_user_with_key by enhancing the
> existing implementation.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
> 
> This works for us and compiles on other architectures (tested x86).
> The patch only implements __copy_from/to_user_with_key, since those
> are the ones we actually need. On other architectures those functions
> don't exists, but they aren't used either, so it's not a problem.

Adding an API where only underscored function names are to be used can be
considered suboptimal.

> Should we also implement single and no underscore variants? Why?
> Completeness?

Please make this _fully_ symmetrical to the existing copy_to/from_user()
implementations, like I tried to say several times. Maybe I wasn't clear
enough about this. Also the default implementation - that is if an
architecture makes use of copy_to_user_key() without providing a
raw_copy_from_user_key() implementation - should fallback to regular
copy_to_user() semantics, like I tried to outline with the ifndef example
of raw_copy_from_user_key() previously.

Furthermore this should be splitted into two patches: one which adds the
common code infrastructure, like described above; and a second patch which
adds the actual s390 architecture backend/override.

The patches should contain a _detailed_ description why the first patch,
aka API, should probably be in common code (staying in sync with code
instrumentation, etc.); and of course it should contain enough information
for people not familiar with s390's storage keys so they can figure out
what this is about.

Hopefully we get some feedback and either this is acceptable for common
code one way or the other, or we have to maintain this on our own, and get
the additional maintenance cost for free.

Please make sure to add Al Viro, Kees Cook, Arnd Bergmann, and Andrew
Morton to cc on your next version, so we hopefully come to a conclusion and
can move on.
