Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0276575E54
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbiGOJSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 05:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiGOJSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 05:18:13 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592CA6587
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 02:18:11 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-31c89111f23so41907917b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 02:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k3C0wIojyulqJOc3gqPPTvNhV+eA7FObSuZqLBbdRPM=;
        b=pOogBYE+C6kqGGUAfEUij9yax6uLLM1R/aVT53WeTPmxIYZFWu6IWa2WPjga4I/MNH
         P4HlXB3K/l4UpcvdlOrtecwmGdwA2MUh+2OePYYn/Y4ea/EqxDJTYaOotoyfIrPOLdc/
         oWWQkFZjgD51+iObnDFwo/7bUIIxqTYnXHAaj7DZCOvVXkBaTSsH0VdaSwZs/hlpXC4K
         7lBmLHoy1pLi9k98lUEObNmpfiFwWxKnovSOb+FuADITS42NiyabI8TSYOyGDR+tW7bA
         68YbPJQAYaPmkx1mQmtYnngXnbMQL2FG7jqtw239GNfsJLCBbIsYP4Jsd8SAnBbFR4Am
         YHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k3C0wIojyulqJOc3gqPPTvNhV+eA7FObSuZqLBbdRPM=;
        b=R7x2P2o+/7FrL0hAQ3XE3F9A1ZlacpNArQ4CnH+TFzAa0TZy3wvSQR2u7lMMoTkJeO
         hUyU+gGDQRJpRaRKFV0UloFijlOU+e95ydWpX+w3RqQKhXEH09fLUE9IzBf6AHRv/Wgo
         fSJPH5XNJu3ZcDJNaTmdBxSxjN3FjOP2Rq21sQjTcqcvx1knZRVY7y3+u/mFb35v/G6t
         UBSLx2dOAu8jw+K/6GzAsl/u+qQrdPnhQzNuKgDYx2h38sjIk/QwOAf7V8usH2W/icCs
         VqOd8l87XqqePQioWLYl/xUsE4ZHpRdZwdVMHK2Ay0GE/YizDiGC52L8FHAzQNRAh4vJ
         WiGQ==
X-Gm-Message-State: AJIora8yguXBfM0cs8H8k2w6mS6pqtIz62PUrg6gJInsKpbBLp8Vddy1
        jTKax6e1A+c5MJby38RRQ9J4bJ4wamL0ME2Z6T+GFq/ltGEEKQ==
X-Google-Smtp-Source: AGRyM1vG8/RlhJDU4+yZQLBM+ZndwV5DjU4EYfGa6tSpfbbGXItXheAJxeNNY805A4KiKuOF3zqWH6FVEA50bsNrh9Y=
X-Received: by 2002:a81:5045:0:b0:31c:9f67:a611 with SMTP id
 e66-20020a815045000000b0031c9f67a611mr15041103ywb.55.1657876690309; Fri, 15
 Jul 2022 02:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220715032233.230507-1-shaozhengchao@huawei.com> <20220714213025.448faf8c@kernel.org>
In-Reply-To: <20220714213025.448faf8c@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 15 Jul 2022 11:17:59 +0200
Message-ID: <CANn89iLS6rhm_N6g-x0JQC8s2Kx2yVO7+r89BdBZNrzr9473WQ@mail.gmail.com>
Subject: Re: [PATCH v3,bpf-next] bpf: Don't redirect packets with invalid pkt_len
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Zhengchao Shao <shaozhengchao@huawei.com>,
        bpf <bpf@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, martin.lau@linux.dev,
        song@kernel.org, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Menglong Dong <imagedong@tencent.com>,
        Petr Machata <petrm@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Talal Ahmad <talalahmad@google.com>,
        Kees Cook <keescook@chromium.org>, Hao Luo <haoluo@google.com>,
        jolsa@kernel.org, weiyongjun1@huawei.com,
        YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 6:30 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 15 Jul 2022 11:22:33 +0800 Zhengchao Shao wrote:
> > +#ifdef CONFIG_DEBUG_NET
> > +     if (unlikely(!skb->len)) {
> > +             pr_err("%s\n", __func__);
> > +             skb_dump(KERN_ERR, skb, false);
> > +             WARN_ON_ONCE(1);
> > +     }
>
> Is there a reason to open code WARN_ONCE() like that?
>
> #ifdef CONFIG_DEBUG_NET
>         if (WARN_ONCE(!skb->len, "%s\n", __func__))
>                 skb_dump(KERN_ERR, skb, false);
>
> or
>
>         if (IS_ENABLED(CONFIG_DEBUG_NET) &&
>             WARN_ONCE(!skb->len, "%s\n", __func__))
>                 skb_dump(KERN_ERR, skb, false);


Also the skb_dump() needs to be done once.

DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
