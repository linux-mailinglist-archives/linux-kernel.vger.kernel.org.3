Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584714E5887
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 19:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343742AbiCWSha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 14:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343984AbiCWShW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 14:37:22 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2547892A;
        Wed, 23 Mar 2022 11:35:51 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id q11so2348195pln.11;
        Wed, 23 Mar 2022 11:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WvsBxfCeE3uzDy/FhG1cS64vo7phnxHLbDB9aw3w/TA=;
        b=S3WvMCVoL2+cTrcEpJ+Ov3n9R/VqZn2PAnXqHSQx0QnWSIsNOplqjj85PGxOC93+ri
         ZtlxSLWyKV6Zb9QFKFTdoE5lDJIWCjPFWgW5UWCxhNs2VoOFpmW3g7iokX5aitsQpfsC
         WrfPv9PEsV+pjCvHQYWNPHLvA+YhZbC7TTS2kQrVaAlxUlVtcPYKmHsuPOgWRCr3FT/U
         DJNollg1x0egZFUEBtvru5kdaku/HUQ1g7Cg6GjWZuTGdwEVwCDZIJcyQNyjlgXFD9N2
         O/9Fd1awefF0KHWFysZOyJ5OUubUmVGZRTrQvwbpMWWOXl7+0fwdKww1+nULsAMFk0sg
         nrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WvsBxfCeE3uzDy/FhG1cS64vo7phnxHLbDB9aw3w/TA=;
        b=GLrzRpeVCOUw1hEvQyLx3kBL9IzsAkYQDlgQtFHs2Cc1krNuJ2yqY/qo68InnXulJh
         Qg+D1ZTHVw2KAaltVc29A89rdPmMfNvaEUS0vE0xZobq2xrhS1r/4rEUm7SvXtLMqp/C
         +4Eq2reXqcJhBEs6oL0CMR7EP6pUJ3s1In6UzKsks6pm4WH5cq4872bJbaBwYRe1FXOA
         SCNzj7drT5wZmWAfR6W2/ICEkqb7kFxMPNJ1oSVQp8/rQzOFsYRsBJYr3dIpErbY9QuC
         uJKDpBBo0m+c3+K79mGAsua2pX6wamXRj0jUY8pkm4f617QGb4RnoKE10mCFxEY1E9RZ
         3R4g==
X-Gm-Message-State: AOAM530n1jxGAl8xdUhxdjcDC6/muTxIo9DDrYQ8wUWohX5SLZMvyz4j
        KZWlJ3GoY84EhY+Ug6XI3Wc=
X-Google-Smtp-Source: ABdhPJyQZohjwI0ZKLNEeABcyKjsZIgdGygyJHI0Ay2CI3+Q9hMTZYY5dgNR/mObLZVelfIfTs1L5Q==
X-Received: by 2002:a17:903:204a:b0:154:80a6:3580 with SMTP id q10-20020a170903204a00b0015480a63580mr1488902pla.47.1648060550482;
        Wed, 23 Mar 2022 11:35:50 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id g14-20020a63be4e000000b00382800d1528sm458279pgo.21.2022.03.23.11.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 11:35:50 -0700 (PDT)
Date:   Thu, 24 Mar 2022 00:05:44 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] dt-bindings: timer: Document arm, cortex-a7-timer
 in arch timer
Message-ID: <20220323183544.GA95717@9a2d8922b8f1>
References: <20220317191527.96237-1-singh.kuldeep87k@gmail.com>
 <20220317191527.96237-3-singh.kuldeep87k@gmail.com>
 <558f0c92-c499-daca-e1ad-2b16137f8c06@arm.com>
 <20220317212508.GB99538@9a2d8922b8f1>
 <Yjd23Gro6B6zWCrO@robh.at.kernel.org>
 <44f3abe1-09a2-657f-7637-afa34781709b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44f3abe1-09a2-657f-7637-afa34781709b@arm.com>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 11:52:27AM +0000, Robin Murphy wrote:
