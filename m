Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2FB4CC31E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbiCCQpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiCCQpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:45:39 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41EC144F54;
        Thu,  3 Mar 2022 08:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646325894; x=1677861894;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+iDGKFAulchRj34sfVomUgUNOfHoOIb3JB/8WAHfFTs=;
  b=ujoppl2nu8/UyuXESWxwBH4/5C3BHnrW2Lfu+iEqZSl9663N7JWgei5j
   WZaUpaSnyiWy0g9OOhcsD7W+LIOxTmACAFj6N738VolimkTJADvZyX7it
   9atShLyM10aP8o1hU3/hFeqlg11dOzIdhDLTJIxJk3FLHAFQetaCsOvGi
   I=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 03 Mar 2022 08:44:53 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 08:44:53 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 3 Mar 2022 08:44:52 -0800
Received: from [10.111.177.132] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Thu, 3 Mar 2022
 08:44:52 -0800
Message-ID: <7ac0be6d-35f1-cab3-0ab3-c06367a28ed1@quicinc.com>
Date:   Thu, 3 Mar 2022 08:44:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 1/2] mac80211: Add support to trigger sta disconnect on
 hardware restart
Content-Language: en-US
To:     Youghandhar Chintala <youghand@codeaurora.org>,
        <ath10k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pillair@codeaurora.org>, <dianders@chromium.org>,
        <kuabhs@chromium.org>, <briannorris@chromium.org>,
        <mpubbise@codeaurora.org>
References: <20220303115541.15892-1-youghand@codeaurora.org>
 <20220303115541.15892-2-youghand@codeaurora.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220303115541.15892-2-youghand@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
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

On 3/3/2022 3:55 AM, Youghandhar Chintala wrote:
> Currently in case of target hardware restart, we just reconfig and
> re-enable the security keys and enable the network queues to start
> data traffic back from where it was interrupted.
> 
> Many ath10k wifi chipsets have sequence numbers for the data
> packets assigned by firmware and the mac sequence number will
> restart from zero after target hardware restart leading to mismatch
> in the sequence number expected by the remote peer vs the sequence
> number of the frame sent by the target firmware.
> 
> This mismatch in sequence number will cause out-of-order packets
> on the remote peer and all the frames sent by the device are dropped
> until we reach the sequence number which was sent before we restarted
> the target hardware
> 
> In order to fix this, we trigger a sta disconnect, in case of target
> hw restart. After this there will be a fresh connection and thereby
> avoiding the dropping of frames by remote peer.
> 
> The right fix would be to pull the entire data path into the host
> which is not feasible or would need lots of complex changes and
> will still be inefficient.
> 
> Tested on ath10k using WCN3990, QCA6174
> 
> Signed-off-by: Youghandhar Chintala <youghand@codeaurora.org>
> ---
>   include/net/mac80211.h     | 11 +++++++++++
>   net/mac80211/ieee80211_i.h |  3 +++
>   net/mac80211/mlme.c        | 12 ++++++++++++
>   net/mac80211/util.c        | 33 ++++++++++++++++++++++++++++++---
>   4 files changed, 56 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index bd6912d0292b..0773c50fa182 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -6064,6 +6064,17 @@ void ieee80211_disconnect(struct ieee80211_vif *vif, bool reconnect);
>    */
>   void ieee80211_resume_disconnect(struct ieee80211_vif *vif);
>   
> +/**
> + * ieee80211_hw_restart_disconnect - disconnect from AP after
> + * hardware  restart

nits:
remove excess space in "hardware  restart"

"Do not leave a blank line between the function description and the 
arguments" per 
<https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#function-documentation>

(I see that there is quite a mixture of compliant and non-compliant 
kernel-doc in this file)
