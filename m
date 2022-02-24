Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9164C25C4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 09:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiBXIVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbiBXIVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:21:42 -0500
Received: from www.kot-begemot.co.uk (ivanoab7.miniserver.com [37.128.132.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21B626A38A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 00:21:12 -0800 (PST)
Received: from [192.168.18.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1nN94u-000AaO-FP; Thu, 24 Feb 2022 08:02:24 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1nN94p-008s7y-SH; Thu, 24 Feb 2022 08:02:18 +0000
Subject: Re: [PATCH] firmware: google: Properly state IOMEM dependency
To:     David Gow <davidgow@google.com>,
        Julius Werner <jwerner@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Hutchings <ben@decadent.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
References: <20220224040136.1595119-1-davidgow@google.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <c877cf8b-7dd0-9766-e4cb-123dba5075a3@cambridgegreys.com>
Date:   Thu, 24 Feb 2022 08:02:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220224040136.1595119-1-davidgow@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/02/2022 04:01, David Gow wrote:
> The Google Coreboot implementation requires IOMEM functions
> (memmremap, memunmap, devm_memremap), but does not specify this is its
> Kconfig. This results in build errors when IOMEM is not enabled, such as
> on some UML configurations:
> 
> /usr/bin/ld: drivers/firmware/google/coreboot_table.o: in function `coreboot_table_probe':
> coreboot_table.c:(.text+0x311): undefined reference to `memremap'
> /usr/bin/ld: coreboot_table.c:(.text+0x34e): undefined reference to `memunmap'
> /usr/bin/ld: drivers/firmware/google/memconsole-coreboot.o: in function `memconsole_probe':
> memconsole-coreboot.c:(.text+0x12d): undefined reference to `memremap'
> /usr/bin/ld: memconsole-coreboot.c:(.text+0x17e): undefined reference to `devm_memremap'
> /usr/bin/ld: memconsole-coreboot.c:(.text+0x191): undefined reference to `memunmap'
> /usr/bin/ld: drivers/firmware/google/vpd.o: in function `vpd_section_destroy.isra.0':
> vpd.c:(.text+0x300): undefined reference to `memunmap'
> /usr/bin/ld: drivers/firmware/google/vpd.o: in function `vpd_section_init':
> vpd.c:(.text+0x382): undefined reference to `memremap'
> /usr/bin/ld: vpd.c:(.text+0x459): undefined reference to `memunmap'
> /usr/bin/ld: drivers/firmware/google/vpd.o: in function `vpd_probe':
> vpd.c:(.text+0x59d): undefined reference to `memremap'
> /usr/bin/ld: vpd.c:(.text+0x5d3): undefined reference to `memunmap'
> collect2: error: ld returned 1 exit status
> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>   drivers/firmware/google/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
> index 931544c9f63d..7ac866a985c6 100644
> --- a/drivers/firmware/google/Kconfig
> +++ b/drivers/firmware/google/Kconfig
> @@ -21,7 +21,7 @@ config GOOGLE_SMI
>   
>   config GOOGLE_COREBOOT_TABLE
>   	tristate "Coreboot Table Access"
> -	depends on ACPI || OF
> +	depends on IOMEM && (ACPI || OF)
>   	help
>   	  This option enables the coreboot_table module, which provides other
>   	  firmware modules access to the coreboot table. The coreboot table
> 
Acked-By: anton ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
