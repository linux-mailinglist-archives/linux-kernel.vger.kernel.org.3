Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6524C7FF3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 02:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiCABDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 20:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiCABDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 20:03:40 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5DAA9E2B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 17:03:00 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id u7so19752542ljk.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 17:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q8NmAcmdqU26V8OH3cYuAlO8sk2yRxtmZWE3w58gSKE=;
        b=MKcB+oboBz5eIjBKGm5s3zVzKk8DOQZGjA7/z4rwsM0NpL91uMsgCG04CXKj6F1XIv
         14Hlb2vQWsXVHInjCCAvtjKzoYQPTTDOCMCVO5I6hBp6i/LKTHKe2j5+XGPPwZKc5qUW
         ezNp7Y8TrpCDsaoFABroafoi19z3NHRD2LkRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q8NmAcmdqU26V8OH3cYuAlO8sk2yRxtmZWE3w58gSKE=;
        b=6loYUPfKa63LHlVy+cT+VXmy19bZKmEB416dwb+4aO4fDFg3cTlNagwpHIcotoYNqm
         tkDP0DgT9EKyvJzBpz6Xjw0eampPtsLqZchYjgeWNHNPcCKUI41ZYtNfeEEbiqqpBYmT
         dFPoBvtPuh2UqsmFYvQoOyi502ndvJYoexU8hBgBBLOdHV0Z6W1nsMwX3tHPT6i0okqF
         Vm2ZsTar3ujS+6OpEOC6GjbBZi0b2kNH6JHHY+KcXOLdmPhkws85cwdXokIKomIMX+dC
         sBgmriOpGorAp+sxf35MdK8tbyX27NBpanqZbiACvzKCyaS8KS8BftanSnfXZT6grUic
         4PBQ==
X-Gm-Message-State: AOAM530WFTEPaRqjvWDs9Gpt9L2AWJpQxyA/QcoMqTLxDtf0FXh0dIA8
        pFnBt1v7rfXEG5WVVsMsuIF/c050KvhRvz1Yv5o=
X-Google-Smtp-Source: ABdhPJz4m+XnYVsIDXtxByYUsXYzSusFBCIwOMUIp2pOXlUQBIFKXFiO922mZbtwu4qMk349s/5VjQ==
X-Received: by 2002:a2e:7809:0:b0:23a:fb4f:2358 with SMTP id t9-20020a2e7809000000b0023afb4f2358mr14949027ljc.224.1646096578325;
        Mon, 28 Feb 2022 17:02:58 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id v21-20020a2e2f15000000b002456e6cdab2sm1616753ljv.93.2022.02.28.17.02.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 17:02:57 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id u7so19752496ljk.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 17:02:57 -0800 (PST)
X-Received: by 2002:a2e:924d:0:b0:246:370c:5618 with SMTP id
 v13-20020a2e924d000000b00246370c5618mr15672702ljg.358.1646096577046; Mon, 28
 Feb 2022 17:02:57 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdYM21hcH5d9rXyvjMPHQp429OZ1Zcy7uLU2tndoJcOmUQ@mail.gmail.com>
 <CAHk-=whg3eRY1nOJjHam+jORmVymU539CxhBUjp4=tGoFitotw@mail.gmail.com>
 <CACRpkdbWkm1WDY30qoGLEQba+G2cDEhT+M8nCdJbcD=ZQiu6uw@mail.gmail.com>
 <CAHk-=wjNdW6Tdei6+6OJy6jGqY=PCJ2TWFKpV+g0projUC1eag@mail.gmail.com> <CACRpkdY-8D8ZYy9VichQmJHTJCSskFs=e0qpbYssf7tED_9dLw@mail.gmail.com>
In-Reply-To: <CACRpkdY-8D8ZYy9VichQmJHTJCSskFs=e0qpbYssf7tED_9dLw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Feb 2022 17:02:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=whcOPRHS-mWaCk3_anVPZheCbkE4E0dLWRD9YbiaTLAqA@mail.gmail.com>
Message-ID: <CAHk-=whcOPRHS-mWaCk3_anVPZheCbkE4E0dLWRD9YbiaTLAqA@mail.gmail.com>
Subject: Re: [GIT PULL] pin control fixes for the v5.17 series
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 2:50 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> I'll take these two:
>
> pinctrl-sunxi: sunxi_pinctrl_gpio_direction_in/output: use correct offset
> pinctrl: sunxi: Use unique lockdep classes for IRQs
>
> and put them into fixes, that should nail it.

Thanks. One down, two more of Guenter's reports to go. But iirc they
both at least had fixes pending too.

Let's hope they aren't in the wrong queue as well ;)

                Linus
