Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DA453C07A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 23:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239487AbiFBVrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 17:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239352AbiFBVrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 17:47:42 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A30E1DA6E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 14:47:41 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id v22so10643360ybd.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 14:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pd1LekGY0cpB3lKyT64rGGQFHBupdHGemhO5JR+nPi0=;
        b=FJXojaZaObe7jR3cqMVF5PSwKT+cwoHHKDI75uBRHVAg/497qEByYBnnrzb2/9yhTa
         kQo6uEGDrnRm25vP79gRadGhkB5GJy0fqmg8AY9bIRojmj1U0tD3CPLYXR+mHv8F2KWY
         I+thDPBDeZJpTi34nM32Lw4f2Pk0OoFaFkSygxLOgA/XE5uWHy9wdGOXXyySNJCrt/Gq
         p6HkD5xTtCS9wEFzJjQ2i1XdJTlpgWv8NnGQIJvIrvs+CVbvIfIWKIp92xgVE1qCIFrh
         Rj487JsZVkUPEfBz8jsW/W4WfgtwrQxuX/e9c8LbObGgei94yAYcswJ6e51n5MZtFAfQ
         6hBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pd1LekGY0cpB3lKyT64rGGQFHBupdHGemhO5JR+nPi0=;
        b=VA870eU/ZyT97ASbTtlEg9qQaOnGpOyNwuOodz1cHDDveYxImg5vKcrCcA+sou6bjw
         o5fhkBtfBV/6H+D2AucioLpnuDkdlo8SuofBh5eTLQknevInvnZ1yXXAtTht290n80pI
         Kc8x577sNsA1loAhaUynDDuljYzErN0xQNx1UokMSjF/PfApwq8SPXiN3XFUdFkX+Zi/
         JKZhs/pcVxrXdn1lD704vY/Wq3T+his1xxSEQARyQixxmRRuSkFRBfRM9SBUiMmMuh+8
         GkjPx2rg+UKpNGGdyC/YR2FpnFfKqzMt3vlSOSl+XFEONDmY6o7rgE0Uzzoe4kXXyRfb
         fbQQ==
X-Gm-Message-State: AOAM532+udsTn5x7YkImA5pyxYv6zkV07nBwNKCruidvDZf6pQI5QLZq
        H68FqFZomwAHzWBQdtl2086pjLdPyGJAGlbYEd1Zdg==
X-Google-Smtp-Source: ABdhPJwhaVML6bY2sbv22pA3loCooNXtPYM9TGo3kGez3Md1KGwL7qsfflQkSlEjz20MmwDUAMTWcCzyNqTr6jeKvsI=
X-Received: by 2002:a25:cc4c:0:b0:65c:8e83:fd5e with SMTP id
 l73-20020a25cc4c000000b0065c8e83fd5emr8182576ybf.563.1654206460483; Thu, 02
 Jun 2022 14:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220322140344.556474-2-atomlin@redhat.com> <20220602035653.4167316-1-saravanak@google.com>
 <YpkMelZC+E5hKTw6@bombadil.infradead.org> <CAHk-=wit6ttmzdFsbH+YLkMeLucTspYADHnENn4fBXNrit0BUQ@mail.gmail.com>
In-Reply-To: <CAHk-=wit6ttmzdFsbH+YLkMeLucTspYADHnENn4fBXNrit0BUQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 2 Jun 2022 14:47:04 -0700
Message-ID: <CAGETcx9f5BiojqU6wr29eUrYr9s8k+CGj_t-7RvrTSmDm6WwJw@mail.gmail.com>
Subject: Re: [PATCH v1] module: Fix prefix for module.sig_enforce module param
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Aaron Tomlin <atomlin@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, Allen Pais <allen.lkml@gmail.com>,
        Joe Perches <joe@perches.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jason Wessel <jason.wessel@windriver.com>,
        Petr Mladek <pmladek@suse.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 2, 2022 at 12:41 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Jun 2, 2022 at 12:16 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > Linus want to take this in or should I just queue these up?
>
> I'll take it, and remove the unnecessary #ifdef/#endif. The #undef
> might as well be unconditional - simpler and doesn't hurt.

Sounds good. I just copy-pasted how it was done elsewhere. Luis was
mentioning adding a wrapper to go this cleanly and I needed it in
another instance too. So I'll look into doing that in a future patch.

-Saravana
