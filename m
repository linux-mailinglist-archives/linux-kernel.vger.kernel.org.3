Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4029D58B9CC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 08:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbiHGGYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 02:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiHGGYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 02:24:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A3CE0FC
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 23:24:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 888DFB80ABD
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 06:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015D5C433D6;
        Sun,  7 Aug 2022 06:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659853489;
        bh=d9ZbKkkoAn0jaQ6IbWUf+e96hveh17MMI1sapeni2mM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rWKm6oJ9w5U6cSNQvoCzHpR7O6jxHr5fR0ib91UH9LAifnti3l9mxt6Y0SIxryy3A
         pzpsByc5fUvySCVphLcztSivMKJcns8sWaQoimy8UeXnMO/E8i4pTelz9Y871Ec3aY
         CO2uPdeFgapTA8+1mr3kN71Pa1bP666/ZfOEK5uI=
Date:   Sun, 7 Aug 2022 08:24:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Baehr <abaehr@osadl.org>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Add parport support for Asix device 99100
Message-ID: <Yu9arOX44o7v1OCC@kroah.com>
References: <20220806113124.608017725@osadl.org>
 <20220806113334.349537884@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220806113334.349537884@osadl.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2022 at 01:31:26PM +0200, Alexander Baehr wrote:
> For some reason, Asix decided to produce a parallel port that is fully
> compatible with Netmos device 9900, but named it 99100. It obviously has
> another vendor ID, but the device ID is the same. This patch adds the 
> required settings and was successfully tested with the Asix device. 
> 
> Signed-off-by: Alexander Baehr <abaehr@osadl.org>
> ---
>  drivers/parport/parport_pc.c |    4 ++++
>  include/linux/pci_ids.h      |    3 +++
>  2 files changed, 7 insertions(+)
> 
> Index: linux/drivers/parport/parport_pc.c
> ===================================================================
> --- linux.orig/drivers/parport/parport_pc.c
> +++ linux/drivers/parport/parport_pc.c
> @@ -2612,6 +2612,7 @@ enum parport_pc_pci_cards {
>  	netmos_9815,
>  	netmos_9901,
>  	netmos_9865,
> +	asix_ax99100,
>  	quatech_sppxp100,
>  	wch_ch382l,
>  };
> @@ -2766,6 +2767,9 @@ static const struct pci_device_id parpor
>  	  0xA000, 0x1000, 0, 0, netmos_9865 },
>  	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9865,
>  	  0xA000, 0x2000, 0, 0, netmos_9865 },
> +	/* Asix AX99100 Parallel port PCIExpressCard */
> +	{ PCI_VENDOR_ID_ASIX, PCI_DEVICE_ID_AX99100,
> +	  0xA000, 0x2000, 0, 0, netmos_9900 },
>  	/* Quatech SPPXP-100 Parallel port PCI ExpressCard */
>  	{ PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_SPPXP_100,
>  	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, quatech_sppxp100 },
> Index: linux/include/linux/pci_ids.h
> ===================================================================
> --- linux.orig/include/linux/pci_ids.h
> +++ linux/include/linux/pci_ids.h
> @@ -3108,4 +3108,7 @@
>  
>  #define PCI_VENDOR_ID_NCUBE		0x10ff
>  
> +#define PCI_VENDOR_ID_ASIX		0x125b
> +#define PCI_DEVICE_ID_AX99100		0x9100

Please read the top of this file for why we shouldn't be added new
entries to it.

thanks,

greg k-h
