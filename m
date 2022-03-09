Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9240D4D273C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiCIDZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 22:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbiCIDZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 22:25:44 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284C715C1BE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 19:24:45 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KCyHD0jbFz4xnG;
        Wed,  9 Mar 2022 14:24:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1646796281;
        bh=jA4RiuIh/f47BYlpUkLuQwhFdbeXYuWZfOEPcAm6HhI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dsKXnzSv+MGrSkitjJwrrc5m6QQatmio+EFM0m5Z9vPAno+CM0gp/0VcWPrfT//ei
         q1mHsJuJJ/M4wYWV5pwiSJNnGbjqJJKeKb054iUY3ipTne5jXi0+5MVluNwyc+l/gT
         uImilHKvAtrhcC0kUUDw6faxUTdt9lqQPxL4rtDz9jI7Dc5fLIecCAUDfk0RbmuO5t
         XYBrrbYT6GS2XPgl95GXdfbp40KC9/fNo6ESWPRCL8Wdy8GbuuggRYdk0U31FtE49t
         KOHiIn2REEj8jIVm5WxJ7V3lqHESdTD5zSH33WISIG19yqK0U1mxW/mhVCXyBa/Dug
         zUUiPg6XWJvLg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Hangyu Hua <hbh25y@gmail.com>, christophe.leroy@csgroup.eu,
        benh@kernel.crashing.org, paulus@samba.org, peng.hao2@zte.com.cn,
        wen.yang99@zte.com.cn
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: Re: [PATCH] powerpc: 8xx: fix a return value error in mpc8xx_pic_init
In-Reply-To: <20220223070223.26845-1-hbh25y@gmail.com>
References: <20220223070223.26845-1-hbh25y@gmail.com>
Date:   Wed, 09 Mar 2022 14:24:39 +1100
Message-ID: <87o82fn6yw.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hangyu Hua <hbh25y@gmail.com> writes:
> mpc8xx_pic_init() should return -ENOMEM instead of 0 when
> irq_domain_add_linear() return NULL. This cause mpc8xx_pics_init to continue
> executing even if mpc8xx_pic_host is NULL.
>
> Fixes: cc76404feaed ("powerpc/8xx: Fix possible device node reference leak")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>  arch/powerpc/platforms/8xx/pic.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/platforms/8xx/pic.c b/arch/powerpc/platforms/8xx/pic.c
> index f2ba837249d6..04a6abf14c29 100644
> --- a/arch/powerpc/platforms/8xx/pic.c
> +++ b/arch/powerpc/platforms/8xx/pic.c
> @@ -153,6 +153,7 @@ int __init mpc8xx_pic_init(void)

Expanding the context:

	siu_reg = ioremap(res.start, resource_size(&res));
	if (siu_reg == NULL) {
		ret = -EINVAL;
		goto out;
	}

	mpc8xx_pic_host = irq_domain_add_linear(np, 64, &mpc8xx_pic_host_ops, NULL);
>  	if (mpc8xx_pic_host == NULL) {
>  		printk(KERN_ERR "MPC8xx PIC: failed to allocate irq host!\n");
>  		ret = -ENOMEM;
> +		goto out;
>  	}
>  
>  	ret = 0;
>  	
out:
	of_node_put(np);
	return ret;
}

Proper error cleanup should also undo the ioremap() if
irq_domain_add_linear() fails.

cheers
