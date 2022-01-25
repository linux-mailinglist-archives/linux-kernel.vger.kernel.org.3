Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E679C49B423
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 13:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241934AbiAYMkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 07:40:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44732 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1383484AbiAYMff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 07:35:35 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PCJwPE031256;
        Tue, 25 Jan 2022 12:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=uGoEhpWT+5nBi9sYi1zFDyYPjs17abSNc6ADbovLhDU=;
 b=FLsIeyS20hJn5w2aMCE2cyNkQu3LRduvwCYIM+n46DHaJPPqHxyolDLOsKNrfa/AxNpD
 AUS/lHNZ+8yuStrqll3b0OtXdzqyEpCZ1U/NC7X0cfA+ziiHThlP0HOF4qidh+wCuvDE
 4ATq9GkFvoRV2LN38gBezxgFOXfqyxwFoad9dBhOUe2H1O3dA+xDnNK+K6LUsS3Lyqmm
 3DdedNlT4XumAQXWDsLg5qeUUuSaeNZfuUkifwcJMG4zcragyMGWtH02Sqns3ZoHc7Ab
 heplU7WCcXctuL24LmB2K/Rh6vYZw3d6NowWBsffWxZYL7seMFDY1maqOXNCweLCBl0v Nw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dtevcbax2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 12:35:29 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20PCVrlL000560;
        Tue, 25 Jan 2022 12:35:27 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3dr9j9cmep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 12:35:27 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20PCZOlI44106200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 12:35:24 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C9F1AE057;
        Tue, 25 Jan 2022 12:35:24 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8AAFAE053;
        Tue, 25 Jan 2022 12:35:23 +0000 (GMT)
Received: from [9.171.4.230] (unknown [9.171.4.230])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jan 2022 12:35:23 +0000 (GMT)
Message-ID: <92c2d051-e25f-7b3a-c811-dd1ce85f1b9b@linux.ibm.com>
Date:   Tue, 25 Jan 2022 13:35:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH] uaccess: Add mechanism for key checked access to user
 memory
Content-Language: en-US
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <YerCfDceDszqbdHU@osiris>
 <20220124103812.2340666-1-scgl@linux.ibm.com> <Ye7kuJ51QWFBGoJ4@osiris>
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
In-Reply-To: <Ye7kuJ51QWFBGoJ4@osiris>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vsBhkIBCjJ_rhSlt5lD3ujFMrTrOo3er
X-Proofpoint-ORIG-GUID: vsBhkIBCjJ_rhSlt5lD3ujFMrTrOo3er
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-25_02,2022-01-25_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201250081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 18:41, Heiko Carstens wrote:
> On Mon, Jan 24, 2022 at 11:38:12AM +0100, Janis Schoetterl-Glausch wrote:
>> KVM on s390 needs a mechanism to do accesses to guest memory
>> that honors storage key protection.
>> __copy_from/to_user_with_key is implemented by introducing
>> raw_copy_from/to_user_with_key.
>> Since the existing uaccess implementation on s390 makes use of move
>> instructions that support having an additional access key supplied,
>> we can implement raw_copy_from/to_user_with_key by enhancing the
>> existing implementation.
>>
>> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
>> ---
>>
>> This works for us and compiles on other architectures (tested x86).
>> The patch only implements __copy_from/to_user_with_key, since those
>> are the ones we actually need. On other architectures those functions
>> don't exists, but they aren't used either, so it's not a problem.
> 
> Adding an API where only underscored function names are to be used can be
> considered suboptimal.
> 
>> Should we also implement single and no underscore variants? Why?
>> Completeness?
> 
> Please make this _fully_ symmetrical to the existing copy_to/from_user()
> implementations, like I tried to say several times. Maybe I wasn't clear
> enough about this. Also the default implementation - that is if an
> architecture makes use of copy_to_user_key() without providing a
> raw_copy_from_user_key() implementation - should fallback to regular
> copy_to_user() semantics, like I tried to outline with the ifndef example
> of raw_copy_from_user_key() previously.

That does help. One thing I'm still confused about is the rational
for the default implementation.
Are you suggesting that copy_from/to_user be implemented in terms of
copy_from/to_user_with_key? I didn't think so, even tho you said something along
those lines, because I assumed you were referring to the architecture specific
implementations for copy_from/to_user, since we weren't talking about
common code changes back then and Christian's suggestion didn't feature it either.

When you say "fully symmetrical" do you mean all functions that wrap architecture
defined access to user space:
__copy_from_user_inatomic
__copy_from_user
__copy_to_user_inatomic
__copy_to_user
_copy_from_user
_copy_to_user
copy_from_user
copy_to_user
__copy_from_user_inatomic_nocache
copy_struct_from_user
copy_from_user_nofault
copy_to_user_nofault
strncpy_from_user_nofault
strnlen_user_nofault
> 
> Furthermore this should be splitted into two patches: one which adds the
> common code infrastructure, like described above; and a second patch which
> adds the actual s390 architecture backend/override.
> 
> The patches should contain a _detailed_ description why the first patch,
> aka API, should probably be in common code (staying in sync with code
> instrumentation, etc.); and of course it should contain enough information
> for people not familiar with s390's storage keys so they can figure out
> what this is about.
> 
> Hopefully we get some feedback and either this is acceptable for common
> code one way or the other, or we have to maintain this on our own, and get
> the additional maintenance cost for free.
> 
> Please make sure to add Al Viro, Kees Cook, Arnd Bergmann, and Andrew
> Morton to cc on your next version, so we hopefully come to a conclusion and
> can move on.

Thanks, will do.
