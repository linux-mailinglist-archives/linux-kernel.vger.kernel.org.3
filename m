Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EA64B5183
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353976AbiBNNTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:19:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353800AbiBNNTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:19:20 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4380C48388;
        Mon, 14 Feb 2022 05:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644844752; x=1676380752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Diwd0EY/7PAtVxvigWXKiOU92Qi73gDqKE8+uKzDHY=;
  b=c2r3cNMc3Ut9nxmqTXISqNZSBIFbK6QpbT0+px3nnrcbAOmo6D5d78ii
   a8Hm6Q0tC9AEHis0b46/6EGuN4xIUk1U9lgXdibSRtsNI7RDt8yKBbfcl
   BSA0fwiKth0f/FMPnw/fwKrwVqTuB3VCJpHS7V0xH1L7eZRLevQCoJRlw
   s=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Feb 2022 05:19:11 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 05:19:11 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Feb 2022 05:19:10 -0800
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 14 Feb 2022 05:19:08 -0800
Date:   Mon, 14 Feb 2022 18:49:04 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ugoswami@quicinc.com>, Jung Daehwan <dh10.jung@samsung.com>
Subject: Re: [PATCH v2] xhci: reduce xhci_handshake timeout in xhci_reset
Message-ID: <20220214131904.GB31021@hu-pkondeti-hyd.qualcomm.com>
References: <1644836663-29220-1-git-send-email-quic_pkondeti@quicinc.com>
 <1644841216-1468-1-git-send-email-quic_pkondeti@quicinc.com>
 <YgpLGGYI0W9mL2gg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YgpLGGYI0W9mL2gg@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 01:29:12PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Feb 14, 2022 at 05:50:16PM +0530, Pavankumar Kondeti wrote:
> > From: Daehwan Jung <dh10.jung@samsung.com>
> > 
> > xhci_reset() is called with interrupts disabled. Waiting 10 seconds for
> > controller reset and controller ready operations can be fatal to the
> > system when controller is timed out. Reduce the timeout to 1 second
> > and print a error message when the time out happens.
> > 
> > Fixes: 22ceac191211 ("xhci: Increase reset timeout for Renesas 720201 host.")
> > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> > Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> > ---
> > 
> > v2:
> > - Add error print statements in the code that change log refers to
> > 
> >  drivers/usb/host/xhci.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > index dc357ca..bb9ea3f 100644
> > --- a/drivers/usb/host/xhci.c
> > +++ b/drivers/usb/host/xhci.c
> > @@ -196,9 +196,11 @@ int xhci_reset(struct xhci_hcd *xhci)
> >  		udelay(1000);
> >  
> >  	ret = xhci_handshake(&xhci->op_regs->command,
> > -			CMD_RESET, 0, 10 * 1000 * 1000);
> > -	if (ret)
> > +			CMD_RESET, 0, 1 * 1000 * 1000);
> > +	if (ret) {
> > +		xhci_err(xhci, "Host controller reset timed out\n");
> 
> A timeout is not the only error that could have happened here.  So why
> claim that all errors are timeout errors?

Thanks for pointing this out. xhci_handshake() can return an error code
other than -ETIMEDOUT. ret == -ETIMEDOUT check needs to be added or
just print the ret error in the print message.
> 
> How did you test this?

This is a hard to reproduce issue. So I have hacked the code to use 1 usec
instead of 1 sec as timeout and see running into the timeout issue. I know
this is not a perfect test. The test patch is included below.

Thanks,
Pavan


diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index e95a5bc..6147544 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -37,6 +37,9 @@ static unsigned long long quirks;
 module_param(quirks, ullong, S_IRUGO);
 MODULE_PARM_DESC(quirks, "Bit flags for quirks to be enabled as default");
 
+static int reset_error;
+module_param(reset_error, int, S_IRUGO | S_IWUSR);
+
 static bool td_on_ring(struct xhci_td *td, struct xhci_ring *ring)
 {
 	struct xhci_segment *seg = ring->first_seg;
@@ -195,8 +198,15 @@ int xhci_reset(struct xhci_hcd *xhci)
 	if (xhci->quirks & XHCI_INTEL_HOST)
 		udelay(1000);
 
-	ret = xhci_handshake(&xhci->op_regs->command,
-			CMD_RESET, 0, 1 * 1000 * 1000);
+	if (reset_error) {
+		xhci_err(xhci, "forcing timeout\n");
+		ret = xhci_handshake(&xhci->op_regs->command,
+				CMD_RESET, 0, 1); /* 1 usec */
+	} else {
+		ret = xhci_handshake(&xhci->op_regs->command,
+				CMD_RESET, 0, 1 * 1000 * 1000);
+	}
+
 	if (ret) {
 		xhci_err(xhci, "Host controller reset timed out\n");
 		return ret;
