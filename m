Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F685544672
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242148AbiFIIuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbiFIIuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:50:40 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9352945D3;
        Thu,  9 Jun 2022 01:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654764461; x=1686300461;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jwiDmz5pKMi/E7+NzTlVzvRpVv2gzJ5DrLPjuQhFOQA=;
  b=qhaSypqtE/2wMW7FnQeX9RBPm2gatgE2CTuFsvlrQmr078Y7CO3CyWSH
   K70Pas5AwkdlK0zPBbn41meGRi5fJH/j+NhnQpqJTZ27WZQH7MTgROsNw
   LvD8Pe/L4JU87dvmlJ4eoK04cxeSl8U7mQFwnQ8YDZ1gYWOp+ui0RNknF
   8=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 09 Jun 2022 01:47:40 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 01:47:40 -0700
Received: from [10.253.77.106] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 9 Jun 2022
 01:47:38 -0700
Message-ID: <600aa8db-6cfd-0e62-7936-e14c4a8c70ed@quicinc.com>
Date:   Thu, 9 Jun 2022 16:47:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix setup CVSD SCO failure
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <1654762252-19603-1-git-send-email-quic_zijuhu@quicinc.com>
 <1403aa05-19ec-62f7-42a6-8b224574eb1e@molgen.mpg.de>
From:   quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <1403aa05-19ec-62f7-42a6-8b224574eb1e@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/2022 4:15 PM, Paul Menzel wrote:
> Dear Zijun,
> 
> 
> Thank you for your patch.
> 
> Am 09.06.22 um 10:10 schrieb Zijun Hu:
> 
> Maybe for the summary:
> 
> Bluetooth: Fix CVSD SCO setup failure
> 
>> It will setup SCO after all CVSD eSCO attempts failure, but
> 
will correct it within v2 patch
> The verb is spelled with a space: set up
> 
>> still fails to setup SCO finally due to wrong D1/D0 @retrans_effort
> 
> Ditto.
> 
see above reply
>> within @esco_param_cvsd, so change it from 0x1 to 0xff to avoid
>> Invalid HCI Command Parameters error.
>>
>> < HCI Command: Setup Synchrono.. (0x01|0x0028) plen 17  #3427
>>          Handle: 3
>>          Transmit bandwidth: 8000
>>          Receive bandwidth: 8000
>>          Max latency: 65535
>>          Setting: 0x0060
>>            Input Coding: Linear
>>            Input Data Format: 2's complement
>>            Input Sample Size: 16-bit
>>            # of bits padding at MSB: 0
>>            Air Coding Format: CVSD
>>          Retransmission effort: Optimize for power consumption (0x01)
>>          Packet type: 0x03c4
>>            HV3 may be used
>>            2-EV3 may not be used
>>            3-EV3 may not be used
>>            2-EV5 may not be used
>>            3-EV5 may not be used
>>> HCI Event: Command Status (0x0f) plen 4               #3428
>>        Setup Synchronous Connection (0x01|0x0028) ncmd 1
>>          Status: Success (0x00)
>>> HCI Event: Synchronous Connect Comp.. (0x2c) plen 17  #3429
>>          Status: Invalid HCI Command Parameters (0x12)
>>          Handle: 0
>>          Address: 14:3F:A6:47:56:15 (OUI 14-3F-A6)
>>          Link type: SCO (0x00)
>>          Transmission interval: 0x00
>>          Retransmission window: 0x00
>>          RX packet length: 0
>>          TX packet length: 0
>>          Air mode: u-law log (0x00)
> 
> What is your test setup to reproduce it?
> 
this issue is reported by our tester.
this issue only happens with some kinds of headsets which says it support eSCO but seems no actually.
it can be reproduced by UBUNTU BT settings UI

D1/D0 @retrans_effort within @esco_param_cvsd are wrong compared with present below definition：
static const struct sco_param sco_param_cvsd[] = {
	{ EDR_ESCO_MASK | ESCO_HV3,   0xffff,	0xff }, /* D1 */
	{ EDR_ESCO_MASK | ESCO_HV1,   0xffff,	0xff }, /* D0 */
};

additionally, based on BT core spec：
0x00 No retransmissions (SCO or eSCO connection allowed)
0x01 At least one retransmission, optimize for power consumption (eSCO connection required).
0x02 At least one retransmission, optimize for link quality (eSCO connection
required)
0xFF Don’t care (SCO or eSCO connection allowed)
All other values Reserved for future use

for SCO, @retrans_effort is 0x00 or 0xff, must not be 0x01.
thanks

>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>   net/bluetooth/hci_conn.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>> index 7829433d54c1..2627d5ac15d6 100644
>> --- a/net/bluetooth/hci_conn.c
>> +++ b/net/bluetooth/hci_conn.c
>> @@ -45,8 +45,8 @@ static const struct sco_param esco_param_cvsd[] = {
>>       { EDR_ESCO_MASK & ~ESCO_2EV3, 0x000a,    0x01 }, /* S3 */
>>       { EDR_ESCO_MASK & ~ESCO_2EV3, 0x0007,    0x01 }, /* S2 */
>>       { EDR_ESCO_MASK | ESCO_EV3,   0x0007,    0x01 }, /* S1 */
>> -    { EDR_ESCO_MASK | ESCO_HV3,   0xffff,    0x01 }, /* D1 */
>> -    { EDR_ESCO_MASK | ESCO_HV1,   0xffff,    0x01 }, /* D0 */
>> +    { EDR_ESCO_MASK | ESCO_HV3,   0xffff,    0xff }, /* D1 */
>> +    { EDR_ESCO_MASK | ESCO_HV1,   0xffff,    0xff }, /* D0 */
>>   };
>>     static const struct sco_param sco_param_cvsd[] = {
> 
> 
> Kind regards,
> 
> Paul

