Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFA24FB327
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 07:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244712AbiDKFPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 01:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244706AbiDKFPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 01:15:17 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5083EF09
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 22:13:04 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bu29so24655494lfb.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 22:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wQM8A4m7f13EJQA8KjIVGrIa54cJcgZ+Jxj0k/6mei0=;
        b=P3EDqa+upFKTQO2q4GrPv45ACRIqEs+l15hrSi37m7t5SzWr1zZb2mRRRTsxMVEPLA
         EEQBLMqWCus/npkQ91kb0T05Fq+ihkPNKP8ElruN61UliwD1LurKcHDu1VdaF7TlWNtN
         ysp+mQ/i1yfmhijrvss3UTgyRwvzZ6zOVt3Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wQM8A4m7f13EJQA8KjIVGrIa54cJcgZ+Jxj0k/6mei0=;
        b=Uv3ugoRNTctEzJOx0E956gg72sWulVK4HhChgwSatemL+MPLiY1xQ3HnwKk83J0ZMV
         vI6FHHgDwAeqzzVtvAWDVfjnqeRxel3mHn6pTB54ApMQc5f1fH0wzAVEv1UlSZV8Okxt
         q45NDA4ZI7ZNFOSpK05jqS/9hqOx3hCU5o+3TxqanBuYxiNbsSSEjocv8JvzNI5p7dwm
         M5xwtFT2ru/QEQUiXuq3L48yhQkLwEE0KCErrGFbUC5B9mBUCRT4UoFoFgFJ98JtH0ue
         Elj1WBKUIDGoKpLYSWlZcO4yXSY/PHMP3j/3TmZ5evp+JjJRLC40D/He+gGaWkWBV1na
         XS9A==
X-Gm-Message-State: AOAM530kunHQtVZkcWGDooTnXG7LXJo8PN8Tcwwk/PY1JCs3v2P8Ujfs
        SESEqier/oUaULQhPCwPB5/0mW+2p5cRI/wd
X-Google-Smtp-Source: ABdhPJxRCfVJw71RSsDRrBmvCM9U2X/2U+mu89CsCACMoZSgH0m8Pydn/WLH6Dy0IeNjMoG01oWwOw==
X-Received: by 2002:a05:6512:39c8:b0:46b:9aed:389f with SMTP id k8-20020a05651239c800b0046b9aed389fmr5519670lfu.194.1649653982071;
        Sun, 10 Apr 2022 22:13:02 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id b43-20020a05651c0b2b00b0024b5f54f483sm395435ljr.28.2022.04.10.22.13.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 22:13:01 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id c15so18640760ljr.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 22:13:01 -0700 (PDT)
X-Received: by 2002:a2e:9041:0:b0:24a:ce83:dcb4 with SMTP id
 n1-20020a2e9041000000b0024ace83dcb4mr19664640ljg.291.1649653981116; Sun, 10
 Apr 2022 22:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh0+DYC2+Aeu2=vfUtGaDqVuKxKrxyhwQFoG89rcynzww@mail.gmail.com>
 <20220411045822.GA295401@roeck-us.net>
In-Reply-To: <20220411045822.GA295401@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 Apr 2022 19:12:44 -1000
X-Gmail-Original-Message-ID: <CAHk-=wg_=3qE9E5ynDukzZzieKUABoEwJuBJzthRhwRo=s-1vQ@mail.gmail.com>
Message-ID: <CAHk-=wg_=3qE9E5ynDukzZzieKUABoEwJuBJzthRhwRo=s-1vQ@mail.gmail.com>
Subject: Re: Linux 5.18-rc2
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sun, Apr 10, 2022 at 6:58 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Build results:
>         total: 151 pass: 151 fail: 0
> Qemu test results:
>         total: 488 pass: 488 fail: 0

Lovely. It seems we got them all sorted out quickly this time. Thanks.

> The only issue left in my testing is the warning in nosmp parisc code.
>
> WARNING: CPU: 0 PID: 1 at fs/sysfs/group.c:115 internal_create_group+0x360/0x394
>
> This problem is fixed in linux-next with
> https://lore.kernel.org/all/20220401203114.348053-1-deller@gmx.de/
> which should hopefully find its way into mainline soon.

Sounds good.

               Linus
