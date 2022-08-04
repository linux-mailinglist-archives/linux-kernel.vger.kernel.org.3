Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE11B58954F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 02:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238456AbiHDA1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 20:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237257AbiHDA10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 20:27:26 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F882654A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 17:27:25 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id cm4-20020a056830650400b0063675a4dd74so3451929otb.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 17:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=wAxTGG2z5uPbKc8r/D1X93SfdtCWLytjF7BL3/nlYA4=;
        b=Vntdz8+B+JaSfFgoi3UYyQn+pGWRu0BUu6JkO2Qyo0srR26BX7aT7NdWIYit8POIyT
         btdkaxIgwIHiB3+3cl4nHzXVK5C4py+EZxJXvMpY8VHZkhW4JpwP7sr3WIdu+vnm866F
         94Gu0mqhxAjdUDMiOBuVbb2uz/icDe7bqeasE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=wAxTGG2z5uPbKc8r/D1X93SfdtCWLytjF7BL3/nlYA4=;
        b=uVvT+RQN5gx3KdMhsTg91oFkSPKgZZ84wnrn0nhDgF0aCCtvlgnZWPJ1mdNnhz3OkT
         wqY6K4GPJwkVkhiUcSrXZnsnxK3A97ylwO2froox0frM/+1GK6m7jsv0hsdsIC1Pmtx9
         q2ti9ydldCOHgjG9TNNJ0UnXoV1M7HARBnSFa8MxjKyN9A8Y9ZD3scz0L0/VIq6T5Qj3
         iqjintEsIm9h4ABuHA/zadiS+KYP7ukD003kyuAaKlvwl8UhT98+EDnm7SWNqU1J/jg6
         4kj2a5uvlZ5Yn/0/qmw4VWnwEjOoNx/23J/5Bagum3b2F0mhOOUO65fT7c2hW5qenKL2
         fgyw==
X-Gm-Message-State: AJIora9e+TkcBuImZXgnzesFIXHACwsqFXV6rx3phwlitpXFCZtqun+F
        XNa8UpWfgTpoH82aKbLjUqf2lzgXEVoIJ/MEVxI=
X-Google-Smtp-Source: AGRyM1vvfyOM8ovavzzgwhLzOLzAHlzOee4gNqHsWKfON+0JOclY6G9fiNABw/UyatIBEWx4PB/zPw==
X-Received: by 2002:a9d:2f2a:0:b0:61c:cc5a:22b with SMTP id h39-20020a9d2f2a000000b0061ccc5a022bmr10224441otb.71.1659572844688;
        Wed, 03 Aug 2022 17:27:24 -0700 (PDT)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id t127-20020acaaa85000000b003429e595d2asm205562oie.43.2022.08.03.17.27.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 17:27:24 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id m22-20020a0568301e7600b006369227f745so1309756otr.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 17:27:23 -0700 (PDT)
X-Received: by 2002:a9d:61c4:0:b0:61d:17b2:59d4 with SMTP id
 h4-20020a9d61c4000000b0061d17b259d4mr10080432otk.284.1659572843301; Wed, 03
 Aug 2022 17:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220803101438.24327-1-pabeni@redhat.com> <CAHk-=widn7iZozvVZ37cDPK26BdOegGAX_JxR+v62sCv-5=eZg@mail.gmail.com>
 <YusOpd6IuLB29LHs@salvia>
In-Reply-To: <YusOpd6IuLB29LHs@salvia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Aug 2022 17:27:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj59jR+pxYHmtf+OJvThEpYLNYLb9P5YkgCcBWDWzhdPQ@mail.gmail.com>
Message-ID: <CAHk-=wj59jR+pxYHmtf+OJvThEpYLNYLb9P5YkgCcBWDWzhdPQ@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for 6.0
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Paolo Abeni <pabeni@redhat.com>, Vlad Buslov <vladbu@nvidia.com>,
        Oz Shlomo <ozsh@nvidia.com>, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 3, 2022 at 5:11 PM Pablo Neira Ayuso <pablo@netfilter.org> wrote:
>
> For these two questions, this new Kconfig toggle was copied from:
>
>  config NF_CONNTRACK_PROCFS
>         bool "Supply CT list in procfs (OBSOLETE)"
>         default y
>         depends on PROC_FS
>
> which is under:
>
>  if NF_CONNTRACK
>
> but the copy and paste was missing this.

Note that there's two problems with that

 (1) the NF_CONNTRACK_PROCFS thing is 'default y' because it *USED* to
be unconditional, and was split up as a config option back in 2011.

See commit 54b07dca6855 ("netfilter: provide config option to disable
ancient procfs parts").

IOW, that NF_CONNTRACK_PROCFS exists and defaults to on, not because
people added new code and wanted to make it default, but because the
code used to always be enabled if NF_CONNTRACK was enabled, and people
wanted the option to *disable* it.

That's when you do 'default y' - you take existing code that didn't
originally have a question at all, and you make it optional. Then you
use 'default y' so that people who used it don't get screwed in the
process.

 (2) it didn't do the proper conditional on the feature it depended on.

So let's not do copy-and-paste programming. The old Kconfig snippet
had completely different rules, had completely different history, and
completely different default values as a result.

I realize that it's very easy to think of Kconfig as some
not-very-important detail to just hook things up. But because it's
front-facing to users, I do want people to think about it more than
perhaps people otherwise would.

                Linus
