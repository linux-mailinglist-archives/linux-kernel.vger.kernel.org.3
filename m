Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6739C50FE2B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350627AbiDZND5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350641AbiDZNDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:03:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E26178F6B;
        Tue, 26 Apr 2022 06:00:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED309B81F49;
        Tue, 26 Apr 2022 13:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611DCC385AA;
        Tue, 26 Apr 2022 12:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650978002;
        bh=STeOVJbFv0JAM+ZjVWQ3iAdUGzHt/rmNObKdTePC+ME=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dAXHGNPCaUc4r5pI9MdXUehO2ZvpZkI6GhGX5vezp8eGr2UoCEc0bCH+9AXCGqWbb
         neaOpOXtSg3rUTweJ7q/HMedbwbwBUQj4XNMVwak2CZLXXspxNlxH8jczgKSuAkUmm
         9SZaARj7Fx2kNLuI71CO4AckeK/s39uwJCEhNPV1DzM82JTTDDvHehXrZGKoFtFJNK
         UUSQIfteZfmRiiI2tkAlMd91iyL+UMviQAyG2sHqH7QjyEERD1gtIXsMVUtBEdAAZ/
         bo/3q640ojKAipfL/DtbRwNaqvXVakHJaZZd0/qu8ESpqewv63X9ZAmZ/iWbgs8Yvn
         7lh9IFW2RJBxQ==
Message-ID: <a9438aef-78a3-e8ab-2b78-cc872447df08@kernel.org>
Date:   Tue, 26 Apr 2022 14:59:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 5/5] usb: host: add xhci-exynos driver
Content-Language: en-US
To:     Daehwan Jung <dh10.jung@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220426092023epcas2p32946c087135ca4b7e63b03915060c55d@epcas2p3.samsung.com>
 <1650964728-175347-6-git-send-email-dh10.jung@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1650964728-175347-6-git-send-email-dh10.jung@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2022 11:18, Daehwan Jung wrote:
> This driver is for Samsung Exynos xhci host conroller. It uses xhci-plat
> driver mainly and extends some functions by xhci hooks and overrides.
> 
> It supports USB Audio offload with Co-processor. It only cares DCBAA,
> Device Context, Transfer Ring, Event Ring, and ERST. They are allocated
> on specific address with xhci hooks. Co-processor could use them directly
> without xhci driver after then.

This does not look like developed in current Linux kernel, but something
out-of-tree, with some other unknown modifications. This is not how the
code should be developed. Please rebase on linux-next and drop any
unrelated modifications (these which are not sent with this patchset).

(...)

> +
> +static int xhci_exynos_suspend(struct device *dev)
> +{
> +	struct usb_hcd	*hcd = dev_get_drvdata(dev);
> +	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
> +
> +	/* TODO: AP sleep scenario*/

Shall the patchset be called RFC?

> +
> +	return xhci_suspend(xhci, device_may_wakeup(dev));
> +}
> +
> +static int xhci_exynos_resume(struct device *dev)
> +{
> +	struct usb_hcd	*hcd = dev_get_drvdata(dev);
> +	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
> +	int ret;
> +
> +	/* TODO: AP resume scenario*/
> +
> +	ret = xhci_resume(xhci, 0);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops xhci_exynos_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(xhci_exynos_suspend, xhci_exynos_resume)
> +};
> +
> +MODULE_DESCRIPTION("xHCI Exynos Host Controller Driver");
> +MODULE_LICENSE("GPL");

You don't have list of compatibles (and missing bindings), driver
definition, driver registration. Entire solution is not used - nothing
calls xhci_exynos_vendor_init(), because nothign uses "ops".

This does not work and it makes it impossible to test it. Please provide
proper XHCI Exynos driver, assuming you need it and it is not part of
regular Exynos XHCI drivers (DWC3 and so on).

Best regards,
Krzysztof
