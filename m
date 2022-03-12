Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189A44D6BC8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 03:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiCLCCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 21:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCLCCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 21:02:20 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEA129E00F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 18:01:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A6318CE2B35
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 02:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D59C340E9;
        Sat, 12 Mar 2022 02:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647050472;
        bh=jlJTQC9rL0Ohy92tmOfNWwQooasADfiPhpQpT96wHT8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=fbl40iQmu8txLiFBKEbYE87/V1sERSDFH6uAO0+5GS7MChg26w54kZeRfO4Nzrwqj
         ZbrLkjWJLk2TktdvkZwqaiRpn/Cu0ANALocft3bD+gI2aoYHndgi9m2ylD1KOqYteX
         siqCfjrZ8kVfjYh7PsfBqBRfGTl0CQHcSE2UqD6dAbbgX47pPeLrvXuG5x5Dp0Ln4n
         7H7YaPpX/4HKIPs1oOTUJYsCw5Syl/j4HbtAQIdiLQ6Iccwov3+zTQZsBeaiU96pJQ
         iuH1YRvi3w7fzTFy/pacesE9nssq3TfFIbjhGBiHswZSZBPE4iENNXUQSnIN6t7PEx
         bXd/T5MfXfOlw==
Date:   Fri, 11 Mar 2022 18:01:11 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Miaoqian Lin <linmq006@gmail.com>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shannon Zhao <shannon.zhao@linaro.org>,
        Julien Grall <julien.grall@arm.com>,
        xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm/xen: Fix refcount leak in xen_dt_guest_init
In-Reply-To: <20220309102442.14726-1-linmq006@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2203111756000.3497@ubuntu-linux-20-04-desktop>
References: <20220309102442.14726-1-linmq006@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2022, Miaoqian Lin wrote:
> The of_find_compatible_node() function returns a node pointer with
> refcount incremented, We should use of_node_put() on it when done
> Add the missing of_node_put() to release the refcount.
> 
> Fixes: 9b08aaa3199a ("ARM: XEN: Move xen_early_init() before efi_init()")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Thanks for the patch!


> ---
>  arch/arm/xen/enlighten.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index ec5b082f3de6..262f45f686b6 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -424,6 +424,7 @@ static void __init xen_dt_guest_init(void)
>  
>  	if (of_address_to_resource(xen_node, GRANT_TABLE_INDEX, &res)) {
>  		pr_err("Xen grant table region is not found\n");
> +		of_node_put(xen_node);
>  		return;
>  	}

This is adding a call to of_node_put on the error path. Shouldn't it
be called also in the non-error path?

Also, there is another instance of of_address_to_resource being called
in this file (in arch_xen_unpopulated_init), does it make sense to call
of_node_put there too?
