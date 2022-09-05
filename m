Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7C75ACCD6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbiIEHbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbiIEHak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:30:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9C017A93;
        Mon,  5 Sep 2022 00:30:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67709B80EFB;
        Mon,  5 Sep 2022 07:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB45C433D6;
        Mon,  5 Sep 2022 07:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662362998;
        bh=T0pZjpm3bTRxwQYW9kgEQBcu+mndOHzjObJEkPtolNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IKXBFBiQYixrQtWJCZhaP0KSPy9lhguVa6pfnGnXwHQ33CDwjO2juAtiSQtdereIa
         5WO1YFzQEZ9DtoYgGmrQuooZ6czs9VJwAdq6iAE/Y7Bb22bKPybzsxMLXr/kj4Zdpb
         s20yMsN6x2o0tPO7lICNUiWnCi6aABXX9JpqkvfA=
Date:   Mon, 5 Sep 2022 09:29:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        sanju.mehta@amd.com, mario.limonciello@amd.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Resume PCIe bridges after switch is found
 on AMD USB4 controller
Message-ID: <YxWlc1n4HRxawa/K@kroah.com>
References: <20220905065622.1573811-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905065622.1573811-1-kai.heng.feng@canonical.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 02:56:22PM +0800, Kai-Heng Feng wrote:
> AMD USB4 can not detect external PCIe devices like external NVMe when
> it's hotplugged, because card/link are not up:
> 
> pcieport 0000:00:04.1: pciehp: pciehp_check_link_active: lnk_status = 1101

That sounds like a hardware bug, how does this work in other operating
systems for this hardware?

> Use `lspci` to resume pciehp bridges can find external devices.

That's not good :(

> A long delay before checking card/link presence doesn't help, either.
> The only way to make the hotplug work is to enable pciehp interrupt and
> check card presence after the TB switch is added.
> 
> Since the topology of USB4 and its PCIe bridges are siblings, hardcode
> the bridge ID so TBT driver can wake them up to check presence.

As I mention below, this is not an acceptable solution.

AMD developers, any ideas on how to get this fixed in the TB controller
firware instead?

> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=216448
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/thunderbolt/nhi.c    | 29 +++++++++++++++++++++++++++++
>  drivers/thunderbolt/switch.c |  6 ++++++
>  drivers/thunderbolt/tb.c     |  1 +
>  drivers/thunderbolt/tb.h     |  5 +++++
>  include/linux/thunderbolt.h  |  1 +
>  5 files changed, 42 insertions(+)
> 
> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> index cb8c9c4ae93a2..75f5ce5e22978 100644
> --- a/drivers/thunderbolt/nhi.c
> +++ b/drivers/thunderbolt/nhi.c
> @@ -1225,6 +1225,8 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct tb_nhi *nhi;
>  	struct tb *tb;
> +	struct pci_dev *p = NULL;
> +	struct tb_pci_bridge *pci_bridge, *n;
>  	int res;
>  
>  	if (!nhi_imr_valid(pdev)) {
> @@ -1306,6 +1308,19 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		nhi_shutdown(nhi);
>  		return res;
>  	}
> +
> +	if (pdev->vendor == PCI_VENDOR_ID_AMD) {
> +		while ((p = pci_get_device(PCI_VENDOR_ID_AMD, 0x14cd, p))) {
> +			pci_bridge = kmalloc(sizeof(struct tb_pci_bridge), GFP_KERNEL);
> +			if (!pci_bridge)
> +				goto cleanup;
> +
> +			pci_bridge->bridge = p;
> +			INIT_LIST_HEAD(&pci_bridge->list);
> +			list_add(&pci_bridge->list, &tb->bridge_list);
> +		}
> +	}

You can't walk the device tree and create a "shadow" list of devices
like this and expect any lifetime rules to work properly with them at
all.

Please do not do this.

greg k-h
