Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13245A0212
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 21:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239932AbiHXTY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 15:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbiHXTYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 15:24:50 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B063E60C5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 12:24:47 -0700 (PDT)
Received: (qmail 390799 invoked by uid 1000); 24 Aug 2022 15:24:46 -0400
Date:   Wed, 24 Aug 2022 15:24:46 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Khalid Masum <khalid.masum.92@gmail.com>
Cc:     linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexey Sheplyakov <asheplyakov@basealt.ru>,
        Weitao Wang <WeitaoWang-oc@zhaoxin.com>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Subject: Re: [PATCH] usb: host: Use helper function to get endpoint
Message-ID: <YwZ6/qkEAk8867qh@rowland.harvard.edu>
References: <20220824130702.10912-1-khalid.masum.92@gmail.com>
 <YwY4cVdB3tVVMIqJ@rowland.harvard.edu>
 <CAABMjtFEfgQtcGKLkd=whFN=WHUywTg=fDAxRQ+zKLiqOFhvQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAABMjtFEfgQtcGKLkd=whFN=WHUywTg=fDAxRQ+zKLiqOFhvQg@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 11:57:25PM +0600, Khalid Masum wrote:
> On Wed, Aug 24, 2022 at 8:40 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> >
> > Even this is awkward.  It's silly to look up the endpoint in a table
> > when you already know that it is endpoint 0.  Just do:
> >
> >         ep = &udev->ep0;
> >
> > with no need to check for NULL.
> 
> After further checking, I realized that  usb_device udev is created by
> ehset_single_step_set_feature and depends on usb_hcd and port. So I do
> not get why the endpoint is at udev->ep0. Can you help me with this?

udev is not a usb_device structure; it is a _pointer_ to a usb_device 
structure.  The pointer is created when ehset_single_step_set_feature() 
calls usb_hub_find_child(), but the structure itself gets created long 
before that, when the USB device is first detected and initialized.

You can see this happening where hub_port_connect() calls 
usb_alloc_dev().  The ep0 field is filled in by hub_port_init() and the 
routines it calls.

Alan Stern
