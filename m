Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70FF56329B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbiGALbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbiGALbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:31:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568A18238D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 04:31:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B390B80813
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 11:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AD2C341C6;
        Fri,  1 Jul 2022 11:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656675106;
        bh=1KeqtJNmJvAPpQc2OndPlGckiq9X5JfT3SyXha3TA1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IDUtSrFcOdaUVduuYoz5F3HlnIv3DWJbEVBAoz7Rp0u8pJGurW0JwlSK8M/x+dxOU
         7iTDm9xTVNE3aAsoWfSc5e8OpfUaP6fNjyFGMc+mU7A8IQDRMiPTd0erHl4a6GVBri
         ZFn/pi2G+ZjoSp8bteD0zOSJdlc4ta8i3fIMnLF5ZdYK2ztprAiliH7WwSxmiHFLOe
         n/hIUosfSmyfLbWsr62MSEnqJ4DL6IMHCGY+2u9+9NJYUEKwWaaZ0tW1vN/oiWTmyc
         JUKg3FKc2PX+avgSLJd3Ia8pGv8ooPr9ivfCsZBXAvNr7nRoZE4FrhkjRoXJYkK3xC
         quzsIxlmeYT9A==
Date:   Fri, 1 Jul 2022 12:31:42 +0100
From:   Will Deacon <will@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v1 1/1] drivers/perf: thunderx2_pmu: Replace open coded
 acpi_match_device()
Message-ID: <20220701113141.GB28070@willie-the-truck>
References: <20220630195103.4088-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630195103.4088-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 10:51:03PM +0300, Andy Shevchenko wrote:
> Replace open coded acpi_match_device() in get_tx2_pmu_type().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/perf/thunderx2_pmu.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
> index 1edb9c03704f..b5a70cc42495 100644
> --- a/drivers/perf/thunderx2_pmu.c
> +++ b/drivers/perf/thunderx2_pmu.c
> @@ -504,24 +504,19 @@ static void tx2_uncore_event_update(struct perf_event *event)
>  
>  static enum tx2_uncore_type get_tx2_pmu_type(struct acpi_device *adev)
>  {
> -	int i = 0;
> -	struct acpi_tx2_pmu_device {
> -		__u8 id[ACPI_ID_LEN];
> -		enum tx2_uncore_type type;
> -	} devices[] = {
> +	struct acpi_device_id devices[] = {
>  		{"CAV901D", PMU_TYPE_L3C},
>  		{"CAV901F", PMU_TYPE_DMC},
>  		{"CAV901E", PMU_TYPE_CCPI2},
> -		{"", PMU_TYPE_INVALID}
> +		{}
>  	};
> +	const struct acpi_device_id *id;
>  
> -	while (devices[i].type != PMU_TYPE_INVALID) {
> -		if (!strcmp(acpi_device_hid(adev), devices[i].id))
> -			break;
> -		i++;
> -	}
> +	id = acpi_match_device(adev, devices);
> +	if (!id)
> +		return PMU_TYPE_INVALID;
>  
> -	return devices[i].type;
> +	return (enum tx2_uncore_type)id->driver_data;

This doesn't even build for me:

 | drivers/perf/thunderx2_pmu.c:515:25: error: incompatible pointer types passing 'struct acpi_device *' to parameter of type 'const struct acpi_device_id *' [-Werror,-Wincompatible-pointer-types]
 |         id = acpi_match_device(adev, devices);
 |                                ^~~~
 | ./include/linux/acpi.h:713:77: note: passing argument to parameter 'ids' here
 | const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
 |                                                                             ^
 | drivers/perf/thunderx2_pmu.c:515:31: error: incompatible pointer types passing 'struct acpi_device_id [4]' to parameter of type 'const struct device *' [-Werror,-Wincompatible-pointer-types]
 |         id = acpi_match_device(adev, devices);
 |                                      ^~~~~~~
 | ./include/linux/acpi.h:714:34: note: passing argument to parameter 'dev' here
 |                                                const struct device *dev);
 |                                                                     ^
 | 2 errors generated.
 | make[2]: *** [scripts/Makefile.build:249: drivers/perf/thunderx2_pmu.o] Error 1
 | make[2]: *** Waiting for unfinished jobs....
 | make[1]: *** [scripts/Makefile.build:466: drivers/perf] Error 2
 | make[1]: *** Waiting for unfinished jobs....
 | make: *** [Makefile:1843: drivers] Error 2
 |

Have you tested this at all?

Will
