Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEAA51147A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 11:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiD0Jp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 05:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiD0Jpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:45:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F0B3808EE;
        Wed, 27 Apr 2022 02:42:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 530BAB825CA;
        Wed, 27 Apr 2022 09:37:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EC4C385A9;
        Wed, 27 Apr 2022 09:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651052272;
        bh=qzyHzucfdjJHdS7Al49wqCBqj8KjWdFYjhXKJTQsUX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B5aL0i2+qF8+AIrqk2twZ40K34FmY3tt3gGR6gXq2EnyxJjkVxlFPkLbFUhaShKCA
         F9PqWYapcCOPaHWMPjnGKn8x81eycW5cyHQ9dYvo3wPtvQWnpN94J0+FfW3uvnWAeL
         cSaF/4xyjd8qOYs4FrIAfNoAToiDPyPl4EcqQ8qo=
Date:   Wed, 27 Apr 2022 11:37:48 +0200
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
Subject: Re: [PATCH v4 5/5] usb: host: add xhci-exynos driver
Message-ID: <YmkO7LDc0q38VFlE@kroah.com>
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220426092023epcas2p32946c087135ca4b7e63b03915060c55d@epcas2p3.samsung.com>
 <1650964728-175347-6-git-send-email-dh10.jung@samsung.com>
 <YmfHtFFIJp6z7ysK@kroah.com>
 <20220427092426.GD145620@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427092426.GD145620@ubuntu>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 06:24:26PM +0900, Jung Daehwan wrote:
> On Tue, Apr 26, 2022 at 12:21:40PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Apr 26, 2022 at 06:18:48PM +0900, Daehwan Jung wrote:
> > > +int xhci_check_trb_in_td_math(struct xhci_hcd *xhci);
> > > +void xhci_segment_free(struct xhci_hcd *xhci, struct xhci_segment *seg);
> > > +void xhci_link_segments(struct xhci_segment *prev,
> > > +		struct xhci_segment *next,
> > > +		enum xhci_ring_type type, bool chain_links);
> > > +void xhci_initialize_ring_info(struct xhci_ring *ring,
> > > +					unsigned int cycle_state);
> > > +void xhci_remove_stream_mapping(struct xhci_ring *ring);
> > 
> > Why does your single driver have global functions?  That should not be
> > needed, right?
> > 
> > And these are odd for a driver's namespace...
> > 
> 
> Those are exported in 1st patches. it's not good to include here as you said.

If you export a function, you also have to add it to a .h file
somewhere, otherwise it really is not exported.

thanks,

greg k-h
