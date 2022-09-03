Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2555AC0DF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 20:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiICSlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 14:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiICSlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 14:41:45 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4A128707;
        Sat,  3 Sep 2022 11:41:44 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id kh8so3833193qvb.1;
        Sat, 03 Sep 2022 11:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=R+6fr3Z46+up0wQuivCog9HCcCTNyVOBY73hRlyB6EY=;
        b=eUWcwbV9/QYS4UNYw5GnHynYy3Dwg7BqVnua3yKsPmEk/nTJKTlmpwUWOxVBwawMgK
         8xCynUVFW1ebLJhmW5GSCGXrMjB2ej1kAHU/OKEVu50798pd9gipegQHhDtC592xd8e1
         qLRLEP1sM+c03FYmSiP1SLHmsPDFqfXXwa3rP7VAzHAE4zM2LfnPw+MoFdo4suq9Kw3Q
         lVQls+EbFFR98DNi07NH9KSkxvczJSLbqmRq24/ajvl+GpkM/FUX/x5G43c42OFmBnW8
         vR+haAw4aSMkWKZjqdDQVlIYzXiqmLwRbvcv6CFnx3rXpDUxdu7sK0TO/zhTyBdZX9aA
         RH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=R+6fr3Z46+up0wQuivCog9HCcCTNyVOBY73hRlyB6EY=;
        b=vFvxECCJUSLhgkAV70zL2d4PQPwMWB8lthltPWqhCmEKhlcBBfLuwTGZjnbZnXVS1J
         T6Ult8+HLFgBW53sj+dVSLYBa9s2XZePjkaZdocI3JcW9UotlXyhKorRo/rvGIelrV2s
         /Y1KqMBOW3ROKC9HaW4FHwcsykU4PP6zN6lq0zGU0CAXj6TerAbNiXJMzjqGk8C89eWS
         sJCZXNk8eX8WKqVJRnSZQ9Cdo0xSzbMwvmwD0Kgx8l6VlqhkYOgRgi8Vb1vd0xk8tb+Q
         OPbglp8I8zLe6Rc117N7kWqtTouq3GecMkI6x5v7jq+htnLkGvXQVHR2fb3gdkYqW8G/
         6+aw==
X-Gm-Message-State: ACgBeo3yj3NSa9AW1gIx+CUfw+d/A4wXGg+adbxbWR4d9+9xXD8r4gyE
        B/86f2I7Sf3NhVYRiahiTjQ=
X-Google-Smtp-Source: AA6agR79o/Sxqsj/ecrboICideMqI973um+6n0GYVre3ZB1RF9tuMHTKi1o6dOktrhnCT2D/a389dQ==
X-Received: by 2002:a0c:df8d:0:b0:49e:47f2:c6ba with SMTP id w13-20020a0cdf8d000000b0049e47f2c6bamr2195009qvl.76.1662230503217;
        Sat, 03 Sep 2022 11:41:43 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id m25-20020ac84459000000b00344cb66b860sm3496308qtn.38.2022.09.03.11.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Sep 2022 11:41:42 -0700 (PDT)
Message-ID: <3e0a54a8-5cea-ba31-89a2-8bf1a5d9ec88@gmail.com>
Date:   Sat, 3 Sep 2022 11:41:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] clk: iproc: Do not rely on node name for correct PLL
 setup
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
Cc:     rafal@milecki.pl, Michael Turquette <mturquette@baylibre.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM IPROC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220803025836.107886-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220803025836.107886-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/2022 7:58 PM, Florian Fainelli wrote:
> After commit 31fd9b79dc58 ("ARM: dts: BCM5301X: update CRU block
> description") a warning from clk-iproc-pll.c was generated due to a
> duplicate PLL name as well as the console stopped working. Upon closer
> inspection it became clear that iproc_pll_clk_setup() used the Device
> Tree node unit name as an unique identifier as well as a parent name to
> parent all clocks under the PLL.
> 
> BCM5301X was the first platform on which that got noticed because of the
> DT node unit name renaming but the same assumptions hold true for any
> user of the iproc_pll_clk_setup() function.
> 
> The first 'clock-output-names' property is always guaranteed to be
> unique as well as providing the actual desired PLL clock name, so we
> utilize that to register the PLL and as a parent name of all children
> clock.
> 
> Fixes: 5fe225c105fd ("clk: iproc: add initial common clock support")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Stephen,

Can we get this applied for an upcoming 6.0-rc? Thanks
-- 
Florian
