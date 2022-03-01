Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D691E4C9072
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbiCAQf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbiCAQf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:35:26 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E19F5FF3F;
        Tue,  1 Mar 2022 08:34:45 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nP5SV-0006n6-00; Tue, 01 Mar 2022 17:34:43 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id C49B5C28F0; Tue,  1 Mar 2022 17:29:50 +0100 (CET)
Date:   Tue, 1 Mar 2022 17:29:50 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     john@phrozen.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: ralink: fix a refcount leak in ill_acc_of_setup()
Message-ID: <20220301162950.GA13091@alpha.franken.de>
References: <20220228073537.31621-1-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228073537.31621-1-hbh25y@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 03:35:37PM +0800, Hangyu Hua wrote:
> of_node_put(np) needs to be called when pdev == NULL.
> 
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>  arch/mips/ralink/ill_acc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/ralink/ill_acc.c b/arch/mips/ralink/ill_acc.c
> index 115a69fc20ca..f395ae218470 100644
> --- a/arch/mips/ralink/ill_acc.c
> +++ b/arch/mips/ralink/ill_acc.c
> @@ -61,6 +61,7 @@ static int __init ill_acc_of_setup(void)
>  	pdev = of_find_device_by_node(np);
>  	if (!pdev) {
>  		pr_err("%pOFn: failed to lookup pdev\n", np);
> +		of_node_put(np);
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.25.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
