Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFA14B2D10
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350641AbiBKSl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 13:41:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbiBKSl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:41:26 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F078D25B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:41:23 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E2EE1EC05DE;
        Fri, 11 Feb 2022 19:41:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644604878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zMuJMdA0rBX7JUREv1an+M91xZteNtLKe6TL7rOUDm8=;
        b=kny4RIW1G1W4VL7Wc34nYKT92JoAEzIr63ES31EjSCuJ01fu1n4Qpg3sFS03D+1hWGbblS
        mXFVRHkY8rbaQRI0haxrNESCOgROeQ1QVQkB4UL/yPupUF0XHpz9epkjVAEyf8zX+kF3Wg
        kwqrEBHzJenvAFM6dx6jZ7OTnSWIMEU=
Date:   Fri, 11 Feb 2022 19:41:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        daniel.kiper@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH 2/2] x86/boot: Add setup_indirect support in
 early_memremap_is_setup_data
Message-ID: <Ygat0FvdP3bWlJbx@zn.tnic>
References: <1643303056-22272-1-git-send-email-ross.philipson@oracle.com>
 <1643303056-22272-3-git-send-email-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1643303056-22272-3-git-send-email-ross.philipson@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 12:04:16PM -0500, Ross Philipson wrote:
> The x86 boot documentation describes the setup_indirect structures and
> how they are used. Only one of the two functions in ioremap.c that needed
> to be modified to be aware of the introduction of setup_indirect
> functionality was updated. This adds comparable support to the other

s/This adds/Add/

> function where it was missing.
> 
> Fixes: b3c72fc9a78e ("x86/boot: Introduce setup_indirect")
> 

No need for a newline here.

> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
> ---
>  arch/x86/mm/ioremap.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index b45e86e..9129b29 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -670,17 +670,34 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
>  
>  	paddr = boot_params.hdr.setup_data;
>  	while (paddr) {
> -		unsigned int len;
> +		unsigned int len, size;
>  
>  		if (phys_addr == paddr)
>  			return true;
>  
>  		data = early_memremap_decrypted(paddr, sizeof(*data));
> +		size = sizeof(*data);
>  
>  		paddr_next = data->next;
>  		len = data->len;
>  
> -		early_memunmap(data, sizeof(*data));
> +		if ((phys_addr > paddr) && (phys_addr < (paddr + len))) {
> +			early_memunmap(data, sizeof(*data));
> +			return true;
> +		}
> +
> +		if (data->type == SETUP_INDIRECT) {
> +			size += len;
> +			early_memunmap(data, sizeof(*data));
> +			data = early_memremap_decrypted(paddr, size);

That can return NULL.

> +
> +			if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
> +				paddr = ((struct setup_indirect *)data->data)->addr;
> +				len = ((struct setup_indirect *)data->data)->len;

As before, use a helper variable here pls.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
