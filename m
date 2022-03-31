Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3604ED7D7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 12:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbiCaKhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 06:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbiCaKha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 06:37:30 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC6318023E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 03:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jLzRFqL/t5POvysK4DG5ydOswhwMgCsJK5hg+X7TMEQ=; b=XlOPqhxhWlwBvktNnKEKYKRJtm
        jszIY35PqTZzLqy2qlCbxB7dkFZ2RiJbVjRWH3+m+StkjM0uDs39KjPFnBquIgIuNhbKRs7mVasVt
        Pqh962VKR0ffi3kmVuFD66q0oO6pMoOgKml0IGqfQ4LuNyrxBqX0bvvMhByUVZkyBNmTli/cZ/NJC
        QEOQU0wPmrqscDJJyFFCQphRcQZ+Hm6S8UJ/LVDN5UnAgaboiFWFhoGPn9fTpN8YkYPo9GVCuQgQu
        iJWdTiFj4eKQ8twXtin1V5oN04UGURQtks/Ev5L3uzS5ikvsbSVlRv1Fwe/CW+Z9LsKBpLBSRIGWQ
        yhZ1+5qQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58044)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nZs9N-0004dn-1Q; Thu, 31 Mar 2022 11:35:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nZs9J-0007XH-1g; Thu, 31 Mar 2022 11:35:29 +0100
Date:   Thu, 31 Mar 2022 11:35:29 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     alexander.sverdlin@nokia.com, ardb@kernel.org,
        linus.walleij@linaro.org, nico@fluxnic.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: module: Add all unwind tables when load module
Message-ID: <YkWD8bV8wSFUobrs@shell.armlinux.org.uk>
References: <20220325011252.55844-1-chenzhongjin@huawei.com>
 <YkVQXPYkae41B7Z2@shell.armlinux.org.uk>
 <c5a918fd-5700-267d-3159-6a034cce0a73@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5a918fd-5700-267d-3159-6a034cce0a73@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 06:15:09PM +0800, Chen Zhongjin wrote:
> Hi Russell,
> 
> Thanks for comment! I've pushed v2 patch with your advises.
> 
> > > -	memset(maps, 0, sizeof(maps));
> > > +	INIT_LIST_HEAD(&table_list->mod_list);
> > > +	mod->arch.init_table = NULL;
> > >   	for (s = sechdrs; s < sechdrs_end; s++) {
> > > -		const char *secname = secstrs + s->sh_name;
> > > +		const unsigned int sectype = s->sh_type;
> > Please loose this local variable.
> 
> Also I moved "txtname" inside func params.
> 
> +		const char *txtname = strcmp(".ARM.exidx", secname) == 0 ?
> +				".text" : secname + strlen(".ARM.exidx");
> +		const Elf_Shdr *txt_sec = find_mod_section(hdr, sechdrs, txtname);
> 
> >>>
> 
> +		const Elf_Shdr *txt_sec = find_mod_section(hdr, sechdrs,
> +				strcmp(".ARM.exidx", secname) ?
> +				secname + strlen(".ARM.exidx") : ".text");
> 

Hmm. I wonder whether it should be:

		const Elf_Shdr *txt_sec;
		const char *txtname;

		if (!strcmp(".ARM.exidx", secname))
			txtname = ".text";
		else
			txtname = secname + strlen(".ARM.exidx");

		txt_sec = find_mod_section(hdr, sechdrs, txtname);

which looks cleaner to me.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
