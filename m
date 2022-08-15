Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46804593405
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 19:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiHOR1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbiHOR1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:27:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06F327FEF;
        Mon, 15 Aug 2022 10:26:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 063F761229;
        Mon, 15 Aug 2022 17:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C41C433D7;
        Mon, 15 Aug 2022 17:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660584413;
        bh=gfrn3wi3lFlHb1DMO/mTQsg4NzAyb0o0/UVlWIOz7MA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZAOTYbOZGP6hcCeGKRAn1Z3DXn8ojOCipv6CPTgverYtBWoJGH+QpFWjV+pzGcRVM
         cgxjAeuHwTEXydOulDfNDCBUb9COW8hRN97s1SqcKsA6WyK3ZnOXnOh28hZ2TW7fp/
         7GyamXOA4hvZB6hmDxuSM6BwVkBThqXWPaO7dnUZM8O2TMSGfSwr7YgaWj6QwIpRnd
         VWhQ1OQtonKYXLx9ChnMwn2PiUeIANAK4RPPezezGfftPT3mgpbAxt7zehwOANvpa0
         Do0HWzA6P2bZQH5cWfVkwUOXBxXQwtFIPFwDCoSGDc5WrEp65ousCby8cJRq37sjoc
         /F9V1khJkN+yw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220810014024.27568-1-samuel@sholland.org>
References: <20220810014024.27568-1-samuel@sholland.org>
Subject: Re: [PATCH] clk: sunxi-ng: mp: Avoid computing the rate twice
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Date:   Mon, 15 Aug 2022 10:26:51 -0700
User-Agent: alot/0.10
Message-Id: <20220815172653.51C41C433D7@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Samuel Holland (2022-08-09 18:40:24)
> ccu_mp_find_best() already computes a best_rate at the same time as the
> best m and p factors. Return it so the caller does not need to duplicate
> the division.

Did the compiler figure this out and thus this patch makes no difference
to the final object code?
