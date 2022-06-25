Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0113755A940
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 13:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbiFYLPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 07:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbiFYLPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 07:15:06 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E801E31396;
        Sat, 25 Jun 2022 04:15:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5972DCE09F9;
        Sat, 25 Jun 2022 11:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672ADC3411C;
        Sat, 25 Jun 2022 11:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656155702;
        bh=BwsbxnbNM5PkdhDastKNPu200JUqaXIgWWRTtFwzuWw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VxeM7/t/m2Dkt3jRetXDo9gfqSh5vIs0Tu4somfmonxhmEIUJ6R5ztCOZpYcXFo72
         3BLlewzQcOoGPTp4mfq7Yd9yPzckXkR2yfSAPs4TQFgHiSHIwdj8X2/kCYZgu33jFE
         c+CxiYF25nfybPwVoRxc9JNbRHRrmVZAvBwov3pYKTf8Nr4hfWO5+/FZEPKcpberYB
         2bUlsI38osBT3Z12MDixWFNCBkCo8+z6TDpgqdTR1jReWIDKV2+Oz/EMvUnaUOguQk
         sSbenumiXt83hA8GLz1eeY0xTRz8hbh+nYqURs1gvINd6f0QFjbDXA5LNa1m5qFeNB
         /YcWhxPqjInEQ==
Date:   Sat, 25 Jun 2022 12:24:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/10] iio: adc: mcp3911: use resource-managed version
 of iio_device_register
Message-ID: <20220625122429.14e98106@jic23-huawei>
In-Reply-To: <YrVZwAqmE0QmibQY@gmail.com>
References: <20220623170844.2189814-1-marcus.folkesson@gmail.com>
        <20220623170844.2189814-2-marcus.folkesson@gmail.com>
        <CAHp75VcYk9PjQ=3ZPB1f=uQ-1GYKnvV-wsu+-z1z81W_ZHCqrw@mail.gmail.com>
        <YrVZwAqmE0QmibQY@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jun 2022 08:29:20 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Thank you for your comments (all of them) Andy!
> 
> On Thu, Jun 23, 2022 at 09:01:59PM +0200, Andy Shevchenko wrote:
> > On Thu, Jun 23, 2022 at 7:40 PM Marcus Folkesson
> > <marcus.folkesson@gmail.com> wrote:  
> > >
> > > Keep using managed resources as much as possible.  
> > 
> > You may not mix devm_ and non-devm_ API calls like this.
> > So, you rule of thumb that goto is most of the time wrong after devm_ call.  
> 
> Can you please confirm that clocks and regulators are disabled when the
> resources are handed back?
> I cannot see where when I'm trying to follow the code.
Andy isn't arguing that the goto is wrong but rather that you cannot
in general safely use devm_* calls if their failure leads to having to
do any cleanup.  The reason is the ordering is hard to reason about. Sometimes
it's safe, but often enough causes problems that we basically refuse to think
hard enough to figure out if it is.  Hence basic rule is don't do it.

The issue is this.
probe() {

	non_devm_call_1();
	ret = devm_call_2()
	if (ret)
		goto err;

	return 0;
err:
	unwind_non_devm_call_1()
}

remove() {
	unwind_non_devm_call_1()
}

remove or error path should unwind in opposite order of what happens in probe.
On the rare occasion where that isn't the right choice, there should be very
clear comments to say why.

Order is

remove() -> unwind_non_devm_call_1()
devm_managed_cleanup() -> unwind_devm_call_2()

Whereas should be

remove()-> unwind_call_2() then unwind_call_1()


There are two ways to solve this.  Either only use devm for those
elements in probe() that happen before the first thing you need to
unwind manually or make everything devm managed (it unwinds in reverse
order of setup) devm_add_action_or_reset() allows you to use your
own devm_ managed callbacks if there isn't a standard one available.

Jonathan




> 
> Best regards
> Marcus Folkesson

