Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591884A9FC7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiBDTKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiBDTK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:10:29 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAD1C061714;
        Fri,  4 Feb 2022 11:10:28 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id a28so14428536lfl.7;
        Fri, 04 Feb 2022 11:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9zg2Epm+4R0Cixsv56zpwyV80d3uBmMu4tyEVn6yI4M=;
        b=Ys1yJzrR1s9q9Z+kSA15wOWVSM8PAg0uzybTzvDI27wK3kZCkIvNHnW+KP9SUvaCis
         dU1UCMCxjaBKOHD+7zj7dTNvdMdlzDb2/OwhgbJ6NWrhW8R90Sa/8xEtILTbS/651KvJ
         LXFgwTXhKowq0XXf4z7Yiph0ff0W8HRw3OJ4WeYIuiFE0vF7f/YRhHWEv1WXdt0tUHMN
         9+CHQNBM7bJvCVDaxAjUQTp6X6XhuTmd0J6/pBzqWczvqohyaCmAneUFd8NKAEBQ4Wim
         Oi/P6FS7Pv7ZQ21Zn4sbwXpKWIyHqGgJfnPcFwuL3M8Xqdt4e0DHV+7L52yAtWOhBz6h
         seqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9zg2Epm+4R0Cixsv56zpwyV80d3uBmMu4tyEVn6yI4M=;
        b=LxAEF3RI6O0HtkQnAvXMI6G0AubQ4hFzEXKfOucA2ePbZMs0NruEkDHqHC6M4Ny+7j
         gjljH+VDwDQ4tjzD92OrukK/sgumv4qmN1hL/HRf5Ix6B+/yilyVuF1JFdWAAzJ15NEx
         wolxVlZ6PwR1xU2ifnV2JtS42aoKmoCkjx5rHZThwdL0GAT1hHLkpaa3ktVbFXfh5EnW
         Yx805WgNhWpgaTnsBjLR/uzahyHMvBGKuTMQr2xWWZ7h6Yfu0PdqGB6jRP3HvOtN6ai4
         UbPfUDNYsdtUPRTl2QYOLo8L2OiCLSmpsyoIBjoegjwOiRfQJDZdnvmXkfscE3IXNU3/
         PR6A==
X-Gm-Message-State: AOAM530TlILNSb7dptipuLIe4M76OtdT6IMSfE8BqCm7WmbhiE/NLExI
        dmwPzGNoQ9/Oi3NuGk9HSDU=
X-Google-Smtp-Source: ABdhPJxlT/1uttoyR0gyiFDPAH7QSRVypaAdnmTQQi8F60RbSv6+M2hOfxi+feW5LvIdkrJncmbH8w==
X-Received: by 2002:a05:6512:3611:: with SMTP id f17mr292460lfs.88.1644001827114;
        Fri, 04 Feb 2022 11:10:27 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id q19sm425278lfp.5.2022.02.04.11.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 11:10:26 -0800 (PST)
Message-ID: <400e45da-837a-c8ad-84b3-285e35f8462c@gmail.com>
Date:   Fri, 4 Feb 2022 22:10:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] PM: domains: Prevent power off for parent unless child is
 in deepest state
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-kernel@vger.kernel.org
References: <20220131113743.52265-1-ulf.hansson@linaro.org>
 <b33ceac4-506a-65c8-7c80-b1b0a67ce65e@gmail.com>
 <CAPDyKFqsvF=Pm-vMXSUwPMPnjCr7nSYuy5AH+8rwLYm_NUPKww@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <CAPDyKFqsvF=Pm-vMXSUwPMPnjCr7nSYuy5AH+8rwLYm_NUPKww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

