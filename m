Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1107A507966
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354412AbiDSSvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354195AbiDSSvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:51:20 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89167369E9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:48:36 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id bn33so21650349ljb.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fR5j6tNvEd20kRXox0BKES1z9CqGLwQFicb24kMNTsY=;
        b=FQSv3Yqg2ec2ArhRNMIWp2J/VcYnUCn8aecvRif9GTF5hcXIN64LvAuUW/lv7d3jBH
         REwSulEtLFK6mA1AE8qBorknMGZzd0wv8NLMoSFSkMyRn46Zk6/Dsv19NpnhOrvLXJ7f
         Ojj9YxIw/UIAo6fG5n87SNwgOZXH1lsYlm+HKw+rQXi2PDXDE7UX3Cshw5W6rqqNVH8K
         YL5AsQm5W7aoA2vKxxSQgTK4FDE0FoXFQt4P+Mc/aL3dFAejcc7/dkrFLz89jAUHJK1q
         yWQddgOdJVe6L6snpZ8FrfG8v58YGStFJJj5nj0Ba1JEMIvoSNBMbxwXXATb3C5ZwsOR
         E64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fR5j6tNvEd20kRXox0BKES1z9CqGLwQFicb24kMNTsY=;
        b=JM+uY2jCi8MDvoA+tNxeUOXBKWiCoRHxtA7+zTUlRtqIi/ZGvtcv08rX8uigBJzfwV
         lpPNwhdh6ZCkMG5XwS/ySdIoy1jHMdU23kttT+/Y7wgu1CZEzUOzhr+DCuv0/4Rog4fY
         AU/r05/SZ6AMW+zbjN2lF7ObQWEq6omv0PtTxnrgrsCoK3OGEY7xW68a4RI2k2JMGfj1
         /X+sHX/kHj/lRsLYluOoDSqpbjbdTegbQGNXbXqV95arWmSCNbcYCXYJ/FhvWbTBn/xx
         MjRm8k3M33KatI08nlEhKR0oV39mYSb4HyoYtbRGjt1FuCHsYSaY4XZ7VN23de/wfyzf
         8XnQ==
X-Gm-Message-State: AOAM532twzVk9Ls7Fflc+Tojfop9I9o9wnSF/numU9b4E2OOvCNDxyzd
        VyPvO76PjI7OeQjNO0oNxuZyvfhk+mnRO2BAN6UNYA==
X-Google-Smtp-Source: ABdhPJwKcESeIVfeFEF/wr+oaM4XU6kMdFkNNQ3rEwKpETLS/xXYe70CXxuDSgs0TV5DQBoKnXLqfVewjgC73AJsvHA=
X-Received: by 2002:a2e:bc28:0:b0:24d:d4b3:ed14 with SMTP id
 b40-20020a2ebc28000000b0024dd4b3ed14mr742509ljf.238.1650394114674; Tue, 19
 Apr 2022 11:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220415120015.52684-1-ales.astone@gmail.com> <20220415120015.52684-2-ales.astone@gmail.com>
In-Reply-To: <20220415120015.52684-2-ales.astone@gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Tue, 19 Apr 2022 11:48:23 -0700
Message-ID: <CAHRSSEwZZMRkytqAMQOL7Ms6dCNZ7VaEf+ykLz82uAVW58Lxdw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] binder: Address corner cases in deferred copy and fixup
To:     Alessandro Astone <ales.astone@gmail.com>
Cc:     tkjos@android.com, gregkh@linuxfoundation.org, brauner@kernel.org,
        arve@android.com, linux-kernel@vger.kernel.org, maco@android.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>
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

On Fri, Apr 15, 2022 at 5:00 AM Alessandro Astone <ales.astone@gmail.com> wrote:
>
> When handling BINDER_TYPE_FDA object we are pushing a parent fixup
> with a certain skip_size but no scatter-gather copy object, since
> the copy is handled standalone.
> If BINDER_TYPE_FDA is the last children the scatter-gather copy
> loop will never stop to skip it, thus we are left with an item in
> the parent fixup list. This will trigger the BUG_ON().
>
> This is reproducible in android when playing a video.
> We receive a transaction that looks like this:
>     obj[0] BINDER_TYPE_PTR, parent
>     obj[1] BINDER_TYPE_PTR, child
>     obj[2] BINDER_TYPE_PTR, child
>     obj[3] BINDER_TYPE_FDA, child
>
> Fixes: 09184ae9b575 ("binder: defer copies of pre-patched txn data")
> Signed-off-by: Alessandro Astone <ales.astone@gmail.com>

Acked-by: Todd Kjos <tkjos@google.com>


> ---
>  drivers/android/binder.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 8351c5638880..31176edb1069 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2295,6 +2295,7 @@ static int binder_do_deferred_txn_copies(struct binder_alloc *alloc,
>  {
>         int ret = 0;
>         struct binder_sg_copy *sgc, *tmpsgc;
> +       struct binder_ptr_fixup *tmppf;
>         struct binder_ptr_fixup *pf =
>                 list_first_entry_or_null(pf_head, struct binder_ptr_fixup,
>                                          node);
> @@ -2349,7 +2350,11 @@ static int binder_do_deferred_txn_copies(struct binder_alloc *alloc,
>                 list_del(&sgc->node);
>                 kfree(sgc);
>         }
> -       BUG_ON(!list_empty(pf_head));
> +       list_for_each_entry_safe(pf, tmppf, pf_head, node) {
> +               BUG_ON(pf->skip_size == 0);
> +               list_del(&pf->node);
> +               kfree(pf);
> +       }
>         BUG_ON(!list_empty(sgc_head));
>
>         return ret > 0 ? -EINVAL : ret;
> --
> 2.35.1
>
