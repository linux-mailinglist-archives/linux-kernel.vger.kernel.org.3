Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EC0578D74
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbiGRWWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiGRWWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:22:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A723135A;
        Mon, 18 Jul 2022 15:22:38 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 244E466019F3;
        Mon, 18 Jul 2022 23:22:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658182956;
        bh=ZtaFeUkq1jYD1KkAdKtkGmQDm6nyXB5ITHnEHsXVkLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GYq3dgaY7yFDp96HSAeWfP4klcykjmMYkTNIPSDlNOBHlZCWdd3037EgUEEvpnGFa
         DVHFzWIKAq37znRj4IeTEr9Fsybh8GcRJdKkQLFYuLCYOCYAs/pvlPZ/XOLdnSbpwA
         y5ojemF2ezxyJ3Xe52EQ4cKEDV1si/tSk926WCsc8haNDGiejZA+9Cp18L2MUSaGdS
         tKOUoDAGWQm7yFC8wG2kuqLluW1u8WDqW+ggclzxG0x6cfBCsMmlw/vz+SMUbDlXIF
         DnN09LuR4KSWJAtuwGiVQRkKS7GeDXf5fimTKtZBy9HwbzCl/QDCz1+uSOq2t4+j7E
         VmedVrZGXJRhQ==
Date:   Mon, 18 Jul 2022 18:22:32 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 2/2] clk: core: Fix runtime PM sequence in
 clk_core_unprepare()
Message-ID: <20220718222232.lffgerc6qfi6jnha@notapiano>
References: <20220713082111.2233016-1-wenst@chromium.org>
 <20220713082111.2233016-3-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220713082111.2233016-3-wenst@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 04:21:11PM +0800, Chen-Yu Tsai wrote:
> In the original commit 9a34b45397e5 ("clk: Add support for runtime PM"),
> the commit message mentioned that pm_runtime_put_sync() would be done
> at the end of clk_core_unprepare(). This mirrors the operations in
> clk_core_prepare() in the opposite order.
> 
> However, the actual code that was added wasn't in the order the commit
> message described. Move clk_pm_runtime_put() to the end of
> clk_core_unprepare() so that it is in the correct order.
> 
> Fixes: 9a34b45397e5 ("clk: Add support for runtime PM")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
