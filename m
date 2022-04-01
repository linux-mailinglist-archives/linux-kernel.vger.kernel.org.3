Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441154EEE1C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346334AbiDAN3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346244AbiDAN3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:29:45 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126AD1E5A76;
        Fri,  1 Apr 2022 06:27:54 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 231BUmw4027845;
        Fri, 1 Apr 2022 15:27:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=ElyEUf9JCJQXOazaKJYNboK1xn5OQrksAiKV8eW767U=;
 b=vhKi4FgQnAF5ptR1H221aD6E3KJYIObp00x0Pttr5CtAjm4l6HdTHieO1xqsbwB03Iz7
 nY/CK5PSy5KwVyf7Mo8XJuWBKBW5z4wyk0CunIZyDiUc0+tc22IYCNrq67g03ESZQFYz
 cWwXkvpejBWz4DdCydUQH02f21cfRRP4niDctS9Hwb/1F1gbt9AWyLlgguRRuG/G25Cc
 xtBYF/TV5K/t2vYK65qzDt0G+uGlXRO8lJ1F0YGNlxN/Y5vb8iK36PRecFtt96tpgE1Z
 7z3EvYzGIlkniZWz2uDXLIRaW1xNAyXqS1WhH0cL9QtYk/MdaUEYw2M/4Ini5hwq4ARV jg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3f5vjk2chu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 15:27:41 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 767DF100034;
        Fri,  1 Apr 2022 15:27:38 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6D1D622D194;
        Fri,  1 Apr 2022 15:27:38 +0200 (CEST)
Received: from [10.211.9.74] (10.75.127.50) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 1 Apr
 2022 15:27:37 +0200
Message-ID: <57c63984-ddf1-6cd7-40a3-aadf9405da5a@foss.st.com>
Date:   Fri, 1 Apr 2022 15:27:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2 2/3] rpmsg: glink: Add support to handle signals
 command
Content-Language: en-US
To:     Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <swboyd@chromium.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
References: <1642534993-6552-1-git-send-email-quic_deesin@quicinc.com>
 <1642534993-6552-3-git-send-email-quic_deesin@quicinc.com>
 <Yiu6guYrKYRhGtei@builder.lan>
 <e59b5d03-0737-56ac-c0af-058799bcb88d@quicinc.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <e59b5d03-0737-56ac-c0af-058799bcb88d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-01_05,2022-03-31_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/23/22 08:20, Deepak Kumar Singh wrote:
