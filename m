Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5088551719A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 16:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348733AbiEBOee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 10:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236543AbiEBOea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 10:34:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3917F38
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 07:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651501860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c77/rDIAYeEnW8QDTuHFvfz/klWTZsXPW+s3RWN5ms4=;
        b=MPAo7waG9P1AG/9PngZTpGFNUbB8JYD8DhaDrigfuDWKdOIkC8RqxQ2WUA4ebWNS4IRIBE
        c706inCwhza6Vn1AKqogNNdzj/k1CYaUbv+0djoAa7Dn1psHCayLW295JHsZWllmbkuadH
        K7z+Amxr3lI0FTJ+WGH1Pg93COvJbW4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-H4mcFkj7OY-Q72G3TtmlbQ-1; Mon, 02 May 2022 10:30:59 -0400
X-MC-Unique: H4mcFkj7OY-Q72G3TtmlbQ-1
Received: by mail-ed1-f72.google.com with SMTP id l24-20020a056402231800b00410f19a3103so8804002eda.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 07:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c77/rDIAYeEnW8QDTuHFvfz/klWTZsXPW+s3RWN5ms4=;
        b=V/D44GmGFP8LBxZTUcoAY6dWzIlqR9DnQ5fOAKFcR/waN+/K49mALMR37U3NLSWgfe
         2Xs8cJNELtOErnuX8Zra23DdUFM7oXA1faSgJifAGqJ+pikBcJJr7g24BV6BFxRbMYnN
         nZ2N3FdM26rW6xJN+FNSxoCAZYSLLB2tPPWqxpSag/LWbsaLkuGRlEVh+AY2Puv4G4GK
         svhVutB01WQ9OVHMyJ6y2VoQHP0KLZoRfOnRIIyAgp1P8CcQ/ZfRCdJcIYrHJfiWWLca
         jmDPK7/YP66mov2IN2tZOH1R71h8//0FW0but26I/Gw4qDqHgNmB8W1ZkXQhIxU5mvAr
         iQKQ==
X-Gm-Message-State: AOAM532W+J4ygzRM5Wso0dDMtKFgTnlBAjGtvJTVnDriP0srtSPPS/LE
        PVV7UmS3VhtI0MowHVckjymyDG/+0h/Gdz2yzhzjg1FeUKykmbkXaVpqO3/SN0vjXKT4vbOEkTK
        TF+UINosqeGbj3gQk/eIJ8jGV
X-Received: by 2002:a17:907:2cc3:b0:6da:e6cb:2efa with SMTP id hg3-20020a1709072cc300b006dae6cb2efamr11358685ejc.169.1651501858373;
        Mon, 02 May 2022 07:30:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLx4IDXJr0EkxOumtryaZEbv9FTqjHDJFUHQuJ26Yauo+JoJXebyA8GYbJpiGICTwaJs7ASg==
X-Received: by 2002:a17:907:2cc3:b0:6da:e6cb:2efa with SMTP id hg3-20020a1709072cc300b006dae6cb2efamr11358667ejc.169.1651501858142;
        Mon, 02 May 2022 07:30:58 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id hy24-20020a1709068a7800b006f3ef214e76sm3602483ejc.220.2022.05.02.07.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 07:30:57 -0700 (PDT)
Message-ID: <827dc313-33ff-1c91-afaf-7645b655a1be@redhat.com>
Date:   Mon, 2 May 2022 16:30:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/4] platform: allow ATOM PMC code to be optional
Content-Language: en-US
To:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20220428062430.31010-1-paul.gortmaker@windriver.com>
 <YmpoeJtFNSyCq1QL@smile.fi.intel.com> <20220428181131.GG12977@windriver.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220428181131.GG12977@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/28/22 20:11, Paul Gortmaker wrote:
