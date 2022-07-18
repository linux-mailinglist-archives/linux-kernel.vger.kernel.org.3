Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00E3578B7F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 22:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbiGRUIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 16:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbiGRUIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:08:32 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B15028E19;
        Mon, 18 Jul 2022 13:08:31 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id r4so2444847ilb.10;
        Mon, 18 Jul 2022 13:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+I5ZRgBbDf3RPxUCbZaLy/tEPOdK4YJDVpzXOSbpprc=;
        b=urkqgoBJs/8re8VIbw7XbwWeqD3M3btujHkj0zmSyOHtSnEqtPClbnqOo0X5c/XcRE
         Obrn702yU+aTE7otsZFuafcJOBLtb7+2TvguhGy569/nXsm9o6f0iEJJYJbq3R197Ch7
         chJZN3uESrptKVs2pdr3SCliB8oiuJFpMPUoex6JRsHucfiOT755nM3on9S3+nPmXy5+
         TG4fFWoHLxAQMC1gIjvlXOzakHUeCB4W1ZyTu/KTdK2GgQUNAwondqWuD0xhNRWYmrBd
         i1FsJBcGxDpoftmzMkBzn5P/yzQUmAS5WFP2ax4HsHKRHYgHawuaTc0/ASWqqIb3WfQh
         XcQg==
X-Gm-Message-State: AJIora9S+qbPmDSPMS5a2EpCy6Jmkw/spcJZwqxlSb1OMq0Y9cLycNZl
        Kh6BuMbkIT6yInaKWOXf/g==
X-Google-Smtp-Source: AGRyM1tR7+ejhnEnx2w/BdniU0UfUO8r5ulQM83VlmIFvYsjDUHUS4lrU8jhwpfyzU+EPv7TFwnmog==
X-Received: by 2002:a05:6e02:1405:b0:2da:c72f:e3a7 with SMTP id n5-20020a056e02140500b002dac72fe3a7mr14370733ilo.113.1658174910682;
        Mon, 18 Jul 2022 13:08:30 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id c7-20020a056638028700b00331b9a3c5adsm5759039jaq.170.2022.07.18.13.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 13:08:30 -0700 (PDT)
Received: (nullmailer pid 3461504 invoked by uid 1000);
        Mon, 18 Jul 2022 20:08:28 -0000
Date:   Mon, 18 Jul 2022 14:08:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>
Subject: Re: [PATCH 7/7] pwm: dwc: add snps,pwm-number to limit pwm count
Message-ID: <20220718200828.GA3453680-robh@kernel.org>
References: <20220712100113.569042-1-ben.dooks@sifive.com>
 <20220712100113.569042-8-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712100113.569042-8-ben.dooks@sifive.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 11:01:13AM +0100, Ben Dooks wrote:
> Add snps,pwm-number property to indicate if the block does not have
> all 8 of the PWM blocks.
> 
> Not sure if this should be a general PWM property consider optional
> for all PWM types, so have added a specific one here (there is only
> one other controller with a property for PWM count at the moment)
> 
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-synposys.yaml | 5 +++++
>  drivers/pwm/pwm-dwc.c                                   | 8 ++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-synposys.yaml b/Documentation/devicetree/bindings/pwm/pwm-synposys.yaml
> index 38ac0da75272..15bdf764b46a 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-synposys.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm-synposys.yaml
> @@ -30,11 +30,16 @@ properties:
>        - items:
>          - const: snps,pwm
>  
> +  snps,pwm-number:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description: u32 value representing the number of PWM devices

Why do we need to know this? Are you going to have a consumer to a 
non-existent PWM? If you do need to know how many, it should be implied 
by the compatible string.

Rob
