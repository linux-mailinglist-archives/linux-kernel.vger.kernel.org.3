Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB43549697E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 03:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbiAVCy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 21:54:56 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:51395 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232051AbiAVCyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 21:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642820095; x=1674356095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JB9i5H3tFBG395GywvZdTOH3c894tyXtUaA5Eai+RP4=;
  b=KRG+kdK3dSWkUG5bf/liaLdLFF1Cgu0YzPHFCMxA8mwD9TTSpBjB/hsi
   +GnEPKNJqZ9/Z40F0PNudliaTqZy+UUyLrT3J2s74T9+oWLH/n1jmTzLF
   GPVPEL+b47CCEvfHH//Nt1ETE10P2BCPLMEz5NYwrnkf/y5fsPApBTg8r
   0=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Jan 2022 18:54:55 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 18:54:54 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 21 Jan 2022 18:54:54 -0800
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 21 Jan 2022 18:54:52 -0800
Date:   Sat, 22 Jan 2022 08:24:48 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: f_sourcesink: Fix isoc transfer for
 USB_SPEED_SUPER_PLUS
Message-ID: <20220122025448.GD11385@hu-pkondeti-hyd.qualcomm.com>
References: <1642764684-26060-1-git-send-email-quic_pkondeti@quicinc.com>
 <YerMjGG8VQkI85bB@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YerMjGG8VQkI85bB@rowland.harvard.edu>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Fri, Jan 21, 2022 at 10:09:00AM -0500, Alan Stern wrote:
> On Fri, Jan 21, 2022 at 05:01:24PM +0530, Pavankumar Kondeti wrote:
> > Currently when gadget enumerates in super speed plus, the isoc
> > endpoint request buffer size is not calculated correctly. Fix
> > this by checking the gadget speed against USB_SPEED_SUPER_PLUS
> > and update the request buffer size.
> > 
> > Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> > ---
> >  drivers/usb/gadget/function/f_sourcesink.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/usb/gadget/function/f_sourcesink.c b/drivers/usb/gadget/function/f_sourcesink.c
> > index 1abf08e..0a423ba 100644
> > --- a/drivers/usb/gadget/function/f_sourcesink.c
> > +++ b/drivers/usb/gadget/function/f_sourcesink.c
> > @@ -584,6 +584,8 @@ static int source_sink_start_ep(struct f_sourcesink *ss, bool is_in,
> >  
> >  	if (is_iso) {
> >  		switch (speed) {
> > +		case USB_SPEED_SUPER_PLUS:
> > +			fallthrough;
> 
> There's no need for this "fallthough" line.  You're allowed to have 
> multiple case labels for a single block of code.
> 
Thanks for the review. I will incorporate your suggestion in v2.

Thanks,
Pavan
