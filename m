Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F10571AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbiGLM74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiGLM7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:59:55 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4CC2A709
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:59:54 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id p129so13787063yba.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Yw8dFDRTfEK72s1TvEU5mH4jhRhU2cchPv1Xp0OufHI=;
        b=CDi6GzUd9o+Bp0LEGfow73v9sBErIFdvMxHm3LFd2Y7PQ/djhXmUcMBUARB0TBsBGJ
         3WWNlR3xVPfAVN0ZdXPZmMWY3If1UOc7GqwkJDmRWCNVQF7nj0prrk4nupHSh1laqrle
         0LJtME793vgTfUsyAdboZ5Z9AI407GmBu39tidCiiiPsOSCw/XdlAlwgYk1wYwHtriDF
         7wZj5OFLOQ3l0lbfMdejd1Lp8MPYOrnqFfzc+SnWSqRdDOrbIaSBN3NIIFXQjoXHEgNe
         ffJXun5HW1Gfroy4LnONNvkwNfuQIYI3R//T+y6qT1dHfCXiMgYfUvDo6TUCMAZ+PpBE
         ijqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Yw8dFDRTfEK72s1TvEU5mH4jhRhU2cchPv1Xp0OufHI=;
        b=V+AgqH+zFqHTzSOlSGP/UsjRGvLqciseZMeOfFOEmsBOD166G0UlHLB4kipBqFB5Jo
         BDIkSV0DSfyUIlKHJ5Meophmr99+Kbzodgvo7M3YPt6vx6I5+KXnNqCYFjjc3X2l06w9
         gVYNhg3kvUgHxbwCwBUdKh6pKjm041ZqSVblr9dH9ZYvWxl7tzhmn95ypJX56o/hEkjj
         jc3kH04naFAHcxvPdyVuWk+DCHZj1s9cJbQcIeazVfvIiorxvVjS/bnOFEP54sM/9K2q
         mSi89ocdmNyAYyKdXfOrH2ITj1C7yzaOeFDvAsubCLS1EIbabOy1VMak6w1VhNFHSUhx
         qBJg==
X-Gm-Message-State: AJIora/AL4faBP6+/6sePpTRrnSUOvLpImdrUbjL/fjNQLN8oJJRn5cg
        fxC6stRBg4HbA65yaPZ2XWOVBEHtyCq4ri1/MeP7bQ1R90M=
X-Google-Smtp-Source: AGRyM1vayg19ci6vjdO2GO/T6CYBbDWohGEtmFFJ79j8MRcnRIaifbaLOSuLtvYLDJz7Miqm7rBtOxcMgfVsb45Drfg=
X-Received: by 2002:a25:50d0:0:b0:66e:dd92:8170 with SMTP id
 e199-20020a2550d0000000b0066edd928170mr20595373ybb.311.1657630793297; Tue, 12
 Jul 2022 05:59:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:b507:0:0:0:0:0 with HTTP; Tue, 12 Jul 2022 05:59:52
 -0700 (PDT)
In-Reply-To: <07ff13d590cf290a14232fb113ff4183a6fa352d.camel@intel.com>
References: <20220704142250.1512726-1-martin.fernandez@eclypsium.com>
 <8d2a3175be8a3aff1d3fc535dd9ab6217cfe1e66.camel@intel.com>
 <CAKgze5azQG1mnOASbpcrs9jTejdXGkXYmezz9bTKuWQoZp5EFg@mail.gmail.com>
 <YsxZKGxVUY61zPEt@google.com> <ba321fad38d5f96a240f1e88a11943cea16bb4dd.camel@intel.com>
 <YszFkTZ7RtXS1rd7@google.com> <07ff13d590cf290a14232fb113ff4183a6fa352d.camel@intel.com>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Tue, 12 Jul 2022 09:59:52 -0300
Message-ID: <CAKgze5bzeakLTMEADKiweL3fnrcVzd6K9oJzo7wWDxuriUfgvA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/cpuinfo: Clear X86_FEATURE_TME if TME/MKTME is
 disabled by BIOS
To:     Kai Huang <kai.huang@intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, mingo@redhat.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        daniel.gutson@eclypsium.com, hughsient@gmail.com,
        alex.bazhaniuk@eclypsium.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/22, Kai Huang <kai.huang@intel.com> wrote:
>
>>
>> > This patch basically tries to fix the issue that TME flag isn't cleared
>> > when TME
>> > is disabled by BIOS.  And fir this purpose, the code change in this
>> > patch looks
>> > reasonable to me.  Unless I am mistaken, detect_tme() will be called for
>> > all
>> > cpus if TME is supported in CPUID but isn't enabled by BIOS (either
>> > LOCKED or
>> > ENABLED bit isn't set).
>>
>> But this patch doesn't handle the bypass bit, which _does_ effectively
>> disable
>> TME when set.  E.g. the MKTME spec says:
>>
>>  Software must inspect the Hardware Encryption Enable (bit 1) and TME
>> Encryption
>>  Bypass Enable (bit 31) to determine if TME encryption is enabled.
>
> Yeah so my original reply said:
>
> "But perhaps it's arguable whether we can also clear TME flag in this
> case."
>
> And I only gave my Acked-by.
>
> It completely depends on the purpose of this patch, or what does this patch
> claim to do.  If it only claims to clear TME bit if BIOS doesn't enable it,
> then
> looks fine to me.  If it wants to achieve "clear TME feature flag if
> encryption
> isn't active", then yes you are right.
>
> But as I said perhaps "whether we should clear TME flag when bypass is
> enabled"
> is arguable.  After all, what does TME flag in /proc/cpuinfo imply?
>

What we want with this patch is to check whether some kind of memory
encryption is active. Right now we are doing it by checking the "tme
active in BIOS" log, so we are not checking the bypass.

Can you change this bypass bit at runtime? ie, does it make sense to
check it only once at boot time?

If no, then maybe it's ok to check that bit in detect_tme and consider
it for cpuinfo,

If it can change, then probably it's ok to leave this patch as is, and
for our use case maybe we can add a sysfs file that reads that msr.
