Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132214ED7DB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 12:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbiCaKk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 06:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbiCaKkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 06:40:23 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795761834DE
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 03:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=C4gut2Gs2tGGDwpbtPOp9BY91dLh0/JG5xCqO02wx44=; b=Dt92fm314sS//aZxisN4PUWhMl
        vfJ3J5MC94SPvvjqlBPfKm/v9OtaBueD3VRlJhHzLPc3UU0q1m6ygf5aSkKZ/AFW6nkItDUV8fuQg
        BUUtN4YkXSySDxDyubwtqloBZGxI1+kC7c8Y4WL0l4eCzXqY8WnYxXGh3Ad5C5h2iNflXrBK+m22b
        PVTUHE8yojBGUoI5ccqMFiZnJvHEriVrt6qwauRsKuPLG3E13zp5BWiZQZJO20WDksYwEEHAVefFX
        2Psy9ny0luN197a2+UUEObCjRY9rIvlrkD4tI8kyGRn1NK5Bi8jyUUlU4TknWlN4HOMeAltmq74C8
        rxpq47FQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58046)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nZsCD-0004eE-EX; Thu, 31 Mar 2022 11:38:29 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nZsCC-0007XP-Eq; Thu, 31 Mar 2022 11:38:28 +0100
Date:   Thu, 31 Mar 2022 11:38:28 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     alexander.sverdlin@nokia.com, ardb@kernel.org,
        linus.walleij@linaro.org, nico@fluxnic.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: module: Add all unwind tables when load module
Message-ID: <YkWEpC4R1roLwlN/@shell.armlinux.org.uk>
References: <20220331090909.113387-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331090909.113387-1-chenzhongjin@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 05:09:09PM +0800, Chen Zhongjin wrote:
>  	for (s = sechdrs; s < sechdrs_end; s++) {
>  		const char *secname = secstrs + s->sh_name;
> +		const Elf_Shdr *txt_sec = find_mod_section(hdr, sechdrs,
> +				strcmp(".ARM.exidx", secname) ?
> +				secname + strlen(".ARM.exidx") : ".text");

In addition to my comments on the above...

>  
> -		if (!(s->sh_flags & SHF_ALLOC))
> +		if (!(s->sh_flags & SHF_ALLOC) ||
> +			s->sh_type != ELF_SECTION_UNWIND)

Please align "s->sh_type" with the ! on the line above (don't use a tab
for this!)

>  			continue;
>  
> -		if (strcmp(".ARM.exidx.init.text", secname) == 0)
> -			maps[ARM_SEC_INIT].unw_sec = s;
> -		else if (strcmp(".ARM.exidx", secname) == 0)
> -			maps[ARM_SEC_CORE].unw_sec = s;
> -		else if (strcmp(".ARM.exidx.exit.text", secname) == 0)
> -			maps[ARM_SEC_EXIT].unw_sec = s;
> -		else if (strcmp(".ARM.exidx.text.unlikely", secname) == 0)
> -			maps[ARM_SEC_UNLIKELY].unw_sec = s;
> -		else if (strcmp(".ARM.exidx.text.hot", secname) == 0)
> -			maps[ARM_SEC_HOT].unw_sec = s;
> -		else if (strcmp(".init.text", secname) == 0)
> -			maps[ARM_SEC_INIT].txt_sec = s;
> -		else if (strcmp(".text", secname) == 0)
> -			maps[ARM_SEC_CORE].txt_sec = s;
> -		else if (strcmp(".exit.text", secname) == 0)
> -			maps[ARM_SEC_EXIT].txt_sec = s;
> -		else if (strcmp(".text.unlikely", secname) == 0)
> -			maps[ARM_SEC_UNLIKELY].txt_sec = s;
> -		else if (strcmp(".text.hot", secname) == 0)
> -			maps[ARM_SEC_HOT].txt_sec = s;
> +		if (txt_sec) {
> +			struct unwind_table *table =
> +				unwind_table_add(s->sh_addr,
> +						s->sh_size,
> +						txt_sec->sh_addr,
> +						txt_sec->sh_size);

blank line here please.

> +			list_add(&table->mod_list, &unwind_list->mod_list);

and here.

Otherwise, looks good. Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
