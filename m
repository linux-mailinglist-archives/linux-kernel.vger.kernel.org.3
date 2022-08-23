Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDAD59CE49
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239490AbiHWCGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235768AbiHWCG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:06:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14F412AF5;
        Mon, 22 Aug 2022 19:06:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DB0161224;
        Tue, 23 Aug 2022 02:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC695C433D6;
        Tue, 23 Aug 2022 02:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661220386;
        bh=OPYilaXNqSN66IcN7hBTc8VxRASQY+HVHTakl3BRzCo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=sC4WBXXCwDxzgWtrnY8VBywxsnDh2qYgGCegZ/IK1zcQ/jAhv+1ARPy8zz+sLAQH+
         S+kMginYgTtkiNC3QtnncpFWhhhlQNQh9gQimhCprRiUKLggqGZjrw/vkS7oarTJcy
         P5aRFh7M5NZ0LKxUOaz1KRk1i5KB8CsFlCiMJiYukASIzYsu66GkFJPnhTMaN0wotu
         Cs5Jq76DkCmC5otm1R1LxPnTf359ozK1g/W4i0wy5heSkgf/oeH0B298PIM0duJXZD
         Zge8ndwccA74rUHPvFa/0FDYGAhNMKsOVFeY7uTgNXvhjQzH7BJ2eVYnpbOpscvxFf
         XHFfylMOUrsGg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220523152811.19692-1-linmq006@gmail.com>
References: <20220523152811.19692-1-linmq006@gmail.com>
Subject: Re: [PATCH] clk: tegra20: Fix refcount leak in tegra20_clock_init
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linmq006@gmail.com
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Mike Turquette <mturquette@linaro.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Warren <swarren@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Date:   Mon, 22 Aug 2022 19:06:25 -0700
User-Agent: alot/0.10
Message-Id: <20220823020626.DC695C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miaoqian Lin (2022-05-23 08:28:11)
> of_find_matching_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
>=20
> Fixes: 37c26a906527 ("clk: tegra: add clock support for Tegra20")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---

Applied to clk-next
