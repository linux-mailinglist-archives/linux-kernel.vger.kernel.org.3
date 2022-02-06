Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5A44AB0F1
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 18:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344172AbiBFRZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 12:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiBFRZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 12:25:40 -0500
X-Greylist: delayed 465 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 09:25:39 PST
Received: from relay4.hostedemail.com (relay4.hostedemail.com [64.99.140.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71376C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 09:25:39 -0800 (PST)
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay12.hostedemail.com (Postfix) with ESMTP id 5A8AF120714;
        Sun,  6 Feb 2022 17:17:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id A466018;
        Sun,  6 Feb 2022 17:17:08 +0000 (UTC)
Message-ID: <8536ca17c2945cb77c506d99eff5ccc42e71f2f3.camel@perches.com>
Subject: Re: [PATCH] staging: octeon-usb: Fix 'should not end with '(''
From:   Joe Perches <joe@perches.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        "'joelcchangg@gmail.com'" <joelcchangg@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.com" <gregkh@linuxfoundation.com>
Date:   Sun, 06 Feb 2022 09:17:45 -0800
In-Reply-To: <c0b504dd1f254f19b6ff60948684303b@AcuMS.aculab.com>
References: <20220206074615.3527-1-joelcchangg@gmail.com>
         <c0b504dd1f254f19b6ff60948684303b@AcuMS.aculab.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: qg4yiupiwhcsqe6n45gxqr7fdpk59b16
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: A466018
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+fnhxLHTdi5aumjIE+T5F75ykVyJ/qk3Y=
X-HE-Tag: 1644167828-153419
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-02-06 at 14:16 +0000, David Laight wrote:
> From: joelcchangg@gmail.com
> > Sent: 06 February 2022 07:46
> > 
> > This patch fixes the checkpatch.pl check:
> > 
> > CHECK: Line should not end with '('
[]
> > diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
[]
> > @@ -1792,23 +1792,18 @@ static void cvmx_usb_start_channel(struct octeon_hcd *usb, int channel,
> >  	case CVMX_USB_TRANSFER_INTERRUPT:
> >  		break;
> >  	case CVMX_USB_TRANSFER_ISOCHRONOUS:
> > -		if (!cvmx_usb_pipe_needs_split(usb, pipe)) {
> > +		if (!cvmx_usb_pipe_needs_split(usb, pipe) &&
> > +		    pipe->transfer_dir == CVMX_USB_DIRECTION_OUT) {
> >  			/*
> >  			 * ISO transactions require different PIDs depending on
> >  			 * direction and how many packets are needed
> >  			 */
> > -			if (pipe->transfer_dir == CVMX_USB_DIRECTION_OUT) {
> > -				if (pipe->multi_count < 2) /* Need DATA0 */
> > -					USB_SET_FIELD32(
> > -						CVMX_USBCX_HCTSIZX(channel,
> > -								   usb->index),
> > +			if (pipe->multi_count < 2) /* Need DATA0 */
> > +				USB_SET_FIELD32(CVMX_USBCX_HCTSIZX(channel, usb->index),
> >  						cvmx_usbcx_hctsizx, pid, 0);
> > -				else /* Need MDATA */
> > -					USB_SET_FIELD32(
> > -						CVMX_USBCX_HCTSIZX(channel,
> > -								   usb->index),
> > +			else /* Need MDATA */
> > +				USB_SET_FIELD32(CVMX_USBCX_HCTSIZX(channel, usb->index),
> >  						cvmx_usbcx_hctsizx, pid, 3);
> > -			}
> >  		}
> >  		break;
> >  	}
> 
> What has that hunk got to do with the patch description?

Nothing and this should be revisited or explained much more
as it seems to change the logic.

> > @@ -2121,17 +2116,17 @@ static void cvmx_usb_complete(struct octeon_hcd *usb,
> >   *
> >   * Returns: Transaction or NULL on failure.
> >   */
> > -static struct cvmx_usb_transaction *cvmx_usb_submit_transaction(
> > -				struct octeon_hcd *usb,
> > -				struct cvmx_usb_pipe *pipe,
> > -				enum cvmx_usb_transfer type,
> > -				u64 buffer,
> > -				int buffer_length,
> > -				u64 control_header,
> > -				int iso_start_frame,
> > -				int iso_number_packets,
> > -				struct cvmx_usb_iso_packet *iso_packets,
> > -				struct urb *urb)
> > +static struct cvmx_usb_transaction *cvmx_usb_submit_transaction(struct octeon_hcd *usb,
> > +								struct cvmx_usb_pipe *pipe,
> > +								enum cvmx_usb_transfer type,
> > +								u64 buffer,
> > +								int buffer_length,
> > +								u64 control_header,
> > +								int iso_start_frame,
> > +								int iso_number_packets,
> > +								struct cvmx_usb_iso_packet
> > +									*iso_packets,
> > +								struct urb *urb)
> 
> Those lines are now far longer than is 'nice'.

True.

This _might_ be better with the return type on a separate line

Something like:

static struct cvmx_usb_transaction *
cvmx_usb_submit_transaction(struct octeon_hcd *usb, struct cvmx_usb_pipe *pipe,
			    enum cvmx_usb_transfer type,
			    u64 buffer, int buffer_length,
			    u64 control_header, int iso_start_frame,
			    int iso_number_packets,
			    struct cvmx_usb_iso_packet *iso_packets,
			    struct urb *urb)


