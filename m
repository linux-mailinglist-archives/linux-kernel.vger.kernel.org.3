Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0673C512D4D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245726AbiD1Hur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiD1Huq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:50:46 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286D99D4DA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:47:30 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220428074725epoutp04c9b7fe78f11684dacd39fe6077197711~p-9jeAqXq2883628836epoutp04g
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:47:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220428074725epoutp04c9b7fe78f11684dacd39fe6077197711~p-9jeAqXq2883628836epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651132045;
        bh=HQRC+VtJnl9YavkblQxCVXOk9smOC+ybXoGKxD9XrAk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kSRl0uKGsY90U+ZytBR145Ggp55cC0+k/C+xmtPgNX1jyDpVLN1aTThOZwlyLY61B
         lmw5m0x0NfTHbkpoZGZ1ls9pspQw2qggn7BDzvg2l1/dbqcJukh5PjlhxJlgt2pRQt
         CuJAax0lL25mssK4g1ywUpWtnT6P4+j8uZ5DHHbI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220428074724epcas2p16cc535cbc4d8b2a8867ee5ea4c401516~p-9i6Z6aS0610406104epcas2p1T;
        Thu, 28 Apr 2022 07:47:24 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.92]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KpnlB0wylz4x9QZ; Thu, 28 Apr
        2022 07:47:18 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.BA.09764.3864A626; Thu, 28 Apr 2022 16:47:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220428074715epcas2p12f9d8b4f9148ac6e3cba02facc2f8341~p-9aZ9ZmN2308523085epcas2p1e;
        Thu, 28 Apr 2022 07:47:15 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220428074715epsmtrp109c7a3a19e3d81291ff5bd880ce26a5a~p-9aY9Z0G1142111421epsmtrp19;
        Thu, 28 Apr 2022 07:47:15 +0000 (GMT)
X-AuditID: b6c32a46-f8bff70000002624-ad-626a46833528
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        88.2F.08924.3864A626; Thu, 28 Apr 2022 16:47:15 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220428074715epsmtip2e31cfc8428817a05f987aade42f66804~p-9aMt3nn0923509235epsmtip2S;
        Thu, 28 Apr 2022 07:47:15 +0000 (GMT)
