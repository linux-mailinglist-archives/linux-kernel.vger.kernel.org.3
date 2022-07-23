Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B2057ECC2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 10:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbiGWIaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 04:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237150AbiGWIad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 04:30:33 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153E51836A;
        Sat, 23 Jul 2022 01:30:29 -0700 (PDT)
Received: from [192.168.1.103] (31.173.80.87) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Sat, 23 Jul
 2022 11:30:17 +0300
Subject: Re: [PATCH 1/3] mtd: spi-nor: Use the spi-mem poll status APIs.
To:     =?UTF-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>, <tudor.ambarus@microchip.com>,
        <p.yadav@ti.com>, <michael@walle.cc>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <aidanmacdonald.0x0@gmail.com>,
        <tmn505@gmail.com>, <paul@crapouillou.net>,
        <dongsheng.qiu@ingenic.com>, <aric.pzqi@ingenic.com>,
        <rick.tyliu@ingenic.com>, <jinghui.liu@ingenic.com>,
        <sernia.zhou@foxmail.com>, <reimu@sudomaker.com>
References: <1658508510-15400-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1658508510-15400-2-git-send-email-zhouyanjie@wanyeetech.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <1926ce77-6de0-0d87-d676-6ae93fa5c527@omp.ru>
Date:   Sat, 23 Jul 2022 11:30:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1658508510-15400-2-git-send-email-zhouyanjie@wanyeetech.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [31.173.80.87]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 07/23/2022 08:13:55
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 171890 [Jul 23 2022]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 493 493 c80a237886b75a8eec705b487193915475443854
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.80.87 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.80.87 in (user) dbl.spamhaus.org}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;31.173.80.87:7.7.3,7.4.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: {iprep_blacklist}
X-KSE-AntiSpam-Info: {Track_Chinese_Simplified, text}
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.80.87
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/23/2022 08:17:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/23/2022 6:36:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 7/22/22 7:48 PM, 周琰杰 (Zhou Yanjie) wrote:

> With advanced controllers (such as Ingenic SFC), it is possible to poll
> the status register of the device. This could be done to offload the CPU
> during a erase or write operation. Make use of spi-mem poll status APIs
> to handle this feature.
> 
> Previously, when erasing large area (e.g. 32MiB), in non-offload case,
> CPU load could reach ~90% and would generate ~3.92 million interrupts,
> now it decrease to ~15% CPU load and 0.15 million interrupts.
> 
> This should also fix the high CPU usage for system which don't have a
> dedicated poll status block logic (decrease to ~80% CPU load and ~1.61
> million interrupts.).
> 
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---
>  drivers/mtd/spi-nor/core.c | 42 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 502967c..6a31132 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -617,19 +617,41 @@ static int spi_nor_wait_till_ready_with_timeout(struct spi_nor *nor,
>  	unsigned long deadline;
>  	int timeout = 0, ret;
>  
> -	deadline = jiffies + timeout_jiffies;
> +	if (nor->spimem && !nor->params->ready) {
> +		struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDSR, 0),
> +						       SPI_MEM_OP_NO_ADDR,
> +						       SPI_MEM_OP_NO_DUMMY,
> +						       SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 0));

   Strange indentation...

[...]
> +		return spi_mem_poll_status(nor->spimem, &op, SR_WIP, 0, 0, 10,
> +						       jiffies_to_msecs(timeout_jiffies));

   Here as well...

[...]

MBR, Sergey
