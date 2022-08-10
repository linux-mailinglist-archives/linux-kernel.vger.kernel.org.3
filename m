Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A630258E855
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiHJIB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiHJIBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:01:24 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B1674CFB;
        Wed, 10 Aug 2022 01:01:22 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4DC4D22246;
        Wed, 10 Aug 2022 10:01:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1660118479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G7tZN0uMVdLV9oVgGYF8IgsqpH2EixeAWvNZaVOc9RY=;
        b=nlfMuIwIsZ5MERF6ng4iqGhwtR09GzWy6dPthREiUJTnz05+65g1ryw8SysRgbshogRrBK
        DxrJvNJo0wDDjskVhseX2pzKGa9z7Nw4I9QBclrEwWxDq2VL9x/bHuIpWKIhVEZBUmZN01
        5NtP09mOqIeXZQS1KCnGjiia1muMiYU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Aug 2022 10:01:16 +0200
From:   Michael Walle <michael@walle.cc>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     daniel.lezcano@linexp.org, abailon@baylibre.com,
        anarsoul@gmail.com, baolin.wang7@gmail.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, digetx@gmail.com,
        f.fainelli@gmail.com, glaroque@baylibre.com,
        hayashi.kunihiko@socionext.com, heiko@sntech.de, j-keerthy@ti.com,
        jonathanh@nvidia.com, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, matthias.bgg@gmail.com,
        mcoquelin.stm32@gmail.com, mhiramat@kernel.org,
        miquel.raynal@bootlin.com, niklas.soderlund@ragnatech.se,
        rafael@kernel.org, rui.zhang@intel.com, shawnguo@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, tiny.windzz@gmail.com,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 00/33] New thermal OF code
In-Reply-To: <27c03303-9ee5-d9df-b7f2-016491fce9e5@linaro.org>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
 <20220808094216.928018-1-michael@walle.cc>
 <27c03303-9ee5-d9df-b7f2-016491fce9e5@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <5adfe0882926d8f16c158d453069b37b@walle.cc>
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

Hi Daniel,

Am 2022-08-09 10:23, schrieb Daniel Lezcano:
>> On my second board
>> (arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts). I get 
>> the
>> following error:
>> 
>> [    6.292819] thermal_sys: Unable to find thermal zones description
>> [    6.298872] thermal_sys: Failed to find thermal zone for hwmon id=0
>> [    6.305375] lan966x-hwmon e2010180.hwmon: error -EINVAL: failed to 
>> register hwmon device
>> [    6.313508] lan966x-hwmon: probe of e2010180.hwmon failed with 
>> error -22
>> 
>> Again, is there seems to be something missing in the device tree. For 
>> this
>> board a device tree change should be easily doable, as it is still in
>> development.
> 
> Logically with the fixes I've send these errors should have gone. Just
> a pr_info should appear "... not attached to any thermal zone".
> 
> If I'm correct, without or with the changes (new thermal OF code +
> fixes), the hwmon message is the same and the hwmon thermal zone is
> not created. So no regression hopefully.
> 
> Is it possible to check that?

Yes, I'm no more seeing any error messages and the device
is probed successfully. Both on the kswitch board as well as on
the sl28 board.

Thanks,
-michael
