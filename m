Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19299584C33
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbiG2Gxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbiG2GxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:53:22 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AACE81B00
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 23:53:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LvJBG0jjkz4x1Y;
        Fri, 29 Jul 2022 16:53:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1659077590;
        bh=mMQHa95tZrtKAkKeRbCcHdd7SVD3uqX6L7aTavd4BmI=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=gokuqtaqlk17LP6I/P2clgOWiapPyjljq5Fa/jnOMj8Ln7tdwUAC0mIq6pqLZv4aO
         lMg02ahMBupC9gROCF1HCPi23mzBTxYMxU2kjZi/4L5TH54rktOb7l8EMpEar1e77w
         PCOlMuj6i98zKM10riGf3w100QnM/4j1AQDycpU8CyEvPP13IgfxiThCvn635/5SFd
         KnCuaUkSRLpBvu91Yevu9mtCwZzU5XNdzKkqyoSXiJ7tPQ8Q2t9dD/muO063u0lmAl
         30zdzIfNi7CXYXcjt//J/A4IsvnN44+o3KJadZFs/01KWsz3JWw+TbN/60NpCe8HoM
         OCQ7kVw2QyWAw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Miaoqian Lin <linmq006@gmail.com>, Scott Wood <oss@buserror.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Miaoqian Lin <linmq006@gmail.com>,
        Nick Child <nick.child@ibm.com>, Nate Case <ncase@xes-inc.com>,
        Kumar Gala <galak@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/85xx: Fix reference leak in
 xes_mpc85xx_setup_arch
In-Reply-To: <20220603121752.23548-1-linmq006@gmail.com>
References: <20220603121752.23548-1-linmq006@gmail.com>
Date:   Fri, 29 Jul 2022 16:53:06 +1000
Message-ID: <87pmhobeb1.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaoqian Lin <linmq006@gmail.com> writes:
> of_find_node_by_path() returns remote device nodepointer with
> refcount incremented, we should use of_node_put() on it when done.
> Add missing of_node_put() to avoid refcount leak.
>
> Fixes: 3038acf9091f ("powerpc/85xx: Add platform support for X-ES MPC85xx boards")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> changes in v2:
> - update Fixes tag.
> v1 Link: https://lore.kernel.org/all/20220603120907.19999-1-linmq006@gmail.com
> ---
>  arch/powerpc/platforms/85xx/xes_mpc85xx.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/powerpc/platforms/85xx/xes_mpc85xx.c b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
> index 5836e4ecb7a0..93f67b430714 100644
> --- a/arch/powerpc/platforms/85xx/xes_mpc85xx.c
> +++ b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
> @@ -130,6 +130,8 @@ static void __init xes_mpc85xx_setup_arch(void)
>  	mpc85xx_smp_init();
>  
>  	fsl_pci_assign_primary();
> +
> +	of_node_put(root);
>  }

For context, here is the full function:

static void __init xes_mpc85xx_setup_arch(void)
{
	struct device_node *root;
	const char *model = "Unknown";

	root = of_find_node_by_path("/");
	if (root == NULL)
		return;

	model = of_get_property(root, "model", NULL);

	printk(KERN_INFO "X-ES MPC85xx-based single-board computer: %s\n",
	       model + strlen("xes,"));

	xes_mpc85xx_fixups();

	mpc85xx_smp_init();

	fsl_pci_assign_primary();
}


So yes it's missing an of_node_put(root).

But rather than add the of_node_put(), it would be simpler to just use
of_root directly, then it doesn't need an of_node_put() at all.

But then look closer. To begin with model is assigned "Unknown", but
then unconditionally overwritten by the of_get_property() call. So
that's a waste of space.

And then if there's no model property of_get_property() will return
NULL, and then the model + strlen("xes,") would oops.

And all of that just to print the model at boot, which is not really
necessary, anyone who cares can look it up in /proc/device-tree
after the system has booted.

So please just remove the lookup and printing of model entirely.

cheers
