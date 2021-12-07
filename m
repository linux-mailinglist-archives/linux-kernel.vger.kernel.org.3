Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407B246B63B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbhLGInG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:43:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53650 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhLGInF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:43:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8745AB80E45;
        Tue,  7 Dec 2021 08:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA58C341C3;
        Tue,  7 Dec 2021 08:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638866373;
        bh=Y6skVCngCbI28tETkZn7Q+Cj+mWVtnxR54oJS9ORRtw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G7wh6klcUOGI124zSciDGLZnl/jFRh+vJkbgsmhrQJQjIBDiCg+p+lnVVCmdikTjt
         hlrOlZFE6Z1zCu2pnuOoTOh2Ohjhol5O4Jx7sAnsN0weqJyYQYKckvy8zHMpnhjKbt
         ljKdfLiWUtTZShxxk3p06CBZE8obhBAjhQOTph2Uo4BR9nryPZxzAbw80wC0jESa3l
         nPruA/i3jo8OzeAiqy+hFhVuvF9K13WjIZqtCbcHPy5HqCYIEyKQk6aWiJ7B1GFFwR
         SPltmVJycfpOzkfIqlxNH6Xm2AtHJ8r5txunauQ+ZDRGGN2GzOsbTMoBLYQO9neVzV
         kaqNcYmXIq6Dw==
Date:   Tue, 7 Dec 2021 09:39:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     Rob Herring <robh+dt@kernel.org>, <linuxarm@huawei.com>,
        <mauro.chehab@huawei.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] arm64: dts: HiSilicon: Add support for HiKey 970
 PCIe controller hardware
Message-ID: <20211207093926.24f26dae@coco.lan>
In-Reply-To: <61AF16AC.1080506@hisilicon.com>
References: <cover.1637063775.git.mchehab+huawei@kernel.org>
        <884b83c1aed70735883e15f032f9668ebfd77a01.1637063775.git.mchehab+huawei@kernel.org>
        <61AF16AC.1080506@hisilicon.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 7 Dec 2021 16:09:16 +0800
Wei Xu <xuwei5@hisilicon.com> escreveu:

> Hi Mauro,
> 
> On 2021/11/16 19:59, Mauro Carvalho Chehab wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > Add DTS bindings for the HiKey 970 board's PCIe hardware.
> > 
> > Co-developed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> > 
> > To mailbombing on a large number of people, only mailing lists were C/C on the cover.
> > See [PATCH 0/5] at: https://lore.kernel.org/all/cover.1637063775.git.mchehab+huawei@kernel.org/
> > 
> >  arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 107 ++++++++++++++++++++++
> >  1 file changed, 107 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> > index 636c8817df7e..225dccbcb064 100644
> > --- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> > +++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> > @@ -176,6 +176,12 @@ sctrl: sctrl@fff0a000 {
> >  			#clock-cells = <1>;
> >  		};
> >  
> > +		pmctrl: pmctrl@fff31000 {
> > +			compatible = "hisilicon,hi3670-pmctrl", "syscon";  
> 
> The "hi3670-pmctrl" is not documented in the devicetree binding documents yet.
> Could we remove this part this time?

Without that, the PCI PHY won't work.

IMO, the best would be to just add this compatible to hi3670-clock,
where it belongs.

Just sent a patch.

Regards,
Mauro
