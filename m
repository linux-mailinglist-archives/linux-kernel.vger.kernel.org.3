Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAAC53ACDC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 20:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbiFASep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 14:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbiFASel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 14:34:41 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6358AF1CD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 11:34:39 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id rs12so5462659ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 11:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=njosF9y/4mY7h7cHbBRt7eN+aSzBOOky31pVud25XUc=;
        b=NPllnz8RYVxm2SnTV64EXzDNNfLuN5S4zdx4+p5tMDUvBFc2HBR70PHsb0+FhzIYOe
         5QBBj11OZ9MvXzN4JDhTfmL34kBXkF5cWwnTwj9QJCpAIQjmWFGOR+tY8hUC7FXp3TPu
         gpZSXodqw0bfpX1vHBHuU/zTaxExUhW5Sii8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=njosF9y/4mY7h7cHbBRt7eN+aSzBOOky31pVud25XUc=;
        b=STU2hJTeMumaAuhQZuGYcAmolvJUy3yD8aHbHcIBDALVwrR8hMyw5sQdDYsORGe4Gm
         EKiIApwHhX89M3OkTdA50OGRZ+b7hPxKOObKLg0Vy4jYg2gd7BstTlpnFE7cJR141Rr/
         e0mL57GGRas9wLrxkQejltqfkXP6ow2On8bhobVnjhzaCcfKKG6T5miCwIp4INgPXZ5k
         qJVnKQ/qaj0nIfLhZRYtgaHSqbdx94i5Q1M4sKc3tLacwxQ7C8Uim5uVdbQX43GAGz+L
         b0P6MW1N4RttfbeOd1xzPEdkhW1h1k7RmaxX1QN3fcND12zhk/VBL5P1NZ8yO7OaLWwk
         ryDw==
X-Gm-Message-State: AOAM530629sIWWwEB8G8JlDfrWtQj3tlSRFc4kymm95TdSZ8ptU1GdRw
        JiZUF4kjeL9niySzK6o/JNSNnW/p+V3BbbKm
X-Google-Smtp-Source: ABdhPJyvFAo7/KgPuM2kl1bVULcRThQoC28P/AP98dwrKdplcegJqeRFWMwtnzxanj8vDaC4A0IPDA==
X-Received: by 2002:a17:907:1c8f:b0:6e8:f898:63bb with SMTP id nb15-20020a1709071c8f00b006e8f89863bbmr789353ejc.721.1654108477858;
        Wed, 01 Jun 2022 11:34:37 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id l15-20020a17090615cf00b006f3ef214dd9sm980927ejd.63.2022.06.01.11.34.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 11:34:36 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id d5-20020a05600c34c500b0039776acee62so2640259wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 11:34:36 -0700 (PDT)
X-Received: by 2002:a1c:7207:0:b0:397:66ee:9d71 with SMTP id
 n7-20020a1c7207000000b0039766ee9d71mr692055wmc.8.1654108476150; Wed, 01 Jun
 2022 11:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whi2SzU4XT_FsdTCAuK2qtYmH+-hwi1cbSdG8zu0KXL=g@mail.gmail.com>
 <cover.1654086665.git.legion@kernel.org> <857cb160a981b5719d8ed6a3e5e7c456915c64fa.1654086665.git.legion@kernel.org>
 <CAHk-=wjJ2CP0ugbOnwAd-=Cw0i-q_xC1PbJ-_1jrvR-aisiAAA@mail.gmail.com> <Ypeu97GDg6mNiKQ8@example.org>
In-Reply-To: <Ypeu97GDg6mNiKQ8@example.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Jun 2022 11:34:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBeQafNgw6DNUwM4vvw4snb83Tb65m_QH9XSic2JSJaQ@mail.gmail.com>
Message-ID: <CAHk-=wgBeQafNgw6DNUwM4vvw4snb83Tb65m_QH9XSic2JSJaQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] sysctl: ipc: Do not use dynamic memory
To:     Alexey Gladkov <legion@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux.dev>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Vasily Averin <vvs@virtuozzo.com>
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

On Wed, Jun 1, 2022 at 11:25 AM Alexey Gladkov <legion@kernel.org> wrote:
>
> I'm not sure how to get rid of ctl_table since net sysctls are heavily
> dependent on it.

I don't actually think it's worth getting rid of entirely, because
there's just a lot of simple cases where it "JustWorks(tm)" and having
just that table entry describe all the semantics is not wrong at all.

The name may suck, but hey, it's not a big deal. Changing it now would
be more pain than it's worth.

No, I was more thinking that things that already need more
infrastructure than that simple static ctl_table entry might be better
off trying to migrate to your new "proper read op" model, and having
more of that dynamic behavior in the read op.

The whole "create dynamic ctl_table entries on the fly" model works,
but it's kind of ugly.

Anyway, I think all of this is "I think there is more room for cleanup
in this area", and maybe we'll never have enough motivation to
actually do that.

Your patches seem to fix the extant issue with the ipc namespace, and
the truly disgusting parts (although maybe there are other truly
disgusting things hiding - I didn't go look for them).

                      Linus
