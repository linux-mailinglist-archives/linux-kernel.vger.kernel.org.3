Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C4C5A1E4F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 03:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244562AbiHZBoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 21:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbiHZBoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 21:44:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B21FC877D
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 18:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661478248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p5oPV+olrHUkMDvetbVRMjHtVUhIxR2PwsRxaCXUCXA=;
        b=QNwXQkii/uretsmOqu5m/KZTdIz+FTAphV7Oe2X7Hi0sX4o8CvEIbfa3skN3oqcF+kRrlj
        0RCd+wbKiPiUmklB0fkQu7OKQ7FweqKVX+bDpVvoz4z+YL0EqoDJp4BFKhqGfEN4Zo6itT
        7n25X15ckdV41vd9lYZ9KgnDAxnkTt8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-652-YDfQNYobOUecACAtRocFtg-1; Thu, 25 Aug 2022 21:44:06 -0400
X-MC-Unique: YDfQNYobOUecACAtRocFtg-1
Received: by mail-ej1-f72.google.com with SMTP id sa33-20020a1709076d2100b0073d83e062c8so53749ejc.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 18:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=p5oPV+olrHUkMDvetbVRMjHtVUhIxR2PwsRxaCXUCXA=;
        b=t7KGhjuFJYcUOwz1T8VzxoqKBupn7X89EUuZd9ZJgE8van5+2jKwXOXQQm1KSa5p2e
         OTLrCpKdk5ElD82Ty730wA2gS2r1oZRHKfIVcWnKCqSrqwE2rQCWRF8BVHGeCmggZSXk
         LXIa7sYeMaXKo7u81V7og6f6aCLAM2ebBT5idAP58E8mUZdX5058iBsSTk+9AICo5Hu+
         cbmhr/LfMc9EkIQQwcYhVt8RpsdrvTblULiFrphmh5d6Ue767unnJRK247gSXEeTKK9n
         Rq1wWE44AoEFC0DY9Lrt4pHDcPYysDXre3xUk18ryHJ15Fu/+tO6Iju7otWrfG+Rnr+Y
         yjSg==
X-Gm-Message-State: ACgBeo1Pt+YwjRu8IFPgqXrq6MbLL58CnKv5JQN82Zo0kBJvCxdjjWAA
        Yg2aqUM7pzfyRLc0pgGCJdRKDNH6OoVW0bUkZFu8eR8F04S93T5DcgJnP6xzV+TA9z5+Zhoq7fe
        MVZiEkAUC8AXw9M+Vk2RqQcZ1FelKyvT1T+6t3FR/
X-Received: by 2002:a05:6402:3714:b0:445:d91b:b0aa with SMTP id ek20-20020a056402371400b00445d91bb0aamr4965838edb.313.1661478245819;
        Thu, 25 Aug 2022 18:44:05 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5Gd3CcJVFzRVYY80RJx7gEeoPX/9eoVrzEpfthId6lHxXKuIxINBj+TfI9cvakWVM3GP+yI0ItM3UAtuh+2is=
X-Received: by 2002:a05:6402:3714:b0:445:d91b:b0aa with SMTP id
 ek20-20020a056402371400b00445d91bb0aamr4965825edb.313.1661478245607; Thu, 25
 Aug 2022 18:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220824163100.224449-1-david@redhat.com> <20220824163100.224449-2-david@redhat.com>
 <0db131cf-013e-6f0e-c90b-5c1e840d869c@nvidia.com> <ea380cf0-acda-aaba-fb63-2834da91b66b@redhat.com>
In-Reply-To: <ea380cf0-acda-aaba-fb63-2834da91b66b@redhat.com>
From:   Dave Young <dyoung@redhat.com>
Date:   Fri, 26 Aug 2022 09:43:54 +0800
Message-ID: <CALu+AoThhou7z+JCyv44AxGWDLDt2b7h0W6wcKRsJyLvSR1iQA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] coding-style.rst: document BUG() and WARN() rules
 ("do not crash the kernel")
To:     David Hildenbrand <david@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

[Added more people in cc]

