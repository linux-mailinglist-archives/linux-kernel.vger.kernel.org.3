Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125B85A5E06
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiH3I06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiH3I0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:26:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C992372FE7;
        Tue, 30 Aug 2022 01:26:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 511FC6153F;
        Tue, 30 Aug 2022 08:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FBEC433C1;
        Tue, 30 Aug 2022 08:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661848013;
        bh=0Kcd47M1Gp8kFRDeRQ4RQQHp2Sfbb0yfmxJLbNXXTAI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tfufUU/A3QjZ3m+QLaSb6e4HmqCItYxnDxEURQDGy7MtmDrUAl7zsgv5pZqZgk8zJ
         N9gmw0rwi4N4GwX3DYnBDrjgzZGzKqvrVHDz0e34HIH/jj65bLQM3Wh95gV9DhfhVq
         mx5LMTMkGP1xU0GuZea2HCRHlTLBc8pU3Fpq7ObE9tCrDzbkPQeLYODSl1P8JgALrB
         /9M7b+U9/mOugZxB/DAFINjVxsmpo234dauIHV37w855hCVQ9krxtRthjRE6y7zDxQ
         aUzBjWYsAX+FBg03eRkNyB/gASlTXheuWRXkGkgeE0nlMyWOjP+I/ApYK1EYbWGIQf
         8XpT1AHJnEBOg==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oSwaB-006fye-EW;
        Tue, 30 Aug 2022 09:26:51 +0100
MIME-Version: 1.0
Date:   Tue, 30 Aug 2022 09:26:51 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linus.walleij@linaro.org, bjorn.andersson@linaro.org,
        robimarko@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan+linaro@kernel.org, steev@kali.org
Subject: Re: [PATCH v2] pinctrl: qcom: spmi-gpio: Make IRQCHIP immutable
In-Reply-To: <20220830081212.164709-1-manivannan.sadhasivam@linaro.org>
References: <20220830081212.164709-1-manivannan.sadhasivam@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <e20dabe02d88f28fc933b596dee8b69d@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: manivannan.sadhasivam@linaro.org, linus.walleij@linaro.org, bjorn.andersson@linaro.org, robimarko@gmail.com, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, johan+linaro@kernel.org, steev@kali.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-30 09:12, Manivannan Sadhasivam wrote:
> The IRQCHIP implementation used inside the gpiochips are not supposed 
> to

lower case

> be changed during runtime. So let's make the one inside the spmi-gpio
> gpiochip immutable.
> 
> This fixes the below warning during boot:
> gpio gpiochip0: (c440000.spmi:pmic@0:gpio@c000): not an immutable
> chip, please consider fixing it!
> 
> Separate callbacks need to be provided for irq_{mask/unmask} pointers 
> since
> the callbacks are supposed to mask/unmask the corresponding parent IRQ 
> in
> addition to changing the gpio_desc flags.

This is all part of the existing documentation, so I don't think
this is really needed.

> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

With the above fixed:

Acked-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
