Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A17459CE4D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbiHWCGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235768AbiHWCGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:06:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97671055C;
        Mon, 22 Aug 2022 19:06:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84302B816BF;
        Tue, 23 Aug 2022 02:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281CDC433D6;
        Tue, 23 Aug 2022 02:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661220360;
        bh=JdnZcPha0akKL8YKef29IKZECmMqqhF6UeNdPF+LQ3k=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ThbmUS5uig3iJo83WUZSQwXT7d6Smx+7dpRbc288fvGTgC449J2NPRYLx8wTvn0f6
         zHoT8vWqghuzz+zwPSuvSVU+CncY2v1OPAjryvnruuD86sB973BTGTRN4yOZ1m/9Nw
         ISRyGGxVYthGdUsMLGzswRynBHfvkO/Wv9ooGBwkpHCsFAA2VmaKkfJh8ji61el2P4
         2Pedb72Ys7uyRr4K6/VqbNTMiU0teG9yMb+Ms3vpVtrh+R6mXdgb9ump4LQVhzQw3+
         XaxkckPGg5B2DYt85ZXcy3KnkqjewK3xdLm9ESbGVy1p3APS4F86GRql5/gpSJ6QrY
         in0kdnI4k+6vA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220523143834.7587-1-linmq006@gmail.com>
References: <20220523143834.7587-1-linmq006@gmail.com>
Subject: Re: [PATCH] clk: tegra: Fix refcount leak in tegra114_clock_init
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
Date:   Mon, 22 Aug 2022 19:05:58 -0700
User-Agent: alot/0.10
Message-Id: <20220823020600.281CDC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miaoqian Lin (2022-05-23 07:38:34)
> of_find_matching_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
>=20
> Fixes: 2cb5efefd6f7 ("clk: tegra: Implement clocks for Tegra114")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---

Applied to clk-next
