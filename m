Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B905AE27A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbiIFI1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbiIFI1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:27:43 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89936696E5;
        Tue,  6 Sep 2022 01:27:41 -0700 (PDT)
Received: from [192.168.1.103] (31.173.80.140) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Tue, 6 Sep 2022
 11:27:32 +0300
Subject: Re: [PATCH] phy: usb: free the buffer after reading a given nvmem
 cell
To:     Vincent Shih <vincent.sunplus@gmail.com>, <kishon@ti.com>,
        <vkoul@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <wells.lu@sunplus.com>
References: <1662445382-29879-1-git-send-email-vincent.sunplus@gmail.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <9d396131-72da-772b-3027-89d390cad1fa@omp.ru>
Date:   Tue, 6 Sep 2022 11:27:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1662445382-29879-1-git-send-email-vincent.sunplus@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.80.140]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 09/06/2022 07:30:13
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 172591 [Sep 06 2022]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 498 498 840112829f78e8dd3e3ddbbff8b15d552f4973a3
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.80.140 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.80.140
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/06/2022 07:34:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/6/2022 6:35:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 9/6/22 9:23 AM, Vincent Shih wrote:

> Use kfree() to free the buffer after calling nvmem_cell_read() to
> read a given nvmem cell.

   Your patch does more than just that. It looks like we need 2 patches here...

> Fixes:99d9ccd97385("phy: usb: Add USB2.0 phy driver for Sunplus SP7021")

   Need spaces after : and before (.

> Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
> ---
>  drivers/phy/sunplus/phy-sunplus-usb2.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/sunplus/phy-sunplus-usb2.c b/drivers/phy/sunplus/phy-sunplus-usb2.c
> index 5269968..c8540e1 100644
> --- a/drivers/phy/sunplus/phy-sunplus-usb2.c
> +++ b/drivers/phy/sunplus/phy-sunplus-usb2.c
[...]
> @@ -92,13 +93,15 @@ static int update_disc_vol(struct sp_usbphy *usbphy)
>  	otp_v = nvmem_cell_read(cell, &otp_l);
>  	nvmem_cell_put(cell);
>  
> -	if (otp_v) {
> +	if (!IS_ERR(otp_v)) {

   This needs a separate patch, I think...

>  		set = *(otp_v + 1);
>  		set = (set << (sizeof(char) * 8)) | *otp_v;
>  		set = (set >> usbphy->disc_vol_addr_off) & J_DISC;
> +		
> +		kfree(otp_v);
>  	}
> -
> -	if (!otp_v || set == 0)
> +	
> +	if (IS_ERR(otp_v) || (set == 0))
>  		set = OTP_DISC_LEVEL_DEFAULT;
>  
>  	val = readl(usbphy->phy_regs + CONFIG7);
> @@ -294,3 +297,4 @@ module_platform_driver(sunplus_usb_phy_driver);
>  MODULE_AUTHOR("Vincent Shih <vincent.shih@sunplus.com>");
>  MODULE_DESCRIPTION("Sunplus USB 2.0 phy driver");
>  MODULE_LICENSE("GPL");
> +

   Huh? :-)

MBR, Sergey
