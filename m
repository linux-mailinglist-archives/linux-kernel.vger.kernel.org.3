Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F245A581E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiH2Xsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiH2Xrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:47:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149C1A6ADC;
        Mon, 29 Aug 2022 16:46:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1AC99CE16AA;
        Mon, 29 Aug 2022 23:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B024C43149;
        Mon, 29 Aug 2022 23:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816803;
        bh=4CeSxgNNAqD4J8I2xDVasWksrY8dmv4iPF35HZ2Vs9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b+bIjLnAdz8YUnSAzi6vDFyEOd2FM55SLqtjwThWDGdUc56R/Sf2ZKhGhTYLjrpBt
         dV4D4jR78zKI/YHpMnw/mSGa0+TeMxCJhIeEvFgjU8S6Fb+s31HWTTtVU4YQgnDQeY
         Yq9HguLgDfOQT5moth4uhu5RyFOBLZlh7t+wo71eQBCR4TUZGOpIWKW8zZTFqD4971
         qYizzeR1OhQjHN54UW8LnYtS/f/O4gyNDcDddGMU5gMfD6xnpZ5dIYYKVPAmDYM9W6
         vnTtQ1/k8IURZusQu4937FV7QU4tb0KqxNdu1Cs3rOGsqCjIzuy/EuBpJaILYeJwj0
         3N0UE+4BSbqDw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     tdas@codeaurora.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, ~postmarketos/upstreaming@lists.sr.ht,
        jami.kettunen@somainline.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh@kernel.org,
        Martin Botka <martin.botka@somainline.org>,
        ctatlor97@gmail.com, agross@kernel.org, sboyd@kernel.org
Subject: Re: [PATCH] clk: qcom: gcc-sdm660: Use floor ops for SDCC1 clock
Date:   Mon, 29 Aug 2022 18:46:05 -0500
Message-Id: <166181675962.322065.7577270067001229984.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220714203822.186448-1-marijn.suijten@somainline.org>
References: <20220714203822.186448-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2022 22:38:22 +0200, Marijn Suijten wrote:
> In commit 3f905469c8ce ("clk: qcom: gcc: Use floor ops for SDCC clocks")
> floor ops were applied to SDCC2 only, but flooring is also required on
> the SDCC1 apps clock which is used by the eMMC card on Sony's Nile
> platform, and otherwise result in the typicial "Card appears
> overclocked" warnings observed on many other platforms before:
> 
>     mmc0: Card appears overclocked; req 52000000 Hz, actual 100000000 Hz
>     mmc0: Card appears overclocked; req 52000000 Hz, actual 100000000 Hz
>     mmc0: Card appears overclocked; req 104000000 Hz, actual 192000000 Hz
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: gcc-sdm660: Use floor ops for SDCC1 clock
      commit: 6956c18f4ad9200aa945f7ea37d65a05afc49d51

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
