Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8F35AFA2C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiIGCsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiIGCsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:48:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3250898D37;
        Tue,  6 Sep 2022 19:48:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3666A61700;
        Wed,  7 Sep 2022 02:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0281C433C1;
        Wed,  7 Sep 2022 02:48:06 +0000 (UTC)
Date:   Tue, 6 Sep 2022 22:48:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arun Easi <aeasi@marvell.com>
Cc:     Martin Petersen <martin.petersen@oracle.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        James Bottomley <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-next@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: Re: [PATCH 1/1] tracing: Fix compile error in trace_array calls
 when TRACING is disabled
Message-ID: <20220906224845.64bc7afd@gandalf.local.home>
In-Reply-To: <20220907023800.4095-2-aeasi@marvell.com>
References: <20220907023800.4095-1-aeasi@marvell.com>
        <20220907023800.4095-2-aeasi@marvell.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2022 19:38:00 -0700
Arun Easi <aeasi@marvell.com> wrote:

> Fix this compilation error seen when CONFIG_TRACING is not enabled:
> 
> drivers/scsi/qla2xxx/qla_os.c: In function 'qla_trace_init':
> drivers/scsi/qla2xxx/qla_os.c:2854:25: error: implicit declaration of function
> 'trace_array_get_by_name'; did you mean 'trace_array_set_clr_event'?
> [-Werror=implicit-function-declaration]
>  2854 |         qla_trc_array = trace_array_get_by_name("qla2xxx");
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~
>       |                         trace_array_set_clr_event
> 
> drivers/scsi/qla2xxx/qla_os.c: In function 'qla_trace_uninit':
> drivers/scsi/qla2xxx/qla_os.c:2869:9: error: implicit declaration of function
> 'trace_array_put' [-Werror=implicit-function-declaration]
>  2869 |         trace_array_put(qla_trc_array);
>       |         ^~~~~~~~~~~~~~~
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Arun Easi <aeasi@marvell.com>
> ---
>  include/linux/trace.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/linux/trace.h b/include/linux/trace.h
> index bf16961..bf206c3 100644
> --- a/include/linux/trace.h
> +++ b/include/linux/trace.h
> @@ -48,6 +48,23 @@ void osnoise_arch_unregister(void);
>  void osnoise_trace_irq_entry(int id);
>  void osnoise_trace_irq_exit(int id, const char *desc);
>  
> +#else	/* CONFIG_TRACING */
> +#define TRACE_EXPORT_FUNCTION	0
> +#define TRACE_EXPORT_EVENT	0
> +#define TRACE_EXPORT_MARKER	0
> +struct trace_export { };

The original for the above can just be moved out of the #ifdef
CONFIG_TRACING. No need to "hide" them.

> +#define register_ftrace_export(export) -EINVAL
> +#define unregister_ftrace_export(export) 0
> +#define trace_printk_init_buffers()
> +#define trace_array_printk(tr, ip, fmt, ...) 0
> +#define trace_array_init_printk(tr) -EINVAL
> +#define trace_array_put(tr)
> +#define trace_array_get_by_name(name) NULL
> +#define trace_array_destroy(tr) 0

With the data outside the #ifdef, the above should be converted into static
inlines.


> +#define osnoise_arch_register() -EINVAL
> +#define osnoise_arch_unregister()
> +#define osnoise_trace_irq_entry(id)
> +#define osnoise_trace_irq_exit(id, desc)

No need to define the osnoise functions. These are only here to allow archs
to define them. They should never be referenced when CONFIG_TRACING is not
set.

>  #endif	/* CONFIG_TRACING */
>  
>  #endif	/* _LINUX_TRACE_H */

