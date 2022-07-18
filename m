Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14154578D6F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbiGRWTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiGRWTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:19:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461E05F50;
        Mon, 18 Jul 2022 15:19:04 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7A8A366019F3;
        Mon, 18 Jul 2022 23:19:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658182742;
        bh=cpVbYxStkk0TBWfh3vWvgvkINPgtVFCpknaqG3L5bMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dse5PnL5X29rke4WJf6H2vO5GuMVfPClG3lZkbvKx+BXigza2knJVk+8uxcFG3+Nm
         DVDe2juLAnNjXr1s6JUVsg9z5EEdXAKQUtZ6trhIWlXE1fp1zrdcZsAP44BN7egHl3
         F2NYsMgwxYObJ1/VHsHJ6j4do6ireEAM3+oppRVwslGpf3I028n+CgST8QYFsIgT0O
         08p7peYZDEFsM7fpsj2oES2+1v/WtWDQIryOsgtzoCSOR+MMczJJuDSzYujjHZwz++
         vDiQCbeRxkUe9pi1eIc06YdkLxAQBPzSiCcn8w/iJNk92uorvbIMKJbpbXf9HBObg0
         5qUSCxAjMXxnQ==
Date:   Mon, 18 Jul 2022 18:18:57 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 1/2] clk: core: Honor CLK_OPS_PARENT_ENABLE for clk
 gate ops
Message-ID: <20220718221857.7vgmsgqxozytkofa@notapiano>
References: <20220713082111.2233016-1-wenst@chromium.org>
 <20220713082111.2233016-2-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220713082111.2233016-2-wenst@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 04:21:10PM +0800, Chen-Yu Tsai wrote:
> In the previous commits that added CLK_OPS_PARENT_ENABLE, support for
> this flag was only added to rate change operations (rate setting and
> reparent) and disabling unused subtree. It was not added to the
> clock gate related operations. Any hardware driver that needs it for
> these operations will either see bogus results, or worse, hang.
> 
> This has been seen on MT8192 and MT8195, where the imp_ii2_* clk
> drivers set this, but dumping debugfs clk_summary would cause it
> to hang.
> 
> Fixes: fc8726a2c021 ("clk: core: support clocks which requires parents enable (part 2)")
> Fixes: a4b3518d146f ("clk: core: support clocks which requires parents enable (part 1)")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Tested that MT8192 no longer hangs when dumping clk_summary.

Thanks,
Nícolas
