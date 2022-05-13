Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE40B526814
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382928AbiEMRRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382841AbiEMRQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:16:50 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E003151F;
        Fri, 13 May 2022 10:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652462202; x=1683998202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7nm5TRFRy85NQvtvvV0a7q247xXcbsARH8DrHwDqsXE=;
  b=x92jauHVU0H79JI8/Xp2pV27iJa1B67TZoFzrj6/qW8meR2vNNr3zANY
   C6+fWQWheDzB9rjHbdB3d8b4ky/hSAyFsuGh1qJJJn57scFntfW4DfzB+
   kNC8B/14Hckvabzy7CJkpLOqT5bk8P3ffqPagpF0ENuaOf38ik4sIZx9F
   w=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 May 2022 10:16:41 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 10:16:41 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 13 May 2022 10:16:40 -0700
Received: from jackp-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 13 May 2022 10:16:39 -0700
Date:   Fri, 13 May 2022 10:16:38 -0700
From:   Jack Pham <quic_jackp@quicinc.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Albert Wang <albertccwang@google.com>, <balbi@kernel.org>,
        <badhri@google.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] usb: dwc3: gadget: Move null pinter check after
 window closed
Message-ID: <20220513171638.GC5637@jackp-linux.qualcomm.com>
References: <20220513065709.1606634-1-albertccwang@google.com>
 <Yn4E0XHlsPjaEgMw@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yn4E0XHlsPjaEgMw@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

On Fri, May 13, 2022 at 09:12:17AM +0200, Greg KH wrote:
> On Fri, May 13, 2022 at 02:57:09PM +0800, Albert Wang wrote:
> > After inspecting further, we do see the locking is implicit, with the
> > main gotcha being the unlock/re-lock.
> 
> This sentance makes no sense at all.
> 
> Who is "we"?  What is the gotcha?  What is the subject of the sentance?
> What is going on?
> 
> > That creates a window for a race to happen.
> 
> What is "that"?
> 
> > This change moves the NULL check to be adjacent to where
> > to it's used and after the window is "closed".
> 
> What is "this"?
> 
> Please read Documentation/process/submitting-patches.rst for how to
> properly write a changelog text so that others can understand what is
> going on.

Albert, it looks like you took my reply comments verbatim.  These were
in context to questions Greg asked about locking or apparent lack
thereof.  But on their own they really don't make sense as Greg poitns
out.  Could you please write up the text (in your own words) in a way
that would be clear to a person seeing this patch for the first time?

Jack

> > Fixes: 26288448120b ("usb: dwc3: gadget: Fix null pointer exception")
> > Signed-off-by: Albert Wang <albertccwang@google.com>
> > ---
> >  v3: Add change log to be compliant with the canonical patch format
> >  v2: Remove redundant 'else' and add additional comments and more
> >      descriptive commit text
> > 
> >  drivers/usb/dwc3/gadget.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index 19477f4bbf54..fda58951cf27 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -3366,14 +3366,19 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
> >  	struct dwc3		*dwc = dep->dwc;
> >  	bool			no_started_trb = true;
> >  
> > -	if (!dep->endpoint.desc)
> > -		return no_started_trb;
> > -
> > +	/*
> > +	 * This function eventually leads to dwc3_giveback() which unlocks
> > +	 * the dwc->lock and relocks afterwards. This actually creates a
> > +	 * a window for a race to happen.
> 
> What race?  Why mention it here?  Why not fix it instead of documenting
> it?
> 
> this comment does not make sense, sorry.
> 
> thanks,
> 
> greg k-h
