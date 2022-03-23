Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA814E4D3D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 08:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242194AbiCWHV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 03:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238750AbiCWHVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:21:51 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B5273055;
        Wed, 23 Mar 2022 00:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648020022; x=1679556022;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tC1t6TOu71irwcRutb9iwhFdSpy/jrZoX5Ena8rSU7w=;
  b=aE57Kdhvn87nFqalUWqhDMEOHrITAcOsl8rYWQvYplFnm2D8pz9WevRd
   8+QLwA39VQvxY1gAS13FMUR/pKu1/vOTKbiJGzullC19ALDUp04tfcuN0
   AgsO1G3DGWlWm2F26STXUgB5iy/o37d/XQ5kNXexU/EHlac9hYrzhjDwQ
   k=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Mar 2022 00:20:22 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 00:20:22 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 00:20:21 -0700
Received: from [10.216.14.227] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 23 Mar
 2022 00:20:17 -0700
Message-ID: <e59b5d03-0737-56ac-c0af-058799bcb88d@quicinc.com>
Date:   Wed, 23 Mar 2022 12:50:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V2 2/3] rpmsg: glink: Add support to handle signals
 command
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <swboyd@chromium.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        "Andy Gross" <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>
References: <1642534993-6552-1-git-send-email-quic_deesin@quicinc.com>
 <1642534993-6552-3-git-send-email-quic_deesin@quicinc.com>
 <Yiu6guYrKYRhGtei@builder.lan>
From:   Deepak Kumar Singh <quic_deesin@quicinc.com>
In-Reply-To: <Yiu6guYrKYRhGtei@builder.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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


