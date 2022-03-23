Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02AB4E590D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 20:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344151AbiCWTWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 15:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiCWTWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:22:22 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E313E887A4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:20:52 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 17so3256122ljw.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RvLqsd6hA44SZTRd4WyyALqX5fHrR7CuTfq09JY31fA=;
        b=L1+CnW9v7Cel+m7AYugndGHnrNngfqh3mqIy8L1GDXMqhYoubDzbR8hJlJGalrxwv3
         ywgBTZ5te3TFothb7smIjOILY7rX2s/fuAwzeAOKxQaFf+Fmu44l01AAkVwz8ZKhEAod
         pOCpyxkglpGo/wB3I1kf2fWfvLV4rQHDTeRdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RvLqsd6hA44SZTRd4WyyALqX5fHrR7CuTfq09JY31fA=;
        b=dNZdrMzYi39dACQG0Rk0ePXikFp815RL/YiuTFAVUcdK2CwKwjcmcvs1lL8hg83MVZ
         6jr3mePHVj4qUptiPPbXEyagnSZvLekSThvyZYZhhuQ9AdLl0ytxvytyZ/tRD/fGhJYf
         wrLQqfLleDm7mpuBg38SXULKPipnRdn6+vsNAS3bqWMzhuwrmSOSL3/YadhmpLffTcGS
         BkDwWLdbWnbifEOUDutTvrYS263j3CsUENFvzAAHc83mdHxSOrIm4+cGmkAijnFIVvp/
         yIDoSx6JTnxP18bwEzfIN+GaK+phBBtoQq6el1yt8kYm02US/V9d6eB76VT8FO+60sFb
         +mPg==
X-Gm-Message-State: AOAM531eUJizZoNvWgwYK2yKVrjI1Be34VS6peAPhZekSWtBwZPgC3sw
        xmRBsAkhAes8az2iPxWjy9IusJSfp1/Ijy3oU6k=
X-Google-Smtp-Source: ABdhPJzPJ1ZhraWSggh1a00xx61zcemZXWIOSR+Ol6g4jmCsx7qKdwgCRIarbNkJTV9m9u+BzeYH0g==
X-Received: by 2002:a2e:b946:0:b0:244:beb1:72b2 with SMTP id 6-20020a2eb946000000b00244beb172b2mr1284034ljs.240.1648063251000;
        Wed, 23 Mar 2022 12:20:51 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id g7-20020a05651222c700b0044a2c68bb24sm68790lfu.224.2022.03.23.12.20.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 12:20:50 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id k21so4376162lfe.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:20:50 -0700 (PDT)
X-Received: by 2002:a05:6512:b13:b0:448:90c6:dc49 with SMTP id
 w19-20020a0565120b1300b0044890c6dc49mr1069565lfu.542.1648063249874; Wed, 23
 Mar 2022 12:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220321105621.3d4a9bc6@gandalf.local.home> <CAHk-=wj3_p98e_oohGZzfkDPaJFLKEW8C6mS9dhuKgLN8PNitg@mail.gmail.com>
In-Reply-To: <CAHk-=wj3_p98e_oohGZzfkDPaJFLKEW8C6mS9dhuKgLN8PNitg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Mar 2022 12:20:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNzTuFN0gCitdkPna0h3MM-ScZhgS_O0NKA5=mcuZCVQ@mail.gmail.com>
Message-ID: <CAHk-=wiNzTuFN0gCitdkPna0h3MM-ScZhgS_O0NKA5=mcuZCVQ@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Updates for 5.18
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
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

On Wed, Mar 23, 2022 at 11:56 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Anyway, when I actually compare my resolution to what is in
> linux-next, it turns out they are fairly different.

Actually, my resolution is fairly similar - but not identical - to
linux-next, but quite different from the one I find in your branch. I
just got confused by having looked at both.

                Linus