> 
> On 3/12/2022 2:39 AM, Bjorn Andersson wrote:
>> On Tue 18 Jan 13:43 CST 2022, Deepak Kumar Singh wrote:
>>
>>> Remote peripherals send signal notifications over glink with
>>> commandID 15.
>>>
>>> Add support to send and receive the signal command and convert the
>>> signals
>>> from NATIVE to TIOCM while receiving and vice versa while sending.
>>>
>>> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
>> Co-developed-by: seems appropriate here, or you need to ensure the
>> author remains Chris, as his S-o-b comes first.
>>
>>> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
>>> ---
>>>   drivers/rpmsg/qcom_glink_native.c | 77
>>> +++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 77 insertions(+)
>>>
>>> diff --git a/drivers/rpmsg/qcom_glink_native.c
>>> b/drivers/rpmsg/qcom_glink_native.c
>>> index 3f377a7..d673d65 100644
>>> --- a/drivers/rpmsg/qcom_glink_native.c
>>> +++ b/drivers/rpmsg/qcom_glink_native.c
>>> @@ -17,6 +17,7 @@
>>>   #include <linux/rpmsg.h>
>>>   #include <linux/sizes.h>
>>>   #include <linux/slab.h>
>>> +#include <linux/termios.h>
>>>   #include <linux/workqueue.h>
>>>   #include <linux/mailbox_client.h>
>>>   @@ -205,9 +206,16 @@ static const struct rpmsg_endpoint_ops
>>> glink_endpoint_ops;
>>>   #define RPM_CMD_TX_DATA_CONT        12
>>>   #define RPM_CMD_READ_NOTIF        13
>>>   #define RPM_CMD_RX_DONE_W_REUSE        14
>>> +#define RPM_CMD_SIGNALS            15
>>>     #define GLINK_FEATURE_INTENTLESS    BIT(1)
>>>   +#define NATIVE_DTR_SIG            BIT(31)
>> Seems reasonable to prefix these with GLINK_, perhaps GLINK_SIGNAL_DTR?
>>
>>> +#define NATIVE_CTS_SIG            BIT(30)
>>> +#define NATIVE_CD_SIG            BIT(29)
>>> +#define NATIVE_RI_SIG            BIT(28)
>>> +#define    SIG_MASK            0x0fff;
>>> +
>>>   static void qcom_glink_rx_done_work(struct work_struct *work);
>>>     static struct glink_channel *qcom_glink_alloc_channel(struct
>>> qcom_glink *glink,
>>> @@ -1003,6 +1011,70 @@ static int qcom_glink_rx_open_ack(struct
>>> qcom_glink *glink, unsigned int lcid)
>>>       return 0;
>>>   }
>>>   +/**
>>> + * qcom_glink_set_flow_control() - convert a signal cmd to wire
>>> format and
>>> + *                    transmit
>>> + * @ept:    Rpmsg endpoint for channel.
>>> + * @enable:    True/False - enable or disable flow control
>> "enable flow control" sounds sufficient (i.e. no need for True/False)
>> part.
>>
>> Regards,
>> Bjorn
> 
> There are some user space clients which require both flow control on and
> off (DTR high/low).
> 
> So i guess true and false both are needed.
> 
>>> + *
>>> + * Return: 0 on success or standard Linux error code.
>>> + */
>>> +static int qcom_glink_set_flow_control(struct rpmsg_endpoint *ept,
>>> bool enable)
>>> +{
>>> +    struct glink_channel *channel = to_glink_channel(ept);
>>> +    struct qcom_glink *glink = channel->glink;
>>> +    struct glink_msg msg;
>>> +    u32 sigs;
>>> +
>>> +    /**
>>> +     * convert signals from TIOCM to NATIVE
>>> +     * sigs = TIOCM_DTR|TIOCM_RTS
>>> +     */
>>> +    if (enable)
>>> +        sigs |= NATIVE_DTR_SIG | NATIVE_CTS_SIG;
>>> +    else
>>> +        sigs |= ~(NATIVE_DTR_SIG | NATIVE_CTS_SIG);
>>> +
>>> +    msg.cmd = cpu_to_le16(RPM_CMD_SIGNALS);
>>> +    msg.param1 = cpu_to_le16(channel->lcid);
>>> +    msg.param2 = cpu_to_le32(sigs);
>>> +
>>> +    return qcom_glink_tx(glink, &msg, sizeof(msg), NULL, 0, true);
>>> +}
>>> +
>>> +static int qcom_glink_handle_signals(struct qcom_glink *glink,
>>> +                     unsigned int rcid, unsigned int sigs)
>>> +{
>>> +    struct glink_channel *channel;
>>> +    unsigned long flags;
>>> +
>>> +    spin_lock_irqsave(&glink->idr_lock, flags);
>>> +    channel = idr_find(&glink->rcids, rcid);
>>> +    spin_unlock_irqrestore(&glink->idr_lock, flags);
>>> +    if (!channel) {
>>> +        dev_err(glink->dev, "signal for non-existing channel\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    if (!channel->ept.sig_cb)
>>> +        return 0;
>>> +
>>> +    /* convert signals from NATIVE to TIOCM */
>>> +    if (sigs & NATIVE_DTR_SIG)

Regarding specs seems that DTR is from the DTE (Data Terminal Equipment)
to the DCE (Data Communication Equipement)
NATIVE_DSR_SIG instead?

Regards
Arnaud

>>> +        sigs |= TIOCM_DSR;
>>> +    if (sigs & NATIVE_CTS_SIG)
>>> +        sigs |= TIOCM_CTS;
>>> +    if (sigs & NATIVE_CD_SIG)
>>> +        sigs |= TIOCM_CD;
>>> +    if (sigs & NATIVE_RI_SIG)
>>> +        sigs |= TIOCM_RI;
>>> +    sigs &= SIG_MASK;
>>> +
>>> +    channel->ept.sig_cb(channel->ept.rpdev, channel->ept.priv, sigs);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   static irqreturn_t qcom_glink_native_intr(int irq, void *data)
>>>   {
>>>       struct qcom_glink *glink = data;
>>> @@ -1067,6 +1139,10 @@ static irqreturn_t qcom_glink_native_intr(int
>>> irq, void *data)
>>>               qcom_glink_handle_intent_req_ack(glink, param1, param2);
>>>               qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
>>>               break;
>>> +        case RPM_CMD_SIGNALS:
>>> +            qcom_glink_handle_signals(glink, param1, param2);
>>> +            qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
>>> +            break;
>>>           default:
>>>               dev_err(glink->dev, "unhandled rx cmd: %d\n", cmd);
>>>               ret = -EINVAL;
>>> @@ -1442,6 +1518,7 @@ static const struct rpmsg_endpoint_ops
>>> glink_endpoint_ops = {
>>>       .sendto = qcom_glink_sendto,
>>>       .trysend = qcom_glink_trysend,
>>>       .trysendto = qcom_glink_trysendto,
>>> +    .set_flow_control = qcom_glink_set_flow_control,
>>>   };
>>>     static void qcom_glink_rpdev_release(struct device *dev)
>>> -- 
>>> 2.7.4
>>>