Date:   Thu, 28 Apr 2022 16:45:45 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <20220428074545.GG151827@ubuntu>
MIME-Version: 1.0
In-Reply-To: <Ymo4Hdi9fuBT7im7@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmqW6zW1aSwb75VhZPjixit2hevJ7N
        4vqf94wW7c8vsFmcP7+B3WLj2x9MFpd3zWGzWLSsldmiedMUVouZa5Utuu7eYHTg9pjV0Mvm
        cbmvl8ljwaZSj8V7XjJ5bFrVyeaxf+4ado++LasYPT5vkgvgiMq2yUhNTEktUkjNS85PycxL
        t1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAG6U0mhLDGnFCgUkFhcrKRvZ1OUX1qS
        qpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQnbH81Wzmgq/aFee7HrM2ME5T
        6mLk5JAQMJFYeWMrG4gtJLCDUWLyntwuRi4g+xOjxNY111ghnM+MEi9WTGaE6Zi2Yw0zRGIX
        o8TJy3MYIZwnjBK7Hz9hAaliEVCVWD95FjuIzSagJXHvxwlmEFtEwFii/yxInIuDWWASs8Sm
        u9uYQBLCArYSv7buBFvBK6AjsW3pQ1YIW1Di5EyIoZwCmhItzxuAbA4OUQEViVcH60HmSAis
        5ZC4s/UTK8R5LhKNt6dD2cISr45vYYewpSRe9rdB2cUSuz61MkE0NzBKND6AuE4C6LpZz9rB
        jmAWyJBYfOgsO8gyCQFliSO3WCDCfBIdh/9ChXklOtqEIDqVJaZfngC1VlLi4OtzUBM9JL49
        3cgGCaBFzBJH539jnsAoPwvJa7OQbIOwdSQW7P7ENgtoBbOAtMTyfxwQpqbE+l36CxhZVzGK
        pRYU56anFhsVGMFjOzk/dxMjOA1rue1gnPL2g94hRiYOxkOMEhzMSiK8X3ZnJAnxpiRWVqUW
        5ccXleakFh9iNAVG1ERmKdHkfGAmyCuJNzSxNDAxMzM0NzI1MFcS5/VK2ZAoJJCeWJKanZpa
        kFoE08fEwSnVwCT6njHjn2H8WRfRHa3CE1I9rK1Tv3AxFLYryBxy4VglKB2/2CvulHsN86PD
        j54YhJnpTkjVvvvwbUHBXHf/KYWsh9tuOkxddeXSxqVb5Bsr5gWdrTONsqrbt/hR0T4JgQft
        zZ2bPQJTP7xrbOIsM/j3q3rl7NsOQclrWks2HZzzrui/8MdZwdov9/LO3nmvY2pMysTTvvtF
        +y+/ipjwviG8/MFD641RIe/m/+C6GlIhP/f35S+HYxqmzNRaFPBofn/a8ubE/d8/bjv+8rVU
        Q+dG3oiortAfE5cvUjnhk3Bd4665iMyi3TfbmB09fdnKv7tsOWDv9Om33uIw30crJifcSJu+
        f0pK49K/U3XDnsYosRRnJBpqMRcVJwIAwbrHPEwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSvG6zW1aSwbe5MhZPjixit2hevJ7N
        4vqf94wW7c8vsFmcP7+B3WLj2x9MFpd3zWGzWLSsldmiedMUVouZa5Utuu7eYHTg9pjV0Mvm
        cbmvl8ljwaZSj8V7XjJ5bFrVyeaxf+4ado++LasYPT5vkgvgiOKySUnNySxLLdK3S+DK6Jx9
        jr1gq2bFlVX3mRsY38t3MXJySAiYSEzbsYa5i5GLQ0hgB6PEw12LWCASkhJL595gh7CFJe63
        HGGFKHrEKHH80mpmkASLgKrE+smzwIrYBLQk7v04ARYXETCW6D8LEufiYBaYxizR8nsCI0hC
        WMBW4tfWnWA2r4COxLalD1lBbCGBJcwSB19KQMQFJU7OfAJ2BTPQ0Bv/XjJ1MXIA2dISy/9x
        gIQ5BTQlWp43sICERQVUJF4drJ/AKDgLSfMsJM2zEJoXMDKvYpRMLSjOTc8tNiwwykst1ytO
        zC0uzUvXS87P3cQIjiItrR2Me1Z90DvEyMTBeIhRgoNZSYT3y+6MJCHelMTKqtSi/Pii0pzU
        4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqYbE5H37mmK/OEUzXPrr6x/9BvOwlN
        OaUtmnrnVrgkrNy1pC47R1rtwuEwnhadwsib9/s2hiZ8e7XRT3YNP7eN0S7+hu+zn1WeXem5
        8c6pi5vtar5+ncz0zNsr+kj2MvMODzWXuw0FNyO0pe205X43Tvbw+fLBv+I4B0NzxOEvzmVd
        i2L/dXrMe/myLbF01zG3o95LFyf12kVb101//qK9/LFVvKv8vT2ObnFVJ/itNhufmWrMLBKo
        rO8bF+Kx1O31+YIHQepLpmXHn/ip9ktF5tS/o15/J8vu9LRLtWL692p6d8mZ58siXs6RuSv0
        d7/PTuZLPwRFz2sZNUcvDFj63eBMG9OrWcud1qwUy1ZXYinOSDTUYi4qTgQAj7W1EhEDAAA=
X-CMS-MailID: 20220428074715epcas2p12f9d8b4f9148ac6e3cba02facc2f8341
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----s9reHD3dvq.Swzu4OgS99nNlXP7CLa0djtt04wdzZepsPVyA=_31dee_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426092023epcas2p32946c087135ca4b7e63b03915060c55d
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220426092023epcas2p32946c087135ca4b7e63b03915060c55d@epcas2p3.samsung.com>
        <1650964728-175347-6-git-send-email-dh10.jung@samsung.com>
        <a9438aef-78a3-e8ab-2b78-cc872447df08@kernel.org>
        <20220428012941.GF145620@ubuntu>
        <01ec9962-e210-ce47-57cd-8849cca0a9df@kernel.org>
        <20220428063634.GF151827@ubuntu> <Ymo4Hdi9fuBT7im7@kroah.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------s9reHD3dvq.Swzu4OgS99nNlXP7CLa0djtt04wdzZepsPVyA=_31dee_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Apr 28, 2022 at 08:45:49AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Apr 28, 2022 at 03:36:34PM +0900, Jung Daehwan wrote:
