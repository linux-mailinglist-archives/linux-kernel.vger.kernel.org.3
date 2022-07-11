Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F0057088F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiGKQxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiGKQxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:53:48 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A13A2A735
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:53:47 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r6so6996129edd.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EvYW5GaG8Gx/hKniNuu2v226hGiRtWNUFfOGKwFgOac=;
        b=aarLedeVOS0wuKcbUerMkVPKpJ3wM6fdhFFWFrG/pkDecFuAYKrWzlgPcW2FE19ruF
         zVeQvPCEI71QlqYuYynt3AOoxXO+3CqUCfzmpcNM8cCb/2hrTyThxmVH45m71sQ/PRSX
         e51w0bGdqnkkgeaSkix9Cot/+hcpVZgc/hd44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EvYW5GaG8Gx/hKniNuu2v226hGiRtWNUFfOGKwFgOac=;
        b=TOxT4Jme97Zdlnmnda/JONNQj4l8E4QDL4X5Jecj69UwSTWUKMYCf4BP1JpmrZzMBK
         L4GYL9xK2S5DBmfDMkEfNtE+ntDfymhpMETPJISv8Jd6CKEJUNIw4Zo96hsdGgIFLtpl
         c/yyxdWAijSqGDJPFn9RWlq9CHg45xW/s9qN8Rv7D7xD6lkTrMgIjn/Tqh2fXeApBo+t
         9x5uS8SLoad472tGzTKHcMpcM5a4XlrZilkOnzdWjqmZ7T2+mh8Q4WwXvLDIMwX8UCkk
         BNC0wAPbs9W7ld1npQIMI9mcnX/LmT1mCxSUPZ9RacsVfrjb5BxKr8HR1hJATdLI509C
         Pppw==
X-Gm-Message-State: AJIora9EiVEHWT797GRzFREUOxa/HhZei9XrCi+veblc2oCvgxzF0jnH
        iyvmSIsd6pJMSUDgP8jTq9bNYymsxG3Lukpu
X-Google-Smtp-Source: AGRyM1ssQlG9ngI1H19Mc866prGR5/2jyz1ILg8WAEUwbo3K27szT2F0DugFOQQRyF9suSS9PrchGQ==
X-Received: by 2002:a05:6402:2b8b:b0:43a:5475:f1ae with SMTP id fj11-20020a0564022b8b00b0043a5475f1aemr6667701edb.363.1657558425738;
        Mon, 11 Jul 2022 09:53:45 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id f15-20020a17090631cf00b0072af3deb944sm2831351ejf.223.2022.07.11.09.53.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 09:53:43 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id d13-20020a05600c34cd00b003a2dc1cf0b4so3386331wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:53:43 -0700 (PDT)
X-Received: by 2002:a05:600c:354e:b0:3a1:9ddf:468d with SMTP id
 i14-20020a05600c354e00b003a19ddf468dmr16648474wmq.145.1657558422860; Mon, 11
 Jul 2022 09:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <7tBrxiXIS8yrkSQC04SW-R8BK2xeKgirCEAeh2XB3EVkZSsJjVPJ3_tTXNwC0Ued3a3e8xYztaYvRGYyWApDAgKEUl9IC_xwvVqUpo0BpaI=@accessvector.net>
 <20220708085713.GA6144@redhat.com> <R1W_P-BmV6F1JDyltK8tqX5q7DGQOcg0jkuq6XI36cXJBD1UZKMy5HjParo0Y2jehd6nA7mHEJzrMOGUsefDoyz7502IemibJyY-UFxdumM=@accessvector.net>
 <20220708150215.GA11062@redhat.com> <CAHk-=wjDfxvACHaU5PGS5XgetAp5oQQOCTXVqBG+e4_hsM2DeA@mail.gmail.com>
 <20220708175133.GB11062@redhat.com> <20220711161624.GA7683@redhat.com>
In-Reply-To: <20220711161624.GA7683@redhat.com>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Mon, 11 Jul 2022 09:53:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiiqOsnqHmC+wiYNA0RvKJQJLZKaGqxfWn_VasuEYVwXA@mail.gmail.com>
Message-ID: <CAHk-=wiiqOsnqHmC+wiYNA0RvKJQJLZKaGqxfWn_VasuEYVwXA@mail.gmail.com>
Subject: Re: [PATCH] fix race between exit_itimers() and /proc/pid/timers
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     chris@accessvector.net,
        "security@kernel.org" <security@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 9:16 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> As Chris explains, the comment above exit_itimers() is not correct,
> we can race with proc_timers_seq_ops. Change exit_itimers() to clear
> signal->posix_timers with ->siglock held.

Thanks. Applied,

                  Linus
