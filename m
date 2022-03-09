Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968854D393E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236910AbiCISv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbiCISv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:51:26 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE6824E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 10:50:26 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id t14so2734831pgr.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 10:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1uHgklcqMNOIpY0vZIN5vRSW5yidN8+O7IFJXUXhgeU=;
        b=FEXzS8ZZoUqIR13rDKSsQLSXbU/Lkf34jRd5q3ZvVnDaqKdUcDGiGT4FmYEhOLt635
         9QDP3RvLPcSYamh7a0Oe+R02xJqQglNXOG3AOAn+9shE9VhWhj7ndmQvMErZhqkcejTC
         GswaZ5HEd/zi6i9lmaxhpi7mgdRJ/Z0kSNg2fQAh61wQq5ag/FF3tUnDW13th25H/QBA
         JWfa2t2iXN5SFtGwKc3Wvc6FtX0SjObNG/7P+WN2tHmv6fZ3jT1DWSoT+NxylnjvWwIo
         4o2stXISFGFEDECLJHHsEX5WOw4z6YGDqO0qj5/ND6irHtqYdWsC6wEGAFa1ijipYu/l
         pvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1uHgklcqMNOIpY0vZIN5vRSW5yidN8+O7IFJXUXhgeU=;
        b=QbLzd9L49PT9l0SgZ1i9x0FheMhypO2TLCP4PfZKdI6sjFiwoCMtOZCuyEZXcR+Lrl
         WIw+IF5XXvsTQQenThNLfNKr/6SlKsaw3RAxsVRPuxm45H9e8c8C+t5evmf2ZPqfOV8x
         9aeW2e8AxdZ2dy5QV9ur31670o92MKZg2hS9vNTU2cBQ+0+Ow9rnexz618nt6LATYvgi
         y7xYn2V/Tirf+wXCWJgGNajy0gysynOlK7AepqnvYBgfQqi2ZdcsQhhK9ohsAVaaaCDj
         jUkaMBJRKzb/g035la1/vbh5FwjTF7NSbgmCOgMGexBKnPEwOCtyqG1LmrSoZpY8ONOu
         8Ycw==
X-Gm-Message-State: AOAM53242e5YaHuUUvtvLUVYbTybw0QJl0+hi5Uck56+R5fumrss9AHC
        r2GHAYMC6fNOsWzNsbZQp7KPXANuAEk=
X-Google-Smtp-Source: ABdhPJzfpb1gtz0+VW7kvlgYoJZtJZbnppzPm8GnEpR0hV4UCPxrwg5mpALr5o7TKkAHuKUWD7L46w==
X-Received: by 2002:a63:fc0e:0:b0:365:39dd:2cd0 with SMTP id j14-20020a63fc0e000000b0036539dd2cd0mr908304pgi.173.1646851826094;
        Wed, 09 Mar 2022 10:50:26 -0800 (PST)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id p28-20020a056a000a1c00b004f6519e61b7sm4339457pfh.21.2022.03.09.10.50.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Mar 2022 10:50:25 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH] mm: madvise: return correct bytes advised with
 process_madvise
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <YijaP7cC6Sclxc29@google.com>
Date:   Wed, 9 Mar 2022 10:50:24 -0800
Cc:     Andrew Morton <akpm@linux-foundation.org>, yuehaibing@huawei.com,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Rientjes <rientjes@google.com>, edgararriaga@google.com,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B156E4D9-C3DD-4EBD-ACE2-CA55A8B3A3F5@gmail.com>
References: <1646803679-11433-1-git-send-email-quic_charante@quicinc.com>
 <YijaP7cC6Sclxc29@google.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>,
        Minchan Kim <minchan@kernel.org>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 9, 2022, at 8:47 AM, Minchan Kim <minchan@kernel.org> wrote:
>=20
> On Wed, Mar 09, 2022 at 10:57:59AM +0530, Charan Teja Kalla wrote:
>> The process_madvise() system call returns error even after processing
>> some VMA's passed in the 'struct iovec' vector list which leaves the
>> user confused to know where to restart the advise next. It is also
>> against this syscall man page[1] documentation where it mentions that
>> "return value may be less than the total number of requested bytes, =
if
>> an error occurred after some iovec elements were already processed.".
>>=20
>> Consider a user passed 10 VMA's in the 'struct iovec' vector list of
>> which 9 are processed but one. Then it just returns the error caused =
on
>> that failed VMA despite the first 9 VMA's processed, leaving the user
>> confused about on which VMA it is failed. Returning the number of =
bytes
>> processed here can help the user to know which VMA it is failed on =
and
>> thus can retry/skip the advise on that VMA.
>>=20
>> [1]https://man7.org/linux/man-pages/man2/process_madvise.2.html.
>>=20
>> Fixes: ecb8ac8b1f14("mm/madvise: introduce process_madvise() syscall: =
an external memory hinting API"
>> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
>> ---
>> mm/madvise.c | 12 +++++++++---
>> 1 file changed, 9 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/mm/madvise.c b/mm/madvise.c
>> index 38d0f51..d3b49b3 100644
>> --- a/mm/madvise.c
>> +++ b/mm/madvise.c
>> @@ -1426,15 +1426,21 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, =
const struct iovec __user *, vec,
>>=20
>> 	while (iov_iter_count(&iter)) {
>> 		iovec =3D iov_iter_iovec(&iter);
>> +		/*
>> +		 * Even when [start, end) passed to do_madvise covers
>> +		 * some unmapped addresses, it continues processing with
>> +		 * returning ENOMEM at the end. Thus consider the range
>> +		 * as processed when do_madvise() returns ENOMEM.
>> +		 * This makes process_madvise() never returns ENOMEM.
>> +		 */
>=20
> Looks like that this patch has two things. first, returns processed
> bytes instead of error in case of error. Second, keep working on
> rest vmas on -ENOMEM due to unmapped hole.
>=20
> First thing totally makes sense to me(that's exactly I wanted to
> do but somehow missed) so it should go stable tree. However,
> second stuff might be arguble so it would be great if you split
> the patch.

I fully understand and relate to the basic motivation of this
patch.

The ENOMEM that this patch checks for, IIUC, is the ENOMEM that is
returned on unmapped holes. Such ENOMEM does not appear, according to
the man page, to be a valid reason to return ENOMEM to userspace.
Presumably process_madvise() is expected to skip unmapped holes
and not to fail because of them.

Having said that, I do not think that the check that the patch does
is clean or clearly documented.

In addition, this patch (and some work on process_madvise()) raise
in my mind a couple of questions:

1. There are other errors that process_madvise might encounter
   and can be propagated back to userspace, but are not
   documented. For instance if can_madv_lru_vma() fails on
   MADV_COLD, userspace will get EINVAL. EINVAL is not documented
   as a valid error-code for such case in either madvise() and
   process_madvise() man pages.

2. If an advice fails due to other reason, specifically
   split_huge_page(), there might be partial success within a
   VMA. I guess for now it is fine to ignore such failures
   since there is no guarantee on the OS behavior following
   most advices (excluding MADV_DONTNEED).

Regards,
Nadav=
