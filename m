Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807A95535F2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352721AbiFUPWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352670AbiFUPV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:21:57 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E821D252BD;
        Tue, 21 Jun 2022 08:21:56 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1o3fh4-0001zL-02; Tue, 21 Jun 2022 17:21:30 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id F264BC01AA; Tue, 21 Jun 2022 17:14:57 +0200 (CEST)
Date:   Tue, 21 Jun 2022 17:14:57 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Liang He <windhl@126.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: mti-malta: Fix refcount leak in malta-time.c
Message-ID: <20220621151457.GC12206@alpha.franken.de>
References: <20220616142756.3987475-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616142756.3987475-1-windhl@126.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 10:27:56PM +0800, Liang He wrote:
> In update_gic_frequency_dt(), of_find_compatible_node() will return
> a node pointer with refcount incremented. We should use of_node_put()
> when it is not used anymore.
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  arch/mips/mti-malta/malta-time.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
> index bbf1e38e1431..2cb708cdf01a 100644
> --- a/arch/mips/mti-malta/malta-time.c
> +++ b/arch/mips/mti-malta/malta-time.c
> @@ -214,6 +214,8 @@ static void update_gic_frequency_dt(void)
>  
>  	if (of_update_property(node, &gic_frequency_prop) < 0)
>  		pr_err("error updating gic frequency property\n");
> +
> +	of_node_put(node);
>  }
>  
>  #endif
> -- 
> 2.25.1

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
