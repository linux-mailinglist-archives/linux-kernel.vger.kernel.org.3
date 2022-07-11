Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C655701C0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbiGKMKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbiGKMKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:10:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E05F491FD;
        Mon, 11 Jul 2022 05:10:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D2ACB80ED5;
        Mon, 11 Jul 2022 12:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F91C34115;
        Mon, 11 Jul 2022 12:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657541409;
        bh=JidRq+aIP/KXPZW1wchQTZoyRdoLEIqVo+G5vnBfgzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YdURxBL8s5KFA6/l+0muCip0f35rftbIwYV0+0cXJyNPljhWxBFJodKI+qv0Ip2DP
         KnsNSGxgoyvXa0Z6OHPAAqi7MbGLi6hr9hF2p2YTpNGA+SKLNrgf51rEP6AbMDIvel
         KoFNezaykyWMe6GTNuirFEfxbG0uFeDE2zAI1Sy2r+h/pnQhaRYZoq2mefu0D/ZPYO
         Pl04YVa+t0NUIYHBpz0ZOPpwT25EhIQdCtzV9xOaDtH1VA6gCtOsgOuFZUAZaAyjN0
         /1zXZUznzNCnhMlveAB0wg7vkwV/6R9eMNK0e+LKMe94djge8UJtsDMwVThMWe/CIz
         B/JGmm3FNTjXQ==
Received: by pali.im (Postfix)
        id 9500D9D7; Mon, 11 Jul 2022 14:10:06 +0200 (CEST)
Date:   Mon, 11 Jul 2022 14:10:06 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: leds: register-bit-led: Add value
 property
Message-ID: <20220711121006.kjk44rubi5gpqycj@pali>
References: <20220706112828.27278-1-pali@kernel.org>
 <20220706162111.GA145516-robh@kernel.org>
 <20220706162335.2eewgf7l3xghdjtr@pali>
 <CACRpkdYncdsVW8LysQ3--rOF-KUF6dkkPyX4tg4e10vn2K+8FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYncdsVW8LysQ3--rOF-KUF6dkkPyX4tg4e10vn2K+8FQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 July 2022 14:06:50 Linus Walleij wrote:
> On Wed, Jul 6, 2022 at 6:23 PM Pali Rohár <pali@kernel.org> wrote:
> > On Wednesday 06 July 2022 10:21:11 Rob Herring wrote:
> > > On Wed, Jul 06, 2022 at 01:28:27PM +0200, Pali Rohár wrote:
> > > > Allow to define inverted logic (0 - enable LED, 1 - disable LED) via value
> > > > property. This property name is already used by other syscon drivers, e.g.
> > > > syscon-reboot.
> > >
> > > Yes, but those are potentially multi-bit values. This is a single bit
> > > value, and the only value that's ever needed is 0. Why not just use
> > > 'active-low' here?
> >
> > Just because to have uniform definitions across more syscon nodes.
> 
> But what happens if he mask and value don't line up?
> 
> mask = 0x10;
> value = 0x08;

Same what would happen in other drivers, no?

Only those value bits are take into account which are also sets in the mask.

> If you just state active-low; this kind of mistake is not possible to make.
> 
> So I'd rather go for active-low;
> 
> Yours,
> Linus Walleij
