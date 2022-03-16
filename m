Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7529B4DA905
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 04:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353484AbiCPDuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 23:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbiCPDuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 23:50:17 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F813255AD;
        Tue, 15 Mar 2022 20:49:03 -0700 (PDT)
Received: (Authenticated sender: frank@zago.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 354381BF203;
        Wed, 16 Mar 2022 03:48:59 +0000 (UTC)
Message-ID: <fee91f27-17c4-25c0-c149-3b20161429ba@zago.net>
Date:   Tue, 15 Mar 2022 22:48:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] mfd: ch341: add driver for the WCH CH341 in I2C/GPIO
 mode
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Wolfram Sang <wsa@kernel.org>, Johan Hovold <johan@kernel.org>,
        linux-usb@vger.kernel.org, gunar@schorcht.net
References: <20220314030937.22762-1-frank@zago.net>
 <YjCpq8YVwmZzOzwE@google.com>
From:   Frank Zago <frank@zago.net>
In-Reply-To: <YjCpq8YVwmZzOzwE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lee,

>> Changes from v2:
>>   - bug fixes
>>   - more robust USB enumeration
>>   - Changed to an MFD driver as suggested
> 
> Perhaps you should have engaged with me before potentially wasting
> your valuable time.
> 
> MFD is designed to take a parent platform driver and split it out into
> various sub-systems.  If you don't use the MFD Core API (which is the
> case here) it is not an MFD.  MFD is not a dumping ground for
> collections of random device drivers.
> 
> I have no problem with you placing registration and core code inside
> MFD (that *is* what it was designed for), but the leaf 'functionality'
> should be placed in more appropriate locations.
> 
> I2C  => drivers/i2c
> SPI  => drivers/spi
> GPIO => drivers/gpio (or perhaps drivers/pinctrl)
> USB  => drivers/usb
> UART => drivers/tty/serial
> 
> Etc ... Find places for everything.
> 
> Anything left over, give to Greg (drivers/misc). :)
> 

AFAICS that works if the driver is built-in, but not as a module. 

I'd prefer that driver to be a module if desired, and have all its files in the same
place instead of scattered in various directories.

I can try drivers/misc if it's a better place.

Frank.


