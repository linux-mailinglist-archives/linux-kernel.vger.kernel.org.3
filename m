Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFFD512BD8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244291AbiD1GtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244417AbiD1GtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:49:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B725398592;
        Wed, 27 Apr 2022 23:45:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4479E61E02;
        Thu, 28 Apr 2022 06:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C9FC385AA;
        Thu, 28 Apr 2022 06:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651128353;
        bh=8+ZKwK/7gDCAxT4CKwYWQoI/MxKpLryRN0epLfeidYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PVbBTRkgLTIM+g7YOh5yxGhjyVk2RIwCwZ06WDYXbXFvnTnTMAu/bABGWVI2qKGQY
         isVpuEc7IZ20SsO5ibyop+UXYclsqNqdSkIAM0m4qAD48FfduCG5T7UFCuncCJwa+F
         oKMi6QppVhNdIYNwqOYaqWcq4Wox0RdhGsIz4XHI=
Date:   Thu, 28 Apr 2022 08:45:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jung Daehwan <dh10.jung@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v4 5/5] usb: host: add xhci-exynos driver
Message-ID: <Ymo4Hdi9fuBT7im7@kroah.com>
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220426092023epcas2p32946c087135ca4b7e63b03915060c55d@epcas2p3.samsung.com>
 <1650964728-175347-6-git-send-email-dh10.jung@samsung.com>
 <a9438aef-78a3-e8ab-2b78-cc872447df08@kernel.org>
 <20220428012941.GF145620@ubuntu>
 <01ec9962-e210-ce47-57cd-8849cca0a9df@kernel.org>
 <20220428063634.GF151827@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428063634.GF151827@ubuntu>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 03:36:34PM +0900, Jung Daehwan wrote:
> On Thu, Apr 28, 2022 at 07:19:04AM +0200, Krzysztof Kozlowski wrote:
> > On 28/04/2022 03:29, Jung Daehwan wrote:
> > > On Tue, Apr 26, 2022 at 02:59:57PM +0200, Krzysztof Kozlowski wrote:
> > >> On 26/04/2022 11:18, Daehwan Jung wrote:
> > >>> This driver is for Samsung Exynos xhci host conroller. It uses xhci-plat
> > >>> driver mainly and extends some functions by xhci hooks and overrides.
> > >>>
> > >>> It supports USB Audio offload with Co-processor. It only cares DCBAA,
> > >>> Device Context, Transfer Ring, Event Ring, and ERST. They are allocated
> > >>> on specific address with xhci hooks. Co-processor could use them directly
> > >>> without xhci driver after then.
> > >>
> > >> This does not look like developed in current Linux kernel, but something
> > >> out-of-tree, with some other unknown modifications. This is not how the
> > >> code should be developed. Please rebase on linux-next and drop any
> > >> unrelated modifications (these which are not sent with this patchset).
> > >>
> > > 
> > > I've been developing on linux-next and I rebase before submitting.
> > > Could you tell me one of dropped modifications or patches?
> > > 
> > >> (...)
> > >>
> > >>> +
> > >>> +static int xhci_exynos_suspend(struct device *dev)
> > >>> +{
> > >>> +	struct usb_hcd	*hcd = dev_get_drvdata(dev);
> > >>> +	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
> > >>> +
> > >>> +	/* TODO: AP sleep scenario*/
> > >>
> > >> Shall the patchset be called RFC?
> > >>
> > > OK. I will add RFC for this patch on next submission.
> > > 
> > >>> +
> > >>> +	return xhci_suspend(xhci, device_may_wakeup(dev));
> > >>> +}
> > >>> +
> > >>> +static int xhci_exynos_resume(struct device *dev)
> > >>> +{
> > >>> +	struct usb_hcd	*hcd = dev_get_drvdata(dev);
> > >>> +	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
> > >>> +	int ret;
> > >>> +
> > >>> +	/* TODO: AP resume scenario*/
> > >>> +
> > >>> +	ret = xhci_resume(xhci, 0);
> > >>> +	if (ret)
> > >>> +		return ret;
> > >>> +
> > >>> +	pm_runtime_disable(dev);
> > >>> +	pm_runtime_set_active(dev);
> > >>> +	pm_runtime_enable(dev);
> > >>> +
> > >>> +	return 0;
> > >>> +}
> > >>> +
> > >>> +static const struct dev_pm_ops xhci_exynos_pm_ops = {
> > >>> +	SET_SYSTEM_SLEEP_PM_OPS(xhci_exynos_suspend, xhci_exynos_resume)
> > >>> +};
> > >>> +
> > >>> +MODULE_DESCRIPTION("xHCI Exynos Host Controller Driver");
> > >>> +MODULE_LICENSE("GPL");
> > >>
> > >> You don't have list of compatibles (and missing bindings), driver
> > >> definition, driver registration. Entire solution is not used - nothing
> > >> calls xhci_exynos_vendor_init(), because nothign uses "ops".
> > >>
> > > 
> > > xhci_exynos_vendor_init is called in xhci-plat.c (xhci_vendor_init)
> > > [v4,2/5] usb: host: add xhci hooks for xhci-exynos
> > > ops are used in some files(xhci-mem.c, xhci.c ..) and the body of ops is in
> > > all xhci-exynos.
> > 
> > 
> > Nothing uses the "ops" except xhci_exynos_register_vendor_ops() which is
> > not called anywhere, so the xhci_vendor_init() does not call
> > xhci_exynos_vendor_init().
> > 
> 
> You are right. xhci_exynos_register_vendor_ops should be called by other
> module. It's only thing not called anywhere in this patchset. I don't uses
> xhci-exynos alone in my scenario. Other module loads this on runtime.
> 
> > > 
> > > xhci-exynos is not a standalone driver. It could be enabled when other module
> > > makes xhci platform driver probed as it uses xhci platform mainly.
> > 
> > It "could be" or "will be"? We do not talk here about theoretical usage
> > of the driver, but a real one.
> > 
> > > I thought I just used existing compltible not adding new one.
> > > I will add them if needed.
> > 
> > Since you called everything here as "exynos" it is specific to one
> > hardware and not-reusable on anything else. How can then you use some
> > other compatible? It would be a misuse of Devicetree bindings.
> > 
> 
> I got it. Let me add them. Is it still necessary if it is only used by
> other module on runtime as I said above?

Please submit a full, working driver so these changes can be able to be
properly reviewed.  Otherwise it is just a waste of time for us to even
read them, right?

We do not add changes to the kernel that do not work or do anything,
that would be pointless, and cause us extra work and maintenance.

thanks,

greg k-h
