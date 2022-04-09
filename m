Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195AA4FA899
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242177AbiDINgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239163AbiDINgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:36:04 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAD4298D5D
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 06:33:52 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id dr20so22245813ejc.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 06:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LO7mTJuUjnyguTxwzU4yCMRsr4W3KT8BOY3t4LlaHc0=;
        b=NSPuRoYHtyOw+PcsMZMVtuInfF33reqEX80RTlsMYF96wzkfEaIKPTkf0zDLCojnUm
         7GdAM9ck8RvQnAE0+woC+0Cz0hKM9k7ConH5cc8CM3A80Q22AF30cnY5tVI5IrRhfRiq
         fUs2YJsfoDOLl23ee7Kfwr0FQg7iHJDavcGzo6omSFqqR7QkLBp6xvW024IMq4mk8XcH
         aI+dI62HLCe60/HRWGhTBdhYz6pdh05BA5qgDsK/MG0ybk9Vjkb5p0YHoofix6xORs7e
         TQjQGp1ld64FVyUXf1RkiYaMnO4jpnKDkq/gesw7lqgg3jkxwTzzbP8gH8cCxOWqkIK3
         2lCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LO7mTJuUjnyguTxwzU4yCMRsr4W3KT8BOY3t4LlaHc0=;
        b=u0D2oPRuR7k2ziajs9f8JQsh4DPdB3r87hE9bKt8f6+RGI5mI2wtWu73dlpm7uZCsS
         Pk/o9ieV0vGLQX5skcwesH7irc1MbhCLlmPILOKTUgOvrzpsE/TQEq0mPT25O9tf2JNV
         C2F85piFgCgI4q7JUsN8caRLQBChcZ+tNkuBPsMMQfTmO0SCwuddQsAKTYPwRejv8r9i
         5iA71TqzyazCIuiHC19Fc208lXnPfH/oLkyGXKJF4fr6fw8Hdl6uDzCg0x881xLNKO75
         544hCxWU1JKNVLzmt8pOxNXfOJFMu8tm8QpE80kQyRrNac5IJuojohgkYdKXzHlKmbCq
         aLjQ==
X-Gm-Message-State: AOAM533SSVb87HKfY12HLR9KvGbs6D9iST1N4U9xeMioK/EO+N2zCnWv
        BQh3rU1ZmL5bt8TGhphygGwRLw==
X-Google-Smtp-Source: ABdhPJw7Y7cYYHPAiiiP0NIjLn5Hmp6+EKk8JZn75hkyokX3E/0ElhCjWMr9REwrEdqcx3UfkRN70w==
X-Received: by 2002:a17:906:d204:b0:6d6:df17:835e with SMTP id w4-20020a170906d20400b006d6df17835emr22437048ejz.20.1649511231518;
        Sat, 09 Apr 2022 06:33:51 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id q22-20020a170906771600b006cf8a37ebf5sm9774514ejm.103.2022.04.09.06.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 06:33:51 -0700 (PDT)
Message-ID: <3b527700-444e-1f6e-fee1-5cd6ed2ef7f9@linaro.org>
Date:   Sat, 9 Apr 2022 15:33:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 05/13] pinctrl: samsung: Switch to use
 for_each_gpiochip_node() helper
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Qianggui Song <qianggui.song@amlogic.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marc Zyngier <maz@kernel.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20220401103604.8705-1-andriy.shevchenko@linux.intel.com>
 <20220401103604.8705-6-andriy.shevchenko@linux.intel.com>
 <d1f873c6-150f-5f4d-7aa8-7bb15823d991@linaro.org>
 <YlBXSVyj88CqjGj4@smile.fi.intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YlBXSVyj88CqjGj4@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2022 17:39, Andy Shevchenko wrote:
> On Fri, Apr 08, 2022 at 05:22:21PM +0200, Krzysztof Kozlowski wrote:
>> On 01/04/2022 12:35, Andy Shevchenko wrote:
>>> Switch the code to use for_each_gpiochip_node() helper.
> 
> (...)
> 
>>>  /*
>>>   * Iterate over all driver pin banks to find one matching the name of node,
>>>   * skipping optional "-gpio" node suffix. When found, assign node to the bank.
>>>   */
>>> -static void samsung_banks_of_node_get(struct device *dev,
>>> -				      struct samsung_pinctrl_drv_data *d,
>>> -				      struct device_node *node)
>>> +static void samsung_banks_node_get(struct device *dev, struct samsung_pinctrl_drv_data *d)
>>
>> This is worth simplification anyway, so please split it to separate patch.
> 
> Not sure what to do and why it worth an additional churn.

Makes this change smaller so it's easier to review.

> 
>>>  {
>>>  	const char *suffix = "-gpio-bank";
>>>  	struct samsung_pin_bank *bank;
>>> -	struct device_node *child;
>>> +	struct fwnode_handle *child;
>>>  	/* Pin bank names are up to 4 characters */
>>>  	char node_name[20];
>>>  	unsigned int i;
>>> @@ -1038,17 +1037,17 @@ static void samsung_banks_of_node_get(struct device *dev,
>>>  			continue;
>>>  		}
>>>  
>>> -		for_each_child_of_node(node, child) {
>>> -			if (!of_find_property(child, "gpio-controller", NULL))
>>> -				continue;
>>
>> This does not look equivalent. There are nodes without this property.
> 
> Not sure I understand why not. The macro checks for the property and
> iterates over nodes that have this property.
> 
> Can you elaborate, please?

Eh, my bad, it is equivalent.

> 
>>> -			if (of_node_name_eq(child, node_name))
>>> +		for_each_gpiochip_node(dev, child) {
>>> +			struct device_node *np = to_of_node(child);
>>> +
>>> +			if (of_node_name_eq(np, node_name))
>>>  				break;
>>> -			else if (of_node_name_eq(child, bank->name))
>>> +			if (of_node_name_eq(np, bank->name))
>>>  				break;
>>>  		}
>>
>> This patch has to wait till someone provides you a tested-by. I might do
>> it around next week.
> 
> Fine with me, I will drop it from my repo for now.


Best regards,
Krzysztof
