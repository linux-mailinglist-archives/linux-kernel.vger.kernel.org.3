Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1FE4ECC98
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350735AbiC3Sqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350712AbiC3Sq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:46:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C25E007
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:43:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id c10so24918799ejs.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FSX9OG9WPMDWC5xU+cTCu3yzNi7wsidqtt+ufjULZeI=;
        b=KBM/vLMk8vmOAjRNld9gv7ydBFtXBUphVE5SlE2/SnNwHMjsvKuQhCApxZdgwKYfEX
         v5ubRB/mR1H7jqcJXVkuO6rwYf6k+qH1jVyjCXRLzeswx3+g7hJnP+/49eGRuilCeTC2
         NegSVK6BsMQUaX6FOcoR7hDq+tA1LdvrBCK8lgHDNN+5h/vFmmse99FdZ+lWiDkVbZ5h
         mJX/iebsMwTTNBYecf9VVhc1Rl9rZLJFNHA83Gjukd1HK6cPB818Hnx3xPw+VsDjzvG+
         GU6mLARik+fBBHukOyVqhwuzgNOfj70UXWYGfqMgOo7d8Csscg6zqdnTwaL/COllUbkT
         RM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FSX9OG9WPMDWC5xU+cTCu3yzNi7wsidqtt+ufjULZeI=;
        b=zgE6EeFZlKnCbXCC/O+iibIqgumVlha4O6C3GqzOx6RLg+FL1VhrHXyqdfXuoGiTRA
         WFtmIb3XorRkPhr7v20ZHx1Y9ZJsuu4kGCLPAwzeuxEHjH8a7s9M8O+YUrOWdH+zKiSG
         GpWfDyBg9ZtA84Jw6LD4SyD/cZE2W/FPkNyOGmF10NF8FCP3yi4/CF1NuD6jaSoOGltZ
         sgGkUeZb80krjg4QuGefh2lrhNlCdiAexs8vN6wRb6z0CtDq62k8DoUvtnX9Sc7V4EMi
         dqR/8MYCTvHDTOjhKitai6HUurtLaOAz6b7kTCxo1KJi8uZqW7M1jTArOf5XjFA2rfD8
         tuqw==
X-Gm-Message-State: AOAM531G2jY3Cp0C3UW9qn39OiRC6k7VIHyR0zyI+54HLCBu1S8eweLM
        Ofn10fCqIZpJULNzEsrPy/EHMhA1LkGxqdNe3zolwg==
X-Google-Smtp-Source: ABdhPJzSPZYPDiR6apJov7hdcSW/nfsA0igomHNB7zaWHaEL/nWsdoD9XfiLbWY61OdvkP/Ms3ZSqJjbnHP6rfnbEuA=
X-Received: by 2002:a17:906:c04d:b0:6b9:252:c51c with SMTP id
 bm13-20020a170906c04d00b006b90252c51cmr1058421ejb.470.1648665824116; Wed, 30
 Mar 2022 11:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220330175850.2030509-1-wonchung@google.com> <CAFivqmLqDXWDyEiYMXvkjQTif9jjqau5nE9YtpYyy=F-PybvDg@mail.gmail.com>
In-Reply-To: <CAFivqmLqDXWDyEiYMXvkjQTif9jjqau5nE9YtpYyy=F-PybvDg@mail.gmail.com>
From:   Won Chung <wonchung@google.com>
Date:   Wed, 30 Mar 2022 11:43:33 -0700
Message-ID: <CAOvb9yimjRJiX-RD8L_BUdpSWeZ+a76do=f-1-NDXC2Q2VjQ6g@mail.gmail.com>
Subject: Re: [PATCH] misc/mei: Add NULL check to component match callback functions
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benson Leung <bleung@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 11:18 AM Prashant Malani <pmalani@google.com> wrote:
>
> Hi Won,
>
> On Wed, 30 Mar 2022 at 10:58, Won Chung <wonchung@google.com> wrote:
>>
>> Component match callback functions need to check if expected data is
>> passed to them. Without this check, it can cause a NULL pointer
>> dereference when another driver registers a component before i915
>> drivers have their component master fully bind.
>>
> IMO this should have a "Fixes"  tag, and be picked back to stable branches.
> Also, please use my chromium.org account (pmalani@chromium.org) for upstream communications.
>
> Thanks!
>>
>> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Signed-off-by: Won Chung <wonchung@google.com>
>> ---
>>  drivers/misc/mei/hdcp/mei_hdcp.c | 2 +-
>>  drivers/misc/mei/pxp/mei_pxp.c   | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/misc/mei/hdcp/mei_hdcp.c b/drivers/misc/mei/hdcp/mei_hdcp.c
>> index ec2a4fce8581..843dbc2b21b1 100644
>> --- a/drivers/misc/mei/hdcp/mei_hdcp.c
>> +++ b/drivers/misc/mei/hdcp/mei_hdcp.c
>> @@ -784,7 +784,7 @@ static int mei_hdcp_component_match(struct device *dev, int subcomponent,
>>  {
>>         struct device *base = data;
>>
>> -       if (strcmp(dev->driver->name, "i915") ||
>> +       if (!base || !dev->driver || strcmp(dev->driver->name, "i915") ||
>>             subcomponent != I915_COMPONENT_HDCP)
>>                 return 0;
>>
>> diff --git a/drivers/misc/mei/pxp/mei_pxp.c b/drivers/misc/mei/pxp/mei_pxp.c
>> index f7380d387bab..e32a81da8af6 100644
>> --- a/drivers/misc/mei/pxp/mei_pxp.c
>> +++ b/drivers/misc/mei/pxp/mei_pxp.c
>> @@ -131,7 +131,7 @@ static int mei_pxp_component_match(struct device *dev, int subcomponent,
>>  {
>>         struct device *base = data;
>>
>> -       if (strcmp(dev->driver->name, "i915") ||
>> +       if (!base || !dev->driver || strcmp(dev->driver->name, "i915") ||
>>             subcomponent != I915_COMPONENT_PXP)
>>                 return 0;
>>
>> --
>> 2.35.1.1021.g381101b075-goog
>>
>
>
> --
> -Prashant

Hi Prashant,

This currently does not fix a patch in the upstream, but is for a
future patch of adding component_add to usb4_port. Would we need the
"Fixes" tag for a future patch too?
Thinking again, I think it might be a better idea to have this as a
series of patches along with the patch to be sent after this one.

I changed the recipient email to send this to your chromium.org
account. Sorry for that.

Thanks,
Won