> [Re: [PATCH 0/4] platform: allow ATOM PMC code to be optional] On 28/04/2022 (Thu 13:12) Andy Shevchenko wrote:
> 
>> On Thu, Apr 28, 2022 at 02:24:26AM -0400, Paul Gortmaker wrote:
>>> A few months back I was doing a test build for "defconfig-like" COTS
>>> hardware and happened to notice some pmc-atom stuff being built.  Fine,
>>> I thought - the defconfig isn't minimal - we all know that - what Kconfig
>>> do I use to turn that off?  Well, imagine my surprise when I found out
>>> you couldn't turn it [Atom Power Management Controller] code off!
>>
>> Turning it off on BayTrail and CherryTrail devices will be devastating
>> to the users' experience. And plenty of cheap tablets are exactly made
>> on that SoCs.
> 
> Sure, but I could say the same thing for DRM_I915 and millions of
> desktop PC users - yet we still give all the other non i915 users the
> option to be able to turn it off.  Pick any other Kconfig value you like
> and the same thing holds true.
> 
> Just so we are on the same page - I want to give the option to let
> people opt out, and at the same time not break existing users. If you
> think the defconfig default of being off is too risky, then I am OK with
> that and we can just start by exposing the option with "default y".
> 
> So, to that end - are you OK with exposing the Kconfig so people can
> opt out, or are you 100% against exposing the Kconfig at all?  That
> obviously has the most impact on what I do or don't do next.
> 
>>> Normally we all agree to not use "default y" unless unavoidable, but
>>> somehow this was added as "def_bool y" which is even worse ; you can
>>> see the Kconfig setting but there is *no* way you can turn it off.
>>>
>>> After investigating, I found no reason why the atom code couldn't be
>>> opt-out with just minor changes that the original addition overlooked.
>>>
>>> And so this series addreses that.  I tried to be sensitive to not
>>> break any existing configs in the process, but the defconfig will
>>> now intentionally be different and exclude this atom specific code.
>>>
>>> Using a defconfig on today's linux-next, here is the delta summary:
>>>
>>> $ ./scripts/bloat-o-meter -c ../pmc-atom-pre/vmlinux ../pmc-atom-post/vmlinux|grep add/remove
>>> add/remove: 0/410 grow/shrink: 0/7 up/down: 0/-47659 (-47659)
>>> add/remove: 0/105 grow/shrink: 0/1 up/down: 0/-6848 (-6848)
>>> add/remove: 0/56 grow/shrink: 0/1 up/down: 0/-10155 (-10155)
>>>
>>> $ ./scripts/bloat-o-meter -c ../pmc-atom-pre/vmlinux ../pmc-atom-post/vmlinux|grep Total
>>> Total: Before=13626994, After=13579335, chg -0.35%
>>> Total: Before=3572137, After=3565289, chg -0.19%
>>> Total: Before=1235335, After=1225180, chg -0.82%
>>>
>>> It is hard to reclaim anything against the inevitable growth in
>>> footprint, so I'd say we should be glad to take whatever we can.
>>>
>>> Boot tested defconfig on today's linux-next on older non-atom COTS.
>>
>> I believe this needs an extensive test done by Hans who possesses a lot of
>> problematic devices that require that module to be present.
> 
> Input from Hans is 100% welcome - but maybe again if we just consider
> using "default y" even though it isn't typical - then your concerns are
> not as extensive?

I have no objection against allowing disabling the PMC_ATOM Kconfig option.

As for users breaking support for BYT/CHT setups because they forget
to enable this, without X86_INTEL_LPSS being enabled BYT/CHT are pretty
much broken anyways and since patch 2/4 adds a "select PMC_ATOM" to the
X86_INTEL_LPSS Kconfig option I'm not really worried about that.

I'm afraid this patch-set might break some randomconfig builds though,
but I cannot see anything obviously causing such breakage here, so
I think it would be fine to just merge this series as is and then
see if we get any breakage reports.

Andy, are you ok with me moving ahead and merging this series as is?

Regards,

Hans

