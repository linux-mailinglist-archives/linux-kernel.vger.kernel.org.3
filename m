Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317BC4DCF49
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiCQU0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiCQU0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:26:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6DA114CD08;
        Thu, 17 Mar 2022 13:25:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 941081FB;
        Thu, 17 Mar 2022 13:25:19 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FC503F766;
        Thu, 17 Mar 2022 13:25:17 -0700 (PDT)
Message-ID: <558f0c92-c499-daca-e1ad-2b16137f8c06@arm.com>
Date:   Thu, 17 Mar 2022 20:25:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/3] dt-bindings: timer: Document arm, cortex-a7-timer
 in arch timer
Content-Language: en-GB
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220317191527.96237-1-singh.kuldeep87k@gmail.com>
 <20220317191527.96237-3-singh.kuldeep87k@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220317191527.96237-3-singh.kuldeep87k@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-17 19:15, Kuldeep Singh wrote:
> Renesas RZ/N1D platform uses compatible "arm,cortex-a7-timer" in
> conjugation with "arm,armv7-timer". Since, initial entry is not
> documented, it start raising dtbs_check warnings.
> 
> ['arm,cortex-a7-timer', 'arm,armv7-timer'] is too long
> 'arm,cortex-a7-timer' is not one of ['arm,armv7-timer', 'arm,armv8-timer']
> 'arm,cortex-a7-timer' is not one of ['arm,cortex-a15-timer']
> 
> Document this compatible to address it. The motivation to add this
> change is taken from an already existing entry "arm,cortex-a15-timer".
> Please note, this will not hurt any arch timer users.

Eh, if it's never been documented or supported, I say just get rid of 
it. The arch timer interface is by definition part of a CPU, and we can 
tell what the CPU is by reading its ID registers. Indeed that's how the 
driver handles the non-zero number of CPU-specific errata that already 
exist - we don't need compatibles for that.

In some ways it might have been nice to have *SoC-specific* compatibles 
given the difficulty some integrators seem to have had in wiring up a 
stable count *to* the interface, but it's not like they could be 
magically added to already-deployed DTs after a bug is discovered, and 
nor could we have mandated them from day 1 just in case and subsequently 
maintained a binding that is just an ever-growing list of every SoC. Oh 
well.

Robin.

> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> ---
>   Documentation/devicetree/bindings/timer/arm,arch_timer.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
> index ba2910f0a7b2..ea390e5df71d 100644
> --- a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
> +++ b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
> @@ -26,6 +26,7 @@ properties:
>             - arm,armv8-timer
>         - items:
>             - enum:
> +              - arm,cortex-a7-timer
>                 - arm,cortex-a15-timer
>             - const: arm,armv7-timer
>   
