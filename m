Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB9553E884
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiFFKMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbiFFKMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:12:35 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7781611EC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 03:08:53 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id p10so19156688wrg.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 03:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0RV+F6arkyT/aJPRBm6+IBJsF9KPkstWE0UH1z609Qo=;
        b=UDCenwDu62ZZ5s6UnVflatrxJRwEFWIX/ZzZ2ukt8uBk7uew6UbMwm9LJCyufH/MFM
         dmYEM/4Wsbx6Kp4eXUBl2U4HkP8ESFmu+jCE3Y0lpcuMGIz/5X6EQ2v7LH4Nr4JIWXMC
         x7oTYz6ediTp3erUqgrR+tvzGpa41h7nrKoHmdgxGHen9pSh85bJfUnmvhho/WlbJ/QY
         HR2DlVOk4RWh5xdOfNYdfv7TgofjFUoSSJRt2yGWbq43nQY6IerM61OjUZPEnbVYLQLW
         mTxV5I51BS3h/S3NgTgwVOivSYDQVWZEcs3M9c1m7IWYy4C0xKsMqwDumj5TweyEAfzI
         /50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0RV+F6arkyT/aJPRBm6+IBJsF9KPkstWE0UH1z609Qo=;
        b=XG58nObEPCMJdbPmYfrUJx3qw5mmJIF0dbKpOCUdsCStnTFR2MPEoKGWMeiDHa+0wo
         h7MG0aiEKkyAk8xHCOEjlHXyvIHCeu6aRBkBlxrAT+J3SIdIdhwrpm32DttTTSdqqxfR
         Ah8BgTGJP68UWxpKpwB9hw++NnsPiDfrVD4g5KJaw5B7dri33VR0wxbQzOGrBm6RyCeK
         dsjAtJmcypNm9zz5WOfuqyliEgZIIfnEKGbO4wkdc47PnSdUcqzgX3B6tmU+9PDZCt+l
         wIsR/koSaiH+rT79oQDEqEfFy6dHFrkXXdU+r4I5eANdVgpm7DVJizhEdYJ8dIHJ4Bxr
         JIaw==
X-Gm-Message-State: AOAM532b/W40d9xnGnc0Y0X6ukSk3yGaCyijElgCu7BlA3eOcoZnq+Wt
        HRfeNdoYFY5V2YzYeNAo+Xzneg==
X-Google-Smtp-Source: ABdhPJyjZZxp1MCCp22/FO1cs1Z6zivtBSY9PHQHJlYm7/CBnxImI3Gdq4JnhnR20WXNWCp/v8PpiQ==
X-Received: by 2002:a05:6000:2ab:b0:211:7fef:7730 with SMTP id l11-20020a05600002ab00b002117fef7730mr20446387wry.533.1654510131375;
        Mon, 06 Jun 2022 03:08:51 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id q18-20020a5d61d2000000b0020d0c9c95d3sm11964896wrv.77.2022.06.06.03.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 03:08:50 -0700 (PDT)
Date:   Mon, 6 Jun 2022 11:08:48 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     richard clark <richard.xnu.clark@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        s32@nxp.com, leoyang.li@nxp.com, catalin-dan.udma@nxp.com,
        bogdan.hamciuc@nxp.com, bogdan.folea@nxp.com,
        ciprianmarian.costea@nxp.com, radu-nicolae.pirea@nxp.com,
        ghennadi.procopciuc@nxp.com
Subject: Re: Question about SPIs' interrupt trigger type restrictions
Message-ID: <20220606100848.ir4bkj5qsskxe6in@maple.lan>
References: <CAJNi4rNwPQf747UM_hiYYwL=HDxg8QnPpfFPv1PfrtN9ZP1y1g@mail.gmail.com>
 <35f95ba3-8a7b-7918-0f9d-e14274a5ffe9@arm.com>
 <CAJNi4rMbBbLP2Tsv-wnnJKt4Y0moOE5-sNaZN1fCty908pwAKw@mail.gmail.com>
 <87ee0gn5rq.wl-maz@kernel.org>
 <CAJNi4rOHYqL8jN5Ju3ndANc-5Te4WEc-z5YGxCN-2ZtN8vf1cQ@mail.gmail.com>
 <20220530084039.7rjjbm4gkplg5747@maple.lan>
 <CAJNi4rNBXs4mwv2dsR+DrV9Of6_eb3Wm3FAJxZsWv5LHnVmVxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJNi4rNBXs4mwv2dsR+DrV9Of6_eb3Wm3FAJxZsWv5LHnVmVxQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2022 at 08:03:02PM +0800, richard clark wrote:
