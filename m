Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AF7585771
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 01:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239352AbiG2XrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 19:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiG2XrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 19:47:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D1682106;
        Fri, 29 Jul 2022 16:47:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E47461957;
        Fri, 29 Jul 2022 23:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4260C433C1;
        Fri, 29 Jul 2022 23:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659138432;
        bh=iXobB2v9U1JQBSFHCNTZcXFdVal0vAJP87SyEQP4Ecs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Qn2EZMoCBv+z+JCCiSG7AFWXXo6VULLglIhBmCyykVc1h9qAsWhfVtcgoaR2DJbbg
         PPo7KiPkCqMKtArMeUfJY68WJ1Gi7oc/cwcfoF9qHREKRrb84vjPvh/P59aF2T2mxJ
         rPuNjH9w+UBuxL/9hDdAHdhMUCpaT7LPL8cpLtaKRJXwgLXgHlMZTd+W5TKCfH58HS
         GG1MLfkdyYGfXOGzwMI5fdPsHwfLyi53XcGQR+Qa3h1JeC1VDDx0p35xADhnqQfy5Y
         yBKcXvffpLJX1lr6QhuWl+hN+/WNUfMgJT0jwEyvgblLer10UrocT/JMfZxLvkfLIz
         XVMhlYa37DfZw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220629225331.357308-2-marijn.suijten@somainline.org>
References: <20220629225331.357308-1-marijn.suijten@somainline.org> <20220629225331.357308-2-marijn.suijten@somainline.org>
Subject: Re: [PATCH v3 01/11] clk: divider: Introduce devm_clk_hw_register_divider_parent_hw()
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
Date:   Fri, 29 Jul 2022 16:47:10 -0700
User-Agent: alot/0.10
Message-Id: <20220729234711.E4260C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marijn Suijten (2022-06-29 15:53:21)
> Add the devres variant of clk_hw_register_divider_parent_hw() for
> registering a divider clock with clk_hw parent pointer instead of parent
> name.
>=20
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Applied to clk-next
