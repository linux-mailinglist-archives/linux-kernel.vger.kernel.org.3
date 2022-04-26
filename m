Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDF850FB08
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241256AbiDZKiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349210AbiDZKh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:37:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9242B626F;
        Tue, 26 Apr 2022 03:21:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CBA2615CF;
        Tue, 26 Apr 2022 10:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E2BC385A0;
        Tue, 26 Apr 2022 10:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650968503;
        bh=KUUK6iT7bOMV0phgkRt5MLlicyQlmJrOnAGbU2zHWtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZSnrGhImsoG4wKFKYyTBS2DRFndoo3/cCxgFlW7JzxYrjCnQJKFuPKn8CpcPvOmep
         0ghcrkJT5LDWtQ9FVu3xSQQ6Q8P31KKrQj4UF+Iyq3N6ZLXW+uutspcwYe8bkXJrva
         Jd4ss0EfsKCPPtXKfQsnJrazsXugBBECakpj63qs=
Date:   Tue, 26 Apr 2022 12:21:40 +0200
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
Subject: Re: [PATCH v4 5/5] usb: host: add xhci-exynos driver
Message-ID: <YmfHtFFIJp6z7ysK@kroah.com>
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220426092023epcas2p32946c087135ca4b7e63b03915060c55d@epcas2p3.samsung.com>
 <1650964728-175347-6-git-send-email-dh10.jung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650964728-175347-6-git-send-email-dh10.jung@samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 06:18:48PM +0900, Daehwan Jung wrote:
> +int xhci_check_trb_in_td_math(struct xhci_hcd *xhci);
> +void xhci_segment_free(struct xhci_hcd *xhci, struct xhci_segment *seg);
> +void xhci_link_segments(struct xhci_segment *prev,
> +		struct xhci_segment *next,
> +		enum xhci_ring_type type, bool chain_links);
> +void xhci_initialize_ring_info(struct xhci_ring *ring,
> +					unsigned int cycle_state);
> +void xhci_remove_stream_mapping(struct xhci_ring *ring);

Why does your single driver have global functions?  That should not be
needed, right?

And these are odd for a driver's namespace...

thanks,

greg k-h
