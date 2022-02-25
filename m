Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE074C3F22
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 08:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238174AbiBYHjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 02:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbiBYHjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 02:39:24 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0152177764;
        Thu, 24 Feb 2022 23:38:46 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aee37.dynamic.kabel-deutschland.de [95.90.238.55])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1671961EA1928;
        Fri, 25 Feb 2022 08:38:45 +0100 (CET)
Message-ID: <38520a76-db53-fc6c-8af4-f72fa7a87321@molgen.mpg.de>
Date:   Fri, 25 Feb 2022 08:38:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 3/4] acpi: exsystem: Warn about sleeps greater than 50 ms
Content-Language: en-US
To:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org
References: <20220224113807.91771-1-pmenzel@molgen.mpg.de>
 <20220224113807.91771-3-pmenzel@molgen.mpg.de>
 <BYAPR11MB32563DC0413B8595D1339B37873D9@BYAPR11MB3256.namprd11.prod.outlook.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <BYAPR11MB32563DC0413B8595D1339B37873D9@BYAPR11MB3256.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Robert,


Am 24.02.22 um 17:19 schrieb Moore, Robert:
> So, this is the current implementation:
> 
>      /*
>       * For compatibility with other ACPI implementations and to prevent
>       * accidental deep sleeps, limit the sleep time to something reasonable.
>       */
>      if (HowLong > ACPI_MAX_SLEEP)
>      {
>          HowLong = ACPI_MAX_SLEEP;
>      }
> 
>      AcpiOsSleep (HowLong);
> 
> Where ACPI_MAX_SLEEP is:
> 
> #define ACPI_MAX_SLEEP                  2000    /* 2000 millisec == two seconds */

Exactly. I am not changing it though, but just add a warning.


Kind regards,

Paul


> -----Original Message-----
> From: Paul Menzel <pmenzel@molgen.mpg.de>
> Sent: Thursday, February 24, 2022 3:38 AM
> To: Moore, Robert <robert.moore@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>; Len Brown <lenb@kernel.org>
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>; linux-acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 3/4] acpi: exsystem: Warn about sleeps greater than 50 ms
> 
> Quick boottime is important, so warn about sleeps greater than 50 ms in ACPI.
> 
> 50 ms is still long compared to distribution Linux kernels reaching initrd in 350 ms, so should probably changed to 10 ms, so people are aware about this.
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>   drivers/acpi/acpica/exsystem.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsystem.c index 00f66af31ffa..bdffb8aac05c 100644
> --- a/drivers/acpi/acpica/exsystem.c
> +++ b/drivers/acpi/acpica/exsystem.c
> @@ -167,6 +167,11 @@ acpi_status acpi_ex_system_do_sleep(u64 how_long_ms)
>   
>   	acpi_ex_exit_interpreter();
>   
> +	if (how_long_ms > 50) {
> +		ACPI_WARNING((AE_INFO,
> +		    "Time parameter %llu > 50 ms. Please contact firmware vendor for more responsive system.", how_long_ms));
> +	}
> +
>   	/*
>   	 * For compatibility with other ACPI implementations and to prevent
>   	 * accidental deep sleeps, limit the sleep time to something reasonable.
> --
> 2.35.1
