Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2944B067F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 07:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbiBJGmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 01:42:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbiBJGmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 01:42:00 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECBC10AD;
        Wed,  9 Feb 2022 22:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644475322; x=1676011322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fvee1abFfi+F3OUQ6XwujWZeP2UCx/GT5KX8hazMnzg=;
  b=sK0S+zz5QTbL7CH8nbMosMj97Cif6Cq7rpmzH1UUqC/xWsM5s/DDQFjC
   CSwplmQCVBzT483ihL4+iFjwYcvZ+Q5TK2G0y+9sPPMhKZHBdHQwWCtNq
   C7a4wrhWjOJvZh96RE5H36XxMcfGRreAalqJ2r9VhZ2sdHRkv/2+Qf9HZ
   4=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 09 Feb 2022 22:42:02 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 22:42:01 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 22:42:01 -0800
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 22:41:57 -0800
Date:   Thu, 10 Feb 2022 12:11:53 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>
CC:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>
Subject: Re: [PATCH v5] usb: host: xhci-plat: Set XHCI_SKIP_PHY_INIT quirk
 for DWC3 controller
Message-ID: <20220210064153.GA15114@hu-pkondeti-hyd.qualcomm.com>
References: <1640153383-21036-1-git-send-email-quic_c_sanm@quicinc.com>
 <Ydb79/twbxLDJB8/@kroah.com>
 <d17330f1-d85e-b8c2-9e87-10d109c25abb@quicinc.com>
 <YfE9s06CIv1P3bA/@kroah.com>
 <f45f5952-e31c-5e9d-2560-064199beb29f@quicinc.com>
 <ca306d7c-d816-3cbd-8c65-2c3619739d47@quicinc.com>
 <YgJB6bGm/y7C0oo/@kroah.com>
 <20220209055352.GA22550@hu-pkondeti-hyd.qualcomm.com>
 <d0048456-eb0a-cf91-fc28-f1dda69c1432@quicinc.com>
 <825a62d8-dc09-fed1-7e33-00d2192a91d5@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <825a62d8-dc09-fed1-7e33-00d2192a91d5@quicinc.com>
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

Hi Sandeep,

