Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485A35535ED
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352820AbiFUPWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352791AbiFUPWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:22:18 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63FEC29802;
        Tue, 21 Jun 2022 08:22:15 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1o3fh4-0001zL-03; Tue, 21 Jun 2022 17:21:30 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id D1C22C01AA; Tue, 21 Jun 2022 17:15:33 +0200 (CEST)
Date:   Tue, 21 Jun 2022 17:15:33 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Liang He <windhl@126.com>
Cc:     john@phrozen.org, xkernel.wang@foxmail.com, wangborong@cdjrlc.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: lantiq: falcon: Fix refcount leak bug in sysctrl
Message-ID: <20220621151533.GD12206@alpha.franken.de>
References: <20220617121958.4047910-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617121958.4047910-1-windhl@126.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 08:19:58PM +0800, Liang He wrote:
> In ltq_soc_init(), of_find_compatible_node() will return a node pointer
> with refcount incremented. We should use of_node_put() when it is not
> used anymore.
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  arch/mips/lantiq/falcon/sysctrl.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/mips/lantiq/falcon/sysctrl.c b/arch/mips/lantiq/falcon/sysctrl.c
> index 5204fc6d6d50..1187729d8cbb 100644
> --- a/arch/mips/lantiq/falcon/sysctrl.c
> +++ b/arch/mips/lantiq/falcon/sysctrl.c
> @@ -208,6 +208,12 @@ void __init ltq_soc_init(void)
>  			of_address_to_resource(np_sysgpe, 0, &res_sys[2]))
>  		panic("Failed to get core resources");
>  
> +	of_node_put(np_status);
> +	of_node_put(np_ebu);
> +	of_node_put(np_sys1);
> +	of_node_put(np_syseth);
> +	of_node_put(np_sysgpe);
> +
>  	if ((request_mem_region(res_status.start, resource_size(&res_status),
>  				res_status.name) < 0) ||
>  		(request_mem_region(res_ebu.start, resource_size(&res_ebu),
> -- 
> 2.25.1

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
