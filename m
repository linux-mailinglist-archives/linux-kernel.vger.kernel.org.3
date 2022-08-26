Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8094B5A29DF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 16:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344477AbiHZOpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 10:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbiHZOpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 10:45:20 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D23CE4DB4F
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 07:45:17 -0700 (PDT)
Received: (qmail 39829 invoked by uid 1000); 26 Aug 2022 10:45:16 -0400
Date:   Fri, 26 Aug 2022 10:45:16 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Fedor Pchelkin <pchelkin@ispras.ru>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        ath9k-devel@qca.qualcomm.com, ldv-project@linuxtesting.org,
        eli.billauer@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        andreyknvl@google.com, gustavoars@kernel.org,
        ingrassia@epigenesys.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        oneukum@suse.com, tiwai@suse.de, syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in hif_usb_alloc_rx_urbs/usb_submit_urb
Message-ID: <YwjcfDOLNTYiRQij@rowland.harvard.edu>
References: <09fbc5ed-d67e-8308-1e49-2de6f2cea7dd@ispras.ru>
 <Yv/ahFW577q5woup@rowland.harvard.edu>
 <9ebc80d0-1b16-642c-e66b-2de52c673334@ispras.ru>
 <5dce2e1c-fa65-2fb3-08ad-65122f7e495d@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dce2e1c-fa65-2fb3-08ad-65122f7e495d@ispras.ru>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 04:14:48PM +0300, Fedor Pchelkin wrote:
> Sat, 10 Oct 2020 at 04:08:19 UTC+3, Alan Stern wrote:
> > Index: usb-devel/drivers/net/wireless/ath/ath9k/hif_usb.c
> > ===================================================================
> > --- usb-devel.orig/drivers/net/wireless/ath/ath9k/hif_usb.c
> > +++ usb-devel/drivers/net/wireless/ath/ath9k/hif_usb.c
> > @@ -1307,6 +1307,20 @@ static int ath9k_hif_usb_probe(struct us
> > struct usb_device *udev = interface_to_usbdev(interface);
> > struct hif_device_usb *hif_dev;
> > int ret = 0;
> > + struct usb_host_interface *alt;
> > + struct usb_endpoint_descriptor *epd;
> > +
> > + /* Verify the expected endpoints are present */
> > + alt = interface->cur_altsetting;
> > + if (!usb_find_int_in_endpoint(alt, &epd) ||
> > + usb_endpoint_num(epd) != USB_REG_IN_PIPE ||
> > + !usb_find_int_out_endpoint(alt, &epd) ||
> > + usb_endpoint_num(epd) != USB_REG_OUT_PIPE ||
> > + !usb_find_bulk_in_endpoint(alt, &epd) ||
> > + usb_endpoint_num(epd) != USB_WLAN_RX_PIPE ||
> > + !usb_find_bulk_out_endpoint(alt, &epd) ||
> > + usb_endpoint_num(epd) != USB_WLAN_TX_PIPE)
> > + return -ENODEV;
> >
> > if (id->driver_info == STORAGE_DEVICE)
> > return send_eject_command(interface);
> 
> We've tested the suggested patch and found a null-ptr-deref. The thing
> is that usb_find_{...}_endpoint() returns zero in normal case, and
> non-zero value (-ENXIO) when failed (in current patch version it is
> supposed to be just opposite and sometimes a NULL epd is dereferenced).

Whoops, you're right.  Silly mistake.

> To fix it the negation signs before usb_find_{...}_endpoint() should be
> removed.

Actually, I would change it to "< 0", which will emphasize to readers 
that it's testing for an error return value.

> And we also think usb_find_common_endpoints(...) should be used directly
> as all the scanned usb_endpoint_descriptors will be passed to it and
> returned in just one call.

Good idea.

> If you wish, I may prepare the patch myself.

Please do; I have more than enough other things going on and little time 
to work on them.

Alan Stern
