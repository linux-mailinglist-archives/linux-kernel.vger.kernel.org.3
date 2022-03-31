Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DAF4EDDE8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 17:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbiCaPwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 11:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239097AbiCaPwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:52:04 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0C45EBD1;
        Thu, 31 Mar 2022 08:50:16 -0700 (PDT)
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M4rkF-1nZ7lg3xXr-00208u; Thu, 31 Mar 2022 17:45:11 +0200
Received: by mail-wr1-f42.google.com with SMTP id h23so341057wrb.8;
        Thu, 31 Mar 2022 08:45:11 -0700 (PDT)
X-Gm-Message-State: AOAM531vONq4YljMzzg4lpYoPH0G7AIFTXF8x2q34N+BssxIH7OS/ASN
        d1rpbebSZK9epEeXVdurRY7LIGtroKu09OIahGI=
X-Google-Smtp-Source: ABdhPJyINqj20BgrqMVql8P0dLX86b0MRGwI7ZaFK1fyvU3QQ0XJBE7cU28CP6wHHSEMpvM8IDEW2Jl0QfL2BRdivwU=
X-Received: by 2002:a5d:6505:0:b0:205:9a98:e184 with SMTP id
 x5-20020a5d6505000000b002059a98e184mr4338853wru.317.1648741511582; Thu, 31
 Mar 2022 08:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220331092235.3000787-1-hasegawa-hitomi@fujitsu.com>
 <20220331092235.3000787-2-hasegawa-hitomi@fujitsu.com> <YkWVTEG5oFO82GPL@kroah.com>
In-Reply-To: <YkWVTEG5oFO82GPL@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 31 Mar 2022 17:44:55 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0jnzse4sG58taO5+Yd5vCgh1uddqbtAuim_z9r15Q3BA@mail.gmail.com>
Message-ID: <CAK8P3a0jnzse4sG58taO5+Yd5vCgh1uddqbtAuim_z9r15Q3BA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] soc: fujitsu: Add A64FX diagnostic interrupt driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:kXY2uz+9T3skG3/rQcpWLGZV/wmu9mwnbrEErlu2X5LOl7QcaTT
 LPDDapDBHZn06WODoqpZUW0RO2MsD2bQt6Xr/35LwBOEyinlwc1SF/49dcvUBpewMQnoIci
 NBtzeBbMcytU/nrAQ9EPo01QzsnpisZy5TKLjvbSJUFWeI1lC2Ozrt0TUoTh0MGLRq3f0Qx
 wucjN2gro/MlvLRfWWbUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8/ixu57X/F0=:D7nw2WCUnDEYMcmc0d8TcP
 Xj+tteEiznHSY2WADjFLxTF4m1kLKXfjmGE8i0IfZPNBuNfv/6/aGaRz7T9lSv0qeoxsRt/Zw
 xPLBk737n2QlgdD5UAErbVLeE8uRZbkJ1LIMuO6KjugibpE6SPS8GSPfpNkAZdiApPWLbWrG7
 0NQseEkwFT2nRH1pFjqLfMbq9XeM7tAvQHJmJQ7pT6NjT8nqfLGpju6bgOW+MUABrV5HRh9Gp
 42RHGUQQfmLfjdU7uP8FeSvP8ArhGOxk+2eqg/cgUUYrlHWxc12kJK6coa3h1UkU0lSeH4Lat
 XC7X/NiqdBrCEA94x8q/CtXItiQ1S7jIxFy47drnwCjfKpno5FCGUJzbq8IIPcZBhSpx1AWWa
 W6bNBFQsXx0wq2+6cWfWxFvRt1kgDxktMK3swH1GIcq1aV1u0JIPkZY4sQAjuQiVp3KLHpLf6
 POd50MMfwItMC8Wo5REw7b6t0WB+/E/mUg5gOMFvbmOjj2W98jBloeE4AWVHanVy8dsIyBKaL
 4H3hvV2qJEDdZZUqapNpAVS81xzhzT7/bohsTK0ArU38d3ZA9VWXL4NV0ldLMx6e1W8n0A9Ah
 vv9+Yya/hNdfKV+PDbeNhrVVW+s0F5oiVilmg3jb3zECV6dJSNvjXDF/i5jpR5EZFiER9f0jS
 9/Er9A+EX+NvTS8D1vzbnM65TsjfR1FOF4nABgr9OCwPMivAY9CRlWr+MAFXYjRnbBeRyqy3D
 FGUPfw9Sa8mfIMsISlqgKKpGpk8/hk2kPl+EBxVptcWCpu1UxIb70w5gYGMdj3/fi8OfYwXLb
 PZLYCFxpLyVmndjbvwhzGihlanHq+A5dGpgiclFYixTXRkyN+g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 1:49 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > +
> > +static irqreturn_t a64fx_diag_handler(int irq, void *dev_id)
> > +{
> > +     handle_sysrq('c');
>
>
> Why is this calling this sysrq call?  From an interrupt?  Why?
>
> And you are hard-coding "c", are you sure?

This is an actual sysrq driver in the traditional sense, where you can send
a single interrupt to the machine from the outside over a side channel.

I suggested sysrq instead of just panic() to make it a bit more flexible.
Unfortunately there is no additional data, so it comes down to always
sending the same character.

It would be possible to make that character configurable with a module
parameter or something like that, but I'm not sure that is an improvement.
Maybe you have another idea for this.

> > +static void a64fx_diag_interrupt_clear(struct a64fx_diag_priv *priv)
> > +{
> > +     u32 mmsc;
> > +     const void __iomem *diag_status_reg_addr;
> > +
> > +     diag_status_reg_addr = priv->mmsc_reg_base + BMC_DIAG_INTERRUPT_STATUS_OFFSET;
> > +     mmsc = readl(diag_status_reg_addr);
> > +     if (mmsc & BMC_INTERRUPT_STATUS_MASK)
> > +             writel(BMC_INTERRUPT_STATUS_MASK, (void *)diag_status_reg_addr);
>
> No need to wait for the write to complete?
>
> You shouldn't have to cast diag_status_reg_addr, right?

I think the cast is needed because the declaration of
'diag_status_reg_addr' incorrectly
marks it as 'const'. However, this should still trigger a 'make C=1'
warning with sparse
because it is now missing the __iomem annotation.

The correct solution of course is to remove both the cast and the 'const'.

       Arnd
