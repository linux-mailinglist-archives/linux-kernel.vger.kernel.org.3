Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92A44AD1B1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 07:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347679AbiBHGmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 01:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbiBHGmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 01:42:05 -0500
X-Greylist: delayed 122 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 22:42:04 PST
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FABCC0401EF;
        Mon,  7 Feb 2022 22:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644302524; x=1675838524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iqtNpA9tQzu6yJkZwnRGduJChMwjXon6hNRj5nmETJQ=;
  b=cbUA0RV9dvcQbdXgm9nAvFpJNGjMr1XdZSic1nHMw2zHqJxqnvqmRfIs
   9aTge8+kUGeJHiB/2D6yvg7okA5hR0HhykI+5U4JgwJSn+lM3m+9VEkv+
   eOtqRXKWL5PQ+tyD5ZMqO36QmZYAOLlhYyhHfa4mV9aGlDHH+vq8tbKIu
   Q=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 07 Feb 2022 22:40:01 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 22:40:00 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 7 Feb 2022 22:40:00 -0800
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 7 Feb 2022 22:39:56 -0800
Date:   Tue, 8 Feb 2022 12:09:52 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Udipto Goswami <quic_ugoswami@quicinc.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Prevent core from processing stale
 TRBs
Message-ID: <20220208063952.GB22194@hu-pkondeti-hyd.qualcomm.com>
References: <1644207958-18287-1-git-send-email-quic_ugoswami@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1644207958-18287-1-git-send-email-quic_ugoswami@quicinc.com>
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

On Mon, Feb 07, 2022 at 09:55:58AM +0530, Udipto Goswami wrote:
> With CPU re-ordering on write instructions, there might
> be a chance that the HWO is set before the TRB is updated
> with the new mapped buffer address.
> And in the case where core is processing a list of TRBs
> it is possible that it fetched the TRBs when the HWO is set
> but before the buffer address is updated.
> Prevent this by adding a memory barrier before the HWO
> is updated to ensure that the core always process the
> updated TRBs.
> 
> Fixes: f6bafc6a1c9 ("usb: dwc3: convert TRBs into bitshifts")
> Signed-off-by: Udipto Goswami <quic_ugoswami@quicinc.com>
> ---
> v1: For an ep the trbs can be reused, and if cpu re-ordering also
> takes place, there is a change that the HWO will get set even before
> the trb bpl/bph are updated which will lead controller to access a
> stale buffer address from the previous transactions.
> 
>  drivers/usb/dwc3/gadget.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 520031b..183b909 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1291,6 +1291,19 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
>  	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) && dep->stream_capable)
>  		trb->ctrl |= DWC3_TRB_CTRL_SID_SOFN(stream_id);
>  
> +	/*
> +	 * As per data book 4.2.3.2TRB Control Bit Rules section
> +	 *
> +	 * The controller autonomously checks the HWO field of a TRB to determine if the
> +	 * entire TRB is valid. Therefore, software must ensure that the rest of the TRB
> +	 * is valid before setting the HWO field to '1'. In most systems, this means that
> +	 * software must update the fourth DWORD of a TRB last.
> +	 *
> +	 * However there is a possibility of CPU re-ordering here which can cause
> +	 * controller to observe the HWO bit set prematurely.
> +	 * Add a write memory barrier to prevent CPU re-ordering.
> +	 */
> +	wmb();
>  	trb->ctrl |= DWC3_TRB_CTRL_HWO;
>  

Looks good to me. FWIW,

Reviewed-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>

It is very similar to what we have in xHC during TRB preparation.

commit 576667bad341516edc4e18eb85acb0a2b4c9c9d9
Author: Mathias Nyman <mathias.nyman@linux.intel.com>
Date:   Fri Jan 15 18:19:06 2021 +0200

xhci: make sure TRB is fully written before giving it to the controller

Thanks,
Pavan
