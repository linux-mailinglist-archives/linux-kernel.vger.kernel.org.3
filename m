Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B702C5999DF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 12:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348375AbiHSKgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 06:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348128AbiHSKgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:36:10 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621AEF2428;
        Fri, 19 Aug 2022 03:36:08 -0700 (PDT)
Received: (Authenticated sender: contact@artur-rojek.eu)
        by mail.gandi.net (Postfix) with ESMTPA id 169CA4000C;
        Fri, 19 Aug 2022 10:36:05 +0000 (UTC)
MIME-Version: 1.0
Date:   Fri, 19 Aug 2022 12:36:05 +0200
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Chris Morgan <macromorgan@hotmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-mips@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 0/4] iio/adc-joystick: buffer data parsing fixes
In-Reply-To: <SN6PR06MB534245440C9A0EA1E0C11B12A56D9@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20220817105643.95710-1-contact@artur-rojek.eu>
 <SN6PR06MB534245440C9A0EA1E0C11B12A56D9@SN6PR06MB5342.namprd06.prod.outlook.com>
Message-ID: <085417ff80442dd7cc74e88d35423054@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-18 20:28, Chris Morgan wrote:
> On Wed, Aug 17, 2022 at 12:56:39PM +0200, Artur Rojek wrote:
>> Hi all,
>> 
>> this patch set fixes the way channel data is being parsed in the
>> adc-joystick driver. To achieve that, it also introduces helpers in 
>> the
>> IIO subsystem. As a side effect of those changes, a bug in ingenic-adc
>> has been exposed, which this patch set promptly rectifies.
>> 
>> Tested on GCW Zero (by me) and on Anbernic RG350 (by Paul).
>> 
>> Chris:
>> As you have originally reported the issue, would you be able to test
>> the above changes on your setup (Odroid Go Advance, was it)?
> 
> I can confirm this fixes the issue I experienced, I can see both
> channels of the joystick now when using an hrtimer as a trigger.
> 
> This patch also does not interfere with the polling work in progress,
> as that still works as expected too (polling work is still desired
> though).
> 
> Thank you.
Perfect, thanks for testing!

Can I add your Tested-by for v2 of this patchset?

Cheers,
Artur
> 
>> 
>> Artur Rojek (4):
>>   iio/adc: ingenic: fix channel offsets in buffer
>>   iio: add iio_channel_cb_get_iio_buffer helper
>>   iio: add helper function for reading channel offset in buffer
>>   input: joystick: Fix buffer data parsing
>> 
>>  drivers/iio/adc/ingenic-adc.c               |  7 +++---
>>  drivers/iio/buffer/industrialio-buffer-cb.c |  7 ++++++
>>  drivers/iio/industrialio-buffer.c           | 28 
>> +++++++++++++++++++++
>>  drivers/input/joystick/adc-joystick.c       | 26 ++++++++++++-------
>>  include/linux/iio/buffer.h                  |  4 +++
>>  include/linux/iio/consumer.h                | 12 +++++++++
>>  6 files changed, 71 insertions(+), 13 deletions(-)
>> 
>> --
>> 2.37.2
>> 
