Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB43D59E602
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243281AbiHWP3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242984AbiHWP2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:28:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED683B6D4E;
        Tue, 23 Aug 2022 04:10:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA515B81CD7;
        Tue, 23 Aug 2022 11:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3EDC433D6;
        Tue, 23 Aug 2022 11:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661252974;
        bh=UpEoL/7Dt4dHrMZYSGjJSXKxqA1hFx3KNHDWHtgrliQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XTjGj4vRbWLLEGxGZ03VClIdP7C+R35uKFwlMeibUAhMbp54Ni0IRvL+5Zo1DGnWS
         mDaCSiVKu+U6Ao4kE1ILd95fJr9hQkpnqg5Y71XJLja/6SHl0BAD+d00V6uA56OGYr
         RHfZqHEMInlMJNHnxmtsILKLaiz8uDCqhGDO4O2MLJxHCBMykVEzXj8xgDf7r+XBOF
         xESw7EcE3aoNa08cQNgVmYIvg1ih5Z6wST+HbY4aICW0nDtdoOOYY8s+kUJL+bFFnE
         pyoAjiafC4n4ndQwL+AJr6MZfyrIp+rzSk6BDLThCoQW8+xncTcnN1UZlvQstj4alp
         BpZI8nQaCkhpw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oQRmn-0002G1-Rh; Tue, 23 Aug 2022 13:09:34 +0200
Date:   Tue, 23 Aug 2022 13:09:33 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] clk: gcc-sc8280xp: fix broken suspend
Message-ID: <YwS1bWufBYE6buSy@hovoldconsulting.com>
References: <20220805121250.10347-1-johan+linaro@kernel.org>
 <20220823021528.7291FC433D6@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823021528.7291FC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 07:15:25PM -0700, Stephen Boyd wrote:
> Quoting Johan Hovold (2022-08-05 05:12:48)
> > The Qualcomm PCIe driver currently does not implement suspend at all so
> > we need to mark the GDSCs as always-on to prevent genpd from disabling
> > them.
> > 
> > Similarly, the Qualcomm dwc3 USB suspend implementation is also
> > incomplete and the controller doesn't currently survive a suspend cycle
> > unless the GDSC is kept on. Note that this has nothing to with whether
> > wakeup is enabled or not (cf. [1]).
> > 
> > With these two workarounds, we have somewhat functional suspend on the
> > SC8280XP reference design and Lenovo Thinkpad X13s until the missing
> > driver support is in place (even USB remote wakeup works with [2]
> > applied).
> 
> Are these urgently needed for this release or does suspend not really
> work yet on sc8280xp? I'm trying to understand if we need to apply
> these to the fixes tree (in which case why isn't there a Fixes tag
> targetting whatever commit broke suspend) or if they can wait for the
> next release and come through clk-next.

They are urgently needed as sc8280xp does not survive a suspend cycle
without them (e.g. crashes on resume) and this is not something that
users expect when closing the lid of their laptops.

This is not a regression, but I guess I could have pointed to the commit
adding the sc8280xp clock driver and GDSC power-domain definitions:

Fixes: d65d005f9a6c ("clk: qcom: add sc8280xp GCC driver")

As several Qualcomm drivers simply ignore system PM and, for example,
leave clocks enabled during suspend, we also need to keep the
power-domains enabled.

I noticed that Bjorn applied these for 6.1, but I believe this is 6.0
material (or at the least the USB one is as PCI support for sc8280xp is
being added in 6.1).

Johan
