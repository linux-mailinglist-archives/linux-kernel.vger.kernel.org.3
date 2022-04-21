Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE6450AAF8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 23:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442209AbiDUVv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 17:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349020AbiDUVvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 17:51:22 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A819A4AE0A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:48:30 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D0106221D4;
        Thu, 21 Apr 2022 23:48:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650577708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pwtletygDsJ+anOkVF0MdbWI7gPYL0brXB0zgaC73Fs=;
        b=tdxjoNuk5SVel4el0Pw2GsYvKS0keifuPS4XEjKm6k10FpVcUjM4k4cvvCxuZaFM52YXLh
        tJXqJnH6tebvin+VZcXvz3K034+za6PLB5wmG905U6SBX+eMPHG83f0vLz/b0v+zs6SelJ
        kpHBxFKIkYNCpWNSUPE4tVD/5Eh314c=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 21 Apr 2022 23:48:27 +0200
From:   Michael Walle <michael@walle.cc>
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Cc:     tudor.ambarus@microchip.com, p.yadav@ti.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com
Subject: Re: [PATCH V8] mtd: spi-nor: winbond: add support for W25Q512NW-IM
In-Reply-To: <1648191975-1366-1-git-send-email-quic_c_sbhanu@quicinc.com>
References: <1648191975-1366-1-git-send-email-quic_c_sbhanu@quicinc.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <9f9fcf2fcf9da3f1aa698892b5c7dfab@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-03-25 08:06, schrieb Shaik Sajida Bhanu:

> 0000000 4653 5044 0106 ff01 0600 1001 0080 ff00
> 0000010 0084 0201 00d0 ff00 ffff ffff ffff ffff
> 0000020 6800 6c65 6f6c 7720 726f 646c ffff ffff
> 0000030 ffff ffff ffff ffff ffff ffff ffff ffff
> *
> 0000080 20e5 fffb ffff 1fff eb44 6b08 3b08 bb42
> 0000090 fffe ffff ffff 0000 ffff eb40 200c 520f
> 00000a0 d810 0000 0233 00a6 e781 d914 63e9 3376
> 00000b0 757a 757a bdf7 5cd5 f719 ff5d 70e9 a5f9
> 00000c0 ffff ffff ffff ffff ffff ffff ffff ffff
> 00000d0 0aff fff0 ff21 ffdc
> 00000d8

00000000  53 46 44 50 06 01 01 ff  00 06 01 10 80 00 00 ff  
|SFDP............|
00000010  84 00 01 02 d0 00 00 ff  ff ff ff ff ff ff ff ff  
|................|
00000020  00 68 65 6c 6c 6f 20 77  6f 72 6c 64 ff ff ff ff  |.hello 
world....|
00000030  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
00000080  e5 20 fb ff ff ff ff 1f  44 eb 08 6b 08 3b 42 bb  |. 
......D..k.;B.|
00000090  fe ff ff ff ff ff 00 00  ff ff 40 eb 0c 20 0f 52  
|..........@.. .R|
000000a0  10 d8 00 00 33 02 a6 00  81 e7 14 d9 e9 63 76 33  
|....3........cv3|
000000b0  7a 75 7a 75 f7 bd d5 5c  19 f7 5d ff e9 70 f9 a5  
|zuzu...\..]..p..|
000000c0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
000000d0  ff 0a f0 ff 21 ff dc ff                           |....!...|

Hello World!

-michael
