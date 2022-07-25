Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9649580651
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236760AbiGYVTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGYVTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:19:50 -0400
X-Greylist: delayed 1800 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Jul 2022 14:19:49 PDT
Received: from wp175.webpack.hosteurope.de (wp175.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:84b6::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7412F23BCD
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:19:49 -0700 (PDT)
Received: from p54bc6cd6.dip0.t-ipconnect.de ([84.188.108.214] helo=[192.168.1.245]); authenticated
        by wp175.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oG4YN-0007hQ-Nw; Mon, 25 Jul 2022 22:19:47 +0200
Message-ID: <be60acab-7dfe-6841-b176-4bd1e875d52e@birger-koblitz.de>
Date:   Mon, 25 Jul 2022 22:19:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RFC v1] spi: realtek-rtl: Fix clearing some register bits
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bert@biot.com, sander@svanheule.net
References: <20220725193547.1038414-1-martin.blumenstingl@googlemail.com>
From:   Birger Koblitz <mail@birger-koblitz.de>
In-Reply-To: <20220725193547.1038414-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;mail@birger-koblitz.de;1658783989;bbd56df9;
X-HE-SMSGID: 1oG4YN-0007hQ-Nw
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On 25/07/2022 21:35, Martin Blumenstingl wrote:
> The code seemingly tries to clear RTL_SPI_SFCSR_LEN_MASK (before then
> setting either RTL_SPI_SFCSR_LEN1 or RTL_SPI_SFCSR_LEN4) and
> RTL_SPI_SFCSR_CS. What it actually does is only keeping these bits and
> clearing all other bits, even the ones which were just set before. Fix
> the operation to clear the bits in the selected mask and keep all other
> ones.
> 
> Fixes: a8af5cc2ff1e80 ("spi: realtek-rtl: Add support for Realtek RTL838x/RTL839x SPI controllers")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> I stumbled across this while reading the driver. This patch is untested
> because I don't have any hardware with this controller.
I believe your fix is correct. In the meantime, more information has been
learned about this hardware, in particular, newer SoC versions and the possibility
to have parallel IO and hardware which uses different chip selects.
I came up with the following patch for supporting this, and it achieves
what you also propose:
https://github.com/bkobl/openwrt/blob/rtl8214qf_merge/target/linux/realtek/patches-5.10/317-spi-cs-support-for-spi-realtek-rtl.patch
It is still is a bit rough, reading it I immediately saw 2 things that
would need to be fixed, but it also improves e.g. that RTL_SPI_SFCSR
is now configured independently of what u-boot did to it.

Cheers,
   Birger
