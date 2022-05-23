Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E35530E07
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbiEWJbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbiEWJbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:31:20 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 177E51054D;
        Mon, 23 May 2022 02:31:20 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nt4Os-0001Pn-00; Mon, 23 May 2022 11:30:54 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 4743AC02F4; Mon, 23 May 2022 11:18:27 +0200 (CEST)
Date:   Mon, 23 May 2022 11:18:27 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: CPC: Fix refcount leak in
 mips_cpc_default_phys_base
Message-ID: <20220523091827.GE5069@alpha.franken.de>
References: <20220516043353.8147-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516043353.8147-1-linmq006@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 08:33:50AM +0400, Miaoqian Lin wrote:
> of_find_compatible_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: 791412dafbbf ("MIPS: CPC: Map registers using DT in mips_cpc_default_phys_base()")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  arch/mips/kernel/mips-cpc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
> index 17aff13cd7ce..3e386f7e1545 100644
> --- a/arch/mips/kernel/mips-cpc.c
> +++ b/arch/mips/kernel/mips-cpc.c
> @@ -28,6 +28,7 @@ phys_addr_t __weak mips_cpc_default_phys_base(void)
>  	cpc_node = of_find_compatible_node(of_root, NULL, "mti,mips-cpc");
>  	if (cpc_node) {
>  		err = of_address_to_resource(cpc_node, 0, &res);
> +		of_node_put(cpc_node);
>  		if (!err)
>  			return res.start;
>  	}
> -- 
> 2.25.1

this is already fixed in mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
