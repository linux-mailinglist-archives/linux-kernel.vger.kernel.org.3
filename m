Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E314C0B52
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 06:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiBWFAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 00:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiBWFAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 00:00:46 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDB060CC3;
        Tue, 22 Feb 2022 21:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645592419; x=1677128419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XE2uJRgDNx1OqsKYkWTFHuk32gD01FUaPfvkpmgVI78=;
  b=ggDz6njMq/Fiid8b+k1K8Wd8trrkLHt/aiVxU1imIrk3cx/y+VSTIygV
   2ng7E1WyxAIU8Yd2VZD8ed6bgzHFVzuDdhSuGOv99vbEs8Hq1pY/YVUxW
   FaB+VLs6uspL8sAWCr4erX4hYV2xUok4Z5PKt+82J0gYI8KoPg/4c7lSJ
   A=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Feb 2022 21:00:19 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 21:00:18 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 22 Feb 2022 21:00:17 -0800
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 22 Feb 2022 21:00:14 -0800
Date:   Wed, 23 Feb 2022 10:30:10 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Daehwan Jung <dh10.jung@samsung.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: usb: gadget: rndis: add spinlock for rndis response list
Message-ID: <20220223050010.GA20891@hu-pkondeti-hyd.qualcomm.com>
References: <CGME20220222053200epcas2p4eddfc8f1083a9d998456164259004b36@epcas2p4.samsung.com>
 <1645507768-77687-1-git-send-email-dh10.jung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1645507768-77687-1-git-send-email-dh10.jung@samsung.com>
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

On Tue, Feb 22, 2022 at 02:29:28PM +0900, Daehwan Jung wrote:
> There's no lock for rndis response list. It could cause list corruption
> if there're two different list_add at the same time like below.
> It's better to add in rndis_add_response / rndis_free_response
> / rndis_get_next_response to prevent any race condition on response list.
> 
> [  361.894299] [1:   irq/191-dwc3:16979] list_add corruption.
> next->prev should be prev (ffffff80651764d0),
> but was ffffff883dc36f80. (next=ffffff80651764d0).
> 
> [  361.904380] [1:   irq/191-dwc3:16979] Call trace:
> [  361.904391] [1:   irq/191-dwc3:16979]  __list_add_valid+0x74/0x90
> [  361.904401] [1:   irq/191-dwc3:16979]  rndis_msg_parser+0x168/0x8c0
> [  361.904409] [1:   irq/191-dwc3:16979]  rndis_command_complete+0x24/0x84
> [  361.904417] [1:   irq/191-dwc3:16979]  usb_gadget_giveback_request+0x20/0xe4
> [  361.904426] [1:   irq/191-dwc3:16979]  dwc3_gadget_giveback+0x44/0x60
> [  361.904434] [1:   irq/191-dwc3:16979]  dwc3_ep0_complete_data+0x1e8/0x3a0
> [  361.904442] [1:   irq/191-dwc3:16979]  dwc3_ep0_interrupt+0x29c/0x3dc
> [  361.904450] [1:   irq/191-dwc3:16979]  dwc3_process_event_entry+0x78/0x6cc
> [  361.904457] [1:   irq/191-dwc3:16979]  dwc3_process_event_buf+0xa0/0x1ec
> [  361.904465] [1:   irq/191-dwc3:16979]  dwc3_thread_interrupt+0x34/0x5c
> 

This is just one context. what about the other contexts? Interested to see the
different contexts under which this list is being manipulated. From the
f_rndis perspective, this  list is touched from setup and disconnect
callbacks. so are those two contexts not serialized from the UDC? not saying
we don't need lock, but would be good to record that information in the change
log.

> Fixes: f6281af9d62e ("usb: gadget: rndis: use list_for_each_entry_safe")
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> ---
>  drivers/usb/gadget/function/rndis.c | 8 ++++++++
>  drivers/usb/gadget/function/rndis.h | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/rndis.c b/drivers/usb/gadget/function/rndis.c
> index 431d5a7..79fd994 100644
> --- a/drivers/usb/gadget/function/rndis.c
> +++ b/drivers/usb/gadget/function/rndis.c
> @@ -919,6 +919,7 @@ struct rndis_params *rndis_register(void (*resp_avail)(void *v), void *v)
>  	params->resp_avail = resp_avail;
>  	params->v = v;
>  	INIT_LIST_HEAD(&params->resp_queue);
> +	spin_lock_init(&params->resp_lock);
>  	pr_debug("%s: configNr = %d\n", __func__, i);
>  
>  	return params;
> @@ -1012,12 +1013,14 @@ void rndis_free_response(struct rndis_params *params, u8 *buf)
>  {
>  	rndis_resp_t *r, *n;
>  
> +	spin_lock(&params->resp_lock);
>  	list_for_each_entry_safe(r, n, &params->resp_queue, list) {
>  		if (r->buf == buf) {
>  			list_del(&r->list);
>  			kfree(r);
>  		}
>  	}
> +	spin_unlock(&params->resp_lock);
>  }
>  EXPORT_SYMBOL_GPL(rndis_free_response);

Are you sure that this lock is not acquired from any interrupt context from
other contexts? Also would it be true for all UDC? some UDC may call setup
from hadirq context and disconnect in process context etc or vice versa. we
don't want to acquire lock without disabling interrupts in that case.

Thanks,
Pavan
