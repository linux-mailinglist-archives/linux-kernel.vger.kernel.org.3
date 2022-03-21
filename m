Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4101C4E2096
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 07:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344583AbiCUGXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 02:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238029AbiCUGXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 02:23:21 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3397B6E5F;
        Sun, 20 Mar 2022 23:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647843716; x=1679379716;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=+rkB4KEmfi5Lh7xQbC1EST+XQiej4N3zvxLPT5tm5cQ=;
  b=w+TogDmd2V/9F3+onYGuyyHd7lSbbv+r5rTnsWX6RtbNRrws1A0e0uKo
   MQM4uHV6X+13wmrQ5jTUdIQzaZIra6tdXEaCw1xA1kqFp1riMIcfzH0EL
   ijOLJgEFKgOPSv3TKUdm1r5xQoTVEWY/nq1kquLBRHCrJXEvdEsuNK7pP
   M=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 Mar 2022 23:21:56 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 23:21:55 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 20 Mar 2022 23:21:55 -0700
Received: from [10.216.8.69] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 20 Mar
 2022 23:21:50 -0700
Subject: Re: [PATCH v2 0/3] Refactor xhci quirks and plat private data
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Doug Anderson" <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>
References: <1646130507-26796-1-git-send-email-quic_c_sanm@quicinc.com>
 <ddc86a4f-8d1c-c02c-5600-4fa851568557@quicinc.com>
 <YjR0Ne3BDxxMfrxt@kroah.com>
From:   "Sandeep Maheswaram (Temp)" <quic_c_sanm@quicinc.com>
Message-ID: <b38ddfcc-68c3-d99f-816b-8b9f788aa88a@quicinc.com>
Date:   Mon, 21 Mar 2022 11:51:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <YjR0Ne3BDxxMfrxt@kroah.com>
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

Hi Mathias,

On 3/18/2022 5:29 PM, Greg Kroah-Hartman wrote:
> On Thu, Mar 17, 2022 at 11:17:17AM +0530, Sandeep Maheswaram (Temp) wrote:
>> Hi Greg,
>>
>> On 3/1/2022 3:58 PM, Sandeep Maheswaram wrote:
>>> changes in v2:
>>> Added a PATCH 2/3 to remove unwanted header inclusion.
>>> Fixed minor nitpicks in PATCH 3/3.
>>>
>>> Pavankumar Kondeti (1):
>>>     usb: xhci: refactor quirks and plat private data
>>>
>>> Sandeep Maheswaram (2):
>>>     usb: xhci: Remove unwanted header inclusion
>>>     usb: dwc: host: add xhci_plat_priv quirk XHCI_SKIP_PHY_INIT
>>>
>>>    drivers/usb/cdns3/host.c        |  2 +-
>>>    drivers/usb/dwc3/host.c         | 13 ++++++++
>>>    drivers/usb/host/xhci-plat.c    |  3 +-
>>>    drivers/usb/host/xhci-plat.h    | 24 ---------------
>>>    drivers/usb/host/xhci-rcar.c    |  3 +-
>>>    drivers/usb/host/xhci.h         | 60 ++++--------------------------------
>>>    include/linux/usb/xhci-plat.h   | 24 +++++++++++++++
>>>    include/linux/usb/xhci-quirks.h | 67 +++++++++++++++++++++++++++++++++++++++++
>>>    8 files changed, 115 insertions(+), 81 deletions(-)
>>>    delete mode 100644 drivers/usb/host/xhci-plat.h
>>>    create mode 100644 include/linux/usb/xhci-plat.h
>>>    create mode 100644 include/linux/usb/xhci-quirks.h
>> Please let me know your opinion about this patch series.
> I need the xhci maintainer to review it...
>
> thanks,
>
> greg k-h


Can you please review this patch series.

Regards

Sandeep

