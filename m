Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB225A877F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 22:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiHaUW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 16:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiHaUWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 16:22:24 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE4BD91E3;
        Wed, 31 Aug 2022 13:22:23 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a15so11751380qko.4;
        Wed, 31 Aug 2022 13:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=aMjCOGjnBUx54TRXPoHZ+EBmpoeeI1dfZnROfWg9ciQ=;
        b=QLLI9KcJVZZBfr8hTLfqVotJeC1mqDmH4oTbWTFf0s9RlSKjRD2puasLTD0d5Kk689
         MNnfgPoRgp1D4YdWxVaktZIvwKgRTcQZ4kF1cl/UXG6Csd6F0rKZYrvUBkJ7nmc9miLG
         3roAfYiM87IEIZtGdGVKwvcewQCG7dmZ/LMpSohhuPFsJNjkebHYUfcQHYGr45mJF7Ba
         lVp8PselLF8Fzvq0LSEcvLvM3V63bHaXCKm6X6LInE6YNm9vJDwFjtzQ+FzYjUWZ4mpQ
         JaRMHEe5qpmW/7HSGS4Bu0pHiwAPuh9euPMMwurw8hqcOsAmCK9mMz1hH3fVL3f6ZH9H
         tx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=aMjCOGjnBUx54TRXPoHZ+EBmpoeeI1dfZnROfWg9ciQ=;
        b=URHH5lCC3wLl6QBI1R/nTCcMV7n9aTrKiR78X0EDMKaYZU2jAuxkvUZIrP7hEgYYKe
         0f3btPfXHV5atq0ATLrJxecP5PKbISaXy5syeenEoJ0fq5ZIzzcM1V85duX/7EivGACg
         eB4h7+k+CjXh6WsE3jcZSs1Kyjjzy7eXiiaQ8/6rl0zbZvSnEXfsf8INQEr94tknvZnr
         I3VT59eNIhkvHGQVEq5g1kmna7M1uNzRi81Okfsy6+bIzm70OjOT6n5pVAOcEhcv5Wy5
         yy86QqsHTDOWgdnnyZOdH98JtDynh660KcOGoWQwaH+o4ajjXQkunmEyLnT4drs2eK1N
         uLww==
X-Gm-Message-State: ACgBeo1pM5YhCIgoTRh/x9Z6j0W331tJtxmgxlw3n0obx5QDgp3Ubm/Q
        FYiAQqp/XNq9H84LysNdiNQOQ7d0xizJz7yomNU=
X-Google-Smtp-Source: AA6agR6Az/ybYGFGYQ659ca2PSf1Yvm0jf3Gty57VLPXAuckkyMu9PC8qEuBnVswDH4idhL6eWmU9wfU35Pc4VB+Zww=
X-Received: by 2002:a05:620a:288a:b0:6b8:fcfe:db02 with SMTP id
 j10-20020a05620a288a00b006b8fcfedb02mr17481309qkp.504.1661977342561; Wed, 31
 Aug 2022 13:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220831100506.3368103-1-vincent.whitchurch@axis.com>
 <20220831100506.3368103-2-vincent.whitchurch@axis.com> <CAHp75Vek8tLnwYWZO91HHr1_i7G_F9tErnRsq-GwfQcpR0FaTw@mail.gmail.com>
 <Yw9t55YVm3YfAs5E@axis.com>
In-Reply-To: <Yw9t55YVm3YfAs5E@axis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 31 Aug 2022 23:21:46 +0300
Message-ID: <CAHp75Vd-1hCy9Hrv7B6rnvxVo-fOgP5bEy0YvnfcBq9Jjs22OA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] iio: adc: mcp320x: use callbacks for RX conversion
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, kernel <kernel@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Aug 31, 2022 at 5:19 PM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
> On Wed, Aug 31, 2022 at 02:40:49PM +0200, Andy Shevchenko wrote:
> > On Wed, Aug 31, 2022 at 1:05 PM Vincent Whitchurch
> > <vincent.whitchurch@axis.com> wrote:
> > > Replace the device_index switch with callbacks from the chip_info
> > > structure, so that the latter has all the information needed to handle
> > > the variants.
> >
> > Below are for the further patches, as I see the original code has the
> > same disadvantages.
>
> Right, these comments are in the original code that is either being just
> being moved or that even just happens to be in the context of the diff.
>
> Just to clarify, do you mean by "further patches" that you expect
> patches to fix these comments to be added to this series which adds
> triggered buffer support?

Yes.

-- 
With Best Regards,
Andy Shevchenko
