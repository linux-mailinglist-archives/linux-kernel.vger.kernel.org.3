Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45DE49D58E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 23:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiAZWiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 17:38:25 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:41649 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiAZWiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 17:38:24 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 711522223E;
        Wed, 26 Jan 2022 23:38:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1643236702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PecoamdTzvINOalik00tsBphSo/Nm52UmAwdXu2OT3E=;
        b=QubxIKLzKoONoLg4yY+sG1eA2aGPHTCdm5ZK8lEsbOucMXtxYmTLqmGesVqZZbU9QyrgTF
        0+kATZip0nlCwg1FFgPw9o/jM8UNXcCeK6XW20jbN3Bd9mTcA3sNiOkdVU1/sEIRuQs/pJ
        TeKl3f/ddguGkm/wodobh5K37BiW74o=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 26 Jan 2022 23:38:21 +0100
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
In-Reply-To: <20220126073227.3401275-1-chentsung@chromium.org>
References: <20220126073227.3401275-1-chentsung@chromium.org>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <8625876c695685fc5409997403130194@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-01-26 08:32, schrieb Chen-Tsung Hsieh:
> Read back Status Register 1 to ensure that the written byte match the
> received value and return -EIO if read back test failed.
> 
> Without this patch, spi_nor_write_16bit_sr_and_check() only check the
> second half of the 16bit. It causes errors like spi_nor_sr_unlock()
> return success incorrectly when spi_nor_write_16bit_sr_and_check()
> doesn't write SR successfully.
> 
> Fixes: 39d1e3340c73 ("mtd: spi-nor: Fix clearing of QE bit on 
> lock()/unlock()")
> Signed-off-by: Chen-Tsung Hsieh <chentsung@chromium.org>

Looks good to me. spi_nor_write_16bit_cr_and_check() also checks
the SR1 and the function doc also mentions it will check it - although
it doesn't.

Reviewed-by: Michael Walle <michael@walle.cc>

Out of curiosity, on what flash did you discover this?

-michael
