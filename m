Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7F150FA52
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348651AbiDZKZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348835AbiDZKX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:23:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABB3340D6;
        Tue, 26 Apr 2022 02:54:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04B68B81D43;
        Tue, 26 Apr 2022 09:54:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFE9C385A4;
        Tue, 26 Apr 2022 09:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650966860;
        bh=dgZLzHPox+J+i5Ksh1CcZ3C8j6e4jGpAgkA7LMle0ME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IHzpt6bZh9xKCjuCxn89GOm1pLinNuvXh2c5ZRsm2+sDH4KUK9TG93MtfpcRuR8OU
         JzE0dWvLvgMVOCc4RRzPzpilvDdVxVOF9z0qKpmbGarVh1ZynncQiAy4kjdXGsawOK
         EcRjRVZzafDnrOBU1S74oY9X+/AEHKYG5ZL3ZxeU=
Date:   Tue, 26 Apr 2022 11:54:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daehwan Jung <dh10.jung@samsung.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v4 1/5] usb: host: export symbols for xhci-exynos to use
 xhci hooks
Message-ID: <YmfBSLDiZGkvu3sG@kroah.com>
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220426092021epcas2p4071f2b7621558a015579131990486a3c@epcas2p4.samsung.com>
 <1650964728-175347-2-git-send-email-dh10.jung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650964728-175347-2-git-send-email-dh10.jung@samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 06:18:44PM +0900, Daehwan Jung wrote:
> Export symbols for xhci hooks usage:
>     xhci_get_slot_ctx
>     xhci_get_endpoint_address
>     - Allow xhci hook to get ep_ctx from the xhci_container_ctx for
>       getting the ep_ctx information to know which ep is offloading and
>       comparing the context in remote subsystem memory if needed.
> 
>     xhci_ring_alloc
>     - Allow xhci hook to allocate vendor specific ring. Vendors could
>       alloc additional event ring.
> 
>     xhci_trb_virt_to_dma
>     - Used to retrieve the DMA address of vendor specific ring. Vendors
>       could get dequeue address of event ring.
> 
>     xhci_segment_free
>     xhci_link_segments
>     - Allow xhci hook to handle vendor specific segment. Vendors could
>       directly free or link segments of vendor specific ring.
> 
>     xhci_initialize_ring_info
>     - Allow xhci hook to initialize vendor specific ring.
> 
>     xhci_check_trb_in_td_math
>     - Allow xhci hook to Check TRB math for validation. Vendors could
>       check trb when allocating vendor specific ring.
> 
>     xhci_address_device
>     - Allow override to give configuration info to Co-processor.
> 
>     xhci_bus_suspend
>     xhci_bus_resume
>     - Allow override of suspend and resume for power scenario.
> 
>     xhci_remove_stream_mapping
>     - Allow to xhci hook to remove stream mapping. Vendors need to do it
>       when free-ing vendor specific ring if it's stream type.
> 

For the static functions that you are now exporting, they need to have
their functions declared in a .h file.  If not, you now get warnings
when you run sparse after applying this commit, right?

thanks,

greg k-h