> On Mon, May 30, 2022 at 4:40 PM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Thu, May 26, 2022 at 08:09:32PM +0800, richard clark wrote:
> > > CC'ing some nxp guys for the S32G274A SOC...
> > >
> > > On Thu, May 26, 2022 at 2:54 PM Marc Zyngier <maz@kernel.org> wrote:
> > > > richard clark <richard.xnu.clark@gmail.com> wrote:
> > > > > On Thu, May 26, 2022 at 3:14 AM Robin Murphy <robin.murphy@arm.com> wrote:
> > > > > > On 2022-05-25 11:01, richard clark wrote:
> > > > From the GIC500 r1p1 TRM, page 2-8:
> > > >
> > > > <quote>
> > > > SPIs are generated either by wire inputs or by writes to the AXI4
> > > > slave programming interface.  The GIC-500 can support up to 960 SPIs
> > > > corresponding to the external spi[991:32] signal. The number of SPIs
> > > > available depends on the implemented configuration. The permitted
> > > > values are 32-960, in steps of 32. The first SPI has an ID number of
> > > > 32. You can configure whether each SPI is triggered on a rising edge
> > > > or is active-HIGH level-sensitive.
> > > > </quote>
> > > >
> > > > So I have no idea what you are talking about, but you definitely have
> > > > the wrong end of the stick. Both the architecture and the
> > > > implementations are aligned with what the GIC drivers do.
> > >
> > > What I am talking about is - The SPI is triggered on a rising edge
> > > only, while the falling edge is not as the document says. But I've
> > > observed the falling edge does trigger the SPI interrupt on my
> > > platform (the SOC is NXP S32G274A, an external wakeup signal with high
> > > to low transition to wake up the SOC - 'Wakeup/Interrupt Rising-Edge
> > > Event Enable Register (WIREER)' and 'Wakeup/Interrupt Falling-Edge
> > > Event Enable Register (WIFEER)', WIFEER set 1 and WIREER  set 0
> > > works).
> > >
> > > I don't know why the GIC has such a behavior and what the subtle
> > > rationale is behind this, so just mark this as a record...
> >
> > Are you really describing the GIC behaviour here? It sounds like you are
> > describing the behaviour of the Wakeup Unit.
> 
> Definitely it's behavior of GIC, not WKPU's

I don't understand what evidence you are basing this on. Everything you
say below contradicts this assertion.


> > The SPI that goes to the GIC is the *output* of the WKPU. However the
> > registers you mention above all control edge detection at the input to
> > the WKPU. If so, the kernel would need an WKPU irqchip driver in order
> > to manage the trigger mode registers above (and to clear them).
>
> external wakeup signal has a transition from High to Low to the SOC,
> then output of WIREER (rising detect) or WIFEER(falling detect) to
> generate INTID to the GIC, you have to enable WIFEER to generate the
> IRQ signal to the GIC which is also an evidence that the external
> wakup is falling edge.

That's what I mean.

How can you reason about the behaviour of the GIC when every
observation you make is based on the behaviour of a second level
interrupt controller (the WKPU)?

I have no doubt you are observing a falling edge being delivered to the
SoC... but that falling edge is *not* delivered to the GIC; it is
delivered to the WKPU.

The WKPU then delivers an active-high signal to the GIC.

> With this clear *falling edge*, I have to
> write the below irq_request code as:
>
>   request_irq(50, wkup12_interrupt, IRQ_TYPE_EDGE_RISING...)
>
> IMO, this is very weird because the wakeup signal is falling edge from
> the point of SOC/GIC side, but I have to name it as
> *IRQ_TYPE_EDGE_RISING*, but it works just to pass the sanity
> check(although I think which is not necessary as the fact shows)

It is indeed very weird.

However it is not the falling edge from the SoC/GIC side that makes it
weird! In fact there is *not* a falling edge from the SoC *and* the GIC
because they are not the same thing. There is a secondary interrupt
controller between the SoC pin and the GIC which inverts the logic (and
also obviates any need to deploy the GIC's edge detection features at
all... IMHO the GIC trigger mode should be active high).

Instead, I think the reason your code is weird is because the irqchip
driver for the WKPU is missing or broken. A secondary interrupt
controller requires an irqchip driver or you will end up with pieces of
the interrupt controller management code (e.g. weird pokes to the WKPU
to acknowledge things) appearing in all manner of inappropriate places.


> > PS I can't find any sign of a WKPU driver in the mainline kernel and
> >    AFAICT this would make wake up sources unusable. What kernel have
> >    you been running your experiments on?
> 
> 5.10.44- BSP code from NXP:
> https://source.codeaurora.org/external/autobsps32/linux

Given you are running a vendor kernel I think you need to discuss this
with that vendor's support channels. To stop your code being weird then
you need to obtain (or implement) an irqchip driver for the WKPU.


Daniel.
