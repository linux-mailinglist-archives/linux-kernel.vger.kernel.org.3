Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF07A59ED6B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 22:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiHWUhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 16:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiHWUh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:37:27 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 8CB22543D3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 13:21:19 -0700 (PDT)
Received: (qmail 357336 invoked by uid 1000); 23 Aug 2022 16:21:18 -0400
Date:   Tue, 23 Aug 2022 16:21:18 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Khalid Masum <khalid.masum.92@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: ehci: Prevent possible modulo by zero
Message-ID: <YwU2vp0FSR5dS/FX@rowland.harvard.edu>
References: <20220823182758.13401-1-khalid.masum.92@gmail.com>
 <20220823182758.13401-2-khalid.masum.92@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823182758.13401-2-khalid.masum.92@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 12:27:57AM +0600, Khalid Masum wrote:
> usb_maxpacket() returns 0 if it fails to fetch the endpoint. This
> value is later used for calculating modulo. Which can cause modulo
> by zero in qtd_fill and qh_urb_transaction.
> 
> Prevent this breakage by returning if maxpacket is found to be 0.
> 
> Fixes coverity warning: 744857 ("Division or modulo by zero")
> Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>

I'm sure we've seen at least one patch doing this submitted in the past.  
It was wrong then and it's wrong now.  Coverity doesn't have a full 
understanding of how the kernel's USB subsystem works and sometimes it 
makes mistakes.

In short, qh_urb_transaction() can be called only by pathways that pass 
through usb_submit_urb(), which already includes this check:

	ep = usb_pipe_endpoint(dev, urb->pipe);
	if (!ep)
		return -ENOENT;

There's no need to check it again in the ehci-hcd driver.


On Wed, Aug 24, 2022 at 12:27:58AM +0600, Khalid Masum wrote:
> usb_maxpacket() returns 0 if it fails to fetch the endpoint. This
> value is later used for calculating modulo. Which can cause modulo
> by zero in qtd_fill.
>
> Prevent this breakage by returning if maxpacket is found to be 0.
>
> Fixes coverity warning: 1487371 ("Division or modulo by zero")
> Fixes: 9841f37a1cca ("usb: ehci: Add support for SINGLE_STEP_SET_FEATURE test of EHSET")
> Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>

This also is unnecessary.  Calls to 
ehci_submit_single_step_set_feature() have to pass through 
request_single_step_set_feature_urb(), which already includes this 
check:

	if (!ep) {
		usb_free_urb(urb);
		return NULL;
	}

Neither of these patches is needed.

Alan Stern
