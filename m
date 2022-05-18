Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57D952C4E1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 23:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242806AbiERU6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242719AbiERU54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:57:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B8521AAA8;
        Wed, 18 May 2022 13:57:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 301D960A51;
        Wed, 18 May 2022 20:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A187C385A5;
        Wed, 18 May 2022 20:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652907474;
        bh=GGZytWTFLG82JL28oj5yBN5xRMB57MT2y/zGvzKExtw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=CuZjhfWtKmePehG5GHb3Adbwl42OdlGFKBUSCdTaGdQUAQ+OTOsFICncz9Exq4wTg
         5QXIqPdxaaRnqvfl2DO9WkauN+euSoVLxb7v9hCtlJYGe4AEkq26l+VheqzqoKho/z
         dy5nP25UVndU3FJUordcTLkHGF2udsGpS0h7WZO2TENoo/w7UfyM+gMjhytVGohZRq
         7H1GnZuY020lWEcLLr6ZYvMsQFSJ2h4fNAB578EEvXXqoiJ26+nQp6XWG7KS7Y/nS3
         IVKc2+ptCpZ45BEmD+FGDux1nfKdx0o3AZD1FvIsU1sQ+muPFMVzK1dfFGLeI9NpQx
         v9NggMoTtnJTw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220428164454.17908-3-aidanmacdonald.0x0@gmail.com>
References: <20220428164454.17908-1-aidanmacdonald.0x0@gmail.com> <20220428164454.17908-3-aidanmacdonald.0x0@gmail.com>
Subject: Re: [PATCH v2 2/3] clk: ingenic: Mark critical clocks in Ingenic SoCs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     paulburton@kernel.org, paul@crapouillou.net,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        mturquette@baylibre.com, tsbogend@alpha.franken.de
Date:   Wed, 18 May 2022 13:57:52 -0700
User-Agent: alot/0.10
Message-Id: <20220518205754.8A187C385A5@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aidan MacDonald (2022-04-28 09:44:53)
> Consider CPU, L2 cache, and memory clocks as critical to prevent
> them -- and the parent clocks -- from being automatically gated,
> since nothing calls clk_get() on these clocks.
>=20
> Gating the CPU clock hangs the processor, and gating memory makes
> external DRAM inaccessible. Normal kernel code can't hope to deal
> with either situation so those clocks have to be critical.
>=20
> The L2 cache is required only if caches are running, and could be
> gated if the kernel takes care to flush and disable caches before
> gating the clock. There's no mechanism to do this, and probably no
> reason to do it, so it's simpler to mark the L2 cache as critical.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
> ---

Applied to clk-next
