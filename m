Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD32514A37
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbiD2NJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359679AbiD2NIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:08:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F4D10EA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:05:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8F25B833F7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DED5C385A4;
        Fri, 29 Apr 2022 13:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651237528;
        bh=1Ze5xcZmIt0iaugrJOOHAsDQ1jS8pGbPcfOZEJjBSXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ue1y8pzmI86FlPEl4Hxcw8XH40ZuLTdYNNjiMZwE1Lr9igH/pVJhrKEg5JWTBA30D
         byRO8WgFWlyOF5ErrRvySIwBmCy2l/D9dMHSSFYOib1JeUnY0pE5dguNYZe2Pac/lG
         BKJ+arvAFkb3WSxXk2voqzQ9kRltV6Nbiz3aKTivfU3/AnzCJGW8B8cfT3RWIYRE3/
         4FE/iv0hfx1g4rDc/fLY5FhK7EyvacsmjEflhDnApVZHswoKUQXXVOBmlr2ZIRQZ63
         wxfJIikQ7lHNg4/BB8CmO6y4c0cqhlPNLLEnB1T3J/gEwGNedyCAERzNRRcG/EYq3w
         6fwWOIQecjTQA==
Received: by pali.im (Postfix)
        id F2463CAF; Fri, 29 Apr 2022 15:05:24 +0200 (CEST)
Date:   Fri, 29 Apr 2022 15:05:24 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] irqchip/armada-370-xp: Do not touch Performance
 Counter Overflow on A375, A38x, A39x
Message-ID: <20220429130524.vs6mlzvotvaortbw@pali>
References: <20220425113706.29310-1-pali@kernel.org>
 <YmvYrFUfIUvfjrmY@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YmvYrFUfIUvfjrmY@lunn.ch>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 April 2022 14:23:08 Andrew Lunn wrote:
> On Mon, Apr 25, 2022 at 01:37:05PM +0200, Pali Rohár wrote:
> > Register ARMADA_370_XP_INT_FABRIC_MASK_OFFS is Armada 370 and XP specific
> > and on new Armada platforms it has different meaning. It does not configure
> > Performance Counter Overflow interrupt masking. So do not touch this
> > register on non-A370/XP platforms (A375, A38x and A39x).
> 
> Hi Pali
> 
> Do the Armada 375, 38x and 39x have an over flow interrupt? I assume
> not.

Hello! According to documentation there is something named performance
counter interrupt, but it is in different register... and this register
is not per-cpu.

> Does this need a fixes tag? Should it be back ported in stable?

git blame show that this functionality appeared in commit 28da06dfd9e4
("irqchip: armada-370-xp: Enable the PMU interrupts").
