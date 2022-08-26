Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC315A2D0D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344904AbiHZRCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344884AbiHZRCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:02:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61E6C6CEF
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661533331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jD7hXmOLkBQH1CWMlWymLxkZmC0QqnhEG6nyPcsh0A4=;
        b=GN6vhlrnJCF4yQiQ+szDDuz2v1lFmn41zSF3pBzrx99rKNyCHLfCz+xNHExmwUaieY6GoB
        zaLcByoN+8KMNIuSfcgccbl6Tfv3k/ssub/+5b6A4Gv7bde26Cvq7k/lWd9GExqm9Wfx2M
        YFiEP4xauiPwJJhI/QaFbO0bEb/yeck=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-244-NqPSFr5SMCmR4e_pAxVENg-1; Fri, 26 Aug 2022 13:02:09 -0400
X-MC-Unique: NqPSFr5SMCmR4e_pAxVENg-1
Received: by mail-wm1-f72.google.com with SMTP id c66-20020a1c3545000000b003a5f6dd6a25so4331934wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=jD7hXmOLkBQH1CWMlWymLxkZmC0QqnhEG6nyPcsh0A4=;
        b=HaLvYemF30DcEyrP/LrgQPHUxTzIT5CpItjj37A5olRoMyqNgdilrzBKEVOCMnpiS1
         BVNbfESkhsezXFNwFchMP1eBp2CgWcZf4FbqKJJZs2GKNr9d+2Fz6+W7Rw0j8yf1vwjA
         uv8eXwO1Ol7ubdNvqaZLZ1j9buBqa8qFw3q0I+l9Q5/gJaCvwxnq0VP3Zq2x9QYrj7Sj
         sWgivrYHiTDqVZNiWMIqIPNUR7pbrMGGpmjEl1tHH2+9niDVtMvTgU3ypfRQGcYXSFt9
         KMyysnj5s6L5W4krpssOFs4OTvae6Y4UabnLjrEcbc8fzp8ZqP8+DEyNFzYMd5VI/BCf
         NprQ==
X-Gm-Message-State: ACgBeo0PJ4ttZgRK4Uwxa4TuMkVj/MQ4BSJnIyU0qjpOc0R69aUX4iT1
        msnARBXHS2F+9niI65jMTqqUAFHn2YPWy4ncmPMgfV2GiLcz+hXA/J8kFvLqn14XV1zujgAUsJb
        91i6mOSqHZa/lZdxWhH1TKhsG
X-Received: by 2002:a05:600c:8a7:b0:3a6:85b1:2275 with SMTP id l39-20020a05600c08a700b003a685b12275mr360776wmp.30.1661533328599;
        Fri, 26 Aug 2022 10:02:08 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4qNFSQdWdKklLyf6JGMNF43WaQ/tj38zI60Lf4fb7qD47lrMKlJqT7hUbr1HvAPU4X99wkqw==
X-Received: by 2002:a05:600c:8a7:b0:3a6:85b1:2275 with SMTP id l39-20020a05600c08a700b003a685b12275mr360750wmp.30.1661533328294;
        Fri, 26 Aug 2022 10:02:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:f600:abad:360:c840:33fa? (p200300cbc708f600abad0360c84033fa.dip0.t-ipconnect.de. [2003:cb:c708:f600:abad:360:c840:33fa])
        by smtp.gmail.com with ESMTPSA id l3-20020a1ced03000000b003a32251c3f9sm277131wmh.5.2022.08.26.10.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 10:02:07 -0700 (PDT)
Message-ID: <fe7aee66-d9f7-e472-a13f-e4c5aa176cca@redhat.com>
Date:   Fri, 26 Aug 2022 19:02:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Dave Young <dyoung@redhat.com>
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
References: <20220824163100.224449-1-david@redhat.com>
 <20220824163100.224449-2-david@redhat.com>
 <0db131cf-013e-6f0e-c90b-5c1e840d869c@nvidia.com>
 <ea380cf0-acda-aaba-fb63-2834da91b66b@redhat.com>
 <CALu+AoThhou7z+JCyv44AxGWDLDt2b7h0W6wcKRsJyLvSR1iQA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC 1/2] coding-style.rst: document BUG() and WARN() rules
 ("do not crash the kernel")
In-Reply-To: <CALu+AoThhou7z+JCyv44AxGWDLDt2b7h0W6wcKRsJyLvSR1iQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.08.22 03:43, Dave Young wrote:
> Hi David,
> 
> [Added more people in cc]
> 

Hi Dave,

thanks for your input!

[...]

>> Side note: especially with kdump() I feel like we might see much more
>> widespread use of panic_on_warn to be able to actually extract debug
>> information in a controlled manner -- for example on enterprise distros.
>> ... which would then make these systems more likely to crash, because
>> there is no way to distinguish a rather harmless warning from a severe
>> warning :/ . But let's see if some kdump() folks will share their
>> opinion as reply to the cover letter.
> 
> I can understand the intention of this patch, and I totally agree that
> BUG() should be used carefully, this is a good proposal if we can
> clearly define the standard about when to use BUG().  But I do have

Essentially, the general rule from Linus is "absolutely no new BUG_ON()
calls ever" -- but I think the consensus in that thread was that there
are corner cases when it comes to unavoidable data corruption/security
issues. And these are rare cases, not the usual case where we'd have
used BUG_ON()/VM_BUG_ON().

> some worries,  I think this standard is different for different sub
> components, it is not clear to me at least,  so this may introduce an
> unstable running kernel and cause troubles (eg. data corruption) with
> a WARN instead of a BUG. Probably it would be better to say "Do not
> WARN lightly, and do not hesitate to use BUG if it is really needed"?


Well, I don't make the rules, I document them and share them for general
awareness/comments :) Documenting this is valuable, because there seem
to be quite some different opinions floating around in the community --
and I've been learning different rules from different people over the years.

> 
> About "patch_on_warn", it will depend on the admin/end user to set it,
> it is not a good idea for distribution to set it. It seems we are
> leaving it to end users to take the risk of a kernel panic even with
> all kernel WARN even if it is sometimes not necessary.

My question would be what we could add/improve to keep systems with
kdump armed running as expected for end users, that is most probably:

1) don't crash on harmless WARN() that can just be reported and the
   machine will continue running mostly fine without real issues.
2) crash on severe issues (previously BUG) such that we can properly
   capture a system dump via kdump. The restart the machine.

Of course, once one would run into 2), one could try reproducing with
"panic_on_warn" to get a reasonable system dump. But I guess that's not
what enterprise customers expect.


One wild idea (in the cover letter) was to add something new that can be
configured by user space and that expresses that something is more
severe than just some warning that can be recovered easily. But it can
eventually be recovered to keep the system running to some degree. But
still, it's configurable if we want to trigger a panic or let the system
run.

John mentioned PANIC_ON().


What would be your expectation for kdump users under which conditions we
want to trigger kdump and when not?

Regarding panic_on_warn, how often do e.g., RHEL users observe warnings
that we're not able to catch during testing, such that "panic_on_warn"
would be a real no-go?

-- 
Thanks,

David / dhildenb