On 3/12/2022 2:39 AM, Bjorn Andersson wrote:
> On Tue 18 Jan 13:43 CST 2022, Deepak Kumar Singh wrote:
>
>> Remote peripherals send signal notifications over glink with commandID 15.
>>
>> Add support to send and receive the signal command and convert the signals
>> from NATIVE to TIOCM while receiving and vice versa while sending.
>>
>> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
> Co-developed-by: seems appropriate here, or you need to ensure the
> author remains Chris, as his S-o-b comes first.
>
>> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
>> ---
>>   drivers/rpmsg/qcom_glink_native.c | 77 +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 77 insertions(+)
>>
>> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
>> index 3f377a7..d673d65 100644
>> --- a/drivers/rpmsg/qcom_glink_native.c
>> +++ b/drivers/rpmsg/qcom_glink_native.c
>> @@ -17,6 +17,7 @@
>>   #include <linux/rpmsg.h>
>>   #include <linux/sizes.h>
>>   #include <linux/slab.h>
>> +#include <linux/termios.h>
>>   #include <linux/workqueue.h>
>>   #include <linux/mailbox_client.h>
>>   
>> @@ -205,9 +206,16 @@ static const struct rpmsg_endpoint_ops glink_endpoint_ops;
>>   #define RPM_CMD_TX_DATA_CONT		12
>>   #define RPM_CMD_READ_NOTIF		13
>>   #define RPM_CMD_RX_DONE_W_REUSE		14
>> +#define RPM_CMD_SIGNALS			15
>>   
>>   #define GLINK_FEATURE_INTENTLESS	BIT(1)
>>   
>> +#define NATIVE_DTR_SIG			BIT(31)
> Seems reasonable to prefix these with GLINK_, perhaps GLINK_SIGNAL_DTR?
>
>> +#define NATIVE_CTS_SIG			BIT(30)
>> +#define NATIVE_CD_SIG			BIT(29)
>> +#define NATIVE_RI_SIG			BIT(28)
>> +#define	SIG_MASK			0x0fff;
>> +
>>   static void qcom_glink_rx_done_work(struct work_struct *work);
>>   
>>   static struct glink_channel *qcom_glink_alloc_channel(struct qcom_glink *glink,
>> @@ -1003,6 +1011,70 @@ static int qcom_glink_rx_open_ack(struct qcom_glink *glink, unsigned int lcid)
>>   	return 0;
>>   }
>>   
>> +/**
>> + * qcom_glink_set_flow_control() - convert a signal cmd to wire format and
>> + * 				   transmit
>> + * @ept:	Rpmsg endpoint for channel.
>> + * @enable:	True/False - enable or disable flow control
> "enable flow control" sounds sufficient (i.e. no need for True/False)
> part.
>
> Regards,
> Bjorn

There are some user space clients which require both flow control on and 
off (DTR high/low).

So i guess true and false both are needed.

>> + *
>> + * Return: 0 on success or standard Linux error code.
>> + */
>> +static int qcom_glink_set_flow_control(struct rpmsg_endpoint *ept, bool enable)
>> +{
>> +	struct glink_channel *channel = to_glink_channel(ept);
>> +	struct qcom_glink *glink = channel->glink;
>> +	struct glink_msg msg;
>> +	u32 sigs;
>> +
>> +	/**
>> +	 * convert signals from TIOCM to NATIVE
>> +	 * sigs = TIOCM_DTR|TIOCM_RTS
>> +	 */
>> +	if (enable)
>> +		sigs |= NATIVE_DTR_SIG | NATIVE_CTS_SIG;
>> +	else
>> +		sigs |= ~(NATIVE_DTR_SIG | NATIVE_CTS_SIG);
>> +
>> +	msg.cmd = cpu_to_le16(RPM_CMD_SIGNALS);
>> +	msg.param1 = cpu_to_le16(channel->lcid);
>> +	msg.param2 = cpu_to_le32(sigs);
>> +
>> +	return qcom_glink_tx(glink, &msg, sizeof(msg), NULL, 0, true);
>> +}
>> +
>> +static int qcom_glink_handle_signals(struct qcom_glink *glink,
>> +				     unsigned int rcid, unsigned int sigs)
>> +{
>> +	struct glink_channel *channel;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&glink->idr_lock, flags);
>> +	channel = idr_find(&glink->rcids, rcid);
>> +	spin_unlock_irqrestore(&glink->idr_lock, flags);
>> +	if (!channel) {
>> +		dev_err(glink->dev, "signal for non-existing channel\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!channel->ept.sig_cb)
>> +		return 0;
>> +
>> +	/* convert signals from NATIVE to TIOCM */
>> +	if (sigs & NATIVE_DTR_SIG)
>> +		sigs |= TIOCM_DSR;
>> +	if (sigs & NATIVE_CTS_SIG)
>> +		sigs |= TIOCM_CTS;
>> +	if (sigs & NATIVE_CD_SIG)
>> +		sigs |= TIOCM_CD;
>> +	if (sigs & NATIVE_RI_SIG)
>> +		sigs |= TIOCM_RI;
>> +	sigs &= SIG_MASK;
>> +
>> +	channel->ept.sig_cb(channel->ept.rpdev, channel->ept.priv, sigs);
>> +
>> +	return 0;
>> +}
>> +
>>   static irqreturn_t qcom_glink_native_intr(int irq, void *data)
>>   {
>>   	struct qcom_glink *glink = data;
>> @@ -1067,6 +1139,10 @@ static irqreturn_t qcom_glink_native_intr(int irq, void *data)
>>   			qcom_glink_handle_intent_req_ack(glink, param1, param2);
>>   			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
>>   			break;
>> +		case RPM_CMD_SIGNALS:
>> +			qcom_glink_handle_signals(glink, param1, param2);
>> +			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
>> +			break;
>>   		default:
>>   			dev_err(glink->dev, "unhandled rx cmd: %d\n", cmd);
>>   			ret = -EINVAL;
>> @@ -1442,6 +1518,7 @@ static const struct rpmsg_endpoint_ops glink_endpoint_ops = {
>>   	.sendto = qcom_glink_sendto,
>>   	.trysend = qcom_glink_trysend,
>>   	.trysendto = qcom_glink_trysendto,
>> +	.set_flow_control = qcom_glink_set_flow_control,
>>   };
>>   
>>   static void qcom_glink_rpdev_release(struct device *dev)
>> -- 
>> 2.7.4
>>
