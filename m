Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15EE575C2C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiGOHPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGOHPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:15:04 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B2F3ED77;
        Fri, 15 Jul 2022 00:15:04 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id x185so5180064oig.1;
        Fri, 15 Jul 2022 00:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=klU2qg7vHBMWA6+TfvHH4QV3TjwjghS4z+pk2bXTXJg=;
        b=oN71OhHbN4ofVFdgsknC/tWV066NA/3KGU/r/14+nLRJlN6FweL+kB+djQ3GAuBzpO
         S38wvPdHNLcp12TivIt6pm8YtrVb0iitLKua/EpYZJlTuY6JLHHDvMwZgWCmGdSat0YT
         4p5Wzu62fz3n18/Akdi+k7yQNoFkTedSa8/B0kRAXBHE4tSutV+sk9r9OkpvYnI/vsKi
         o8hvvCLPEhLtbWOTObjDH9gs0tr7op6lu8UK2B2py4r6qG/aQ6T2UMstAF9wW/TAvh51
         vxT1zqCFivALXqv690pjOzo2WV8Zm/G0bbXTlzl1Vq7crlNyE/TtCDpAQoyeOBnhAgj3
         /BbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klU2qg7vHBMWA6+TfvHH4QV3TjwjghS4z+pk2bXTXJg=;
        b=vOA12hyDio9jiU3b0Fy61Q7tRpB4xe2zIKwo4eqaIKIP36kmfHeDLemAzRoqj/MpY3
         g53P3khagHl7rkCQioEdLb6oWG6izAQZmxIiTN19dg3imuDp7SXwXuqY1lpEJRxdpRot
         DfOlp2JEO8sMO/Yj9wNhNfG1QVoxNZr0dyG8Zcn+5YqFeJZz5pZ0Cbu2CqVw6uJ/xbjs
         8rIT+icuzkZgfm5cE2M+GHU/mHCZi8xoizERdCtz4fvdSi85wY4BcTFpnQ0sOIx/YlCF
         GVMhP+Muqz6RR8uODRYrbzWGiz86AGP+d/UzZX7/UIsGai/lLROQQUKTO995RmqRhp4d
         sOWw==
X-Gm-Message-State: AJIora8Vim8VPq3w8qMwBLZmPK3Z6Z+kUL+bKLewChpN9itBdXJiwOhS
        TbgqWnU0s2BjNcJuJ1S07LHyLGsVKV6OaGgTve5PZZh1zoIMCQ==
X-Google-Smtp-Source: AGRyM1uOKC90SLbqCf9YUcDOvmr8UGUPzJBtWUs7h9evNvxBrNlISK1e/cVOMacbgZTPMmichNXAyCDbJHwDyY45vR4=
X-Received: by 2002:a05:6808:219a:b0:335:6a90:79be with SMTP id
 be26-20020a056808219a00b003356a9079bemr6154127oib.275.1657869303653; Fri, 15
 Jul 2022 00:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220713084247.3090353-1-bbara93@gmail.com> <9d799a6a-edbd-c7d7-1b20-b033fe38bcf7@wanadoo.fr>
In-Reply-To: <9d799a6a-edbd-c7d7-1b20-b033fe38bcf7@wanadoo.fr>
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Fri, 15 Jul 2022 09:14:51 +0200
Message-ID: <CAJpcXm6WkLt0pv7UYJ7K413j37ja9M++YUs9VzzaWqOWs1iGfg@mail.gmail.com>
Subject: Re: [PATCH] Input: tsc2007 - enable GPIO chips that can sleep
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>,
        richard.leitner@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi., 13. Juli 2022 um 10:56 Uhr schrieb Christophe JAILLET
<christophe.jaillet@wanadoo.fr>:
> should you care and/or should there be a v2, some nitpick below.

I will soon provide a v2 with the mentioned fixes.

Thanks & br,
bb