> On 2022-03-20 18:47, Rob Herring wrote:
> > On Fri, Mar 18, 2022 at 02:55:08AM +0530, Kuldeep Singh wrote:
> > > On Thu, Mar 17, 2022 at 08:25:12PM +0000, Robin Murphy wrote:
> > > > On 2022-03-17 19:15, Kuldeep Singh wrote:
> > > > > Renesas RZ/N1D platform uses compatible "arm,cortex-a7-timer" in
> > > > > conjugation with "arm,armv7-timer". Since, initial entry is not
> > > > > documented, it start raising dtbs_check warnings.
> > > > > 
> > > > > ['arm,cortex-a7-timer', 'arm,armv7-timer'] is too long
> > > > > 'arm,cortex-a7-timer' is not one of ['arm,armv7-timer', 'arm,armv8-timer']
> > > > > 'arm,cortex-a7-timer' is not one of ['arm,cortex-a15-timer']
> > > > > 
> > > > > Document this compatible to address it. The motivation to add this
> > > > > change is taken from an already existing entry "arm,cortex-a15-timer".
> > > > > Please note, this will not hurt any arch timer users.
> > > > 
> > > > Eh, if it's never been documented or supported, I say just get rid of it.
> > > > The arch timer interface is by definition part of a CPU, and we can tell
> > > > what the CPU is by reading its ID registers. Indeed that's how the driver
> > > > handles the non-zero number of CPU-specific errata that already exist - we
> > > > don't need compatibles for that.
> > > > 
> > > > In some ways it might have been nice to have *SoC-specific* compatibles
> > > > given the difficulty some integrators seem to have had in wiring up a stable
> > > > count *to* the interface, but it's not like they could be magically added to
> > > > already-deployed DTs after a bug is discovered, and nor could we have
> > > > mandated them from day 1 just in case and subsequently maintained a binding
> > > > that is just an ever-growing list of every SoC. Oh well.
> > > 
> > > Robin, A similar discussion was already done on v1 thread. Please see
> > > below for details:
> > > https://lore.kernel.org/linux-devicetree/20220317065925.GA9158@9a2d8922b8f1/
> > > https://lore.kernel.org/linux-devicetree/726bde76-d792-febf-d364-6eedeb748c3b@canonical.com/
> > > 
> > > And final outcome of discussion turns out to add this compatible string.
> > 
> > I agree with Robin on dropping. More specific here is not useful. If
> > we're going to add some cores, then we should add every core
> > implementation.

Sure Rob, I will drop A7/15-timer entry from compatibles.
This means only two entries i.e arm,armv7/8-timer will be there under
compatibles now.

I actually added A7-timer because A15-timer was already present in
binding. Since, it was added by you that's why I added this one.
I will update compatibles accordingly as you said above.

> 
> Yeah, what I was trying to convey is that a compatible like
> "arm,cortex-a76-timer" has the problem of being both too specific *and* not
> specific enough to be genuinely useful *for the particular case of the arch
> timer*. It's an architectural interface, where the actual functional
> features are described through the interface itself, so the purpose of the
> DT entry is really just to indicate that the standard interface is present
> and describe how its externally-routed interrupts are wired up.
> 
> However, it's also true that implementations of standard functionality
> sometimes have bugs that software needs to know about, but in order for
> specific DT compatibles to be useful in that respect they really need to
> identify the *exact* implementation, e.g. to know that
> "arm,cortex-a76-r0p0-timer" has a bug which needs working around, but
> "arm,cortex-a76-r4p0-timer" does not. There might be cases where every known
> version of a CPU is equally affected (e.g. Cortex-A73), but it doesn't hold
> as a general assumption. Furthermore as mentioned, the other class of bugs
> which affect this interface are not in the CPU's implementation of the
> interface at all, but in the external SoC logic that provides the counter
> value, and therefore it can be identification of the overall SoC that
> matters regardless of which CPU IP(s) may be present.
> 
> If we'd had the benefit of 10 years worth of hindsight 10 years ago, we
> probably wouldn't have defined "arm,cortex-a15-timer" either. However the
> fact that we can't erase the legacy of that decision doesn't make an
> argument for repeating it now.
> 
> > If one has a big.LITTLE system with A15/A7 what would be the right
> > compatible value?
> > 
> > > 
> > > I see people with different set of perspective in regard to whether keep
> > > compatible string or not. We should have some sort of evidences to
> > > support claims so that next time when similar situation arises, we'll be
> > > aware beforehand how to proceed.
> > 
> > Every situation tends to be different.
> 
> Indeed, I certainly don't have a personal perspective of "delete all the
> bindings!" in general - only when they're truly redundant (functionally, any
> driver that can touch the arch timer registers can also read the CPU ID
> registers, but even in the DT there should already be compatibles for the
> CPUs themselves).

Thanks Robin for providing inputs.
I agree with your opinion of having soc specific compatibles which is
also mentioned under dos and dont's of bindings and other cases will
require investigation though.
https://www.kernel.org/doc/html/latest/devicetree/bindings/writing-bindings.html

- Kuldeep
