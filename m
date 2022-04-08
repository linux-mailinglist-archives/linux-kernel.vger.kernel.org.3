Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAD44F96BA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbiDHNe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiDHNex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:34:53 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B91E1E814D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 06:32:50 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m41-20020a05600c3b2900b0038eab72923aso333684wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 06:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pDC9L0lcr1QHf8qfh13ooZQp7CHb5z3+opmiIbCpO5g=;
        b=jmrr9ES2B8XWO03NQZzQI4F2KKQwsDwVsKRsbWp63khlAKSkmi9C+eilQOfzSCKath
         b3no7GA5N4PEoy7SBC5oRO6EjCTlned/SX99tuyEsBpExUCpvQy48bLQ5u/Ei8+f7+70
         JjoSwIq3ChdypUMSjHJMZXtPDo6LBN4VWGLzEibGOseVKZTsmd8rOjKDQID9fcDLqQLJ
         NDZUZYPMPUPPbnyc0e1+Kc+f3IMnC7PXOXkmbrtOHF4HITAHh0MbxX93nNvzfRQLYfBj
         JRUU1LkEyrPi6gVeOgj1vX501pObHoK8SRG8vDH2evWMkgLQFKGNabXNKtnXXbfryVtb
         7B1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pDC9L0lcr1QHf8qfh13ooZQp7CHb5z3+opmiIbCpO5g=;
        b=i2CJOED3d9oFbJqSSo2oPfpgstlJ4VrQeu96xl58xh41f2VLk7isOyi+xzXLnv3ZlF
         N4rizCozUzRQxr4bh36LuESKhjamrebLKQIuuTedYv7n7jXI+XI6E9HWvYn+r6mM3OF2
         ZE1wf/VTTGTOuuDYZIEuU//aEMHM9fGbvSode5q1AAbPF17xn0EVwTX4vjQOx4a8v3T3
         8FPjMYXRZmsCB30EhYOyIlxCB1CGpyYyrVQ5YpEbbtLkqwBI7V9VwUrQcDz6XOsxW4pI
         ULAF9HK7pVKk5rLRDERxYmZjF2RgXuN55uBQ7u8qGG+XhOpNLkX0/kmb2VVd9ACfJCHx
         QgIQ==
X-Gm-Message-State: AOAM531IYz6TzFwZxjgrKOfE5GE6LJgBhfoRddv2fyECCpAxtqAGjc7a
        sE2CkfCYvgPmbGAQPBcunT8Gww==
X-Google-Smtp-Source: ABdhPJyeiw4bwAQfXU133L8POlyN9oSdy3Td0K/5lQO2DSbqQQ73iq/K4PM/64Hhgx/RD0NCcuI3hQ==
X-Received: by 2002:a05:600c:34c5:b0:38c:30e3:1e6c with SMTP id d5-20020a05600c34c500b0038c30e31e6cmr17255479wmq.144.1649424768622;
        Fri, 08 Apr 2022 06:32:48 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id v26-20020a1cf71a000000b0038ea373273bsm1707695wmh.47.2022.04.08.06.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 06:32:48 -0700 (PDT)
Date:   Fri, 8 Apr 2022 14:32:46 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Doug Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Travis <mike.travis@hpe.com>
Subject: Re: [PATCH v3 1/1] soc: fujitsu: Add A64FX diagnostic interrupt
 driver
Message-ID: <20220408133246.fyw5554lgli4olvg@maple.lan>
References: <20220331092235.3000787-1-hasegawa-hitomi@fujitsu.com>
 <20220331092235.3000787-2-hasegawa-hitomi@fujitsu.com>
 <YkWVTEG5oFO82GPL@kroah.com>
 <CAK8P3a0jnzse4sG58taO5+Yd5vCgh1uddqbtAuim_z9r15Q3BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0jnzse4sG58taO5+Yd5vCgh1uddqbtAuim_z9r15Q3BA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 05:44:55PM +0200, Arnd Bergmann wrote:
> On Thu, Mar 31, 2022 at 1:49 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > +
> > > +static irqreturn_t a64fx_diag_handler(int irq, void *dev_id)
> > > +{
> > > +     handle_sysrq('c');
> >
> >
> > Why is this calling this sysrq call?  From an interrupt?  Why?
> >
> > And you are hard-coding "c", are you sure?
> 
> This is an actual sysrq driver in the traditional sense, where you can send
> a single interrupt to the machine from the outside over a side channel.
> 
> I suggested sysrq instead of just panic() to make it a bit more flexible.
> Unfortunately there is no additional data, so it comes down to always
> sending the same character.
> 
> It would be possible to make that character configurable with a module
> parameter or something like that, but I'm not sure that is an improvement.
> Maybe you have another idea for this.

Given the interrupt can be dismissed then offering non-fatal actions in
response the chassis command seems reasonable.

There is some prior art for this sort of feature. AFAICT SGI UV has a
similar mechanism that can send an NMI-with-no-side-channel to the
kernel. The corresponding driver offers a range of actions using a
module parameter:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/platform/uv/uv_nmi.c#n180

I don't think a hardcoded 'c' makes any sense. With a hardcoded argument
it is just obfuscation. However it is certainly seems attractive to be
able to reuse handle_sysrq() to provide a more powerful set of actions.


Daniel.
