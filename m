Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFC5494F3F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238649AbiATNnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiATNnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:43:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0582C061574;
        Thu, 20 Jan 2022 05:43:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB9A4B81D5B;
        Thu, 20 Jan 2022 13:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD52C340E8;
        Thu, 20 Jan 2022 13:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642686195;
        bh=D+Etye9r3fua1x02UnecAbZv0CalmuxTOWCQ+e8HzdE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cN8TeiZRwruoIRJkOoV5cCJrRkANf7l3v6f2dnF2xlBmUXAwCKjGM3kmUmmr7lfcJ
         1APkSDv+D1H3WQp3uuaV0kT/S8OeoYHOyoCm+Uh5ZwvEw7IhawBDNn89d/q5eyXPa3
         nAY2sqd8hpAZSIAYJGf70xVxfIBc+dqte1gPEuhjwCNzY97jFtY3PEtY924x+w0WZd
         wAeTD/djlb2LaOfPp5PAZ48mZs2FwdBxQt7SiLMX8KePhQm69b789EqQ8wWQDq0dC/
         8Od7DRhnmvf6YwO+Awvtgi4eoym2J8Zy/zeuP32XDNFMzEGlHelD0Dh2qQJ7xmBcHR
         1Xfu4zn6tGfTQ==
Received: by mail-vk1-f169.google.com with SMTP id z15so393775vkp.13;
        Thu, 20 Jan 2022 05:43:15 -0800 (PST)
X-Gm-Message-State: AOAM530ztEEKfU5JodV39Z2gFeZVMW1ONO+knS9Gubx6OGhHrhE4BxPl
        /+H7A+6YWz03uQspLPqUgts+iT3ffL3usEUCN94=
X-Google-Smtp-Source: ABdhPJxsPoD4QKSG5cjRmiwRNbBq9kp7PjD2iW5iWTPRRES5wTkmV/37UExZW0GDHhLl6tuiT3nFW4CEpN2qDzbKvC8=
X-Received: by 2002:a1f:2844:: with SMTP id o65mr15161979vko.2.1642686194514;
 Thu, 20 Jan 2022 05:43:14 -0800 (PST)
MIME-Version: 1.0
References: <20220120073911.99857-16-guoren@kernel.org> <CAK8P3a0Mr2m2dVoVss59cN-9X7GVBD29VQLo3m4xswRznk_WUQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0Mr2m2dVoVss59cN-9X7GVBD29VQLo3m4xswRznk_WUQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 20 Jan 2022 21:43:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTGD_Ks2pO4jXx+QbiLV4nkjzk6mP-xKJOCvHtGTeFfOQ@mail.gmail.com>
Message-ID: <CAJF2gTTGD_Ks2pO4jXx+QbiLV4nkjzk6mP-xKJOCvHtGTeFfOQ@mail.gmail.com>
Subject: Re: [PATCH V3 15/17] riscv: compat: Add UXL_32 support in start_thread
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        inux-parisc@vger.kernel.org,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 9:39 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jan 20, 2022 at 8:39 AM <guoren@kernel.org> wrote:
> > +
> > +#ifdef CONFIG_COMPAT
> > +       if (is_compat_task())
> > +               regs->status |= SR_UXL_32;
> > +#endif
>
>
> You should not need that #ifdef, as the is_compat_task() definition is
> meant to drop the code at compile time, unless the SR_UXL_32
> definition is not visible here.
I almost put CONFIG_COMPAT in every compat related code, because I
hope the next arch that wants to support COMPAT could easily find
where to be modified.

>
>          Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