04.02.2022 12:43, Ulf Hansson пишет:
> On Mon, 31 Jan 2022 at 19:29, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 31.01.2022 14:37, Ulf Hansson пишет:
>>> A PM domain managed by genpd may support multiple idlestates. During
>>> genpd_power_off() a genpd governor may be asked to select one of the
>>> idlestates based upon the dev PM QoS constraints, for example.
>>>
>>> However, there is a problem with the behaviour around this in genpd. More
>>> precisely, a parent-domain is allowed to be powered off, no matter of what
>>> idlestate that has been selected for the child-domain.
>>>
>>> So far, we have not received any reports about errors, possibly because
>>> there might not be platform with this hierarchical configuration, yet.
>>> Nevertheless, it seems reasonable to change the behaviour into preventing
>>> the parent-domain from being powered off, unless the deepest idlestate has
>>> been selected for the child-domain, so let's do that.
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>>  drivers/base/power/domain.c | 18 ++++++++++++++++++
>>>  1 file changed, 18 insertions(+)
>>>
>>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>>> index 5db704f02e71..7f97c5cabdc2 100644
>>> --- a/drivers/base/power/domain.c
>>> +++ b/drivers/base/power/domain.c
>>> @@ -636,6 +636,17 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
>>>                       atomic_read(&genpd->sd_count) > 0)
>>>               return -EBUSY;
>>>
>>> +     /*
>>> +      * The children must be in their deepest states to allow the parent to
>>> +      * be powered off. Note that, there's no need for additional locking, as
>>> +      * powering on a child, requires the parent's lock to be acquired first.
>>> +      */
>>> +     list_for_each_entry(link, &genpd->parent_links, parent_node) {
>>> +             struct generic_pm_domain *child = link->child;
>>> +             if (child->state_idx < child->state_count - 1)
>>> +                     return -EBUSY;
>>> +     }
>>> +
>>>       list_for_each_entry(pdd, &genpd->dev_list, list_node) {
>>>               enum pm_qos_flags_status stat;
>>>
>>> @@ -1073,6 +1084,13 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
>>>           || atomic_read(&genpd->sd_count) > 0)
>>>               return;
>>>
>>> +     /* Check that the children are in their deepest state. */
>>> +     list_for_each_entry(link, &genpd->parent_links, parent_node) {
>>> +             struct generic_pm_domain *child = link->child;
>>> +             if (child->state_idx < child->state_count - 1)
>>> +                     return;
>>> +     }
>>> +
>>>       /* Choose the deepest state when suspending */
>>>       genpd->state_idx = genpd->state_count - 1;
>>>       if (_genpd_power_off(genpd, false))
>>
>> Hello Ulf,
> 
> Hi Dmitry,
> 
>>
>> Is this needed by a concrete SoC? It needs to be clarified in the commit
>> message, otherwise looks like this patch wasn't tested and it's unclear
>> whether this change is really needed.
> 
> It's needed on a STMicro SoC that I have been working on. However,
> it's difficult for me to test on that platform, as some SoC specific
> pieces are missing upstream (the power domain deployment in
> particular). Anyway, let me add some information about this in the
> commit log for the next version.
> 
> When it comes to testing, I am using a couple of local test dummy
> drivers. One that manages devices that gets attached to a genpd,
> mostly to execute runtime PM and dev PM QoS calls - and another that
> manages the PM domains with genpd. I have been thinking of a way to
> share these "tools" to let other people use them for testing too, but
> I haven't just got to it yet.
> 
> Besides the above, do you see any issues from Nvidia platforms point
> of view with $subject patch?

I've two main concerns:

1. This is a patch for something (STMicro SoC) that isn't fully
supported by upstream kernel and it's not clear whether it will be ever
supported at all.

2. It's not clear why behaviour of a very specific SoC should be applied
to all SoCs, especially given that the specific SoC itself isn't going
to use to this feature right now. I guess it could be okay to put this
behaviour into the core code until any other SoC will require a
different behaviour, but the commit message doesn't clarify this.

To my knowledge all NVIDIA Tegra SoCs are indifferent to this patch
because they don't have such kind of dependency between power domains.

In general, such changes usually are deferred from being upstreamed
until there is a real user, otherwise there is a risk of cluttering the
code with unused features. Do you have a time estimation in regards to
when STMicro may start to benefit from this change?
