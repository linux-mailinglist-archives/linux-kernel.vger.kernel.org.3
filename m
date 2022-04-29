Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F805145BD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356709AbiD2JsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244541AbiD2JsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:48:09 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78498BF514
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:44:51 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8763D22238;
        Fri, 29 Apr 2022 11:44:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1651225490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=es0PSQekIsrCkXSWsT/g4+RRJjGr5RMyR8HYTLziDzY=;
        b=LR5P7lh+xBnddAHSoSStD2hEY1vfyhYmKhAv64wrj2P6xLwX5aUF2Pj1ceewHPg/B5p/nd
        JvSfUdQWjGxWwbTc52mhKjIsMTX9nspMJDhGNhxGH7Pkm2fSNDB6MSWAeMZtarkA5NYGFy
        YOqEA0OJvZsuJDtcsRoGuycQ5vMa2RE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 29 Apr 2022 11:44:49 +0200
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 2/2] mtd: spi-nor: expose internal parameters via
 debugfs
In-Reply-To: <20220429045731.sjhlkyxfxw4zvfxt@ti.com>
References: <20220428122840.1496876-1-michael@walle.cc>
 <20220428122840.1496876-2-michael@walle.cc>
 <20220429045731.sjhlkyxfxw4zvfxt@ti.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <f303280eea2e7a4bc2d14a5cd22727b1@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> +#define SNOR_F_NAME(name) [ilog2(SNOR_F_##name)] = #name
>> +static const char *const snor_f_names[] = {
>> +	SNOR_F_NAME(HAS_SR_TB),
>> +	SNOR_F_NAME(NO_OP_CHIP_ERASE),
>> +	SNOR_F_NAME(BROKEN_RESET),
>> +	SNOR_F_NAME(4B_OPCODES),
>> +	SNOR_F_NAME(HAS_4BAIT),
>> +	SNOR_F_NAME(HAS_LOCK),
>> +	SNOR_F_NAME(HAS_16BIT_SR),
>> +	SNOR_F_NAME(NO_READ_CR),
>> +	SNOR_F_NAME(HAS_SR_TB_BIT6),
>> +	SNOR_F_NAME(HAS_4BIT_BP),
>> +	SNOR_F_NAME(HAS_SR_BP3_BIT6),
>> +	SNOR_F_NAME(IO_MODE_EN_VOLATILE),
>> +	SNOR_F_NAME(SOFT_RESET),
>> +	SNOR_F_NAME(SWP_IS_VOLATILE),
>> +};
>> +#undef SNOR_F_NAME
> 
> You said you would add a comment here. Changed your mind?

No, it just slipped through.

>> +void spi_nor_debugfs_register(struct spi_nor *nor)
>> +{
>> +	struct dentry *d;
>> +	int ret;
>> +
>> +	/* Create rootdir once. Will never be deleted again. */
>> +	if (!rootdir)
>> +		rootdir = debugfs_create_dir("spi-nor", NULL);
> 
> If I compile SPI NOR as module, I insmod it, rmmod it, and then insmod
> it again, I get:
> 
> 	[  360.623465] spi-nor spi0.0: mt35xu512aba (65536 Kbytes)
> 	[  360.623478] debugfs: Directory 'spi-nor' with parent '/' already 
> present!
> 	[  360.632237] spi-nor spi1.0: mt25qu512a (65536 Kbytes)
> 
> I guess when you remove the module, rootdir also gets destroyed, and
> then gets re-initialized on probing again. I am not familiar enough 
> with
> the debugfs APIs to suggest a fix though.

Thanks for testing. And yes, you are right. I've changed that code
quite a few times for this damn subdirectory. But it seems I didn't
get it right. Usually, it's created in the module_init() but since
we just have an implicit one (and I don't really want to change that),
that's not an option. Some subsystems don't create a subdirectory at
all, which doesn't appeal to me.

I'll first lookup if the directory is already there, if it is, use it,
if not, create it. That should work. FWIW, the mvpp2 network card driver
does it too.

-michael
