Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E58583603
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 02:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbiG1AcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 20:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiG1Ab6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 20:31:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81EE54CA0;
        Wed, 27 Jul 2022 17:31:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75B23B8229F;
        Thu, 28 Jul 2022 00:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D28C433D6;
        Thu, 28 Jul 2022 00:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658968315;
        bh=cgMax9nf9qW48JMtAkUoIyip26M7Bpa8V5h47PbKfC4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nlqaAET4ci75hpEpVFTfRPIEF2htScl2LXIAlqXintsUaUKetcCiPAzb42chVmnkB
         wKr9EwczFt7JxVVho5QiYakPC+GtoRtP4t0rfUVwGo9Fslccl0m+4xx7uQrCsgmCTm
         DO7IySLE7/4lrN2Wbug+uNmq4hEj2qUCKYShnJduTcyRX+nB26mLun1a4MxFjOqyJ1
         f2wI2hMWzsu0AaZVl7XYyzu8ulkz9VwMj5klckTi/1Y0zHSSkpKf/rEdKtDtWEXpkd
         VpwhUErr0IIXtuOyfLAJvhkyLkJGvvPVMm6yRSH/RtCPQnAFIrj9KScMWnH2Stkk5W
         Rj4PZYLvujSxA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220714203822.186448-1-marijn.suijten@somainline.org>
References: <20220714203822.186448-1-marijn.suijten@somainline.org>
Subject: Re: [PATCH] clk: qcom: gcc-sdm660: Use floor ops for SDCC1 clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Craig Tatlor <ctatlor97@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Date:   Wed, 27 Jul 2022 17:31:53 -0700
User-Agent: alot/0.10
Message-Id: <20220728003155.22D28C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marijn Suijten (2022-07-14 13:38:22)
> In commit 3f905469c8ce ("clk: qcom: gcc: Use floor ops for SDCC clocks")
> floor ops were applied to SDCC2 only, but flooring is also required on
> the SDCC1 apps clock which is used by the eMMC card on Sony's Nile
> platform, and otherwise result in the typicial "Card appears
> overclocked" warnings observed on many other platforms before:
>=20
>     mmc0: Card appears overclocked; req 52000000 Hz, actual 100000000 Hz
>     mmc0: Card appears overclocked; req 52000000 Hz, actual 100000000 Hz
>     mmc0: Card appears overclocked; req 104000000 Hz, actual 192000000 Hz
>=20
> Fixes: f2a76a2955c0 ("clk: qcom: Add Global Clock controller (GCC) driver=
 for SDM660")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
