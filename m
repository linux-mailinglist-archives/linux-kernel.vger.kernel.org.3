Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C38505DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347230AbiDRRrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347204AbiDRRri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:47:38 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923FA62DB;
        Mon, 18 Apr 2022 10:44:58 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 65BE322175;
        Mon, 18 Apr 2022 19:44:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650303896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wP2wWFVd6q4JzYn6RjWWHfuzqPY6kzLac4JQBKQqFtg=;
        b=J3TYgOmC7h4lL+3gTW3/xuqhv9KpvQMbd4GrDePppDT4+L1jmokYTzI5LVZiqUcVTY+Zb/
        frLrTX83SrpnDCCCP3wVtwdNi2SccR7DEQaCfNVTZbg5tLRg1KlaxkGw2Hi4TOBIhXs0hF
        GeUZ76/vxb71JX5jmm0gN/vbWu+lkrc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 18 Apr 2022 19:44:55 +0200
From:   Michael Walle <michael@walle.cc>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] hwmon: add lan9668 driver
In-Reply-To: <20220401214032.3738095-1-michael@walle.cc>
References: <20220401214032.3738095-1-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <95a2e996285649dadba673f2f0614192@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2022-04-01 23:40, schrieb Michael Walle:
> Add a temperature and fan controller driver for the Microchip LAN9668 
> SoC.
> 
> The temperature sensor uses a polynomial to calculate the actual
> temperature. Fortunately, the bt1-pvt already has such a calculation.
> It seems that the LAN9668 uses the same Analog Bits sensor as the
> BT1 although with a different characteristic. To be able to reuse the
> code move it to lib/ as it seems pretty generic to calculate any
> polynomial using integers only, which might also be used by other parts
> of the kernel. Another option might be to move the code to 
> hwmon-poly.c,
> I'm not sure. Thoughts?
> 
> I also plan on submitting patches to add temperature sensor support for
> the GPYxxx and LAN8814 PHYs which also use polynomial_calc().
> 
> The last two patches adds the actual driver and the dt-binding for it.
> 
> changes since v3:
>  - validate input frequency in lan966x_hwmon_write_pwm_freq()
>  - enable sensor before registering hwmon device
>  - automatically disable sensor when driver is removed
>  - set the required clock devider in case someone changed the
>    hardware default before the driver is loaded
>  - remove extra empty lines
> 
> changes since v2:
>  - strip unwanted copy pasta.. oops
>  - use "select REGMAP" instead of "depends on"
> 
> changes since v1:
>  - add doc string to polynomial_calc(), moved the comment
>    into the function.
>  - add missing "select POLYNOMIAL" to the bt1_pvt driver
>    Kconfig symbol
>  - add hwmon driver documentation
>  - cache sys_clk rate during probe
>  - add missing ERR_CAST()
>  - adapted comment for the PPS->RPM calculation
>  - add temporary variable in lan966x_hwmon_read_pwm_freq()
> 
> Michael Walle (4):
>   lib: add generic polynomial calculation
>   hwmon: (bt1-pvt) use generic polynomial functions
>   dt-bindings: hwmon: add Microchip LAN966x bindings
>   hwmon: add driver for the Microchip LAN966x SoC

Any news here? Or did I miss anything?

-michael
