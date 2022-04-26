Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C8C510086
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351327AbiDZOgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351647AbiDZOgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:36:06 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DAB9B7C62;
        Tue, 26 Apr 2022 07:32:58 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1njMFK-0004FF-05; Tue, 26 Apr 2022 16:32:54 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id CDD39C01C7; Tue, 26 Apr 2022 16:32:45 +0200 (CEST)
Date:   Tue, 26 Apr 2022 16:32:45 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Yuanjun Gong <ruc_gongyuanjun@163.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mips: cpc: Fix refcount leak in
 mips_cpc_default_phys_base
Message-ID: <20220426143245.GF18291@alpha.franken.de>
References: <20220407042657.28614-1-ruc_gongyuanjun@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407042657.28614-1-ruc_gongyuanjun@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 12:26:57PM +0800, Yuanjun Gong wrote:
> From: Gong Yuanjun <ruc_gongyuanjun@163.com>
> 
> Add the missing of_node_put() to release the refcount incremented
> by of_find_compatible_node().
> 
> Signed-off-by: Gong Yuanjun <ruc_gongyuanjun@163.com>
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
> 2.17.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
