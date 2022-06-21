Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7172A5535F5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352765AbiFUPWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352750AbiFUPWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:22:10 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A57802873E;
        Tue, 21 Jun 2022 08:22:09 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1o3fh4-0001zL-07; Tue, 21 Jun 2022 17:21:30 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 81272C01AA; Tue, 21 Jun 2022 17:21:19 +0200 (CEST)
Date:   Tue, 21 Jun 2022 17:21:19 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Liang He <windhl@126.com>
Cc:     john@phrozen.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: lantiq: Add missing of_node_put() in irq.c
Message-ID: <20220621152119.GB12322@alpha.franken.de>
References: <20220615153339.3970658-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615153339.3970658-1-windhl@126.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 11:33:39PM +0800, Liang He wrote:
> In icu_of_init(), of_find_compatible_node() will return a node
> pointer with refcount incremented. We should use of_node_put()
> when it is not used anymore.
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  arch/mips/lantiq/irq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
> index b732495f138a..62f1b20a2169 100644
> --- a/arch/mips/lantiq/irq.c
> +++ b/arch/mips/lantiq/irq.c
> @@ -396,6 +396,9 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
>  
>  		ret = of_property_read_u32_array(eiu_node, "lantiq,eiu-irqs",
>  						ltq_eiu_irq, exin_avail);
> +						

trailing whitespaces

> +		of_node_put(eiu_node);
> +						

trailing whitespaces

>  		if (ret)
>  			panic("failed to load external irq resources");
>  
> @@ -409,6 +412,9 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
>  			panic("Failed to remap eiu memory");
>  	}
>  
> +	/* if eiu_node&of_address_to_resource */
> +	of_node_put(eiu_node);
> +

if I'm not mistaken you are freeing the taken reference twice. Shouldn't
it work by only adding the last of_node_put() ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
