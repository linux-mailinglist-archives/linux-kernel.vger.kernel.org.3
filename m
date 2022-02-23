Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57044C1AB9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 19:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243798AbiBWSOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 13:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241030AbiBWSOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 13:14:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406CB48315;
        Wed, 23 Feb 2022 10:14:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0BFBB8212F;
        Wed, 23 Feb 2022 18:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B95DC340E7;
        Wed, 23 Feb 2022 18:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645640049;
        bh=Wxzunyx2l5y9CCTx4nOCZYPf3YEgpmzKbzTfonaFoKU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cWls5NedytacTVIsmrOIUE3vd72wtl/GQAbopySZo28Qw+t3dBZxW21q358WS1WPU
         ubsWSGp8yl8bYZCKRhoWRDLVsmLj/Ldhf4CePDJMZNCSSFTzyzbriOxkTps3HfIudw
         VjfsWHd/FunR3t084E1Yk1iPcmL1bLFVQNhQEBMPIqgbmQkQinm3bTsS4NkCsG0bdx
         YAvKlSqq8MA6DY2ZLvFYXj+LTMMVLXALkStw+k8txeIAi90gempgMtPi8P0Eps/q/C
         0rOjTx2yH5VbID64xgs/gAAtJqNC9Gh1m8ah3g3cG1kXYKSD60zw740oeKlGZbVyz1
         hBscF6tkx5FbQ==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nMw9O-009ynS-2h; Wed, 23 Feb 2022 18:14:07 +0000
MIME-Version: 1.0
Date:   Wed, 23 Feb 2022 18:14:05 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        gpio <linux-gpio@vger.kernel.org>, linux-tegra@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 1/5] gpio: Don't fiddle with irqchips marked as immutable
In-Reply-To: <CAOCk7NpJ5ui+uTKvKeShKmzeKpZkwqCDtyAd_bt2PJKGhE=Gww@mail.gmail.com>
References: <20220223154405.54912-1-maz@kernel.org>
 <20220223154405.54912-2-maz@kernel.org>
 <CAOCk7NpJ5ui+uTKvKeShKmzeKpZkwqCDtyAd_bt2PJKGhE=Gww@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <dfaecd99516ca3c6b994119e308c8579@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: jeffrey.l.hugo@gmail.com, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, thierry.reding@gmail.com, joey.gouly@arm.com, jonathanh@nvidia.com, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, bjorn.andersson@linaro.org, agross@kernel.org, tglx@linutronix.de, linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, kernel-team@android.com
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

On 2022-02-23 17:48, Jeffrey Hugo wrote:
> On Wed, Feb 23, 2022 at 10:40 AM Marc Zyngier <maz@kernel.org> wrote:
>> 
>> In order to move away from gpiolib messing with the internals of
>> unsuspecting irqchips, add a flag by which irqchips advertise
>> that they are not to be messed with, and do solemnly swear that
>> they correctly call into the gpiolib helpers wueh required.
> 
> "wueh"?  Should that be "when"?

Absolutely. There are more typos in this cover letter, and probably
even more in the individual patches!

         M.
-- 
Jazz is not dead. It just smells funny...
