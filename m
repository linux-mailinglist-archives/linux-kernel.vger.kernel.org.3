Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FC8479420
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 19:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240329AbhLQSf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 13:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236643AbhLQSfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 13:35:54 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8061FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 10:35:54 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id a11-20020a17090a854b00b001b11aae38d6so3643739pjw.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 10:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=RfxHFpZlqmWmrOhX0SjTdet5aAn/GTXiRTdFAF3tpYc=;
        b=yiSdDzJy9t3MFVNvLefD1QaSkWAgSg9kAqDILstEXGo211Dy9ErJtv8lNLZvexjSTR
         3CJzGfexnMQ9AAUAqJ5BHKADLhNF6alDqA8WY0eSchMVCUamBSIwcDj2E3wFNDhSytp6
         jvqhR1NiHuKNO7Y9BcFTojEX50NQtaaASJLmDdveB3G/afhkWoIJ4RFrjIRtqq1gkxJy
         jq5Psn6et0he6rj0J5oq80XViS/5uaqREOeDidCXq1UNX49R9Zt9M52fm4SdCHkelkrs
         VpbZ4ZRzrNzrm3O26cXcJUnI+cKVII7kqfbnrgCMLvdepGucKGWJ8HamPrcmpPrcU3d8
         y4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=RfxHFpZlqmWmrOhX0SjTdet5aAn/GTXiRTdFAF3tpYc=;
        b=YyafIg0RMaeyNbgLLpP/MM0QkthC6jaTfRLkBG6BgXUp2l6VCzHcgrkzceRNg3UzsD
         gsrVjS1kgoduM2IOAJH/z/4lsgV9F0fzcAXn1jSiBMVoGfF1343X78Z/gcQ62UEtmiAO
         I4zZ8fvPBtLQPnRuLMu/8rSwcHEKLJrXJLZlGxkc6jLV3PzYnyxPNGWkuUHL/apEL/X5
         xbh3UznUpgjJvE/nOA++dQ8WMTrrks3RWxjzlMqbaeXTSA3W/raqsE//uSQHhaItBgy4
         2phJw6U3sYPG071R+AQOrI6HtLx6KQsvS/kzSDWGqyy/eel/a9WNCdBOeCA+2gIO/9LG
         fCSg==
X-Gm-Message-State: AOAM533aSzvF6WbSQlupYmWtYg0Z8ohOE6hSE3ssXhBqeazqrPYbGCe9
        f9QNg4cbEN1ur5ZaXAuLr4TFEA==
X-Google-Smtp-Source: ABdhPJxkJbjeR0+y6x9OUMjUg99fl6xT5+a06/VihxboH47Qaux5H75KbE/JVWhizbVkzidNnpgYfA==
X-Received: by 2002:a17:90b:314b:: with SMTP id ip11mr13325893pjb.133.1639766153894;
        Fri, 17 Dec 2021 10:35:53 -0800 (PST)
Received: from localhost ([12.163.77.120])
        by smtp.gmail.com with ESMTPSA id m3sm8856760pgj.25.2021.12.17.10.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 10:35:53 -0800 (PST)
Date:   Fri, 17 Dec 2021 10:35:53 -0800 (PST)
X-Google-Original-Date: Fri, 17 Dec 2021 10:35:27 PST (-0800)
Subject:     Re: [PATCH 1/1] riscv: default to CONFIG_RISCV_SBI_V01=n
In-Reply-To: <CAAhSdy3CXJAieR3toyhQtk07CiCkUkmK7hB1DiQ5Wrd7JCqcmA@mail.gmail.com>
CC:     heinrich.schuchardt@canonical.com, atishp@atishpatra.org,
        jrtc27@jrtc27.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     anup@brainfault.org
Message-ID: <mhng-5c40ae0c-64e1-4fdb-8203-8a6e142724a6@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 04:09:22 PST (-0800), anup@brainfault.org wrote:
> +Atish
>
> On Fri, Dec 17, 2021 at 4:12 PM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>>
>>
>> On 12/16/21 17:51, Jessica Clarke wrote:
>> > On 16 Dec 2021, at 14:17, Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
>> >>
>> >> On 12/16/21 14:49, Jessica Clarke wrote:
>> >>> On 16 Dec 2021, at 12:35, Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
>> >>>>
>> >>>> The SBI 0.1 specification is obsolete. The current version is 0.3.
>> >>>> Hence we should not rely by default on SBI 0.1 being implemented.
>> >>> It’s what BBL implements, and some people are still using it,
>> >>> especially given early hardware shipped before OpenSBI grew in
>> >>> popularity.
>> >>> Jess
>> >>
>> >> Do you mean BBL is not developed anymore?
>> >>
>> >> Some people may still be using a 0.1 SBI. But that minority stuck on an outdated software stack does not justify defaulting to deprecated settings in future Linux releases.
>> >
>> > BBL is still actively maintained; its most recent commit was 24 days
>> > ago. Also, the amount of code CONFIG_RISCV_SBI_V01 affects is tiny, so
>> > I see no tangible benefit from making this change, just unnecessary
>> > breakage of perfectly functional systems.
>>
>> Only the default is changed. How could this break any existing system?
>> You can still compile with the deprecated setting.
>>
>> I can not see why we should keep a default that will cause issues on
>> systems complying to the current SBI specification.
>
> I agree with Heinrich.
>
> Almost all SBI implementations (OpenSBI, EDK2, KVM, Xvisor, etc) are
> providing at least SBI v0.2 and we can't endlessly wait for BBL to move
> away from SBI v0.1. We can't totally remove SBI v0.1 but we should
> at least disable it by default.
>
> Same rationale applies to the spinwait CPU operations which are only
> required for systems using BBL. The sparse HART id series from Atish
> can include a patch to have spinwait CPU operations disabled by
> default.
>
> @Atish/Palmer, what do you think ?

I agree with Heinrich: it's just a defconfig change, we're not dropping 
support for SBI-0.1.  The defconfig is generally meant to reflect what 
kernel developers are using, and AFAIK everyone doing upstream 
development moved off the legacy SBI implementations as of a while ago.  
There's some cost associated with supporting the old SBI, it's not like 
this is just some backup calls we're adding.

If vendors are still shipping old firmwares as part of their SDKs that's 
fine, they'll just need to flip on support for it in their configs.  Who 
knows, maybe this will even be the nudge they need to stop shipping 
ancient firmware ;)
