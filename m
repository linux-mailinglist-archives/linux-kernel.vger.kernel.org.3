Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F8B59CE5D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239265AbiHWCPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239318AbiHWCPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:15:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0235141E;
        Mon, 22 Aug 2022 19:15:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 290C6611CD;
        Tue, 23 Aug 2022 02:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7291FC433D6;
        Tue, 23 Aug 2022 02:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661220928;
        bh=ekv+kHPsa3ERTf8s5MZWSsBHuJoLYwnb90GldnXMkhc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hfsujWiKgzi2VkTHvLEzunBRU0fJ4MIkH5ID2nRFONl4ug0OVvgib5Regsb7ma5Yg
         3miuwu/CVkN0pXPDoA2k5OkBLdoUNBwGiwAtXTjnxHAgGLcR/pnqTdkMRP+xwvKkFj
         9R9rr2710BmTUbiZkiFsTSnbMfKGVLSaS8LY7t8UUXqOS1P9vz4QZnfslik69UyCbs
         iUGNOj+vSCUlaNYAlOh+t3+U1f31J3h4s2KHLbv98BjK7u66WPfjjqnBPlBHnfp5nv
         MA586WEuIjm0T4dYruh2c9yvL5wxhmJlzSylKT4sXpHvVUiJpeDDIdYcT8gKy6Xs3l
         6WyvGyaXgXZBg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220805121250.10347-1-johan+linaro@kernel.org>
References: <20220805121250.10347-1-johan+linaro@kernel.org>
Subject: Re: [PATCH 0/2] clk: gcc-sc8280xp: fix broken suspend
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Date:   Mon, 22 Aug 2022 19:15:25 -0700
User-Agent: alot/0.10
Message-Id: <20220823021528.7291FC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Johan Hovold (2022-08-05 05:12:48)
> The Qualcomm PCIe driver currently does not implement suspend at all so
> we need to mark the GDSCs as always-on to prevent genpd from disabling
> them.
>=20
> Similarly, the Qualcomm dwc3 USB suspend implementation is also
> incomplete and the controller doesn't currently survive a suspend cycle
> unless the GDSC is kept on. Note that this has nothing to with whether
> wakeup is enabled or not (cf. [1]).
>=20
> With these two workarounds, we have somewhat functional suspend on the
> SC8280XP reference design and Lenovo Thinkpad X13s until the missing
> driver support is in place (even USB remote wakeup works with [2]
> applied).

Are these urgently needed for this release or does suspend not really
work yet on sc8280xp? I'm trying to understand if we need to apply
these to the fixes tree (in which case why isn't there a Fixes tag
targetting whatever commit broke suspend) or if they can wait for the
next release and come through clk-next.