> > On Thu, Apr 28, 2022 at 07:19:04AM +0200, Krzysztof Kozlowski wrote:
> > > On 28/04/2022 03:29, Jung Daehwan wrote:
> > > > On Tue, Apr 26, 2022 at 02:59:57PM +0200, Krzysztof Kozlowski wrote:
> > > >> On 26/04/2022 11:18, Daehwan Jung wrote:
> > > >>> This driver is for Samsung Exynos xhci host conroller. It uses xhci-plat
> > > >>> driver mainly and extends some functions by xhci hooks and overrides.
> > > >>>
> > > >>> It supports USB Audio offload with Co-processor. It only cares DCBAA,
> > > >>> Device Context, Transfer Ring, Event Ring, and ERST. They are allocated
> > > >>> on specific address with xhci hooks. Co-processor could use them directly
> > > >>> without xhci driver after then.
> > > >>
> > > >> This does not look like developed in current Linux kernel, but something
> > > >> out-of-tree, with some other unknown modifications. This is not how the
> > > >> code should be developed. Please rebase on linux-next and drop any
> > > >> unrelated modifications (these which are not sent with this patchset).
> > > >>
> > > > 
> > > > I've been developing on linux-next and I rebase before submitting.
> > > > Could you tell me one of dropped modifications or patches?
> > > > 
> > > >> (...)
> > > >>
> > > >>> +
> > > >>> +static int xhci_exynos_suspend(struct device *dev)
> > > >>> +{
> > > >>> +	struct usb_hcd	*hcd = dev_get_drvdata(dev);
> > > >>> +	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
> > > >>> +
> > > >>> +	/* TODO: AP sleep scenario*/
> > > >>
> > > >> Shall the patchset be called RFC?
> > > >>
> > > > OK. I will add RFC for this patch on next submission.
> > > > 
> > > >>> +
> > > >>> +	return xhci_suspend(xhci, device_may_wakeup(dev));
> > > >>> +}
> > > >>> +
> > > >>> +static int xhci_exynos_resume(struct device *dev)
> > > >>> +{
> > > >>> +	struct usb_hcd	*hcd = dev_get_drvdata(dev);
> > > >>> +	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
> > > >>> +	int ret;
> > > >>> +
> > > >>> +	/* TODO: AP resume scenario*/
> > > >>> +
> > > >>> +	ret = xhci_resume(xhci, 0);
> > > >>> +	if (ret)
> > > >>> +		return ret;
> > > >>> +
> > > >>> +	pm_runtime_disable(dev);
> > > >>> +	pm_runtime_set_active(dev);
> > > >>> +	pm_runtime_enable(dev);
> > > >>> +
> > > >>> +	return 0;
> > > >>> +}
> > > >>> +
> > > >>> +static const struct dev_pm_ops xhci_exynos_pm_ops = {
> > > >>> +	SET_SYSTEM_SLEEP_PM_OPS(xhci_exynos_suspend, xhci_exynos_resume)
> > > >>> +};
> > > >>> +
> > > >>> +MODULE_DESCRIPTION("xHCI Exynos Host Controller Driver");
> > > >>> +MODULE_LICENSE("GPL");
> > > >>
> > > >> You don't have list of compatibles (and missing bindings), driver
> > > >> definition, driver registration. Entire solution is not used - nothing
> > > >> calls xhci_exynos_vendor_init(), because nothign uses "ops".
> > > >>
> > > > 
> > > > xhci_exynos_vendor_init is called in xhci-plat.c (xhci_vendor_init)
> > > > [v4,2/5] usb: host: add xhci hooks for xhci-exynos
> > > > ops are used in some files(xhci-mem.c, xhci.c ..) and the body of ops is in
> > > > all xhci-exynos.
> > > 
> > > 
> > > Nothing uses the "ops" except xhci_exynos_register_vendor_ops() which is
> > > not called anywhere, so the xhci_vendor_init() does not call
> > > xhci_exynos_vendor_init().
> > > 
> > 
> > You are right. xhci_exynos_register_vendor_ops should be called by other
> > module. It's only thing not called anywhere in this patchset. I don't uses
> > xhci-exynos alone in my scenario. Other module loads this on runtime.
> > 
> > > > 
> > > > xhci-exynos is not a standalone driver. It could be enabled when other module
> > > > makes xhci platform driver probed as it uses xhci platform mainly.
> > > 
> > > It "could be" or "will be"? We do not talk here about theoretical usage
> > > of the driver, but a real one.
> > > 
> > > > I thought I just used existing compltible not adding new one.
> > > > I will add them if needed.
> > > 
> > > Since you called everything here as "exynos" it is specific to one
> > > hardware and not-reusable on anything else. How can then you use some
> > > other compatible? It would be a misuse of Devicetree bindings.
> > > 
> > 
> > I got it. Let me add them. Is it still necessary if it is only used by
> > other module on runtime as I said above?
> 
> Please submit a full, working driver so these changes can be able to be
> properly reviewed.  Otherwise it is just a waste of time for us to even
> read them, right?
> 
> We do not add changes to the kernel that do not work or do anything,
> that would be pointless, and cause us extra work and maintenance.
> 

We have several drivers including this and some drivers depends on other
drivers. I can't submit all drivers at the same time and It would be harder
if I did. That's why I submitted only patches in xhci without any dependancy.
I wanted to submit our all drivers one by one after then.
I will add it on next submission. New patch would be about dwc3-exynos.c not
in xhci.

I'm sorry to bother you but I hope you wouldn't think it's waste of time..

Best Regards,
Jung Daehwan

> thanks,
> 
> greg k-h
> 

------s9reHD3dvq.Swzu4OgS99nNlXP7CLa0djtt04wdzZepsPVyA=_31dee_
Content-Type: text/plain; charset="utf-8"


------s9reHD3dvq.Swzu4OgS99nNlXP7CLa0djtt04wdzZepsPVyA=_31dee_--
