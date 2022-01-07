Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAC8487D31
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 20:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiAGTj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 14:39:58 -0500
Received: from sibelius.xs4all.nl ([83.163.83.176]:59446 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiAGTj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 14:39:57 -0500
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id ac96d287;
        Fri, 7 Jan 2022 20:39:53 +0100 (CET)
Date:   Fri, 7 Jan 2022 20:39:53 +0100 (CET)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     jszhang@kernel.org, shawnguo@kernel.org, leoyang.li@nxp.com,
        robh+dt@kernel.org, linux@armlinux.org.uk, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, hayashi.kunihiko@socionext.com,
        mhiramat@kernel.org, nobuhiro1.iwamatsu@toshiba.co.jp,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org
In-Reply-To: <99115cc4-32f6-d217-68be-33256a6993a8@canonical.com> (message
        from Krzysztof Kozlowski on Fri, 7 Jan 2022 13:47:03 +0100)
Subject: Re: [PATCH 0/7] arm/arm64: dts: Remove unused num-viewport from pcie
 node
References: <20211229160245.1338-1-jszhang@kernel.org>
 <d3cb7b8439ee3d06@bloch.sibelius.xs4all.nl> <99115cc4-32f6-d217-68be-33256a6993a8@canonical.com>
Message-ID: <d3cb933f371ab5b5@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Fri, 7 Jan 2022 13:47:03 +0100
> From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> On 29/12/2021 17:50, Mark Kettenis wrote:
> >> From: Jisheng Zhang <jszhang@kernel.org>
> >> Date: Thu, 30 Dec 2021 00:02:38 +0800
> >>
> >> After commit 281f1f99cf3a("PCI: dwc: Detect number of iATU windows"),
> >> the number of iATU windows is detected at runtime, what's more,
> >> the 'num-viewport' property parsing has been removed, so remove the
> >> unused num-viewport from pcie node(s).
> >>
> >> It's too late for linux-5.17-rc1, I will rebase and send out v2 if
> >> necessary when 5.17-rc1 is released.
> > 
> > Please no.  This only makes the device trees unnecessarily
> > incompatible with older kernels
> 
> Anyone who is running a new DTB with older kernel is doomed anyway, not
> only because of this change but hundreds of other similar cleanups, e.g.
> making DTS conforming to dtschema. Are you sure there are such use cases
> of using new DTB with old kernel? I cannot imagine making a stable
> product with such scenario...

Well, many of those changes just affect the node names, which aren't
part of the ABI.  And adding missing properties or compatibles doesn't
break things either.  But yes, we keep seeing diffs to "cleanup"
bindings and device trees, especially in the context of converting
them to dtschema.  And that's just wrong.  If old device trees don't
pass validation, the default assumption should be that the schema is
wrong; not the other way around.

> > and other OSes that do rely on the
> > "num-viewport" property.
> 
> Right. We should have move the DTS out of the kernel when it was still
> small. :)

I don't think the number/size of DTs really matters.  But yes, moving
them to a separate repository would certainly make it more obvious
that they should not be tied to a particular kernel version and that
they are shared with other projects such as U-Boot and other OSes.

> > It really doesn't hurt to keep this property
> > even if future Linux kernels no longer look at it.
> 
> For Exynos PCIe, the property is still required by bindings, so
> definitely it cannot be removed from DTS. I did not check the other
> bindings.
> 
> Best regards,
> Krzysztof

Cheers,

Mark
