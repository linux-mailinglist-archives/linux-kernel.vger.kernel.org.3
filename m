Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2237A558C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 02:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiFXAmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 20:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiFXAmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 20:42:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BF45DC25;
        Thu, 23 Jun 2022 17:42:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B232261F9D;
        Fri, 24 Jun 2022 00:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCD4C3411D;
        Fri, 24 Jun 2022 00:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656031360;
        bh=DI0FXxI6PSfD9rLKB6kDL9lKC6YPyy5SZxWJ3Enrfj4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=AfhC1nDK01STGD+Lb1EqlIFbNQ+zlukNen3ynfq+EboThvy8BR4juTElrvkfZ0VML
         rLP/yiUhzgLYzYRg+V+dCxRSX+E3TN0/eEzxlX4gEAU83CQwTwjIXbSHOKzyVcxs6P
         MqBU8GkzddsYctfOC9Ear7/3idSGBLLoH6Q5BXbwId3Sh8dlOQb9Q9JqrNSxpgsVRp
         yHkGkV8qUCVMfXG00JDINfROFl3/MN4l/CySga9cTK4h02IsIcoJTrhsawQC8kadgJ
         SIrl2B4ad7Rf7XeUFsbnoNv3GbuMs5k+1ipm1K3f1YGMO06BLna1E6XZV3UxwjentC
         ltMBdYjYWEe/g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220623083217.26433-2-jslaby@suse.cz>
References: <20220623083217.26433-1-jslaby@suse.cz> <20220623083217.26433-2-jslaby@suse.cz>
Subject: Re: [PATCH 2/2] clk: renesas: rcar-gen4: Fix initconst confusion for cpg_pll_config
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mliska@suse.cz, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
To:     Jiri Slaby <jslaby@suse.cz>, mturquette@baylibre.com
Date:   Thu, 23 Jun 2022 17:42:39 -0700
User-Agent: alot/0.10
Message-Id: <20220624004240.DBCD4C3411D@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jiri Slaby (2022-06-23 01:32:17)
> From: Andi Kleen <ak@linux.intel.com>
>=20
> A variable pointing to const isn't const itself. It'd have to contain
> "const" keyword after "*" too. Therefore, cpg_pll_config cannot be put
> to "rodata".  Hence use __initdata instead of __initconst to fix this.
>=20
> [js] more explanatory commit message.
>=20
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
