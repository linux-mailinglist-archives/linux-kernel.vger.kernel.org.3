Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3214B61C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 04:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbiBODih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 22:38:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiBODif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 22:38:35 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87E295A2E;
        Mon, 14 Feb 2022 19:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644896306; x=1676432306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k/UOigYSrO779wbjOBp/W7DmwwybqRpUs2WFG9x/VnM=;
  b=XxLvcv90H74FFrox2qqUqM5Lo5h/qJBKyTvVYTrEqOVIrR2QwhDMeuSZ
   4Fpi3u+oXCTDLW03H5XBAhh61e3OaWpSifIcLJMM+owGcPoZ3HQJbtlQ5
   QXdaScSd3/Uj4DYN7ZvrvTUKBQ/M0hCvupeKtjVrvYkaE+lDfXMCyoCdF
   w=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Feb 2022 19:38:26 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 19:38:26 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Feb 2022 19:38:25 -0800
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 14 Feb 2022 19:38:22 -0800
Date:   Tue, 15 Feb 2022 09:08:18 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
CC:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "Sarah Sharp" <sarah.a.sharp@linux.intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ugoswami@quicinc.com>, Jung Daehwan <dh10.jung@samsung.com>
Subject: Re: [PATCH] xhci: reduce xhci_handshake timeout in xhci_reset
Message-ID: <20220215033818.GD31021@hu-pkondeti-hyd.qualcomm.com>
References: <1644836663-29220-1-git-send-email-quic_pkondeti@quicinc.com>
 <766b6370-979e-cd3c-cb64-44abce1977d7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <766b6370-979e-cd3c-cb64-44abce1977d7@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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

On Mon, Feb 14, 2022 at 06:45:30PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 2/14/22 2:04 PM, Pavankumar Kondeti wrote:
> 
> > From: Daehwan Jung <dh10.jung@samsung.com>
> > 
> > xhci_reset() is called with interrupts disabled. Waiting 10 seconds for
> > controller reset and controller ready operations can be fatal to the
> > system when controller is timed out. Reduce the timeout to 1 second
> > and print a error message when the time out happens.
> 
>    Waiting 1 second with IRQs diabled is also hardly acceptable. :-/
> 

Thanks for making this point clear.

Having debugged several performance issue related to preemption and irqs
disabled, I can't agree more. We had to chase down the code that disable
scheduling for more than 2-3 msec in our downstream kernels on a mobile
SoC.

However in this case, we run into timeout very very rarely in which case
10 sec timeout is causing system hang like symptops which we want to avoid.

Thanks,
Pavan
