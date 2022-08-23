Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110F759E8A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343956AbiHWRHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345095AbiHWRGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:06:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B256B165
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:05:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 313436159D
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 14:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0577AC433C1;
        Tue, 23 Aug 2022 14:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661263522;
        bh=S0VvwFbhkUbg0J1K7JzzgKx7jkkvkUDzoournj+cn0k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=S2Zz1oxH/x/wkwSoL9kuxUAr4gzUXXOgWzfmcdTfyAYKi728EaNjv2mbp6xJDxSdM
         NNA114sAS4IHSYrv+4KtHYPoVTfgiOaE85Xa/wWNvcO5Qh5HGttNZIoGdSWM93/Bxd
         rKhMqA0JcKaeWz/mbDXNisNHLyLeZz0pnAiJD1EHkacj+DWUkQA2bSA3NBw7BSMq3X
         +VPtFoJck+O15l5SkeQ71Yxf+M1cxiNS4wQzhuzsoYLw0SEb3sDwS6nNr7lN1kegoM
         SVTYFmRBl4fWPioucrgTXvRolPLBy0Mg6O6o/NcC3I61QxCtzDEol3xr/y/7gB67vU
         UuwMry35U99zg==
Message-ID: <378d61ab-8866-8026-d6ad-b8f6718ff345@kernel.org>
Date:   Tue, 23 Aug 2022 16:05:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH -next] trace: wwnr: Make local symbol 'rv_wwnr' static
Content-Language: en-US
To:     Zeng Heng <zengheng4@huawei.com>, rostedt@goodmis.org,
        mingo@redhat.com
Cc:     liwei391@huawei.com, linux-kernel@vger.kernel.org
References: <20220822063056.3890045-1-zengheng4@huawei.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220822063056.3890045-1-zengheng4@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/22 08:30, Zeng Heng wrote:
> The sparse tool complains as follows:
> 
> kernel/trace/rv/monitors/wwnr/wwnr.c:18:19:
> warning: symbol 'rv_wwnr' was not declared. Should it be static?
> 
> The `rv_wwnr` symbol is not dereferenced by other exter files,
> so add static qualifier for it.

Would you mind re-sending this patch with some changes?

- Use "rv/monitors:" as the subsystem
- Do the same change for wip monitor
- Add the fixes tags:
  Fixes:	ccc319dcb450 ("rv/monitor: Add the wwnr monitor")
  Fixes:	8812d21219b9 ("rv/monitor: Add the wip monitor skeleton created by dot2k")

Also, to fix this problem for new monitors, do another patch changing the dot2k
templates files, adding the same 'static' attribute. The files are:

- tools/verification/dot2/dot2k_templates/main_global.c
- tools/verification/dot2/dot2k_templates/main_per_cpu.c
- tools/verification/dot2/dot2k_templates/main_per_task.c

In this second patch, add the subsystem as "rv/dot2k" and the following tags:

  Fixes:	24bce201d798 ("tools/rv: Add dot2k")
  Suggested-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel


> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> ---
>  kernel/trace/rv/monitors/wwnr/wwnr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.c b/kernel/trace/rv/monitors/wwnr/wwnr.c
> index 599225d9cf38..a063b93c6a1d 100644
> --- a/kernel/trace/rv/monitors/wwnr/wwnr.c
> +++ b/kernel/trace/rv/monitors/wwnr/wwnr.c
> @@ -15,7 +15,7 @@
>  
>  #include "wwnr.h"
>  
> -struct rv_monitor rv_wwnr;
> +static struct rv_monitor rv_wwnr;
>  DECLARE_DA_MON_PER_TASK(wwnr, unsigned char);
>  
>  static void handle_switch(void *data, bool preempt, struct task_struct *p,
> @@ -59,7 +59,7 @@ static void disable_wwnr(void)
>  	da_monitor_destroy_wwnr();
>  }
>  
> -struct rv_monitor rv_wwnr = {
> +static struct rv_monitor rv_wwnr = {
>  	.name = "wwnr",
>  	.description = "wakeup while not running per-task testing model.",
>  	.enable = enable_wwnr,

