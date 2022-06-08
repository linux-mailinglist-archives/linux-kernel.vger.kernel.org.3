Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52921542C8D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbiFHKFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236353AbiFHKDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:03:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52E717EF4C;
        Wed,  8 Jun 2022 02:47:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 431BC619C5;
        Wed,  8 Jun 2022 09:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744BFC34116;
        Wed,  8 Jun 2022 09:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654681625;
        bh=Jorqtsqre+knYuVCMZVf8w1e+vT3PzQP8A6uE9eOcy0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ia1uTWThiKJKkirUArp2zjiq0kobE6RwKYmZKHNbgpZTPkbpYUQFUslRjCXTXLG0f
         eLCLHr+lnNY1BNrvwwu5fIG9tNAMo8hpMI+5TKr8C4hiZ0i1bSYC4aWGa+TburuZ9m
         /X6c6Fe0X8a6lrrrUeIDg6iS+Sx6bpm8O0o3ISgHIKIsyIvVdH1wWi+mzkzbl0UDSq
         IAOzeCx9822Y5RQzLC31P8AQCUNazUqO17x5xchx1vq8Fj/nQ0TL9sy0475Q0r2FJK
         D7kx9cY06b0+oUhjePOojzbIG/EcgkGt9QJOticwFliv/HyIl9EBX39Nrpzyimqb76
         jIfjRBOdvUgtg==
Date:   Wed, 8 Jun 2022 11:47:00 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: HID: i2c-hid: elan: Introduce bindings
 for Elan eKTH6915
In-Reply-To: <20220523142257.v2.1.Iedc61f9ef220a89af6a031200a7850a27a440134@changeid>
Message-ID: <nycvar.YFH.7.76.2206081146490.10851@cbobk.fhfr.pm>
References: <20220523142257.v2.1.Iedc61f9ef220a89af6a031200a7850a27a440134@changeid>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022, Douglas Anderson wrote:

> Like many i2c-hid touchscreen controllers, the Elan eKTH6915
> controller has a reset gpio. For the Goodix GT7375P touchscreen the
> decision was to add a new binding rather than trying to add a new GPIO
> to the existing i2c-hid binding. We'll follow the lead and do it here,
> too.
> 
> SIDE NOTE: the Elan eKTH6915 is a touchscreen _controller_ that's
> included as a part on some touchscreens. The reset line isn't truly
> necessary for the functioning of the touchscreen, so it's possible
> that some designs won't have it hooked up and will just guarantee the
> power sequencing requirements with RLC circuits. Thus, we'll mark the
> reset gpio as optional.
> 
> Note that if the reset GPIO isn't used there's actually no true need
> to use the "elan,ekth6915" compatible instead of the "hid-over-i2c" on
> Linux. However:
> - Officially using just "hid-over-i2c" for this device violates the
>   existing "hid-over-i2c" bindings. The bindings say that you're not
>   supposed to use "post-power-on-delay-ms" without specifying a more
>   specific compatible. Currently the Linux driver doesn't enforce
>   this, but it violates the bindings to just use
>   "hid-over-i2c". ...and if you're going to add a more specific
>   compatible anyway, might as well do it right.
> - Using this compatible means we don't need to specify
>   "hid-descr-addr" since it's inferred from the compatible.
> - Using this compatible means that the regulator names match the names
>   on the Elan datasheet (vcc33 / vccio) vs the generic hid-over-i2c
>   (vdd / vddl).
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Now queued in hid.git, thanks.

-- 
Jiri Kosina
SUSE Labs

