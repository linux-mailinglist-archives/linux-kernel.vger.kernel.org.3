Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2C652FF44
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 22:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344455AbiEUUYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 16:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiEUUYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 16:24:14 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F064D43387;
        Sat, 21 May 2022 13:24:13 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t28so2860846pga.6;
        Sat, 21 May 2022 13:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/2ZAUb/3c79LcOEhAzhrL/gplGAmxHvegs+oT3E6170=;
        b=Bp1QoGAeLOyNFbJlvwluZCvsqYA/v8a3UFp7oCy9RK7CtRFTrnLZf5muVW4bsn0vo3
         +azZmvFtF7BvPNiIkq9X4n8JPBGVahcsRN+9AKaYufqzcsMvonHSpVay6/4Wh1bavFiZ
         GvyEheean2KgKTZWQj5UqGIsx0hHgf/5//axfm2PJfNeKSRWywEh3Va09XbgxGhiTKN8
         U5vNsHklenPf9TM3ANj3VUwFI/REu1KW5OEfEVjs640FWdJbpCZ3x05MCxWSWrVjFmPF
         PKrF9lk+NxwgMgiezysgyEbU8xpdDoNNZOPpfq8yYR2iWP8Avx8ERYcV+WJtSTOGKZhx
         BBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/2ZAUb/3c79LcOEhAzhrL/gplGAmxHvegs+oT3E6170=;
        b=i1gs1EuMV3nLMt67DVuTTW/w+oIUTpiytAY9x34LSPd8OR0+KGqqh4WKsXhgBTV6BB
         /hzueEiw5VkqyEzFn5Zh2vZfEV5pEYrQdIBCLEudY1/M8tKFNMR6BELM3QZ/wn9iyssk
         olMO9DyQLNSu5kW5Hbic4ytllD6DqwcT4D+9pNVlE9CLVBYzPlbGrwV84lAlhMvLJ4QU
         7is+LRVhDEWwZ4RPv6Yu+BS8Ny84Us7x9dwAc53S9XMK9cYeAC1eqGSj5NenKUA/huLa
         SEz5EvD835G0ob8hxVdC9/fuHvNxOwszrelfvcYxx/6F19HHkS2LtUsjuBWTOB5E4Ubi
         Zg1w==
X-Gm-Message-State: AOAM530fUJIRW48xRnCqfmZ8Vznm4S/KR4sKPspP6XRHWutC9OG4ApK9
        nuUW+fal/kL1rzRis8uiXo8=
X-Google-Smtp-Source: ABdhPJx32VOCtiFkS02kj04P4T3cF2gQ7pXNLVeVkKZ+tgJ1RdKsUS4MpJVxJxafNRrV45tRZgon9w==
X-Received: by 2002:a63:2d8:0:b0:3f9:d9fa:e089 with SMTP id 207-20020a6302d8000000b003f9d9fae089mr5373293pgc.255.1653164653492;
        Sat, 21 May 2022 13:24:13 -0700 (PDT)
Received: from Negi ([207.151.52.3])
        by smtp.gmail.com with ESMTPSA id a7-20020a17090a740700b001d9780b7779sm4102278pjg.15.2022.05.21.13.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 13:24:13 -0700 (PDT)
Date:   Sat, 21 May 2022 13:24:12 -0700
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] dt-bindings: mips: Convert plain text file to ReST
Message-ID: <20220521202412.GE14144@Negi>
References: <20220521015613.6197-1-soumya.negi97@gmail.com>
 <7fd80a4b-5e60-0117-b790-359f6d94aeef@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fd80a4b-5e60-0117-b790-359f6d94aeef@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 04:25:07PM +0200, Krzysztof Kozlowski wrote:
> On 21/05/2022 03:56, Soumya Negi wrote:
> > Converts .txt documentation file to ReST format(.rst).
> > 
> > Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> > ---
> >  .../devicetree/bindings/mips/cpu_irq.rst      | 56 +++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mips/cpu_irq.rst
> > 
> > diff --git a/Documentation/devicetree/bindings/mips/cpu_irq.rst b/Documentation/devicetree/bindings/mips/cpu_irq.rst
> > new file mode 100644
> > index 000000000000..601cc12caa2a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mips/cpu_irq.rst
> > @@ -0,0 +1,56 @@
> > +=============================
> > +MIPS CPU interrupt controller
> > +=============================
> > +
> > +On MIPS the ``mips_cpu_irq_of_init()`` helper can be used to initialize the 8 CPU
> > +IRQs from a devicetree file and create a ``irq_domain`` for IRQ controller.
> 
> Bindings is not a place for code. No.
> 
> > +
> > +With the ``irq_domain`` in place we can describe how the 8 IRQs are wired to the
> > +platforms internal interrupt controller cascade.
> > +
> > +Below is an example of a platform describing the cascade inside the devicetree
> > +and the code used to load it inside ``arch_init_irq()``.
> > +
> > +Required properties
> > +-------------------
> > +* compatible: Should be **"mti,cpu-interrupt-controller"**
> 
> If you wanted to add bindings, please use DT schema format (see
> writing-schema, writing-bindings and example-schema files).

Hi, 
I don't want to add bindings. I want to the convert the doc file
Documentation/devicetree/bindings/mips/cpu_irq.txt to ReST file format.

I referred to this page(https://wiki.linuxfoundation.org/lkmp/lkmp_task_list) while
creating the patch. It also mentions exceptions that should be kept as plain text 
files. Does this file count as an exception?

Thanks
Soumya
