Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2206C50B8A9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447938AbiDVNj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448067AbiDVNjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:39:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324AD4F46B;
        Fri, 22 Apr 2022 06:37:01 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MCiHhA025833;
        Fri, 22 Apr 2022 13:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : content-type :
 mime-version; s=pp1; bh=VyQebr7yOdrQbt8DYFcva59WTdAH9zD09P6uLQXpWYQ=;
 b=QXbFwmgCvIcUpUbl6vwzybx10o5Lpyl11b7nu86jYVHlAx8Fm7Iy04oxJfA6+kTPpECx
 InSuOUPRohR7mnup4rRe5yZIpGyrLFR8ZkRfWnjjXgXRQFHaIK8JsJQ3t9Q6DnU4ZVtJ
 c3xf0qGfX3Ca6MDxamRJOFVqao6DAS4Gx3zz1D4HtL1VN6ye0E2D8l5UoukUiGIGg5H6
 b+yi85E5XCkhlkVA+xkHF3akQfHbF2SrN/3k7c/IZv48a3ergksupJaHwMxQ9I96JdOe
 j5hnJtZ0WEATtpHzwzwBRtxl3FAafZzdOgdNZ3EG7bXemxYG+SdXd4Zu2t9KeLypuAwA Gw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fkm5q2nmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 13:36:58 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23MDLJMJ030707;
        Fri, 22 Apr 2022 13:36:55 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3ffne8sed6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 13:36:55 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23MDb40T9044594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 13:37:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C91FF11C04C;
        Fri, 22 Apr 2022 13:36:52 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8873E11C04A;
        Fri, 22 Apr 2022 13:36:52 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 22 Apr 2022 13:36:52 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org, krebbel@linux.ibm.com,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: -Warray-bounds fun again
References: <yt9dzgkelelc.fsf@linux.ibm.com>
        <CAHk-=wgv4NLtEowsmX+0jq_nBWXFp8jtruX6U3SDm52N=ftkgg@mail.gmail.com>
Date:   Fri, 22 Apr 2022 15:36:52 +0200
In-Reply-To: <CAHk-=wgv4NLtEowsmX+0jq_nBWXFp8jtruX6U3SDm52N=ftkgg@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 21 Apr 2022 09:10:33 -0700")
Message-ID: <yt9dilr1kznv.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6ezghKyRCNCosEJHNXa1JwhFpeyP2ARJ
X-Proofpoint-GUID: 6ezghKyRCNCosEJHNXa1JwhFpeyP2ARJ
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_03,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2204220059
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Apr 21, 2022 at 7:02 AM Sven Schnelle <svens@linux.ibm.com> wrote:
>>
>> The obvious 'fix' is to use absolute_pointer():
>>
>> #define S390_lowcore (*((struct lowcore *)absolute_pointer(0)))
>>
>> That makes the warning go away, but unfortunately the compiler no longer
>> knows that the memory access is fitting into a load/store with a 12 bit
>> displacement.
>
> In the gcc bugzilla for us needing to do these games:
>
>     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578
>
> one of the suggestions was "I recommend suppressing the warning either
> by #pragma GCC diagnostic or by making the pointer volatile".
>
> But READ_ONCE() should already be doing that volatile thing, so that
> suggestion may not work with gcc-12 any more.
>
> It is *possible* that gcc-12 has now special-cased the very special
> issue of a cast of the constant zero. That is how NULL was
> traditionally defined.
>
> So just out of a perverse curiosity, what happens if you do something like this:
>
>    #define S390_lowcore_end ((struct lowcore *)sizeof(struct lowcore))
>    #define S390_lowcore (S390_lowcore_end[-1])
>
> instead? It should get the same value in the end, but it doesn't have
> that special case of "cast an integer constant 0 to a pointer".
>
> I suspect it probably doesn't help, because gcc will still see "oh,
> you're basing this off address zero".

Yes.

> Another thing to try might be to remove the initial 16 bytes of
> padding from 'struct lowcore' (it looks like the first 20 bytes are
> not used - so leave 4 bytes of padding still), and use
>
>    #define S390_lowcore (*((struct lowcore_nopad *)16))
>
> instead. Then gcc will never see that 0, and hopefully the "he's
> accessing based off a NULL pointer" logic will go away.

Looks like gcc also catches that, i get the same warning.

> Because right now, our absolute_pointer() protection against this
> horrible gcc mis-feature is literally based on hiding the value from
> the compiler with an inline asm, and by virtue of hiding the value
> then yes, gcc will have to go through a register base pointer and
> cannot see that it fits in 12 bits.
>
> .. or you just need to disable -Warray-bounds on s390.

That's what i'll do for now. I'll complain in the bugtracker entry
mentioned above, but for now it is propably easier to just disable
the warning until we have a fix.

Thanks
Sven
