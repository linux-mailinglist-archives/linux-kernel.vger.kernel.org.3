Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5E04EF9D3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350997AbiDAS2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345972AbiDAS2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:28:33 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1664E1AC710
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:26:43 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id b188so3596961oia.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 11:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MGpdsUgeU20LgBuDXB+NmysxzRrBIqWkuKnTRQ4cJj0=;
        b=aiBkZqE7yk6o2sGGdrjmlF6VLxoE/QsqdWTRKaC1hibWaS67x5lCoqPB9YMyCC6t2x
         JsxZiR9RLdlTJYLNZ2nXhalhdOEkbRrW7okbFQntFeyvLVnd+YfOaniPvZxDgRFtwdQ8
         NvsC9dddsPamXwaB4f7593BXIPRbPnDYeab5vMnlvVNR+4jer4/aN4W+eeYmCPLnNYS4
         0grai+oljzag9E+YX1qXV8YlnDu0swMJm3E0gl3tmakt6j48eMqBVUVbWa/8p1zti4ud
         rcqBqLsYKRC5Jzrz3cEUNKQwJYU18TNvRCW8Nur9QTL7TIDO6fPFYmhPg5S/51RMmXlb
         qcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MGpdsUgeU20LgBuDXB+NmysxzRrBIqWkuKnTRQ4cJj0=;
        b=4PdX7xL23b8qfLqBfmLEI3XxKmpISyCZQpP0iE4F5OoeXXEPdDbE3IYzs4yFMYjfvq
         TRo6YRsW/W1/vVzB7TbBAR8lxzc8vwIKcYARe4YNHTNVZc9KtsZgFMbpddUrNAQ3X4I3
         ogGgVDXglibx9HJ/FZHZtANegLM2VQsLDibYBcK+roRA7HcxOMPzEMhoxXmjgQQHLGGd
         xuuw3unpcWrKYqwD0bwabP/24UaMWWpHLkRlpqfsVxLAKKXcyDaQzWN63R2xpFFEghTd
         tM7wMQoKYR30vDS0d+YiNaJA+A9ySbsRapE875pwfdvGQJRLqS2QibSAfK1SBrnGmgZe
         lvzA==
X-Gm-Message-State: AOAM5302Tl6EtQMXloa68c3nKC5c6oClO/BdZAc3KoLdNk624LSq/gyK
        /N/PxEnw2Lg5AyO4D083POQE0XdkOlwc5vemffkmiQ==
X-Google-Smtp-Source: ABdhPJz5M9gXG3KFarzLuNAyVxZt/t1H1FkSUDEcbqPBpDVi+IlN3G7ahiDEKSf7m+E+Ih5W9ZaOTfxFZqnhzILbboM=
X-Received: by 2002:a05:6808:2207:b0:2f9:35b6:8866 with SMTP id
 bd7-20020a056808220700b002f935b68866mr5382338oib.269.1648837602235; Fri, 01
 Apr 2022 11:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220329134632.6064-1-likexu@tencent.com>
In-Reply-To: <20220329134632.6064-1-likexu@tencent.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 1 Apr 2022 11:26:31 -0700
Message-ID: <CALMp9eRqrkLRQ7UWNUdp3Z58WWgTqO-OPRuNo+EjcOW3c5eteQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/pmu: Update AMD PMC smaple period to fix guest NMI-watchdog
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Eric Hankland <ehankland@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, Mar 29, 2022 at 6:46 AM Like Xu <like.xu.linux@gmail.com> wrote:
>
> From: Like Xu <likexu@tencent.com>
>
> NMI-watchdog is one of the favorite features of kernel developers,
> but it does not work in AMD guest even with vPMU enabled and worse,
> the system misrepresents this capability via /proc.
>
> This is a PMC emulation error. KVM does not pass the latest valid
> value to perf_event in time when guest NMI-watchdog is running, thus
> the perf_event corresponding to the watchdog counter will enter the
> old state at some point after the first guest NMI injection, forcing
> the hardware register PMC0 to be constantly written to 0x800000000001.
>
> Meanwhile, the running counter should accurately reflect its new value
> based on the latest coordinated pmc->counter (from vPMC's point of view)
> rather than the value written directly by the guest.
>
> Fixes: 168d918f2643 ("KVM: x86: Adjust counter sample period after a wrmsr")
> Reported-by: Dongli Cao <caodongli@kingsoft.com>
> Signed-off-by: Like Xu <likexu@tencent.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
