Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6C949F5D4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbiA1JBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:01:04 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:24580 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231745AbiA1JBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:01:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643360461; x=1674896461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S3e5y1COnJGoNRJE23BZTdY32iYtl21gfGAn8hzt754=;
  b=upClQ2MR84eliCywQ7EId+j9DUUWslb7xhBY/YXKuEqKLbcpafc7wIMO
   Zr3KcJz37Ate4CE4P00obxAJMnj+sClly6AMcHV5JYXyS3+Qjt5Uc9vIK
   eP723dIbMjf/2I5WlHxfGwmqtjZ33EoPDFP/rB0p4bdN0ZBvqTL43J5z7
   0=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Jan 2022 01:01:00 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 01:01:00 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 28 Jan 2022 01:00:59 -0800
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 28 Jan 2022 01:00:54 -0800
Date:   Fri, 28 Jan 2022 14:30:50 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Steev Klimaszewski <steev@kali.org>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
CC:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Doug Anderson" <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>
Subject: Re: [PATCH v10 6/6] usb: dwc3: qcom: Enable the interrupts during
 probe
Message-ID: <20220128090050.GB7851@hu-pkondeti-hyd.qualcomm.com>
References: <1642398248-21753-1-git-send-email-quic_c_sanm@quicinc.com>
 <1642398248-21753-7-git-send-email-quic_c_sanm@quicinc.com>
 <93b68251-7e7e-ac92-fb47-346c410744b2@kali.org>
 <20220118095255.GB11385@hu-pkondeti-hyd.qualcomm.com>
 <78c90e46-666b-bc9b-235d-ae4c69e19929@quicinc.com>
 <601cdc74-392f-dd4f-7ea0-8e65c6b6d7e2@quicinc.com>
 <52b37547-3e78-b18c-307d-7eedf5baab0d@kali.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <52b37547-3e78-b18c-307d-7eedf5baab0d@kali.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 02:36:38AM -0600, Steev Klimaszewski wrote:
> Hi Sandeep,
> 
> On 1/25/22 3:17 AM, Sandeep Maheswaram wrote:
> >Hi Steev,
> >
> >>I didn't face any such issue with devices connected.
> >>
> >>I think this is because I used IRQ_TYPE_EDGE_BOTH in device tree and
> >>Steev has IRQ_TYPE_LEVEL_HIGH in his device tree.
> >>
> >>When i changed to IRQ_TYPE_LEVEL_HIGH I also observed a storm of
> >>interrupts in my device though it booted .
> >>
> >>Regards
> >>
> >>Sandeep
> >>
> >Can you try with IRQ_TYPE_EDGE_BOTH in your device tree and see if you are
> >getting the issue.
> >
> >Regards
> >
> >Sandeep
> >
> I just tested here, changing both of the IRQ_TYPE_LEVEL_HIGH in the yoga's
> dts to EDGE_BOTH and I still do not get a booting system.
> 

Sandeep,

For whatever reason, if the interrupt comes immediately after enabling it in
the probe, are we ready to call pm_runtime_resume(&dwc->xhci->dev); ? 

I am not sure if Steev is facing an interrupt storm issue or some kind of
incorrect access and device is crashing. In any case, can you simulate this
and see if we can call the above runtime PM API in dwc->xhci->dev immediately
after enabling the IRQs.

Thanks,
Pavan
