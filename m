Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EC9539456
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 17:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345938AbiEaPyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 11:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243830AbiEaPx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:53:59 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F3E8DDF5
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:53:58 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id x11so4943834uao.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BOXJpZ0+BUAE//wNjHDEkwjUXPD0snUpl09DbEzmQhE=;
        b=RsBYSrMCSxK918LuTyxNjJc7E/HnxGnKuFo5NpHNQj8246AEq5DarJ/c8T9BzuNxGf
         nCE0rxsBMIplRG6nsFE3gHIRTTuUH9iIjG7BMMPmqyyT0vwgN1yDLDoEDer19lYBGTmi
         Z+x+pxs+QbgRzZJPppHXsqeg7/JSZHQDQ9psTsCn29mpd5BscViKpxkcVN5ZAWi2qVQG
         OZOmd31h74Nr+7/G7yQ1qJrc9tGIxESxHEH9YoLEBVeOgdnjEvJZylDhWXKqu0Lw08fQ
         g0aQAphtgQ+euM86Sx77ukH5UjuS8O9UhPdRhxXROwpnTO3rPBM/7TZhI3zqcZvvI0u5
         xs6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BOXJpZ0+BUAE//wNjHDEkwjUXPD0snUpl09DbEzmQhE=;
        b=x/tZPzgfy/3Lu1btk74Cw9h8GNO7bGnlMoic5+sAkwc7JZfAIY2J1tkapVUPMJTGPd
         mgAjxVHHgNluYMGGFgxraMruVhzCvbGx9wTyka0iCM3Ynt2GwLAjvKX+R+/SBXQFzxzH
         pvMeZlNsImdxjbteUACqgXZzgv1XLZPSteSa2YeFadEa58Np6ya7LQh86v/R4YIbDbqM
         bkudAIWPP2m35oJxz5JSlISyvUzmqzW1UtRNkHbXS9NcnfGn2t+kYZ2UIk7TzG0aOV8G
         xykZq+WxXPTZUjtUP5RZSCaTHzZKt/7j1+7hM8YPKerx/Sa+GoYWz0/g/WugScaNVmj1
         pIow==
X-Gm-Message-State: AOAM5310L4322jQZhtp8DFwp4zGpJboPSgEz9NEEyYg6LC7Yd/pOJKr7
        bwydmuZx1OxuvfIY0z3PZlUY6wL1d1i7gmiVIIN6iJgRFdLkcJ6vAl4=
X-Google-Smtp-Source: ABdhPJy/RAcdBAFAmWFQf6AWpLc9uHEKCp+uQkEH8BsIzrXYzln0GKbNcKGbF7WUtO5A1NUANhEJQQ2eiaBIaPy5iok=
X-Received: by 2002:ab0:2bc9:0:b0:362:8750:8032 with SMTP id
 s9-20020ab02bc9000000b0036287508032mr21707440uar.118.1654012437602; Tue, 31
 May 2022 08:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220531115942.1686812-1-chenhuacai@loongson.cn> <e7cf33a170d0b4e98e53744f60dbf922@kernel.org>
In-Reply-To: <e7cf33a170d0b4e98e53744f60dbf922@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Tue, 31 May 2022 23:53:46 +0800
Message-ID: <CAAhV-H6ZoqSty=yaAUPMg1QTamfwuYODB_mxf_o=HCJ1boawQg@mail.gmail.com>
Subject: Re: [PATCH 1/2] irqchip: Adjust Kconfig for Loongson
To:     Marc Zyngier <maz@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marc,

On Tue, May 31, 2022 at 8:52 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2022-05-31 12:59, Huacai Chen wrote:
> > We are preparing to add new Loongson (based on LoongArch, not
> > compatible
> > with old MIPS-based Loongson) support.
>
> Please drop this blurb from all your patches. It adds zero information.
OK, will be removed.

>
> > HTVEC will be shared by both old
> > and new Loongson processors, so we adjust its description. HTPIC is
> > only
> > used by MIPS-based Loongson, so we add a MIPS dependency. PCH_PIC and
> > PCH_MSI will have some arch-specific code, so we remove the
> > COMPILE_TEST
> > dependency to avoid build warnings.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> No cover letter, no indication of what this applies on, no mention
> of how this relates to the ongoing irqchip review.
>
> What do you want me to do with this?
Sorry about the confusion; as suggested by you and Arnd, these two patches
are the minimal changes required on irqchip's side to make the port build,
without introducing any non-reviewed pieces of code. I originally wanted to
send the patches then quickly reply you in the asm-generic thread, but
unfortunately I lost Internet connectivity at my site until you have replied.

You are knowledgeable, and have taught me much; I owe you many thanks.
However, as my native language is not English, I realize I may sound impolite
or inappropriate from time to time, making some of you unhappy. (Actually I
had to ask Xuerui to translate this reply for me, in case I get something
wrong again.) I'll try to improve in the future and I hope you'll understand.

Apologizes for the confusion again,

Huacai
>
>          M.
> --
> Jazz is not dead. It just smells funny...