On Thu, Feb 10, 2022 at 11:18:19AM +0530, Sandeep Maheswaram wrote:
> Hi Pavan,
> 
> On 2/9/2022 11:31 AM, Sandeep Maheswaram wrote:
> >
> >On 2/9/2022 11:23 AM, Pavan Kondeti wrote:
> >>On Tue, Feb 08, 2022 at 11:11:53AM +0100, Greg Kroah-Hartman wrote:
> >>>On Tue, Feb 08, 2022 at 03:34:22PM +0530, Sandeep Maheswaram wrote:
> >>>>Hi Greg,
> >>>>
> >>>>On 1/27/2022 10:28 AM, Sandeep Maheswaram wrote:
> >>>>>On 1/26/2022 5:55 PM, Greg Kroah-Hartman wrote:
> >>>>>>On Fri, Jan 07, 2022 at 10:27:59AM +0530, Sandeep Maheswaram wrote:
> >>>>>>>On 1/6/2022 7:55 PM, Greg Kroah-Hartman wrote:
> >>>>>>>>On Wed, Dec 22, 2021 at 11:39:43AM +0530, Sandeep Maheswaram
> >>>>>>>>wrote:
> >>>>>>>>>Set XHCI_SKIP_PHY_INIT quirk to avoid phy initialization twice.
> >>>>>>>>>Runtime suspend of phy drivers was failing from DWC3
> >>>>>>>>>driver as runtime
> >>>>>>>>>usage value is 2 because the phy is initialized from
> >>>>>>>>>DWC3 and HCD core.
> >>>>>>>>>DWC3 manages phy in their core drivers. Set this quirk to
> >>>>>>>>>avoid phy
> >>>>>>>>>initialization in HCD core.
> >>>>>>>>>
> >>>>>>>>>Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> >>>>>>>>>---
> >>>>>>>>>v5:
> >>>>>>>>>Added comment to explain the change done.
> >>>>>>>>>v4:
> >>>>>>>>>Changed pdev->dev.parent->of_node to sysdev->of_node
> >>>>>>>>>
> >>>>>>>>>    drivers/usb/host/xhci-plat.c | 8 ++++++++
> >>>>>>>>>    1 file changed, 8 insertions(+)
> >>>>>>>>>
> >>>>>>>>>diff --git a/drivers/usb/host/xhci-plat.c
> >>>>>>>>>b/drivers/usb/host/xhci-plat.c
> >>>>>>>>>index c1edcc9..e6014d4 100644
> >>>>>>>>>--- a/drivers/usb/host/xhci-plat.c
> >>>>>>>>>+++ b/drivers/usb/host/xhci-plat.c
> >>>>>>>>>@@ -327,6 +327,14 @@ static int xhci_plat_probe(struct
> >>>>>>>>>platform_device *pdev)
> >>>>>>>>>&xhci->imod_interval);
> >>>>>>>>>        }
> >>>>>>>>>+    /*
> >>>>>>>>>+     * Set XHCI_SKIP_PHY_INIT quirk to avoid phy
> >>>>>>>>>initialization twice.
> >>>>>>>>>+     * DWC3 manages phy in their core drivers. Set this
> >>>>>>>>>quirk to avoid phy
> >>>>>>>>>+     * initialization in HCD core.
> >>>>>>>>>+     */
> >>>>>>>>>+    if (of_device_is_compatible(sysdev->of_node, "snps,dwc3"))
> >>>>>>>>>+        xhci->quirks |= XHCI_SKIP_PHY_INIT;
> >>>>>>>>>+
> >>>>>>>>Why is this function caring about dwc3 stuff? Shoudn't this be a
> >>>>>>>>"generic" device property instead of this device-specific one?
> >>>>>>>>
> >>>>>>>>thanks,
> >>>>>>>>
> >>>>>>>>greg k-h
> >>>>>>>This quirk is set only if required for some controllers (eg:
> >>>>>>>dwc3 & cdns3).
> >>>>>>>
> >>>>>>>Please check below commit.
> >>>>>>>
> >>>>>>>https://lore.kernel.org/all/20200918131752.16488-5-mathias.nyman@linux.intel.com/
> >>>>>>>
> >>>>>>>
> >>>>>>That commit has nothing to do with a specific "dwc3" quirk anywhere.
> >>>>>>Why not set this flag in the specific platform xhci driver
> >>>>>>instead where
> >>>>>>it belongs?
> >>>>>>
> >>>>>>thanks,
> >>>>>>
> >>>>>>greg k-h
> >>>>>There is no specific xhci platform driver for dwc3 controllers.
> >>>>>
> >>>>>dwc3 controllers use xhci-plat driver .
> >>>>>
> >>>>>We can add this quirk in usb/dwc3/host.c as cdns3 does but that
> >>>>>requires
> >>>>>tying dwc3 and xhci driver .
> >>>>>
> >>>>>https://patchwork.kernel.org/project/linux-arm-msm/patch/1633946518-13906-1-git-send-email-sanm@codeaurora.org/
> >>>>>
> >>>>>
> >>>>>
> >>>>>Regards
> >>>>>
> >>>>>Sandeep
> >>>>>
> >>>>>
> >>>>Can you suggest any other method to set this quirk for dwc3
> >>>>controllers.
> >>>No idea, sorry.
> >>Sandeep,
> >>
> >>I agree with Greg's comments here. The compatible based check to detect
> >>dwc3
> >>controller is not elegant. Your proposal of adding a device tree param
> >>is
> >>overkill, I believe.
> >>
> >>Greg already gave us a pointer here [1] which I feel is the best
> >>approach going
> >>forward. We know that xhci-plat is being used by drivers like dwc3,
> >>cdns3 and
> >>these drivers need to expose their xhci quirks. As Greg suggested, why
> >>can't
> >>we move xhci quirks definition to include/linux/usb/xhci-quriks.h and
> >>directly
> >>access from the glue drivers? The attached is the patch (completely
> >>untested)
> >>for your reference. It will prepare the setup for you to add the private
> >>data
> >>and quirks in the dwc3 host glue driver.
> >>
> >>Thanks,
> >>Pavan
> >>
> >>[1]
> >>https://patchwork.kernel.org/project/linux-arm-msm/patch/1633946518-13906-1-git-send-email-sanm@codeaurora.org/
> >>
> >>
> >Thanks Pavan..will test the patch.
> 
> Tested your patch. It is working fine along with the attached changes.
> 

Your patch looks good to me. Feel free to send the two patches together.

Thanks,
Pavan
