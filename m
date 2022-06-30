Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4830562016
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 18:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbiF3QRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 12:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236330AbiF3QRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:17:31 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060F72E087
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 09:17:31 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-318889e6a2cso184116937b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 09:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+tJf/17a3GQ00Kn5C7fSPbfS+nGvxRvX74INNcvd7FM=;
        b=V3IQdTjwGtjHq/wY732Ok5nzPOJUJqa005Rjh4xsvyjkOvxBhqe9k6+vrZGL/tcswq
         47DBJDjy1pOYDTaYRu5k7So0tFRo9qf8mXCvatq9gaoBf1DfxkRKsX5tf624n1A1J5WZ
         23IEz9yDN2Y/rJ+PWcc8WSpdQ78EJGf0hq4xxvWzUL/F30sfLXWEwn+HtiiyFfUjveIj
         MP4bYCJgaRY+wnD7da1+nEh6j6LLAvYE83G3gNqaoAIoxf+pBcAmnHAkw1DHEBHRFon+
         FM9Wb4svFi8uTslDwmzkHDu41Z74gJ+iVOd2a9U2wskWBSIIlgZuSzeZDm9dnV3BuQXN
         xpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+tJf/17a3GQ00Kn5C7fSPbfS+nGvxRvX74INNcvd7FM=;
        b=ncwCOFXPO7k4W+Gh0Aw/cy8in45B/iiAIsmgeQED2lPkCXg+csKtJzOH6CItd2FzYz
         9Lzwmb//z3hvohkIvtixtESXtEuCzISncB2RsmQCGUN9gvH1Sw7NgV0PkNOAhj6B3HMe
         BdySyWN8ORiSwXoExcWu2BQdJ0EZV9Zo14Xtjvgzmgu3EUkbHmhc0vD80Z6/F7bnUL9w
         dhrHFA7TKrHNdhdmmulLRWi9agBd00X217huE8VspGHYm5kzIWBthrbYO8JNQalN1IiT
         Ze9xvNM2EmT7MM8vZtlXshoPwz2TtTOGULgEQ51MW29F7JnaPADRnwM8Cdmb+vPhmLm1
         hn2w==
X-Gm-Message-State: AJIora+lkYEFb/G3NhvRWkqefZp9hjXlvMc3aC54ru5CyF9xwYDg92km
        FJ8gh4hIhoBcPDkO1En/i+mr8zSUD14pshGvkBWC/A==
X-Google-Smtp-Source: AGRyM1sbaK65wf5OF7UYo6reMNsQ9IKIvv8vWLIjJgL97P1kM6VEZuZlgN8a9YFYBeLnAT80hQNyEvy2X6rmMVj68I0=
X-Received: by 2002:a81:68e:0:b0:317:ca36:5807 with SMTP id
 136-20020a81068e000000b00317ca365807mr10798982ywg.314.1656605849995; Thu, 30
 Jun 2022 09:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220630094646.91837-1-haibo.li@mediatek.com> <20220630094646.91837-3-haibo.li@mediatek.com>
In-Reply-To: <20220630094646.91837-3-haibo.li@mediatek.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 30 Jun 2022 09:16:53 -0700
Message-ID: <CABCJKudz5O5_-1q1H0o2DFRcnpMQDBPv4STUVa2bOE9ePaeyDA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ANDROID: cfi: free old cfi shadow asynchronously
To:     Haibo Li <haibo.li@mediatek.com>
Cc:     xiaoming.yu@mediatek.com, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Aaron Tomlin <atomlin@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
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

Hi,

On Thu, Jun 30, 2022 at 2:47 AM Haibo Li <haibo.li@mediatek.com> wrote:
>
> Currenly, it uses synchronize_rcu() to wait old rcu reader to go away
> in update_shadow.In embedded platform like ARM CA7X,
> load_module blocks 40~50ms in update_shadow.
> When there are more than one hundred kernel modules,
> it blocks several seconds.
>
> To accelerate load_module,change synchronize_rcu to call_rcu.
>
> Signed-off-by: Haibo Li <haibo.li@mediatek.com>
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>

Thanks for the patch! Please drop ANDROID: from the subject line,
that's only used in the Android kernel trees.

>  kernel/cfi.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/cfi.c b/kernel/cfi.c
> index 456771c8e454..a4836d59ca27 100644
> --- a/kernel/cfi.c
> +++ b/kernel/cfi.c
> @@ -43,6 +43,8 @@ typedef u16 shadow_t;
>  struct cfi_shadow {
>         /* Page index for the beginning of the shadow */
>         unsigned long base;
> +       /* rcu to free old cfi_shadow asynchronously */
> +       struct rcu_head rcu;
>         /* An array of __cfi_check locations (as indices to the shadow) */
>         shadow_t shadow[1];
>  } __packed;
> @@ -182,6 +184,13 @@ static void remove_module_from_shadow(struct cfi_shadow *s, struct module *mod,
>         }
>  }
>
> +static void _cfi_shadow_free_rcu(struct rcu_head *rcu)

I think this can be simply renamed to free_shadow.

> +{
> +       struct cfi_shadow *old = container_of(rcu, struct cfi_shadow, rcu);
> +
> +       vfree(old);
> +}
> +
>  typedef void (*update_shadow_fn)(struct cfi_shadow *, struct module *,
>                         unsigned long min_addr, unsigned long max_addr);
>
> @@ -211,11 +220,10 @@ static void update_shadow(struct module *mod, unsigned long base_addr,
>
>         rcu_assign_pointer(cfi_shadow, next);
>         mutex_unlock(&shadow_update_lock);
> -       synchronize_rcu();
>
>         if (prev) {
>                 set_memory_rw((unsigned long)prev, SHADOW_PAGES);
> -               vfree(prev);
> +               call_rcu(&prev->rcu, _cfi_shadow_free_rcu);
>         }
>  }

It's probably better to keep the pages read-only until they're
actually released. Can you move the set_memory_rw call to the new
function?

Sami
