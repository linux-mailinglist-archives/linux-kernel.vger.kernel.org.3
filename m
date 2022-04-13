Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82AE4FF718
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbiDMMxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiDMMxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:53:10 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD993616A;
        Wed, 13 Apr 2022 05:50:47 -0700 (PDT)
Received: from apollo.. (unknown [IPv6:2a02:810b:4340:43bf:4685:ff:fe12:5967])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 12A4E22205;
        Wed, 13 Apr 2022 14:50:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1649854246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gGQKNMATt0VXs2Gr3ljY3Dvzv0/7dWKNIw1LPszM13o=;
        b=s+ChkiLc/0lHYW3E0/kcfVSlc0ch3xCuhjscEPqzUjM4c8VpXpETaEY7gC9FKwwkU/EaX0
        43XH7x6ykbJxIi256NJdQ8QuqOuKENbr5Axv+LmCOzVfLbqogc33pOW0pqJZMhWEMyaJqd
        OTQBDozq4yDWXqvbwFf/t6x4rRfcWpc=
From:   Michael Walle <michael@walle.cc>
To:     tudor.ambarus@microchip.com
Cc:     alexandre.belloni@bootlin.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, ludovic.desroches@microchip.com,
        nicolas.ferre@microchip.com, Michael Walle <michael@walle.cc>
Subject: Re: [PATCH] spi: atmel-quadspi: Add support for sama7g5 QSPI
Date:   Wed, 13 Apr 2022 14:50:32 +0200
Message-Id: <20220413125032.151907-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211214133404.121739-1-tudor.ambarus@microchip.com>
References: <20211214133404.121739-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

> The sama7g5 QSPI controller uses dedicated clocks for the
> QSPI Controller Interface and the QSPI Controller Core, and
> requires synchronization before accessing registers or bit
> fields.
> 
> QSPI_SR.SYNCBSY must be zero before accessing any of the bits:
> QSPI_CR.QSPIEN, QSPI_CR.QSPIDIS, QSPI_CR.SRFRSH, QSPI_CR.SWRST,
> QSPI_CR.UPDCFG, QSPI_CR.STTFR, QSPI_CR.RTOUT, QSPI_CR.LASTXFER.
> 
> Also, the QSPI controller core configuration can be updated by
> writing the QSPI_CR.UPDCFG bit to ‘1’. This is needed by the
> following registers: QSPI_MR, QSPI_SCR, QSPI_IAR, QSPI_WICR,
> QSPI_IFR, QSPI_RICR, QSPI_SMR, QSPI_SKR,QSPI_REFRESH, QSPI_WRACNT
> QSPI_PCALCFG.
> 
> The Octal SPI supports frequencies up to 200 MHZ DDR. The need
> for output impedance calibration arises. To avoid the degradation
> of the signal quality, a PAD calibration cell is used to adjust
> the output impedance to the driven I/Os.
> 
> The transmission flow requires different sequences for setting
> the configuration and for the actual transfer, than what is in
> the sama5d2 and sam9x60 versions of the IP. Different interrupts
> are handled. aq->ops->set_cfg() and aq->ops->transfer() are
> introduced to help differentiating the flows.
> 
> Tested single and octal SPI mode with mx66lm1g45g.

I've successfully tested this on a LAN9668 with a SST25VF016B
and 104 MHz (quad mode). But there are some catches:

(1) SPI mode is not set, i.e. SCR.CPHA, SCR.CPOL

(2) There is no (or a really short delay) between asserting
    the chip select and the first clock edge. I.e. SCR.DLYBS
    is zero. I wasn't able to go faster than ~20MHz with that.
    Also the slightest capacitance, like a probe tip, made things
    worse. I've been successful with a value of 2 at 104MHz,
    although attaching an oscilloscope probe (<4 pF input
    capacitance, no cheapo probe) made things unreliable again.
    In the end a value of 4 worked perfectly. I think it is
    overkill to make this configurable, the added delay should
    be negligible.

(3) As already discussed on IRC, the driver will iomap the
    whole memory window which is 256MB for one controller
    in my case. On arm32 the vmalloc area is only 240MB by
    default. The lan9668 has three of these controllers
	(whereas one only has an 8MB window). Therefore, we would
    potentially waste 520MB just for the SPI windows.

    I had a look at the driver, although IAR is set, it is
    not used for the accesses through the memory window. doh ;)
    It seems we need to map the memory just for the memcpy_io.
    The DMA engine should be happy with the physical addresses
    and shouldn't need the iomap. What do you think about just
    mapping like 16MB and after that always fall back to DMA
    regardless of the transfer size.

    In fact I don't know why that memory window is needed at all.
    Shouldn't the DMA engine be able to just read from RDR and
    write to TDR? And PIO mode could do the same.

(4) Odd transfer lengths doesn't work. That is I get different
    results for the folllwing:
    (a) dd if=/dev/mtd0 bs=3 | hexdump -C | head
    (a) dd if=/dev/mtd0 bs=4 | hexdump -C | head

    Actually, I've notived that using the (busybox) hexdump
    directly on /dev/mtd0 returned some really odd bytes. Might
    or might not be related to that above.

-michael
