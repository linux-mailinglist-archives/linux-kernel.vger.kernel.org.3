Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD94F53797F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbiE3K4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbiE3K4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:56:45 -0400
Received: from mail.bitwise.fi (mail.bitwise.fi [109.204.228.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9E8111C;
        Mon, 30 May 2022 03:56:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.bitwise.fi (Postfix) with ESMTP id C08FC46003F;
        Mon, 30 May 2022 13:56:42 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from mail.bitwise.fi ([127.0.0.1])
        by localhost (mustetatti.dmz.bitwise.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ffezlduZpJEQ; Mon, 30 May 2022 13:56:40 +0300 (EEST)
Received: from [192.168.5.238] (fw1.dmz.bitwise.fi [192.168.69.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: anssiha)
        by mail.bitwise.fi (Postfix) with ESMTPSA id 95CE5460032;
        Mon, 30 May 2022 13:56:40 +0300 (EEST)
Message-ID: <af065054-50cb-08d7-4eb4-e42530710eb2@bitwise.fi>
Date:   Mon, 30 May 2022 13:56:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 00/12] can: kvaser_usb: Various fixes
Content-Language: en-US
To:     Jimmy Assarsson <extja@kvaser.com>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org
References: <20220516134748.3724796-1-anssi.hannula@bitwise.fi>
 <61060501-7edb-4277-acf6-117161e8593f@kvaser.com>
 <17631d66-7b90-e60b-e3fb-76b25e5eceaa@kvaser.com>
From:   Anssi Hannula <anssi.hannula@bitwise.fi>
In-Reply-To: <17631d66-7b90-e60b-e3fb-76b25e5eceaa@kvaser.com>
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

On 28.5.2022 10.42, Jimmy Assarsson wrote:
> On 5/17/22 10:41, Jimmy Assarsson wrote:
>> On 2022-05-16 15:47, Anssi Hannula wrote:
>>> Hi all,
>>>
>>> Here's a set of fixes for issues I found while testing kvaser_usb as we
>>> are preparing to start using it in production (with 0bfd:0124).
>> Hi Anssi,
>>
>> Thanks for the patches!
>> I will review and test your fixes before the weekend.
>>
>> Best regards,
>> jimmy
> Sorry for the delay!

No problem!

> To summarize the status.
>
> These patches look good:
> [PATCH 01/12] can: kvaser_usb_leaf: Fix overread with an invalid command
> [PATCH 02/12] can: kvaser_usb: Fix use of uninitialized completion
> [PATCH 03/12] can: kvaser_usb: Fix possible completions during 
> init_completion
> [PATCH 05/12] can: kvaser_usb_leaf: Set Warning state even without bus 
> errors
> [PATCH 10/12] can: kvaser_usb_leaf: Fix wrong CAN state after stopping
> [PATCH 12/12] can: kvaser_usb_leaf: Fix bogus restart events
>
> This looks good, but see comment regarding explicit queue flush:
> [PATCH 06/12] can: kvaser_usb_leaf: Fix TX queue out of sync after restart

Feel free to drop the flush, or let me know if you want me to resend it
without it.

> I still need some more time looking into:
> PATCH 07/12] can: kvaser_usb_leaf: Fix CAN state after restart
> PATCH 08/12] can: kvaser_usb_leaf: Fix improved state not being reported
> PATCH 11/12] can: kvaser_usb_leaf: Ignore stale bus-off after start
>
> I want to replace
> [PATCH 04/12] can: kvaser_usb: Mark Mini PCIe 2xHS as supporting error 
> counters
> with a new patch
> "can: kvaser_usb: kvaser_usb_leaf: Get capabilities from device"
>
> I want to split the handling of CMD_ERROR_EVENT and the readback
> functionality. I also want to add parameter readback for
> kvaser_usb_hydra. I need more time to look over the can_bittiming_const
> in kvaser_usb_leaf for the different supported firmware.
> [PATCH 09/12] can: kvaser_usb_leaf: Fix silently failing bus params setup
>
>
> I would like to create a V2 series, including my patches, if you are
> okay with it?


Yes, that's fine. I can test your series on my setup as well.

>
> Best regards,
> jimmy
>
>
>
>>> The biggest caveat is that I only have two devices to test with [1] and I
>>> don't have HW documentation, so there is a possibility that some of the
>>> fixes might not work properly on all HW variants.
>>> Hopefully Jimmy can confirm they look OK, or suggest alternatives.
>>>
>>> [1] Tested devices:
>>> - 0bfd:0017 Kvaser Memorator Professional HS/HS FW 2.0.50
>>> - 0bfd:0124 Kvaser Mini PCI Express 2xHS FW 4.18.778


-- 
Anssi Hannula / Bitwise Oy
+358 503803997

