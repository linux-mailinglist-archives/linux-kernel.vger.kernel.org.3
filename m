Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4F54BF2EB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 08:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiBVHvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 02:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiBVHvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 02:51:19 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AD2145AEE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 23:50:54 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B10BD22175;
        Tue, 22 Feb 2022 08:50:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645516251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yGq+Oc5aD7EUYB4n828ghG01xMsEGGRgt8fg8Ih6798=;
        b=kwuCX5ruihrC3zbgci6X0EZ4+u1LNrbfUiFoLnb9hydgfhMmwuG7kljqM2cSQqsEmjuzIQ
        Tw8B5Unp4q5/nW0TIw+z6sibzt4vusLZwPqtJ4Y2HdV3dTHZk3VmGjWvmQhOGkj2q4tYIQ
        nUqOP4/NSI8gT6UBPy2H2leNVEgXXc8=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 22 Feb 2022 08:50:50 +0100
From:   Michael Walle <michael@walle.cc>
To:     =?UTF-8?Q?Potin_Lai_=28=E8=B3=B4=E6=9F=8F=E5=BB=B7=29?= 
        <Potin.Lai@quantatw.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Patrick Williams <patrick@stwcx.xyz>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mtd: spi-nor: winbond: Add support for w25q01jv-iq
In-Reply-To: <0b619d9e-4ca0-88ae-69a1-4cb07d2aeea4@quantatw.com>
References: <20220222064227.16724-1-potin.lai@quantatw.com>
 <aedb6f8e3d878f487aa7fef147e352b4@walle.cc>
 <0b619d9e-4ca0-88ae-69a1-4cb07d2aeea4@quantatw.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <ef3d0391d22ce472e7410a77af3e938d@walle.cc>
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

Am 2022-02-22 08:37, schrieb Potin Lai:
> Michael Walle 於 2022/2/22 下午 03:24 寫道:
>> Hi,
>> 
>> Am 2022-02-22 07:42, schrieb Potin Lai:
>>> Add support for winbond w25q01jv-iq chip
>>> 
>>> root@bletchley:~# cat
>>> /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/jedec_id
>>> ef4021
>>> root@bletchley:~# cat
>>> /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/manufacturer
>>> winbond
>>> root@bletchley:~# cat
>>> /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/partname
>>> w25q01jv-iq
>>> root@bletchley:~# hexdump -C
>>> /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp
>>> 00000000 53 46 44 50 06 01 01 ff 00 06 01 10 80 00 00 ff 
>>> |SFDP............|
>>> 00000010 84 00 01 02 d0 00 00 ff 03 00 01 02 f0 00 00 ff 
>>> |................|
>>> 00000020 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
>>> |................|
>>> *
>>> 00000080 e5 20 fb ff ff ff ff 3f 44 eb 08 6b 08 3b 42 bb |. 
>>> .....?D..k.;B.|
>>> 00000090 fe ff ff ff ff ff 00 00 ff ff 40 eb 0c 20 0f 52 
>>> |..........@.. .R|
>>> 000000a0 10 d8 00 00 36 02 a6 00 82 ea 14 e2 e9 63 76 33 
>>> |....6........cv3|
>>> 000000b0 7a 75 7a 75 f7 a2 d5 5c 19 f7 4d ff e9 70 f9 a5 
>>> |zuzu...\..M..p..|
>>> 000000c0 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
>>> |................|
>>> 000000d0 ff 0a f0 ff 21 ff dc ff |....!...|
>>> 000000d8
>> 
>> Can you please provide an md5sum or sha256sum of this file?
> 
> root@bletchley:~# md5sum
> /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp
> a7b9dbf76e99a33db99e557b6676588a 

Thanks!

> /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp
> 
> Is it required in commit message, if yes, I will update it.

Ohh, I actually missed that. These information should go as
a comment, that is below the "---" line.

-michael
