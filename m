Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358C25A45CB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiH2JNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiH2JNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:13:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8414C5A888;
        Mon, 29 Aug 2022 02:13:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E383B80DD6;
        Mon, 29 Aug 2022 09:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DEDC433C1;
        Mon, 29 Aug 2022 09:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661764426;
        bh=Eqbqp+MrH60JQwN+zE589Hnlma9libigltFy4on3El8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZsemnGJ9vgJqoT2bXEnn7gKqm+G/qNS27JVcXueQYJSEPv7fUFidjcC2FRhN5h7TJ
         RSSpxmcAG7/5JoNkxiXSiuxf1494QiAnkhmUmW9KsQnHe15OoHksZa+xgyMGOMpuam
         p9F2HBGfpB/snsgBD9t3O8oUcCmWDRiJD0fxIeQbXeDBz1ESPSL+5I16F2GMgDpKOd
         pwilZRp13Nda41H6m+Pk2PUaDPrrci3oMr+yuyvMCE9FhnlxRc7l4P6SCCZzYbhpBV
         FSrxPA5IE9nyhckMB36QjrFh2pEOfIgSzEgHGUUuPF5qJVC/9FW48yEickqIYx0CAN
         9UH4OD3EB1S2Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oSaqA-0002TH-3N; Mon, 29 Aug 2022 11:13:54 +0200
Date:   Mon, 29 Aug 2022 11:13:54 +0200
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
Message-ID: <YwyDUm+dS7OLTo2h@hovoldconsulting.com>
References: <20220714124333.27643-1-johan+linaro@kernel.org>
 <YtVPX2WHKU61MTo5@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtVPX2WHKU61MTo5@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod, 

On Mon, Jul 18, 2022 at 02:17:36PM +0200, Johan Hovold wrote:
> On Thu, Jul 14, 2022 at 02:43:03PM +0200, Johan Hovold wrote:
> > When adding support for SC8280XP to the QMP PHY driver I noticed that
> > the PHY provider child node was not described by the current DT schema.
> > 
> > The SC8280XP PHYs also need a second fixed-divider PIPE clock
> > ("pipediv2") and I didn't want to have to add a bogus "lane" suffix to
> > the clock name just to match the current "pipe0" name so I decided to
> > deprecate the unnecessary suffix in the current binding instead.
> > 
> > To be able to add the missing child-node schema and handle device
> > specifics like additional PIPE clocks, it quickly became obvious that
> > the binding needs to be split up.
> > 
> > This series clean up and fixes some issue with the current schema before
> > splitting it up in separate schemas for PCIe, UFS and USB and adding
> > missing parts like the child PHY provider nodes.
> > 
> > The MSM8996 PCIe PHY gets its own schema as this is the only non-combo
> > PHY that actually provides more than one PHY per IP block. Note that the
> > "lane" suffix is still unnecessary and misleading.
> > 
> > The final patches add support for the updated binding to the (recently
> > split up) PHY drivers. Included is also a related combo PHY cleanup.
> 
> Hi Vinod,
> 
> any chance of getting these into 5.20?
> 
> Note that there'll be an -rc8 on Sunday.

Have you had a chance to look at this series yet?

Johan
