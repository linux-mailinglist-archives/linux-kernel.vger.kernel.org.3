Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A284BAE36
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiBRAQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:16:47 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiBRAQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:16:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B55396AB;
        Thu, 17 Feb 2022 16:16:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FA10B82437;
        Fri, 18 Feb 2022 00:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF4DC340E8;
        Fri, 18 Feb 2022 00:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645143388;
        bh=2kWXeoctbsWvcDjrtxkz9u4o+5N4Ldwg/Eo/KgfyIVI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ahd67xoyk8mcqBq4gtOKS9qtV+aD+a0RWx0ypDbSL6SSmaWbcEW0/2lluwUOGmZOK
         5fDO1DbyO1C+1cFE4Mjitc+OtLshdpQTNQNlwBw5aq5rl21DGiule/a0kBcCBi8MZg
         amniiC/Q5iCJg4t+09/y1yGaffCR+B3GrHjYaaVKRnO/l6so4/SB5Ej+7bP1+frWQk
         y6eK+nLVDNf/BNIhVEiLjhXLoRrwt70g2nTEUuYO2wVCFyaxbGmnhchvonmUlNdkx1
         KIKYjyXlp7h8umDI1YVnhKcFaoCqduhsU/UcvQD2ySTr58KMo3A5I/8AMmaNMKKpC4
         N0Qkzp+L0V4IA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220217232408.78932-1-konrad.dybcio@somainline.org>
References: <20220217232408.78932-1-konrad.dybcio@somainline.org>
Subject: Re: [PATCH v2] clk: qcom: gcc-msm8994: Remove NoC clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Date:   Thu, 17 Feb 2022 16:16:26 -0800
User-Agent: alot/0.10
Message-Id: <20220218001628.3FF4DC340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konrad Dybcio (2022-02-17 15:24:08)
> Just like in commit 05cf3ec00d460b50088d421fb878a0f83f57e262
> ("clk: qcom: gcc-msm8996: Drop (again) gcc_aggre1_pnoc_ahb_clk")
> adding NoC clocks turned out to be a huge mistake, as they cause a lot of
> issues at little benefit (basically letting Linux know about their
> children's frequencies), especially when mishandled or misconfigured.
>=20
> Adding these ones broke SDCC approx 99 out of 100 times, but that somehow
> went unnoticed. To prevent further issues like this one, remove them.
>=20
> This commit is effectively a revert of 74a33fac3aab77558ca0d80c9935
> (clk: qcom: gcc-msm8994: Add missing NoC clocks) with ABI preservation.
>=20
> Fixes: 74a33fac3aab ("clk: qcom: gcc-msm8994: Add missing NoC clocks")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Is boot broken on msm8994? I can take this for clk-fixes then.
