Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553C4512AD9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242921AbiD1FW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235900AbiD1FW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:22:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDB533E9F;
        Wed, 27 Apr 2022 22:19:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4406361C9A;
        Thu, 28 Apr 2022 05:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D6AC385A9;
        Thu, 28 Apr 2022 05:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651123151;
        bh=UQfVi3ZGeNriIKk381DlRNwfzv/ILBbw7Z6AKGd13XA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eIgMY3GZMKEglFJtWh76V0pJAjxc/sYlKuLCeJWSGsiN+hlLSloUN9DuzeNgCB+VG
         WJWuMLRBBjP02ElF6KcXYMzZ/R5Ux069rbX4GX5VlEWjaF6Z8mCHcIfUPVCcB08IZ2
         sSaHwJ66iP7fCjaSdNvx0TteTLnVX3V1aeLjKqSau3J8ITgz/dzRxkDc9+HGfFfADg
         eH8MUuY4ZPcAhslrftwE4hUg+oLcaK6EHTsxXaQVKH4ZmvyT8uK+enh0KWO/rr4hSn
         eLj9YdCkylWSfAG09O7p4RuvT0cDOhOqR5OKDo4iBnXZw6B+ax+95DUu+LV/PV+Lzq
         DbVFB0orSgIAw==
Message-ID: <01ec9962-e210-ce47-57cd-8849cca0a9df@kernel.org>
Date:   Thu, 28 Apr 2022 07:19:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 5/5] usb: host: add xhci-exynos driver
Content-Language: en-US
To:     Jung Daehwan <dh10.jung@samsung.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220426092023epcas2p32946c087135ca4b7e63b03915060c55d@epcas2p3.samsung.com>
 <1650964728-175347-6-git-send-email-dh10.jung@samsung.com>
 <a9438aef-78a3-e8ab-2b78-cc872447df08@kernel.org>
 <20220428012941.GF145620@ubuntu>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220428012941.GF145620@ubuntu>
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

On 28/04/2022 03:29, Jung Daehwan wrote:
> On Tue, Apr 26, 2022 at 02:59:57PM +0200, Krzysztof Kozlowski wrote:
>> On 26/04/2022 11:18, Daehwan Jung wrote:
>>> This driver is for Samsung Exynos xhci host conroller. It uses xhci-plat
>>> driver mainly and extends some functions by xhci hooks and overrides.
>>>
>>> It supports USB Audio offload with Co-processor. It only cares DCBAA,
>>> Device Context, Transfer Ring, Event Ring, and ERST. They are allocated
>>> on specific address with xhci hooks. Co-processor could use them directly
>>> without xhci driver after then.
>>
>> This does not look like developed in current Linux kernel, but something
>> out-of-tree, with some other unknown modifications. This is not how the
>> code should be developed. Please rebase on linux-next and drop any
>> unrelated modifications (these which are not sent with this patchset).
>>
> 
> I've been developing on linux-next and I rebase before submitting.
> Could you tell me one of dropped modifications or patches?
> 
>> (...)
>>
>>> +
>>> +static int xhci_exynos_suspend(struct device *dev)
>>> +{
>>> +	struct usb_hcd	*hcd = dev_get_drvdata(dev);
>>> +	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
>>> +
>>> +	/* TODO: AP sleep scenario*/
>>
>> Shall the patchset be called RFC?
>>
> OK. I will add RFC for this patch on next submission.
> 
>>> +
>>> +	return xhci_suspend(xhci, device_may_wakeup(dev));
>>> +}
>>> +
>>> +static int xhci_exynos_resume(struct device *dev)
>>> +{
>>> +	struct usb_hcd	*hcd = dev_get_drvdata(dev);
>>> +	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
>>> +	int ret;
>>> +
>>> +	/* TODO: AP resume scenario*/
>>> +
>>> +	ret = xhci_resume(xhci, 0);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	pm_runtime_disable(dev);
>>> +	pm_runtime_set_active(dev);
>>> +	pm_runtime_enable(dev);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct dev_pm_ops xhci_exynos_pm_ops = {
>>> +	SET_SYSTEM_SLEEP_PM_OPS(xhci_exynos_suspend, xhci_exynos_resume)
>>> +};
>>> +
>>> +MODULE_DESCRIPTION("xHCI Exynos Host Controller Driver");
>>> +MODULE_LICENSE("GPL");
>>
>> You don't have list of compatibles (and missing bindings), driver
>> definition, driver registration. Entire solution is not used - nothing
>> calls xhci_exynos_vendor_init(), because nothign uses "ops".
>>
> 
> xhci_exynos_vendor_init is called in xhci-plat.c (xhci_vendor_init)
> [v4,2/5] usb: host: add xhci hooks for xhci-exynos
> ops are used in some files(xhci-mem.c, xhci.c ..) and the body of ops is in
> all xhci-exynos.


Nothing uses the "ops" except xhci_exynos_register_vendor_ops() which is
not called anywhere, so the xhci_vendor_init() does not call
xhci_exynos_vendor_init().

> 
> xhci-exynos is not a standalone driver. It could be enabled when other module
> makes xhci platform driver probed as it uses xhci platform mainly.

It "could be" or "will be"? We do not talk here about theoretical usage
of the driver, but a real one.

> I thought I just used existing compltible not adding new one.
> I will add them if needed.

Since you called everything here as "exynos" it is specific to one
hardware and not-reusable on anything else. How can then you use some
other compatible? It would be a misuse of Devicetree bindings.

Unless this is not specific to "exynos", but then please remove any
exynos and vendor references and make it integrated in generic XHCI
working for all drivers.


>> This does not work and it makes it impossible to test it. Please provide
>> proper XHCI Exynos driver, assuming you need it and it is not part of
>> regular Exynos XHCI drivers (DWC3 and so on).
>>
> 
> What makes you think it doesn't work?

Not possible to probe. The code cannot be loaded.

> I think it's almost proper. I just removed
> other IPs code like Co-Processor(we call it abox) or Power Management because
> it would make build-error. I've added hooking points in some files(xhci-mem.c,
> xhci.c..) and ops are implemented in xhci-exynos. It's mainly operated with
> xhci platform driver.

Best regards,
Krzysztof
