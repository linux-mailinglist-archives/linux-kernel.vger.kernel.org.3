Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D384B5A50
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 20:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiBNS7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 13:59:20 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiBNS7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 13:59:09 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23301D227A;
        Mon, 14 Feb 2022 10:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644865131; x=1676401131;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hqUWCkwFgLNSlm3+0KgS55gIZECqY05ZG+GhSPxmO5Y=;
  b=x+ESaLuY55jFioNmD/65//hsgoxCcZuiwXKpY+HZB5NGZdhJ/d4QHtZV
   e1Vnjwpj2soCiPvNcRDRJqtKQ86736VqdVx45oXDavnKVMcao9PVfHuTb
   5QS7BvRkwNPtu2Fte086U3a/qNynCVh3b/uGKHT3XohIE/SKPTua+DVwq
   g=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 14 Feb 2022 10:53:37 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 10:53:37 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Feb 2022 10:53:16 -0800
Received: from [10.110.117.25] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 14 Feb
 2022 10:53:16 -0800
Message-ID: <e4b18b77-ab33-bd70-c239-b009210c3864@quicinc.com>
Date:   Mon, 14 Feb 2022 10:53:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 1/2] usb: dwc3: Not set DWC3_EP_END_TRANSFER_PENDING in
 ep cmd fails
Content-Language: en-US
To:     Daehwan Jung <dh10.jung@samsung.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <quic_jackp@quicinc.com>, <Thinh.Nguyen@synopsys.com>
References: <1644831438-125403-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220214094041epcas2p2ec37c252dd5f9508454e9449c95e6c7a@epcas2p2.samsung.com>
 <1644831438-125403-2-git-send-email-dh10.jung@samsung.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <1644831438-125403-2-git-send-email-dh10.jung@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daehwan,

On 2/14/2022 1:37 AM, Daehwan Jung wrote:
> It always sets DWC3_EP_END_TRANSFER_PENDING in dwc3_stop_active_transfer
> even if dwc3_send_gadget_ep_cmd fails. It can cause some problems like
> skipping clear stall commmand or giveback from dequeue. We fix to set it
> only when ep cmd success. Additionally, We clear DWC3_EP_TRANSFER_STARTED
> for next trb to start transfer not update transfer.
> 
> Change-Id: I2e6b58acc99f385e467e8b639a3792a5e5f4d2bb
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> ---
>  drivers/usb/dwc3/gadget.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 183b90923f51..3ad3bc5813ca 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2044,6 +2044,12 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
>  				dwc3_gadget_move_cancelled_request(r,
>  						DWC3_REQUEST_STATUS_DEQUEUED);
>  
> +			/* If ep cmd fails, then force to giveback cancelled requests here */
> +			if (!(dep->flags & DWC3_EP_END_TRANSFER_PENDING)) {
> +				dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
> +				dwc3_gadget_ep_cleanup_cancelled_requests(dep);
> +			}
> +
What I realized when looking at the endxfer command fail due to TIMEOUT,
was that it would lead to subsequent controller halt failures as well
(during pullup disable case).  It might not be safe to forcefully unmap
the request buffers if the controller may still be "working" on it.

I found some interesting quirks with regards to endxfer timeouts as
well, which I'm trying to get some more feedback on [1].  What is the
end issue being seen that requires this change? (we may have run into
the same issue as well.

[1] -
https://lore.kernel.org/linux-usb/20220203080017.27339-1-quic_wcheng@quicinc.com/

Thanks
Wesley Cheng
>  			dep->flags &= ~DWC3_EP_WAIT_TRANSFER_COMPLETE;
>  
>  			goto out;
> @@ -3645,7 +3651,7 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
>  
>  	if (!interrupt)
>  		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
> -	else
> +	else if (!ret)
>  		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
>  }
>  
