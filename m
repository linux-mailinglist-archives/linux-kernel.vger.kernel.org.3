Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F93959CE42
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239516AbiHWCFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235768AbiHWCFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:05:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9239EF590;
        Mon, 22 Aug 2022 19:05:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 296E460C1E;
        Tue, 23 Aug 2022 02:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B832C433D6;
        Tue, 23 Aug 2022 02:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661220321;
        bh=oSh5FfNfwL6/Rv0w4q9r+OWZqkJmP31snhtT+GznY8k=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=T/jy4xAy41RdRJX6mIHpwgbY69DhvMxwHpmwdobKmqNVTFcJtXtBuy3RF1jnL88VQ
         4kPx4Ndwl5QVKmSwKzpWoEZLdYlB5+GNibJ24gPJcDnvc4DXkT/aVorWQUKXuEnQaD
         Mtt8GfUjLla91gyuzzqNXCTm1b1HD0uvoVDyyg61r4ww0SZIgk0v87KH5MvbDzy3Ei
         n2NiKIvFYV6ns+CeaMuWEuanFV/3JEyXCVFtDccZJxLxTI+w71iXN3+XK/sWcxyp5Y
         AMp4V3/PMxolJzVbQOLUF7xHDbDD3hhSOkMNUZmfSoRMUuSSXVtxHGHYoh9haH5Jlt
         4viFBKUFeG84w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220523142608.65074-1-linmq006@gmail.com>
References: <20220523142608.65074-1-linmq006@gmail.com>
Subject: Re: [PATCH] clk: tegra: Fix refcount leak in tegra210_clock_init
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linmq006@gmail.com
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Rhyland Klein <rklein@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Date:   Mon, 22 Aug 2022 19:05:19 -0700
User-Agent: alot/0.10
Message-Id: <20220823020521.7B832C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miaoqian Lin (2022-05-23 07:26:08)
> of_find_matching_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
>=20
> Fixes: 6b301a059eb2 ("clk: tegra: Add support for Tegra210 clocks")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---

Applied to clk-next
