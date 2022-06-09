Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCACA544576
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238725AbiFIIP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiFIIPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:15:23 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A2F1CAC1C;
        Thu,  9 Jun 2022 01:15:18 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id B039C61EA1929;
        Thu,  9 Jun 2022 10:15:15 +0200 (CEST)
Message-ID: <1403aa05-19ec-62f7-42a6-8b224574eb1e@molgen.mpg.de>
Date:   Thu, 9 Jun 2022 10:15:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix setup CVSD SCO failure
Content-Language: en-US
To:     Zijun Hu <quic_zijuhu@quicinc.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <1654762252-19603-1-git-send-email-quic_zijuhu@quicinc.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <1654762252-19603-1-git-send-email-quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Zijun,


Thank you for your patch.

Am 09.06.22 um 10:10 schrieb Zijun Hu:

Maybe for the summary:

Bluetooth: Fix CVSD SCO setup failure

> It will setup SCO after all CVSD eSCO attempts failure, but

The verb is spelled with a space: set up

> still fails to setup SCO finally due to wrong D1/D0 @retrans_effort

Ditto.

> within @esco_param_cvsd, so change it from 0x1 to 0xff to avoid
> Invalid HCI Command Parameters error.
> 
> < HCI Command: Setup Synchrono.. (0x01|0x0028) plen 17  #3427
>          Handle: 3
>          Transmit bandwidth: 8000
>          Receive bandwidth: 8000
>          Max latency: 65535
>          Setting: 0x0060
>            Input Coding: Linear
>            Input Data Format: 2's complement
>            Input Sample Size: 16-bit
>            # of bits padding at MSB: 0
>            Air Coding Format: CVSD
>          Retransmission effort: Optimize for power consumption (0x01)
>          Packet type: 0x03c4
>            HV3 may be used
>            2-EV3 may not be used
>            3-EV3 may not be used
>            2-EV5 may not be used
>            3-EV5 may not be used
>> HCI Event: Command Status (0x0f) plen 4               #3428
>        Setup Synchronous Connection (0x01|0x0028) ncmd 1
>          Status: Success (0x00)
>> HCI Event: Synchronous Connect Comp.. (0x2c) plen 17  #3429
>          Status: Invalid HCI Command Parameters (0x12)
>          Handle: 0
>          Address: 14:3F:A6:47:56:15 (OUI 14-3F-A6)
>          Link type: SCO (0x00)
>          Transmission interval: 0x00
>          Retransmission window: 0x00
>          RX packet length: 0
>          TX packet length: 0
>          Air mode: u-law log (0x00)

What is your test setup to reproduce it?

> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>   net/bluetooth/hci_conn.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 7829433d54c1..2627d5ac15d6 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -45,8 +45,8 @@ static const struct sco_param esco_param_cvsd[] = {
>   	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000a,	0x01 }, /* S3 */
>   	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x0007,	0x01 }, /* S2 */
>   	{ EDR_ESCO_MASK | ESCO_EV3,   0x0007,	0x01 }, /* S1 */
> -	{ EDR_ESCO_MASK | ESCO_HV3,   0xffff,	0x01 }, /* D1 */
> -	{ EDR_ESCO_MASK | ESCO_HV1,   0xffff,	0x01 }, /* D0 */
> +	{ EDR_ESCO_MASK | ESCO_HV3,   0xffff,	0xff }, /* D1 */
> +	{ EDR_ESCO_MASK | ESCO_HV1,   0xffff,	0xff }, /* D0 */
>   };
>   
>   static const struct sco_param sco_param_cvsd[] = {


Kind regards,

Paul
