Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BBF585777
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 01:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239529AbiG2Xr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 19:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiG2Xr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 19:47:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874FB82108;
        Fri, 29 Jul 2022 16:47:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 475FEB829DF;
        Fri, 29 Jul 2022 23:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01044C433D6;
        Fri, 29 Jul 2022 23:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659138444;
        bh=dT5GZ6zmZU3ANlCEsEIrqIoq0Qqt6y3p4JIxrUxZVsA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=IlX0F8ytpgbIXClGKxuq2VaXNQkDMm93SPHREUH/gNYnaKOc226TBayXwf34PjrXq
         0U/PmzCZL0eYc+FfoGf5ZYpYagp427wRnISFu83BlDxN856WxFhmMFYjY49KCQOz6j
         LQOiTn4D7GsiZDQTdQhFvx/PUl3Q93467S5HS1X+8ZBp0vkb13bEoOijpT2ZkStfva
         fEOek2/yzTjmOanW2d/NSkxXOLVstTdysTQGzBO6yS/e35LKkbFJ2fAvuM1H/PitR8
         0kNRd+ki6rkUDT67TnA63JDltV5Hyj8Sa8TtBzJ7xmNQbOo/gy6FQFRbuebyDDkGKO
         vRDtXH7DHc3aQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220629225331.357308-3-marijn.suijten@somainline.org>
References: <20220629225331.357308-1-marijn.suijten@somainline.org> <20220629225331.357308-3-marijn.suijten@somainline.org>
Subject: Re: [PATCH v3 02/11] clk: mux: Introduce devm_clk_hw_register_mux_parent_hws()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Jonathan Marek <jonathan@marek.ca>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Date:   Fri, 29 Jul 2022 16:47:22 -0700
User-Agent: alot/0.10
Message-Id: <20220729234724.01044C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marijn Suijten (2022-06-29 15:53:22)
> Add the devres variant of clk_hw_register_mux_hws() for registering a
> mux clock with clk_hw parent pointers instead of parent names.
>=20
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Applied to clk-next
