Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59015A7F3B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiHaNuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiHaNuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:50:11 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE452018B
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:50:06 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-33dba2693d0so306928387b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=64Z6Nr61BsH9podjAJYqr1emZXHxMOReLT3+pHE2NKM=;
        b=YnplyhxhMibyQ9RtCCMLvz4mdx8AOLBMphiTn/pTAePQ87NYENtGDGJ7cdsxjn1Mwm
         dd0a5CP+JF7M2bGNDsXes8bzYIdClsuPrJDkRrz9TZRpcO4j9p8l0cfLlXTlMHAKetOF
         5nzRViN+UJS6yIvbIhFcA5+dIbRpiOQXsDJg8jP1+RHkZSOcfZMIFLDgJcFmEZ4tVXyn
         UDq792bJcYDVl8dLK20x0P9u8/VhZJcAtILIyhce4CqbibDiyTlkgkTvBQGaXHWOhwA0
         NSMDFv+3emntZXVvmHU/RqjUTn0QE3sGFqI0aPYgnvlu4R75MhvFKd3Es8zYprO3am/F
         Tw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=64Z6Nr61BsH9podjAJYqr1emZXHxMOReLT3+pHE2NKM=;
        b=wYQWOeOhmQwSqs8V7rsACJ+iq0bQKVCJWJYtzHnIFZSBt7zmPndxXDmTHWCsiC7za2
         Md67jxyGkUXFVgdIqQbXiU4kz8y2SafX9rbfQtE/SbkPJvKLeLlgAyuwZJ4cT5DNK1Kb
         4OuCGyXzgk/DprVg+lg3SyFByll4CsHeiDp3yljPEQ+QXar/ZOnt9bZgXWlnhRYx7U43
         FDvh6wtVlj2TwCizlMj2G2N9zl2pLpJAA2jVxEaQuRfSUt+jdKGEs21j7nny2M753Zvk
         a0J2THIc0uP/0tj4Cn//8dNlaFmziI2tx38PwvXvrVHflbElKRjRaO0ZprgNGfaniuh8
         ZH4A==
X-Gm-Message-State: ACgBeo2u/nkfBS2zAwZLEUo13lF21W4RyM2R36XDKFZVc6s4Dl4lotno
        eVaiegyGGWEzAV+IqFLNws9gamAhc7N1mvI47rVskA==
X-Google-Smtp-Source: AA6agR7Y/SNX0LwF41mH5PHZKnKKyE3Pke4wzQt6sHVa5tSJFC4wKf2FcL7ZFoqZ3IKyD2fJDS8ZB/WsSI6sJ269sDw=
X-Received: by 2002:a81:7cc3:0:b0:336:e83b:51fd with SMTP id
 x186-20020a817cc3000000b00336e83b51fdmr18805142ywc.457.1661953805597; Wed, 31
 Aug 2022 06:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220816130221.885920-1-peternewman@google.com>
 <YvunKCJHSXKz/kZB@FVFF77S0Q05N> <CALPaoCjJyYW68Vn1CNbf0Asggyu1AY68DbqcoK5n5FcXqeybJA@mail.gmail.com>
In-Reply-To: <CALPaoCjJyYW68Vn1CNbf0Asggyu1AY68DbqcoK5n5FcXqeybJA@mail.gmail.com>
From:   Peter Newman <peternewman@google.com>
Date:   Wed, 31 Aug 2022 15:49:54 +0200
Message-ID: <CALPaoCiJSABEtY61Xg9dxak8NJKpTd9wSFr1qbnnaZL2outR_w@mail.gmail.com>
Subject: Re: [PATCH v3] perf/arm: adjust hwevents mappings on boot
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, Aug 16, 2022 at 7:00 PM Peter Newman <peternewman@google.com> wrote:
>
> On Tue, Aug 16, 2022 at 4:18 PM Mark Rutland <mark.rutland@arm.com> wrote:

...

>
> I can confirm that your patch fixes the issue we saw.
>
> Thank you for coming back with this quickly, it looks like a better
> solution to me.
>

Just following up, please let me know what plans you have for your patch.

-Peter