On Thu, 25 Aug 2022 at 20:13, David Hildenbrand <david@redhat.com> wrote:
>
> On 24.08.22 23:59, John Hubbard wrote:
> > On 8/24/22 09:30, David Hildenbrand wrote:
> >> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> >> index 03eb53fd029a..a6d81ff578fe 100644
> >> --- a/Documentation/process/coding-style.rst
> >> +++ b/Documentation/process/coding-style.rst
> >> @@ -1186,6 +1186,33 @@ expression used.  For instance:
> >>      #endif /* CONFIG_SOMETHING */
> >>
> >
> > I like the idea of adding this documentation, and this is the right
> > place. Naturally, if one likes something, one must immediately change
> > it. :) Therefore, here is an alternative writeup that I think captures
> > what you and the email threads were saying.
> >
> > How's this sound?
>
> Much better, thanks! :)
>
> >
> > diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> > index 03eb53fd029a..32df0d503388 100644
> > --- a/Documentation/process/coding-style.rst
> > +++ b/Documentation/process/coding-style.rst
> > @@ -1185,6 +1185,53 @@ expression used.  For instance:
> >         ...
> >         #endif /* CONFIG_SOMETHING */
> >
> > +22) Do not crash the kernel
> > +---------------------------
> > +
> > +Use WARN() rather than BUG()
> > +****************************
> > +
> > +Do not add new code that uses any of the BUG() variants, such as BUG(),
> > +BUG_ON(), or VM_BUG_ON(). Instead, use a WARN*() variant, preferably
> > +WARN_ON_ONCE(), and possibly with recovery code. Recovery code is not required
> > +if there is no reasonable way to at least partially recover.
>
> I'll tend to keep in this section:
>
> "Unavoidable data corruption / security issues might be a very rare
> exception to this rule and need good justification."
>
> Because there are rare exceptions, and I'd much rather document the
> clear exception to this rule.
>
> > +
> > +Use WARN_ON_ONCE() rather than WARN() or WARN_ON()
> > +**************************************************
> > +
> > +WARN_ON_ONCE() is generally preferred over WARN() or WARN_ON(), because it is
> > +common for a given warning condition, if it occurs at all, to occur multiple
> > +times. (For example, once per file, or once per struct page.) This can fill up
>
> I'll drop the "For example" part. I feel like this doesn't really need
> an example -- most probably we've all been there already when the kernel
> log was flooded :)
>
> > +and wrap the kernel log, and can even slow the system enough that the excessive
> > +logging turns into its own, additional problem.
> > +
> > +Do not WARN lightly
> > +*******************
> > +
> > +WARN*() is intended for unexpected, this-should-never-happen situations. WARN*()
> > +macros are not to be used for anything that is expected to happen during normal
> > +operation. These are not pre- or post-condition asserts, for example. Again:
> > +WARN*() must not be used for a condition that is expected to trigger easily, for
> > +example, by user space actions. pr_warn_once() is a possible alternative, if you
> > +need to notify the user of a problem.
> > +
> > +Do not worry about panic_on_warn users
> > +**************************************
> > +
> > +A few more words about panic_on_warn: Remember that ``panic_on_warn`` is an
> > +available kernel option, and that many users set this option. This is why there
> > +is a "Do not WARN lightly" writeup, above. However, the existence of
> > +panic_on_warn users is not a valid reason to avoid the judicious use WARN*().
> > +That is because, whoever enables panic_on_warn has explicitly asked the kernel
> > +to crash if a WARN*() fires, and such users must be prepared to deal with the
> > +consequences of a system that is somewhat more likely to crash.
>
> Side note: especially with kdump() I feel like we might see much more
> widespread use of panic_on_warn to be able to actually extract debug
> information in a controlled manner -- for example on enterprise distros.
> ... which would then make these systems more likely to crash, because
> there is no way to distinguish a rather harmless warning from a severe
> warning :/ . But let's see if some kdump() folks will share their
> opinion as reply to the cover letter.

I can understand the intention of this patch, and I totally agree that
BUG() should be used carefully, this is a good proposal if we can
clearly define the standard about when to use BUG().  But I do have
some worries,  I think this standard is different for different sub
components, it is not clear to me at least,  so this may introduce an
unstable running kernel and cause troubles (eg. data corruption) with
a WARN instead of a BUG. Probably it would be better to say "Do not
WARN lightly, and do not hesitate to use BUG if it is really needed"?

About "patch_on_warn", it will depend on the admin/end user to set it,
it is not a good idea for distribution to set it. It seems we are
leaving it to end users to take the risk of a kernel panic even with
all kernel WARN even if it is sometimes not necessary.


>
> --
> Thanks,
>
> David / dhildenb
>

Thanks
Dave

