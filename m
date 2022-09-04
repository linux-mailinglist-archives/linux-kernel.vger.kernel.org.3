Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298A55AC4E9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 17:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbiIDPR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 11:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiIDPRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 11:17:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D7533427;
        Sun,  4 Sep 2022 08:17:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5502AB80D70;
        Sun,  4 Sep 2022 15:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21440C433D6;
        Sun,  4 Sep 2022 15:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662304640;
        bh=xjdPYgdB9h50iN/sMAXgx3TlezzJ2hEsjMGUNuESwQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bSZ4dTKtfMNrRfeMjIh0uwpaywenCjzYh7YAtyAapy/xSEsV2B/DjrmrWFNfaoIxZ
         fRLCTgyJhn0nU3HHUKigGDtRWjfxtQfKkiBmg4Vx2ur7rtVDKDpxBAFTMbsJ57ckn0
         K0zPIG3VCYowbB3wCwadpgFSVG+fLaqif+4d2OmQPZm2pSQaSdYPsgr87J2XIsGgY0
         Q8qcamBf9Wd2s0h/3AwC0MKS3OFLay2XyAnJTm6sIJSaZt0qTzAqjKri9VZ/yLm+ub
         J82ButxZ6R+CFLc8PS+QSfsRwyKehuqD4AoIBiq7IuTkw4KDCipnGxROIAEzUS+mAu
         DzYxz/mLbtQ3A==
Date:   Sun, 4 Sep 2022 20:47:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com
Subject: Re: [PATCH v11 2/3] phy: qcom-snps: Add support for overriding phy
 tuning parameters
Message-ID: <YxTBewhBecSgXvPq@matsya>
References: <1658384954-9506-1-git-send-email-quic_kriskura@quicinc.com>
 <1658384954-9506-3-git-send-email-quic_kriskura@quicinc.com>
 <20220830203518.pty67fyefho4ewgw@builder.lan>
 <31d459e4-57c0-85d1-2d88-e5bf0bed6604@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31d459e4-57c0-85d1-2d88-e5bf0bed6604@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-08-22, 18:41, Krishna Kurapati PSSNV wrote:
 
> > The ordering of this list needs to match the order of
> > override_param_map[] and there's nothing indicating this in the code.
> > 
> > I was considering suggesting that you add a enum/define and do
> > 	[SQUELCH_DETECTOR_BP] = "qcom,squelch-detector-bp",
> > 	...
> > and then do the same in the override_param_map array.
> > >
> > But I think it will be cleaner if you add a const char const pointer to
> > override_param_map and just specify these strings in the
> > override_param_map array.
> > 
> > Each entry will grow by a pointer, but multiple copies of the same
> > strings (when added in the future) should be combined by the compiler.
> > 
> IIUC, you want me to remove this array of const char*'s and embed them in
> the override_param_map and iterate through it without using this const
> phy_seq_props as a reference.

I think that would make it simpler.. 

> > > +static const struct override_param_map sc7280[] = {
> > 
> > There's nothing ensuring that the loop below doesn't run off the end of
> > this array. So when the next platform is added, there's no way to
> > handle the fact that they might have a different set of properties.
> > 
> > If you add the property name to these elements, that will no longer be a
> > problem (and you can add a {} entry at the end of the list and check for
> > this when looping over the elements.

Would be great if this is addressed as well

-- 
~Vinod
