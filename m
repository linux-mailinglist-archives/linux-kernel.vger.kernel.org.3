Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD68850FB13
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349175AbiDZKl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349078AbiDZKkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:40:55 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF2B4132C;
        Tue, 26 Apr 2022 03:31:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ACF18CE1C05;
        Tue, 26 Apr 2022 10:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A002CC385AF;
        Tue, 26 Apr 2022 10:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650969097;
        bh=G2ZTitD/EVuSTT3gVi8lMCMvmV58yHmWi/5BPeES7+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X1WQLUkMilXrPy39ia/9XBYPW9CMsQjHGtM0E5Dj0GyRNEsSqjxH31Ue7zn7yrS1e
         IeOgXhppFmG97EkS1zzuSWuzgvW0iJ2M85P8r2n68hv0ek8p2kdeJ1N2TeejcSf4Dk
         GjOjLGtCxMZlmp2E3hK9Wodh0VOiVuorh1SYmiAw=
Date:   Tue, 26 Apr 2022 12:31:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jung Daehwan <dh10.jung@samsung.com>
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
Message-ID: <YmfKBX2m+vOznq5h@kroah.com>
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220426092021epcas2p4071f2b7621558a015579131990486a3c@epcas2p4.samsung.com>
 <1650964728-175347-2-git-send-email-dh10.jung@samsung.com>
 <YmfBSLDiZGkvu3sG@kroah.com>
 <20220426102709.GA175152@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426102709.GA175152@ubuntu>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 07:27:09PM +0900, Jung Daehwan wrote:
> On Tue, Apr 26, 2022 at 11:54:16AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Apr 26, 2022 at 06:18:44PM +0900, Daehwan Jung wrote:
> > > Export symbols for xhci hooks usage:
> > >     xhci_get_slot_ctx
> > >     xhci_get_endpoint_address
> > >     - Allow xhci hook to get ep_ctx from the xhci_container_ctx for
> > >       getting the ep_ctx information to know which ep is offloading and
> > >       comparing the context in remote subsystem memory if needed.
> > > 
> > >     xhci_ring_alloc
> > >     - Allow xhci hook to allocate vendor specific ring. Vendors could
> > >       alloc additional event ring.
> > > 
> > >     xhci_trb_virt_to_dma
> > >     - Used to retrieve the DMA address of vendor specific ring. Vendors
> > >       could get dequeue address of event ring.
> > > 
> > >     xhci_segment_free
> > >     xhci_link_segments
> > >     - Allow xhci hook to handle vendor specific segment. Vendors could
> > >       directly free or link segments of vendor specific ring.
> > > 
> > >     xhci_initialize_ring_info
> > >     - Allow xhci hook to initialize vendor specific ring.
> > > 
> > >     xhci_check_trb_in_td_math
> > >     - Allow xhci hook to Check TRB math for validation. Vendors could
> > >       check trb when allocating vendor specific ring.
> > > 
> > >     xhci_address_device
> > >     - Allow override to give configuration info to Co-processor.
> > > 
> > >     xhci_bus_suspend
> > >     xhci_bus_resume
> > >     - Allow override of suspend and resume for power scenario.
> > > 
> > >     xhci_remove_stream_mapping
> > >     - Allow to xhci hook to remove stream mapping. Vendors need to do it
> > >       when free-ing vendor specific ring if it's stream type.
> > > 
> > 
> > For the static functions that you are now exporting, they need to have
> > their functions declared in a .h file.  If not, you now get warnings
> > when you run sparse after applying this commit, right?
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> I didn't get warnings in my environment. I tested to build default config +
> xhci_exynos by make command. Is there compile option to check it?

make "C=1"


