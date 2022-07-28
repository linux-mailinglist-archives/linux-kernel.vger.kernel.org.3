Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574AA5845EE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiG1Sbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiG1Sbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:31:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D2836D9D8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659033094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QhY3ObgcFzWk2BFvDLXSaBECfSBu+CBG1/43F5hyd8c=;
        b=JF7E18LqnrxOcuZcDb5RNTBLQLPPjaqQjqa+sv4yqpyQL8BntMiHj5N64jltgUDwsGLR0n
        W4bp/He/cSRijsowdzUvZhXOBsoOraYuRKGCnaft30HqfTafi5iB+GmZ9at3lA+QOUFuai
        92rAxYSxABcagA+ourEqe6HkFfaly4g=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-88-Lhi6EYAXMgu02F5liFCsrw-1; Thu, 28 Jul 2022 14:31:30 -0400
X-MC-Unique: Lhi6EYAXMgu02F5liFCsrw-1
Received: by mail-ed1-f70.google.com with SMTP id x20-20020a05640226d400b0043c37fa024eso1581476edd.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QhY3ObgcFzWk2BFvDLXSaBECfSBu+CBG1/43F5hyd8c=;
        b=I/Q3LlFQRf3usrNi0CmoE7+jgSE3lnhpxhg0VSaZChaYgoWDSVV6XgdlYOJnUgkT0a
         AcofS3GzPiGP46j3ubOShhnv3Wbue3w+p/ROJCjWjxxfi7Seq55EC+45S2LSgXBsW8in
         oHDe3ryE97V0DUKuXYOPEFAbV2SGqueNMWsFXE7mKd4FtI/gCRuk3SBa6T1MlzUL8ukW
         BXzGQ58PpWUEcodQJPwAGiLiIuOzbkngi+T6WPSilZa3kfVoL5Sq4I8lNzE8Ba9LydyH
         zTIjp0TT3o3QPfKbF+UkLfg84GiRpXbVjYzh+PQPxs9YkamOiqchxzcjD8oLrV3N/s6g
         YiLg==
X-Gm-Message-State: AJIora8DM0OFMwnjdZWChoWe3FOMq4yKLos2qLart9LtfQf3QcdjQ9YI
        kbB6HOVKTM7ahaD3pubk8ZYDCmV93fNecqrC9DdVEHwCGV2Wa7vs1H5H66OFYsDtRnaeO+E9H9Q
        qoQ0hqv2YnERfSpLhCQNrl1W2
X-Received: by 2002:a17:907:94ca:b0:72b:8f3e:3be0 with SMTP id dn10-20020a17090794ca00b0072b8f3e3be0mr179596ejc.462.1659033089654;
        Thu, 28 Jul 2022 11:31:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uJB235TPpQNv9e8JQkKUJNSfFDNzHYjRTJcGk43W5BxEYszUWsouNlsn/D31SmMM4cdvfKvw==
X-Received: by 2002:a17:907:94ca:b0:72b:8f3e:3be0 with SMTP id dn10-20020a17090794ca00b0072b8f3e3be0mr179588ejc.462.1659033089441;
        Thu, 28 Jul 2022 11:31:29 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id u10-20020aa7d54a000000b0043aa5c2ce17sm1113285edr.35.2022.07.28.11.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 11:31:28 -0700 (PDT)
Message-ID: <cc4f32fe-c28d-afb6-c97f-fb600c210059@redhat.com>
Date:   Thu, 28 Jul 2022 20:31:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] platform/x86: pmc_atom: Add Lex 3I380NX industrial PC to
 critclk_systems DMI table
Content-Language: en-US
To:     Paul Spooren <paul.spooren@rhebo.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Michael_Sch=c3=b6ne?= <michael.schoene@rhebo.com>
References: <20220719124830.2320-1-paul.spooren@rhebo.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220719124830.2320-1-paul.spooren@rhebo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/19/22 14:48, Paul Spooren wrote:
> The Lex 3I380NX industrial PC has 4 ethernet controllers on board
> which need pmc_plt_clk0 - 3 to function, add it to the critclk_systems
> DMI table, so that drivers/clk/x86/clk-pmc-atom.c will mark the clocks
> as CLK_CRITICAL and they will not get turned off.
> 
> This commit is nearly redundant to 3d0818f5eba8 ("platform/x86:
> pmc_atom: Add Lex 3I380D industrial PC to critclk_systems DMI table")
> but for the 3I380NX device.
> 
> The original vendor firmware is only available using the WaybackMachine:
> http://www.lex.com.tw/products/3I380NX.html
> 
> Signed-off-by: Michael Schöne <michael.schoene@rhebo.com>
> Signed-off-by: Paul Spooren <paul.spooren@rhebo.com>

Thank you for the patch.

The last week I have received 2 different patches adding
a total of 3 new "Lex BayTrail" entries to critclk_systems[]
on top of the existing 2.

Looking at: https://www.lex.com.tw/products/embedded-ipc-board/
we can see that Lex BayTrail makes many embedded boards with
multiple ethernet boards and none of their products are battery
powered so we don't need to worry (too much) about power consumption
when suspended.

So instead of adding 3 new entries I've written a patch to
simply disable the turning off of the clocks on all
systems which have "Lex BayTrail" as their DMI sys_vendor:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?h=review-hans&id=f046d13750b759f090cae13e47cab06b023a700b

I've added a Reported-by tag to give you credit for the work
you have done on this.

I will send this alternative fix to Linus as part of
the other pdx86 patches for 5.21.

Regards,

Hans




> ---
>  drivers/platform/x86/pmc_atom.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
> index b8b1ed1406de..15973a400e43 100644
> --- a/drivers/platform/x86/pmc_atom.c
> +++ b/drivers/platform/x86/pmc_atom.c
> @@ -397,6 +397,15 @@ static const struct dmi_system_id critclk_systems[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "3I380D"),
>  		},
>  	},
> +	{
> +		/* pmc_plt_clk0 - 3 are used for the 4 ethernet controllers */
> +		.ident = "Lex 3I380NX",
> +		.callback = dmi_callback,
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Lex BayTrail"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "3I380NX"),
> +		},
> +	},
>  	{
>  		/* pmc_plt_clk* - are used for ethernet controllers */
>  		.ident = "Lex 2I385SW",

