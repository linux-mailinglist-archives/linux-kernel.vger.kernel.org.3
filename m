Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA2A53EA7D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239897AbiFFOn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239831AbiFFOnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:43:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07485457B0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:43:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B41FEB81A6E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 14:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F44C385A9;
        Mon,  6 Jun 2022 14:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654526595;
        bh=8KryTG7Uz5Xg2VPtI9tDJ0yLVfz1AHsMhRF/iWdXK/8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JE0xHj4NtCjcwb7NokcoDCY6oPe8PvZLwv7gB1jsy7/Jd88JS1cBcPGp4AFiKy9aH
         6i3VZFHD0shi8cmboUAjdcVkqNXnSstcznANSyOXVBqAu6OMWjnnEwnOhH475AYO3I
         Zf3aPWGYhscm0/PNTviJZf/sgnPcTSqg/TJl0DFDTsj78w7HOUMqTdeX2t9UV0gtJg
         28jqL40mXJR/g8HRYVEIluOEmcj7r4W6gcCdExN1nmdymlVUYYN03dUKte8wN+jIjh
         HO0Ha652yGRwt8W0Q5K0SvRgaTAP6tcA26JAkjFTisk6Jxhbbu2ecSmfER4F9fbjQ4
         vVQv7XHwCWasg==
Date:   Mon, 6 Jun 2022 23:43:10 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     sunliming <sunliming@kylinos.cn>
Cc:     rostedt@goodmis.org, ast@kernel.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kelulanainsley@gmail.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] fprobe/samples: make sample_probe static
Message-Id: <20220606234310.b0f893ee35c0106e414bd67f@kernel.org>
In-Reply-To: <20220606075659.674556-1-sunliming@kylinos.cn>
References: <20220606075659.674556-1-sunliming@kylinos.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Jun 2022 15:56:59 +0800
sunliming <sunliming@kylinos.cn> wrote:

> This symbol is not used outside of fprobe_example.c, so marks it static.
> 
> Fixes the following warning:
> 
> sparse warnings: (new ones prefixed by >>)
> >> samples/fprobe/fprobe_example.c:23:15: sparse: sparse: symbol 'sample_probe'
> was not declared. Should it be static?
> 

Looks good to me. Thanks for the fix!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---
>  samples/fprobe/fprobe_example.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/fprobe/fprobe_example.c b/samples/fprobe/fprobe_example.c
> index 24d3cf109140..123cfd83d4c6 100644
> --- a/samples/fprobe/fprobe_example.c
> +++ b/samples/fprobe/fprobe_example.c
> @@ -20,7 +20,7 @@
>  
>  #define BACKTRACE_DEPTH 16
>  #define MAX_SYMBOL_LEN 4096
> -struct fprobe sample_probe;
> +static struct fprobe sample_probe;
>  
>  static char symbol[MAX_SYMBOL_LEN] = "kernel_clone";
>  module_param_string(symbol, symbol, sizeof(symbol), 0644);
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
