Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4E2504FC9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 14:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238056AbiDRMQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 08:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbiDRMQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 08:16:08 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E15F1A82E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 05:13:30 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 920A122175;
        Mon, 18 Apr 2022 14:13:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650284008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sDTjYlCaBa9GLh++sa/WCQdXuUrcubJCdTwx3SdcA1Q=;
        b=hzXAChF9N1ILebUw69v7FcCfSE9sAXERxDXW3a/CotuLCpZBsGXKG1XdWjLEjkWmngXnWn
        gUazAnZpwYWZz0SfXIFiXCWZAbIDjBnh1xOoOE3zQl21SBxUiY9RKR1vj9Sd+tf27qs1U2
        qgWiIvXubT6htCbhqMTTfZv3JAd4bBc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 18 Apr 2022 14:13:28 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v1 2/2] mtd: spi-nor: expose internal parameters via
 debugfs
In-Reply-To: <20220418121044.2825448-2-michael@walle.cc>
References: <20220418121044.2825448-1-michael@walle.cc>
 <20220418121044.2825448-2-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <fca7f401141caee41f574cdd0339a6e1@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-04-18 14:10, schrieb Michael Walle:
> There is no way to gather all information to verify support for a new
> flash chip. Also if you want to convert an existing flash chip to the
> new SFDP parsing, there is not enough information to determine if the
> flash will work like before. To ease this development, expose internal
> parameters via the debugfs.

Here's an example:
# cat params
name		w25q32dw
id		ef6016
size		4.00 MiB
write size	1
page size	256
address width	3
flags		HAS_SR_TB|HAS_LOCK|HAS_16BIT_SR|NO_READ_CR|SOFT_RESET

opcodes
  read		3b
   dummy cycles	8
  erase		20
  program	02
  8D extension	none

protocols
  read		1S-1S-2S
  write		1S-1S-1S
  register	1S-1S-1S

erase commands
  20 (4.00 KiB) [1]
  52 (32.0 KiB) [2]
  d8 (64.0 KiB) [3]
  c7 (4.00 MiB)

sector map
  region              | erase mask | flags
  --------------------+------------+----------
  00000000 - 003fffff |     [ 123] |

# cat capabilities
Supported read modes by the flash
1S-1S-1S
   opcode	03
   mode cycles	00
   dummy cycles	00
1S-1S-1S (fast read)
   opcode	0b
   mode cycles	00
   dummy cycles	08
1S-1S-2S
   opcode	3b
   mode cycles	00
   dummy cycles	08
1S-2S-2S
   opcode	bb
   mode cycles	02
   dummy cycles	02
1S-1S-4S
   opcode	6b
   mode cycles	00
   dummy cycles	08
1S-4S-4S
   opcode	eb
   mode cycles	02
   dummy cycles	04
4S-4S-4S
   opcode	eb
   mode cycles	02
   dummy cycles	00

Supported page program modes by the flash
1S-1S-1S
   opcode	02
