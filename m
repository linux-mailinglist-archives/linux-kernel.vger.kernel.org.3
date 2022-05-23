Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F431530DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbiEWKaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbiEWKaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:30:11 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CDA4B43D;
        Mon, 23 May 2022 03:30:10 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 27so11707931ljw.0;
        Mon, 23 May 2022 03:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q+D4+x9Ejx/vd1/L2sZoQuS+SholF4oqHtieSOOiG1E=;
        b=VAKzmOPm4zBP+u3nqOY493ToRu4/JG29VfNBPGjHBiFeG29uE0CFsAjL+a1dpRM+Et
         bbRHEhVBWwNyuoj9D8XSPDyhmnW+TkacBNpfYmPYN5Xos23WkSQ43kYVTlGZbPn6V+Sp
         hjITZm+z70bpXzYGNdQcrgHEcOOI6XeTLAh5mRe9wpLm/gfSMy+5HMksl/sHpvzB0rpo
         1Hf/x1CyDukUZK+V0ObW1oaE65XnhcquXI/UCG3XjY1JjQkjvTII+CHhhjuNNZUYc1Bx
         coTvHOjOkfnZ0kN0PjfWSvZ4SM7UZX8hRVdAAJ0vTHzsRz3CSrGNUgXBJB/tOLdv6Xug
         uSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q+D4+x9Ejx/vd1/L2sZoQuS+SholF4oqHtieSOOiG1E=;
        b=0IY5s5i+SFLeraVjZY6XiGb31Vn59T6WnvNm5Un9PELHDZBOKmixeuNtC/UMJARm5J
         QoF8AedYz/7HEdizPcl5S0R8cWm6vpayWGrl0UjeVIDVhjlV4pI5mxCigNHwXddkEghi
         5PDhBX1q3roq/NrFtIfmiGTpvZzT872yhxxyNoRIsPhBXV5cRykbuW+kGgGPzklz8xId
         r/ezhVFEWFwq2zV1L4cvkLiOv0enFiwwMJqq9N/V/BTIFfQXeMydwjwd/lHq6hR8YZ/y
         2rebYlzfJLEoC6kDu1LJJBoMBcYS9bnfNQno5/Ob9G23pNAnY1hXsB/6joAqtGnnmPu9
         P/vQ==
X-Gm-Message-State: AOAM532LJmvf7pCeEQii1ZhkO25y0rQrfK2jJrtHAcPcQQGfbyqmS0hS
        q6PaYs9XCFcR4EURIm/75eGDW/eDpkaOuA==
X-Google-Smtp-Source: ABdhPJwB2J5Hj96U28XtsZysxrVvnfQkgK6OUgPfkpYFHjI3AYNNsQRzgYW70iM9po7efCEROzH7ng==
X-Received: by 2002:a2e:681a:0:b0:253:bba4:231a with SMTP id c26-20020a2e681a000000b00253bba4231amr12456589lja.286.1653301809073;
        Mon, 23 May 2022 03:30:09 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id z5-20020a056512308500b0047255d211e9sm1761572lfd.280.2022.05.23.03.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 03:30:08 -0700 (PDT)
Date:   Mon, 23 May 2022 13:30:06 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Marc Zyngier <maz@kernel.org>,
        Dragan Mladjenovic <Dragan.Mladjenovic@syrmia.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chao-ying Fu <cfu@wavecomp.com>
Subject: Re: [PATCH 03/12] irqchip: mips-gic: Introduce
 gic_with_each_online_cpu()
Message-ID: <20220523103006.gklftp22pyjrkoqm@mobilestation>
References: <20220519185125.11686-1-Dragan.Mladjenovic@syrmia.com>
 <20220519185125.11686-4-Dragan.Mladjenovic@syrmia.com>
 <87k0agmwdc.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0agmwdc.wl-maz@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 09:38:55AM +0100, Marc Zyngier wrote:
> On Thu, 19 May 2022 19:51:16 +0100,
> Dragan Mladjenovic <Dragan.Mladjenovic@syrmia.com> wrote:
> > 
> > From: Paul Burton <paulburton@kernel.org>
> > 
> > A few pieces of code in the MIPS GIC driver operate on the GIC local
> > register block for each online CPU, accessing each via the GIC's
> > other/redirect register block. This patch abstracts the process of
> > iterating over online CPUs & configuring the other/redirect region to
> > access their registers through a new gic_with_each_online_cpu() macro.
> > 
> > This simplifies users of the new macro slightly, and more importantly
> > prepares us for handling multi-cluster systems where the register
> > configuration will be done via the CM's GCR_CL_REDIRECT register. By
> > abstracting all other/redirect block configuration through this macro,
> > and the __gic_with_next_online_cpu() function which backs it, users will
> > trivially gain support for multi-cluster when it is implemented in
> > __gic_with_next_online_cpu().
> > 
> > Signed-off-by: Paul Burton <paulburton@kernel.org>
> > Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
> > 
> > diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
> > index ff89b36267dd..4872bebe24cf 100644
> > --- a/drivers/irqchip/irq-mips-gic.c
> > +++ b/drivers/irqchip/irq-mips-gic.c
> 

> No SoB from the sender, odd patch format (no ---), and I didn't get a
> complete series, which makes it impossible to review things in context
> (I don't even know what the series is about).

Hi Marc,
Here is the link to the whole series:
https://lore.kernel.org/linux-mips/20220519185125.11686-1-Dragan.Mladjenovic@syrmia.com/
but yes, having a full patchset in the inbox would be much better.

@Dragan, if you are still willing to get the series reviewed, please
add both Marc and me to the lists of the recipients of each patch and
resend. Of course make sure Thomas Bogendoerfer gets the whole series too.

@Dragan, as Marc already noted the sender's SoB must be added.
Who is Chao-ying and why do you need to add his SoB to each patch?
For instance you have the patch
"[PATCH 05/12] irqchip: mips-gic: Setup defaults in each cluster"
in this series which is stated being authored by Chao-ying but
you've also added Paul' SoB there. What did Paul do for that patch
development?

-Sergey

> 
> Please fix things and resend.
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
