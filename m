Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0281E49DDBA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbiA0JSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:18:47 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:35907 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238442AbiA0JSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:18:36 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3907B223E9;
        Thu, 27 Jan 2022 10:18:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1643275114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aFL3RqGgxhLVfd0lm0lYMK9cSaSzp17SbNgy9wIf3yU=;
        b=gRfP+MrvWC6BwihDv6A8kHJHjzdJOgUpqTp/kzzPjHXRyiK65HxVdNs80wV5x3jI3oL6Ck
        qCSGPDpr4bH6E2pEnllxSr+qnb7P1mgQvpRnEskGVgm69XKM4jYpCvQMBSWUZ73sH09UGi
        nFSze6eZA2CO7KGcpQn+rouNujQPKJY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 27 Jan 2022 10:18:32 +0100
From:   Michael Walle <michael@walle.cc>
To:     Chen-Tsung Hsieh <chentsung@chromium.org>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [RESEND PATCH] mtd: spi-nor: core: Check written SR value in
 spi_nor_write_16bit_sr_and_check()
In-Reply-To: <CAMu4cy5onQ2JNKhoLVmR4Nb7Cqv2L59SoE=2Q9CK8bhfPvvHTQ@mail.gmail.com>
References: <20220126073227.3401275-1-chentsung@chromium.org>
 <8625876c695685fc5409997403130194@walle.cc>
 <CAMu4cy5onQ2JNKhoLVmR4Nb7Cqv2L59SoE=2Q9CK8bhfPvvHTQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <ea37e84c8c83350d089c6c9ed4474851@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-01-27 04:31, schrieb Chen-Tsung Hsieh:
> On Thu, Jan 27, 2022 at 6:38 AM Michael Walle <michael@walle.cc> wrote:
>> Out of curiosity, on what flash did you discover this?
> 
> It's Winbond W25Q64JWZPIM
> https://www.winbond.com/hq/product/code-storage-flash-memory/serial-nor-flash/?__locale=en&partNo=W25Q64JW
> 
> We are verifying the write protection on W25Q64JWZPIM and run into an
> issue that spi_nor_sr_unlock() always return success even if HW & SW
> write protection are both enabled.

Ah that ring a bell... Anyway, could you dump the SFDP data please?
See [1], you'll find the files in sysfs. I wonder why that flash is
using the 16bit write at all.

-michael

[1] 
https://lore.kernel.org/linux-mtd/4304e19f3399a0a6e856119d01ccabe0@walle.cc/
