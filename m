Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502EC50BCF4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449653AbiDVQ3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384500AbiDVQ3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:29:31 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355E15EBEF;
        Fri, 22 Apr 2022 09:26:35 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 0279383D4B;
        Fri, 22 Apr 2022 18:26:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1650644793;
        bh=DEvATQUcmAUvQtZt+xl0HhiXkCZH3A3i2rSRnjRahGM=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=jKUSyRNQXt+3uKyhT+4qpG0zhfDqsIKb0MBe+7dwBIJclr3+0t+w6Ln8rjXZrzxCD
         xsSvW7US62e0SpaA9TMWJPC/safVtElF5FYHE31gz3JgklEPwIW9KFUtR2QQQ0ozQN
         agRKE947CU4MdHKxst1LEtQIiMauosoyl//jME5tgChBF4S59bKxydkKbWQ1hCTNQI
         JTdmBiIdnsHz97Xy8ptppSto0l0m1qwnBrJGkJR11U8+PG0tFYrjduXU8kNVhEy1nD
         XwbQTh5F+jyvWjb+fXvvK5mPi9WgegzMnHLZthTR+AxdlgVquuEcHBvVzeomwheuCb
         ASx+DqSWM6ORw==
Message-ID: <c48500cd-50be-1d70-2f2c-02c2dcede1eb@denx.de>
Date:   Fri, 22 Apr 2022 18:26:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] pinctrl: stm32: improve bank clocks management
Content-Language: en-US
To:     Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-gpio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220422143608.226580-1-fabien.dessenne@foss.st.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20220422143608.226580-1-fabien.dessenne@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/22 16:36, Fabien Dessenne wrote:
> Instead of enabling/disabling the clock at each IO configuration update,
> just keep the clock enabled from the probe.
> This makes things simpler and more efficient (e.g. the time required to
> toggle an output IO is drastically decreased) without significantly
> increasing the power consumption.

[...]

>   static struct irq_domain *stm32_pctrl_get_irq_domain(struct device_node *np)
> @@ -1575,6 +1537,10 @@ int stm32_pctl_probe(struct platform_device *pdev)
>   			ret = stm32_gpiolib_register_bank(pctl, child);
>   			if (ret) {
>   				of_node_put(child);
> +
> +				for (i = 0; i < pctl->nbanks; i++)
> +					clk_disable_unprepare(pctl->banks[i].clk);
> +

There are clk_bulk_*() functions, maybe you can use those to get rid of 
these loops ?

The rest looks good to me.
