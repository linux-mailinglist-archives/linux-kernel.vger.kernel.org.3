Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8542A53797D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbiE3Kzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235528AbiE3Kzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:55:46 -0400
Received: from mail.bitwise.fi (mail.bitwise.fi [109.204.228.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C425548F;
        Mon, 30 May 2022 03:55:45 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.bitwise.fi (Postfix) with ESMTP id C495E460032;
        Mon, 30 May 2022 13:55:43 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from mail.bitwise.fi ([127.0.0.1])
        by localhost (mustetatti.dmz.bitwise.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id K6g75fgke0bD; Mon, 30 May 2022 13:55:41 +0300 (EEST)
Received: from [192.168.5.238] (fw1.dmz.bitwise.fi [192.168.69.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: anssiha)
        by mail.bitwise.fi (Postfix) with ESMTPSA id BC4ED46003F;
        Mon, 30 May 2022 13:55:41 +0300 (EEST)
Message-ID: <7ec86c10-3cef-d806-2e27-c99a12704288@bitwise.fi>
Date:   Mon, 30 May 2022 13:55:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 09/12] can: kvaser_usb_leaf: Fix silently failing bus
 params setup
Content-Language: en-US
To:     Jimmy Assarsson <extja@kvaser.com>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org
References: <20220516134748.3724796-1-anssi.hannula@bitwise.fi>
 <20220516134748.3724796-10-anssi.hannula@bitwise.fi>
 <39946f68-ac16-9412-fd5e-47e10b84ffbf@kvaser.com>
From:   Anssi Hannula <anssi.hannula@bitwise.fi>
In-Reply-To: <39946f68-ac16-9412-fd5e-47e10b84ffbf@kvaser.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.5.2022 10.37, Jimmy Assarsson wrote:
> On 5/16/22 15:47, Anssi Hannula wrote:
>> The device may reject bus params with cmd 45, which is an unhandled
>> error event that does not contain any channel reference.
>>
>> In such cases set_bittiming() callback returns 0 so upper levels will
>> think setting bitrate succeeded and proceed with starting the interface
>> with wrong parameters, causing bus errors (the kernel log will have
>> "Unhandled command (45)", though).
>>
>> Fix that by verifying the bus params took hold by reading them back.
>>
>> Also, add a handler for cmd 45 that simply prints out the error.
>>
>> This condition can be triggered on 0bfd:0124 Kvaser Mini PCI Express
>> 2xHS FW 4.18.778 by trying to set bitrate 1300000 and on 0bfd:0124
>> Kvaser Mini PCI Express 2xHS FW 4.18.778 by trying to set bitrate
>> 1000000.
> The device will send cmd CMD_ERROR_EVENT (45) when invalid data is
> received from the driver and should never occur. CMD_ERROR_EVENT
> indicates a misbehaving driver.
>
> For the Kvaser Mini PCI Express 2xHS case, the problem is settings
> resulting in prescaler equal to 1 are not accepted. This is a bug in the
> firmware and will be fixed in our next release.
>
> And for Kvaser Memorator Professional HS/HS, the can_bittiming_const
> limits are not correct.
> I'll have to look into this a bit more. I'm pretty sure we endup with
> three different can_bittiming_const in kvaser_usb_leaf, depedning on
> firmware/microcontroller.
>
> I created new patches for the CMD_ERROR_EVENT, based on your patch.
> See at end of this mail.
>
> I prefere if we can avoid the paramter readback and
> kvaser_usb_setup_rx_urbs() in kvaser_usb_leaf_set_bittiming().
> With correct can_bittiming_const limits this should not be an issue.
> On the otherhand, since there are existing devices with a bug that will
> reject parameters that are within the correct limits, and the result
> silently failing calls, I cannot see any alternative...
>
> If it ok with you I'll create a new patch based on your readback fix,
> and also implement this in kvaser_usb_hydra?

All OK for me.

-- 
Anssi Hannula / Bitwise Oy
+358 503803997

