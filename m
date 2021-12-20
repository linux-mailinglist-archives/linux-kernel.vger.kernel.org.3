Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72AC147B0FF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 17:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbhLTQVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 11:21:53 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:38517 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbhLTQVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 11:21:52 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 661B5300002D0;
        Mon, 20 Dec 2021 17:21:50 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 527C6294C61; Mon, 20 Dec 2021 17:21:50 +0100 (CET)
Date:   Mon, 20 Dec 2021 17:21:50 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Add defines for normal and subtractive PCI
 bridges
Message-ID: <20211220162150.GA706@wunner.de>
References: <20211210145352.16323-1-pali@kernel.org>
 <20211220145140.31898-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211220145140.31898-1-pali@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 03:51:40PM +0100, Pali Rohár wrote:
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -178,9 +178,9 @@ static pci_ers_result_t pcie_portdrv_mmio_enabled(struct pci_dev *dev)
>   */
>  static const struct pci_device_id port_pci_ids[] = {
>  	/* handle any PCI-Express port */
> -	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0) },
> +	{ PCI_DEVICE_CLASS(PCI_CLASS_BRIDGE_PCI_NORMAL, ~0) },
>  	/* subtractive decode PCI-to-PCI bridge, class type is 060401h */
> -	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x01), ~0) },
> +	{ PCI_DEVICE_CLASS(PCI_CLASS_BRIDGE_PCI_SUBTRACTIVE, ~0) },

Any harm in simply matching for 0x060400 with mask 0xffff00?
