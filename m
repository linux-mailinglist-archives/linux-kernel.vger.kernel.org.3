Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED51497893
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 06:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241024AbiAXF2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 00:28:14 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:42789 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240794AbiAXF2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 00:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643002089; x=1674538089;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nq++dEOUvOPQNL9JX+JAyJ8bodZJyUToDpB6A9Q7Iks=;
  b=Dvy7ppxbGSroGQlBKz9zYhH1O+p+FEJU01mFELbx1UXQ1bk9BfFR7Tg6
   BiExvIQ6FSUBPXbtusbqOur1a7mftSorh9j1fMSx4CFfPNQ5lJTcJShTU
   85Bku9/v7VrbAd7NyVFmS5JCDDErqvFAm7dolzoVQCtgkjAKmhK2n+7fr
   c=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Jan 2022 21:28:08 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 21:28:07 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 23 Jan 2022 21:28:07 -0800
Received: from [10.216.10.243] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sun, 23 Jan
 2022 21:28:02 -0800
Message-ID: <eaca1146-666d-2b1f-637d-7a5f3e2ad989@quicinc.com>
Date:   Mon, 24 Jan 2022 10:57:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 2/6] usb: dwc3: core: Host wake up support from system
 suspend
Content-Language: en-US
To:     Jun Li <lijun.kernel@gmail.com>, Li Jun <jun.li@nxp.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-arm-msm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>
References: <1642398248-21753-1-git-send-email-quic_c_sanm@quicinc.com>
 <1642398248-21753-3-git-send-email-quic_c_sanm@quicinc.com>
 <CAKgpwJUpMZTUKRbuWye8Qxjw6odqTS=ZLFLnPfunc=iA79ckew@mail.gmail.com>
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
In-Reply-To: <CAKgpwJUpMZTUKRbuWye8Qxjw6odqTS=ZLFLnPfunc=iA79ckew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/18/2022 2:27 PM, Jun Li wrote:
> Sandeep Maheswaram <quic_c_sanm@quicinc.com> 于2022年1月17日周一 22:03写道：
>> Avoiding phy powerdown when wakeup capable devices are connected
>> by checking wakeup property of xhci plat device.
>> Phy should be on to wake up the device from suspend using wakeup capable
>> devices such as keyboard and mouse.
>>
>> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>> Tested-by: Brian Norris <briannorris@chromium.org>
>> ---
>> Remove redundant else part in dwc3_resume_common. This will not be
>> required if GDSC is always on during suspend/resume.
>>
>>
>>   drivers/usb/dwc3/core.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index f4c0995..e7a5e3f 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -1789,7 +1789,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>>                  dwc3_core_exit(dwc);
>>                  break;
>>          case DWC3_GCTL_PRTCAP_HOST:
>> -               if (!PMSG_IS_AUTO(msg)) {
>> +               if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(&dwc->xhci->dev)) {
>>                          dwc3_core_exit(dwc);
>>                          break;
>>                  }
>> @@ -1850,7 +1850,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
>>                  spin_unlock_irqrestore(&dwc->lock, flags);
>>                  break;
>>          case DWC3_GCTL_PRTCAP_HOST:
>> -               if (!PMSG_IS_AUTO(msg)) {
>> +               if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(&dwc->xhci->dev)) {
> If XHCI_SKIP_PHY_INIT is not set, I see the usb core will help to
> handle phy power on/off and init/exit via drivers/usb/core/phy.c, so
> if the wakeup is enabled for controller, then finally the phy will not
> be power off/exit. I am wondering if this change is actually required if
> that is the case.
>
> Sorry for the late comment.
>
> Li Jun
>
The patch is to avoid phy power off in case only if some wakeup capable 
devices are connected.

Regarding  XHCI_SKIP_PHY_INIT we are setting  in this patch

https://patchwork.kernel.org/project/linux-arm-msm/patch/1640153383-21036-1-git-send-email-quic_c_sanm@quicinc.com/

>
>>                          ret = dwc3_core_init_for_resume(dwc);
>>                          if (ret)
>>                                  return ret;
>> --
>> 2.7.4
>>
