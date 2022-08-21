Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F44559B52B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 17:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiHUPnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 11:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiHUPn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:43:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B25DFF7;
        Sun, 21 Aug 2022 08:43:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23811B80BEC;
        Sun, 21 Aug 2022 15:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81E4C433C1;
        Sun, 21 Aug 2022 15:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661096605;
        bh=6YrboagxfcrIsF7BZoM8iyrWzRJRjV3+khQjjaTXuP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P9SSTtLbwg+9M+57117oVRiOEZtLjqCGEWt8HOJinpG1AS23k70n7IdVqjzewjs97
         5OmO620TITYD+dZwmnEHMTHz3gkFuBQyVqnzDZOzciVZ9/voERMWYJpM+2TV48oing
         OgZ7vJnrG1aFdNU2OoBuurgV+UUxBNfMCbPmHB4JTSiMStmVPlNmg7PPb3lWN/mwk6
         qQ58JV1AeomEHgDKagDCgjyK5VNo3QuA9v9TFQdZn/I23HqDrtUShMOF0oUbQ0I8Xx
         Wf5IMZOAwQKPMh8eJSoDZRrlD2lTULqFWb1MuIhZIe3UZhuJK7XA1Y2OZtIVoHAn7L
         aV3yYpdzS+uoA==
Received: by pali.im (Postfix)
        id 3997C828; Sun, 21 Aug 2022 17:43:23 +0200 (CEST)
Date:   Sun, 21 Aug 2022 17:43:23 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] hwmon: (dell-smm) Add FW_BUG to SMM warning message
Message-ID: <20220821154323.h3htrvnw7wsbahzw@pali>
References: <20220821151713.11198-1-W_Armin@gmx.de>
 <20220821151713.11198-3-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220821151713.11198-3-W_Armin@gmx.de>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 August 2022 17:17:12 Armin Wolf wrote:
> When a SMM call takes very long to execute, then it definitely
> is a firmware bug which should be marked with FW_BUG.
> Also add the number of the buggy SMM call to the warning message
> so BIOS developers, etc immediately know which part of the SMM
> interface is buggy.
> 
> Tested on a Dell Inspiron 3505.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Acked-by: Pali Rohár <pali@kernel.org>

Ideally this change should be CCed to Dell BIOS developers :D (hehe)

> ---
>  drivers/hwmon/dell-smm-hwmon.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 1dab7591576a..f7bab1a91b93 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -26,6 +26,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/platform_device.h>
> +#include <linux/printk.h>
>  #include <linux/proc_fs.h>
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
> @@ -198,7 +199,7 @@ static int i8k_smm_func(void *par)
>  		 eax, ebx, regs->eax & 0xffff, carry, duration);
> 
>  	if (duration > DELL_SMM_MAX_DURATION)
> -		pr_warn_once("SMM call took %lld usecs!\n", duration);
> +		pr_warn_once(FW_BUG "SMM call 0x%.4x took %lld usecs!\n", eax, duration);
> 
>  	if (carry || (regs->eax & 0xffff) == 0xffff || regs->eax == eax)
>  		return -EINVAL;
> --
> 2.30.2
> 
