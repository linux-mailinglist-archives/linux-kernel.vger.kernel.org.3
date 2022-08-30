Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C88E5A5C5D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiH3HCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiH3HCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:02:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E36BA0338;
        Tue, 30 Aug 2022 00:02:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D2396147D;
        Tue, 30 Aug 2022 07:02:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA2FC433D6;
        Tue, 30 Aug 2022 07:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661842953;
        bh=tTxDJDfW3hJQxcrGdJkuUNTzSsR/3oVSy5Af/ZZpu1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dvydNahPkTxF3/W72hmkkKWGPERKTb0RcDb0I7AWFwfKTBkRDU1uUX3AqE2Lut7+l
         5zN4p3mCa+6aLd1R/dWBNbMLLYw4k/QNQbDhrvjpcuxis4CHKuisBDKRD+C02WstHc
         iPTuU/6w4fASsDn+ieYpA26NE+akmmT9Gh0bfsTiNuFfmOpyOyAjM3Ut0yJHzk4kt1
         L56AsE7exm1B/xqD/5arWl1zOXJbxwPfmppwEEncen7GA20zcYVPD2ua6QWAkmfA94
         LRA1Qw8pCaKD6IfPluv+rWVBtm/OoC/Rljifz/adIH/wvDFIblOlo6Kn0jYFD/yTf0
         v+47TedxlLdKw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oSvGk-0007TX-3C; Tue, 30 Aug 2022 09:02:42 +0200
Date:   Tue, 30 Aug 2022 09:02:42 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/30] phy: qcom,qmp: fix dt-bindings and deprecate
 lane suffix
Message-ID: <Yw22EtnQldKWAWZF@hovoldconsulting.com>
References: <20220714124333.27643-1-johan+linaro@kernel.org>
 <YtVPX2WHKU61MTo5@hovoldconsulting.com>
 <Yw2alI4lV7aIsA/o@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw2alI4lV7aIsA/o@matsya>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 10:35:24AM +0530, Vinod Koul wrote:
> On 18-07-22, 14:17, Johan Hovold wrote:
> > On Thu, Jul 14, 2022 at 02:43:03PM +0200, Johan Hovold wrote:
> > > When adding support for SC8280XP to the QMP PHY driver I noticed that
> > > the PHY provider child node was not described by the current DT schema.
> > > 
> > > The SC8280XP PHYs also need a second fixed-divider PIPE clock
> > > ("pipediv2") and I didn't want to have to add a bogus "lane" suffix to
> > > the clock name just to match the current "pipe0" name so I decided to
> > > deprecate the unnecessary suffix in the current binding instead.
> > > 
> > > To be able to add the missing child-node schema and handle device
> > > specifics like additional PIPE clocks, it quickly became obvious that
> > > the binding needs to be split up.
> > > 
> > > This series clean up and fixes some issue with the current schema before
> > > splitting it up in separate schemas for PCIe, UFS and USB and adding
> > > missing parts like the child PHY provider nodes.
> > > 
> > > The MSM8996 PCIe PHY gets its own schema as this is the only non-combo
> > > PHY that actually provides more than one PHY per IP block. Note that the
> > > "lane" suffix is still unnecessary and misleading.
> > > 
> > > The final patches add support for the updated binding to the (recently
> > > split up) PHY drivers. Included is also a related combo PHY cleanup.
> > 
> > Hi Vinod,
> > 
> > any chance of getting these into 5.20?
> > 
> > Note that there'll be an -rc8 on Sunday.
> 
> Sorry phy tree goes thru char-misc and it was already sent and closed,
> so couldnt do the needful

Yeah, it was a bit of a wild shot, but I noticed you hadn't actually
sent your PR to Greg yet when I pinged you.

Johan
