Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37034BF4A9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiBVJ14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiBVJ1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:27:49 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952CEB0C47;
        Tue, 22 Feb 2022 01:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645522044; x=1677058044;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LFQp/ZxtUokCWlxkpsscjeCoS50+fMvujr/3gkeQpGM=;
  b=mFGAVa8g/gQUw/mvB2CQsMC3iKo56IwLVyYU9cYH5jEm9X6y8ik6i7Sr
   Rrw1marApJddHVVAqMlmkp3fQOOM/DxFIvC8OtBrwIMim1HRrTHBUgxhr
   QtXy8tZKHbhbPLX7pYkJn27ZqsT5mgQ4leVxefqEVed1fSv82IXJDKaQx
   0=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 22 Feb 2022 01:27:24 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 01:27:23 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 22 Feb 2022 01:27:23 -0800
Received: from [10.216.35.124] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Tue, 22 Feb
 2022 01:27:18 -0800
Message-ID: <efd3c978-6d37-a386-4953-758df73e1e1f@quicinc.com>
Date:   Tue, 22 Feb 2022 14:57:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] usb: xhci: refactor quirks and plat private data
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Doug Anderson <dianders@chromium.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Mathias Nyman" <mathias.nyman@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>
References: <1644949454-814-1-git-send-email-quic_c_sanm@quicinc.com>
 <1644949454-814-2-git-send-email-quic_c_sanm@quicinc.com>
 <CAE-0n522ctciYfxCxKqF0p3QFWcZU03nP5HoKsc=uKnokg7BCQ@mail.gmail.com>
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
In-Reply-To: <CAE-0n522ctciYfxCxKqF0p3QFWcZU03nP5HoKsc=uKnokg7BCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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


On 2/16/2022 7:43 AM, Stephen Boyd wrote:
> Quoting Sandeep Maheswaram (2022-02-15 10:24:13)
>> From: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
>>
>> This refactoring allows drivers like dwc3 host glue driver to
>> specify their xhci quirks.
>>
>> Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> Your SoB should be here as well.
okay. Will add in next version.
>
>> diff --git a/include/linux/usb/xhci-plat.h b/include/linux/usb/xhci-plat.h
>> new file mode 100644
>> index 0000000..58a56ae
>> --- /dev/null
>> +++ b/include/linux/usb/xhci-plat.h
>> @@ -0,0 +1,24 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * xhci-plat.h - xHCI host controller driver platform Bus Glue.
>> + *
>> + * Copyright (C) 2015 Renesas Electronics Corporation
>> + */
>> +
>> +#ifndef _XHCI_PLAT_H
>> +#define _XHCI_PLAT_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/usb/hcd.h>
> It would be great to remove this include and forward declare struct
> usb_hcd instead to avoid include hell. Maybe a followup patch?
okay.  Will do in next version.
>> +
>> +struct xhci_plat_priv {
>> +       const char *firmware_name;
>> +       unsigned long long quirks;
>> +       int (*plat_setup)(struct usb_hcd *hcd);
>> +       void (*plat_start)(struct usb_hcd *hcd);
>> +       int (*init_quirk)(struct usb_hcd *hcd);
>> +       int (*suspend_quirk)(struct usb_hcd *hcd);
>> +       int (*resume_quirk)(struct usb_hcd *hcd);
>> +};
>> +
>> +#endif /* _XHCI_PLAT_H */
