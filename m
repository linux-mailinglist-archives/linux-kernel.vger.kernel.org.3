Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF7150E9A5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 21:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245003AbiDYTnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 15:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbiDYTm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:42:58 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220F012C43C;
        Mon, 25 Apr 2022 12:39:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 17B6A1F41B18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650915592;
        bh=qinDi2GBBW9kGnMhrPxn4h6KUQhZ0ca8SpwjSyGHrKY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HNiWF1Iib5nowoR6mXKLlQwEvt428mh1OjWFHuz+msveQpU9DOaY90fH6FZqRJr3L
         fElhUu3Nv3bM+Jh34/IuOxzo++KSgC3/fvGOMXXTwDoBR+BTChK/26mfmszu0Gqhyt
         jvfRtQIYpJeklo+p8++/m8rorfsdMgYKyFjNJcMDsfV6d7LoxSVOdxGoOZ5uAeBr8h
         jC30yK6oZi5CDV9RXyi9jvNg9irPfET8xI3DyOFc65EZQbHyfHqOzv/4/8IZsTD/Re
         Qe8PqDDqbPhZ6N7iO4JyGHYJGYjdBgBieygdJbWXKOfV14oyHiY5PTYuHpiVa8P0za
         PE6b1aJSOqSEQ==
Message-ID: <777b30fd-59ba-56ec-4f66-4d82118ca921@collabora.com>
Date:   Mon, 25 Apr 2022 22:39:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v8 2/4] memory: tegra: Add MC error logging on tegra186
 onward
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, krzysztof.kozlowski@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, digetx@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220425075036.30098-1-amhetre@nvidia.com>
 <20220425075036.30098-3-amhetre@nvidia.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220425075036.30098-3-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/22 10:50, Ashish Mhetre wrote:
> Add support for reading MC_GLOBAL_INTSTATUS register which points to the
> memory controller channels on which interrupts have occurred.
> Add helper function 'mc_global_intstatus_to_channel' which returns the
> channel which should be used to get the information of interrupts.
> Remove static from tegra30_mc_handle_irq and use it as interrupt handler
> for MC interrupts on tegra186, tegra194 and tegra234 to log the errors.
> Add error specific MC status and address register bits and use them on
> tegra186, tegra194 and tegra234.
> Add error logging for generalized carveout interrupt on tegra186, tegra194
> and tegra234.
> Add error logging for route sanity interrupt on tegra194 an tegra234.
> Add register for higher bits of error address which is available on
> tegra194 and tegra234.
> Add a boolean variable 'has_addr_hi_reg' in tegra_mc_soc struture which
> will be true if soc has register for higher bits of memory controller
> error address. Set it true for tegra194 and tegra234.
> Add helper function 'mc_channel_to_global_intstatus' which returns the
> bit of MC_GLOBAL_INSTATUS corresponding to channel of which interrupts
> are logged and use it to clear that interrupt channel.
> Update variable type of client_id_mask from u8 to u16 and add it for
> tegra186, tegra194 and tegra234.

The formatting of the message could be improved. At minimum adding
newlines will help readability. For upstream patches it's very important
to make a good commit message that is readable and concise.

The commit message should contain:

1. A rationale for the change, i.e. you should explain why it is needed.
2. A brief description of what patch does, explaining only difficult
parts in a more details.

> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  drivers/memory/tegra/mc.c       | 134 ++++++++++++++++++++++++++++----
>  drivers/memory/tegra/mc.h       |  43 +++++++++-
>  drivers/memory/tegra/tegra186.c |   9 +++
>  drivers/memory/tegra/tegra194.c |   8 ++
>  drivers/memory/tegra/tegra234.c |   8 ++
>  include/soc/tegra/mc.h          |   5 +-
>  6 files changed, 189 insertions(+), 18 deletions(-)

Otherwise looks okay:

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
