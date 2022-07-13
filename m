Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4C05735B2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiGMLlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbiGMLlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:41:11 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143251034C1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=8ZCq1iSnvi0O00uuBMOScdqdbc5RwcoliWQLs0MPRVc=; b=Z9D/0
        zOzvVLXlw6ceawn/Xw117z0+LKbgtLfyrEvGdT6jyR8dShVBR+WgO+uUDpbj6SVT7ZeUTxVJi4E8V
        87giNudYKUWDUv0T3dsns+zIc7IAnp80gcZZahgyabAr573IpNnS1OCB/zzcXR9WpbaKrsC9WvZSp
        NvKVmNdCDjUSBl404vNSUsvUOeu6I4U6OY22eCrfe2ny7hyjjWP8T4s279+Sqg7DTeHsDg26FxTq/
        xObn/LVI471dwKJebtiU6b8sR7meDZxCUn87d3r+xakk9LvfOFs/eKlb0sAXF8TjVsDM9CNyF7oup
        7XH/314jjoKDaI9xplhJuxZA9o2tA==;
Received: from dougal.metanate.com ([192.168.88.1] helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1oBaji-00075W-1G;
        Wed, 13 Jul 2022 12:40:59 +0100
Date:   Wed, 13 Jul 2022 12:40:53 +0100
From:   John Keeping <john@metanate.com>
To:     Jack Pham <quic_jackp@quicinc.com>
Cc:     Wesley Cheng <quic_wcheng@quicinc.com>, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Thinh.Nguyen@synopsys.com
Subject: Re: [PATCH v2 5/5] usb: dwc3: gadget: Increase DWC3 controller halt
 timeout
Message-ID: <Ys6vReAwrYbEavob@donbot>
References: <20220713003523.29309-1-quic_wcheng@quicinc.com>
 <20220713003523.29309-6-quic_wcheng@quicinc.com>
 <20220713025643.GC8200@jackp-linux.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713025643.GC8200@jackp-linux.qualcomm.com>
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 07:56:43PM -0700, Jack Pham wrote:
> Hi Wesley,
> 
> On Tue, Jul 12, 2022 at 05:35:23PM -0700, Wesley Cheng wrote:
> > Since EP0 transactions need to be completed before the controller halt
> > sequence is finished, this may take some time depending on the host and the
> > enabled functions.  Increase the controller halt timeout, so that we give
> > the controller sufficient time to handle EP0 transfers.
> > 
> > Fixes: 861c010a2ee1 ("usb: dwc3: gadget: Refactor pullup()")
> > Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> > Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> > ---
> > Link:
> >   https://lore.kernel.org/linux-usb/4988ed34-04a4-060a-ccef-f57790f76a2b@synopsys.com/
> > 
> >  drivers/usb/dwc3/gadget.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index 41b7007358de..e32d7293c447 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -2476,6 +2476,7 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
> >  	dwc3_gadget_dctl_write_safe(dwc, reg);
> >  
> >  	do {
> > +		msleep(1);
> 
> Be aware that this probably won't sleep for *just* 1ms.  From
> Documentation/timers/timers-howto.rst:
> 
> 	msleep(1~20) may not do what the caller intends, and
> 	will often sleep longer (~20 ms actual sleep for any
> 	value given in the 1~20ms range). In many cases this
> 	is not the desired behavior.
> 
> So with timeout==500 this loop could very well end up iterating for up
> to 10 seconds.  Granted this shouldn't be called from any atomic context
> but just wanted to make sure that the effective increase in timeout as
> $SUBJECT intends is made clear here and that it's not overly generous.
> 
> >  		reg = dwc3_readl(dwc->regs, DWC3_DSTS);
> >  		reg &= DWC3_DSTS_DEVCTRLHLT;
> >  	} while (--timeout && !(!is_on ^ !reg));

Does it make sense to convert this loop to use read_poll_timeout() and
make the timeout explicit, something like:

	ret = read_poll_timeout(dwc3_readl, reg, !(!is_on ^ !(reg & DWC3_DSTS_DEVCTRLHLT)),
				100, timeout * USEC_PER_MSEC, true, dwc->regs, DWC3_DSTS);

?
