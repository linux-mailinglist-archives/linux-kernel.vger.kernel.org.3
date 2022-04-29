Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A680B515301
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 19:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355622AbiD2RzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 13:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbiD2RzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:55:07 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8ED40913
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 10:51:48 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i5so11706873wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 10:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q4LKjQ1U2+sf1jDRR/wmFcJSlftJ5m8wtTLrONCN7K8=;
        b=Mx9deQE4aebSBXjeg6/n+XvihVNWEA+R8LqgPvhusqySIVjYYu8XmzEqUKw6XzJa7I
         Z08/qGNiLiEyw5O5QmyuF/nV1L3vVx+v4ggEd3Uj2Su3+m0amIxPGQFaeeQfmPJwVcwP
         P+nSL/8PRJp+3gWuW/Oc1dOSpQhkVJbKlPzx6iKAzRT8JCFcBQbeXbA0rvaP8OhZTwvI
         t20LVqGVI+rA0pPAufsArJWkTbnbqVDzW5HK3fi0iL2MAKgWXwfRKh26qrH9VMCXYEa/
         cmDwpt5gRCnYF15UTyZzu1ZgxU8DSL/izY7on7B2LSowGNpRyoa0X+f/pGoFmAH0JhDx
         yX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q4LKjQ1U2+sf1jDRR/wmFcJSlftJ5m8wtTLrONCN7K8=;
        b=iWTHXO22UUcKUUbioh6QVc+6zaJ4pq7626jHoY9sGkiUP3tXBPru6JQvQDmO42amkR
         x6FTc1vWqPrPsdKe3pfutVAoFkH9I+KPHC4LfkcNjPcyIuWTInXQbdFQVexV3/JQnJeA
         um6alR0HFYg1LCD8yVewHInADHj6NO/MymyBpa3BTWPgI7Y+STx2VCGlawmGUzCSnYWj
         kayUVm9Ilb6z7ATDKIM6KbYlOK5jni1aU0/g5fFUm/nowMwKEVG7TWhwttQBNkDB9sSK
         UxM2oDXjf/ITGIV6N0WgVtZ/cSnTSby38CDX3q9X2gmNHNLJMFdHeyVf6dBLkVbNEUyB
         VUjA==
X-Gm-Message-State: AOAM530A1w0wkwr6kRgMCz0kiBJCUt0/riJ+MEiLZjWtInhgbHdr+hFI
        uC7Cwpqn7iBxLRCW40eG5V0VtQ==
X-Google-Smtp-Source: ABdhPJwYldJfCI+pcbRbU7bTqfY3Xe/BYdNH363pA7ya48kQwqt8w0hNEG7l8RuXkES4c+eNj4ts9g==
X-Received: by 2002:a05:6000:2a6:b0:20a:f2c7:4e70 with SMTP id l6-20020a05600002a600b0020af2c74e70mr205584wry.85.1651254707279;
        Fri, 29 Apr 2022 10:51:47 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id 62-20020a1c1941000000b00393a1a024desm7422410wmz.14.2022.04.29.10.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 10:51:46 -0700 (PDT)
Date:   Fri, 29 Apr 2022 18:51:44 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] irqchip/exiu: Fix acknowledgment of edge triggered
 interrupts
Message-ID: <20220429175144.czymk5alqvqobzzf@maple.lan>
References: <20220427142647.1736658-1-daniel.thompson@linaro.org>
 <CAMj1kXEYO_HRwZ=Wz5aTWN8XZctemVv2op4B2=DbFEozuxTNVw@mail.gmail.com>
 <20220429132858.gaqhjrxblciacvki@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429132858.gaqhjrxblciacvki@maple.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 02:28:58PM +0100, Daniel Thompson wrote:
> On Wed, Apr 27, 2022 at 05:29:33PM +0200, Ard Biesheuvel wrote:
> > On Wed, 27 Apr 2022 at 16:27, Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > >
> > > Currently the EXIU uses the fasteoi interrupt flow that is configured by
> > > it's parent (irq-gic-v3.c). With this flow the only chance to clear the
> > > interrupt request happens during .irq_eoi() and (obviously) this happens
> > > after the interrupt handler has run. EXIU requires edge triggered
> > > interrupts to be acked prior to interrupt handling. Without this we
> > > risk incorrect interrupt dismissal when a new interrupt is delivered
> > > after the handler reads and acknowledges the peripheral but before the
> > > irq_eoi() takes place.
> > >
> > > Fix this by clearing the interrupt request from .irq_ack() instead. This
> > > requires switching to the fasteoi-ack flow instead of the fasteoi flow.
> > > This approach is inspired by the nmi code found in irq-sun6i-r.c .
> > >
> > 
> > How are level triggered EXIU interrupts affected by this change?
> 
> Functionally they should not be affected simply because the controller
> does not care when (or even if) software writes to IREQCLR... and
> testing on SC2A11/Developerbox with a hacked gpio-keys driver does
> back this up.

If, and only if, you do the experiment properly... and this afternoon
the penny dropped and I fixed that.

In summary, level triggered interrupts require IREQCLR to happen at EOI
(to avoid spurious re-entry) whilst edge triggered interrupts require
IREQCLR to be acked before ISR is entered (to avoid spurious dismissal).

v2 is on its way...


Daniel.

