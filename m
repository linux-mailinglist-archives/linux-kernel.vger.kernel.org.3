Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33254DBF00
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 07:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiCQGKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 02:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiCQGJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:09:42 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73810FDE27;
        Wed, 16 Mar 2022 22:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647496047; x=1679032047;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=6KoLxshBUSQgrxvXs8rBJCOuvua+PRWtt1ALGtU2HME=;
  b=HzHP9vgaYIFl8WMMD8iNuDaTzi6cZ6Z92SNxYh+IDv2dDQK2oez2bxeU
   ro2VlrAiO2MSJHZYkwBKsFGk8KhZx2k8yZ4I+Ssc1UEGFCmrOx9EMP6eX
   e4X5P/kwjhBKdBb6/xSDlM/tuzE++eQODx8dJXWcywFT5fcq0y01c1PPT
   g=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 16 Mar 2022 22:47:27 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 22:47:26 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 16 Mar 2022 22:47:26 -0700
Received: from [10.216.39.133] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 16 Mar
 2022 22:47:21 -0700
Subject: Re: [PATCH v2 0/3] Refactor xhci quirks and plat private data
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>
References: <1646130507-26796-1-git-send-email-quic_c_sanm@quicinc.com>
From:   "Sandeep Maheswaram (Temp)" <quic_c_sanm@quicinc.com>
Message-ID: <ddc86a4f-8d1c-c02c-5600-4fa851568557@quicinc.com>
Date:   Thu, 17 Mar 2022 11:17:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <1646130507-26796-1-git-send-email-quic_c_sanm@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 3/1/2022 3:58 PM, Sandeep Maheswaram wrote:
> changes in v2:
> Added a PATCH 2/3 to remove unwanted header inclusion.
> Fixed minor nitpicks in PATCH 3/3.
>
> Pavankumar Kondeti (1):
>    usb: xhci: refactor quirks and plat private data
>
> Sandeep Maheswaram (2):
>    usb: xhci: Remove unwanted header inclusion
>    usb: dwc: host: add xhci_plat_priv quirk XHCI_SKIP_PHY_INIT
>
>   drivers/usb/cdns3/host.c        |  2 +-
>   drivers/usb/dwc3/host.c         | 13 ++++++++
>   drivers/usb/host/xhci-plat.c    |  3 +-
>   drivers/usb/host/xhci-plat.h    | 24 ---------------
>   drivers/usb/host/xhci-rcar.c    |  3 +-
>   drivers/usb/host/xhci.h         | 60 ++++--------------------------------
>   include/linux/usb/xhci-plat.h   | 24 +++++++++++++++
>   include/linux/usb/xhci-quirks.h | 67 +++++++++++++++++++++++++++++++++++++++++
>   8 files changed, 115 insertions(+), 81 deletions(-)
>   delete mode 100644 drivers/usb/host/xhci-plat.h
>   create mode 100644 include/linux/usb/xhci-plat.h
>   create mode 100644 include/linux/usb/xhci-quirks.h

Please let me know your opinion about this patch series.

Regards

Sandeep

