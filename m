Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B0D5171C5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 16:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241703AbiEBOnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 10:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238116AbiEBOnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 10:43:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A17012A86
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 07:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651502386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=58rLakAFNoJNnG5Di+FTawUYlxOYFnmmF/e8CRlldJQ=;
        b=fDMMjsGob76Auxk9B/qKtQgr7d2vYKxTOqQuQZt4Kgsa1wn/KLlPf6OZJdHv2RXe2boCfT
        qf7BbPfrKFI7ZYXDhL8/52SUX6Aqw7rtFPF93Qg4q3b/rRcdVg+C7c0g1qQDdDtI6SiEHs
        TCRagxUWj4ZlguXTsTaiKq3brqZPznA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-ExDVaFBBNCGo9zrwtPcQig-1; Mon, 02 May 2022 10:39:45 -0400
X-MC-Unique: ExDVaFBBNCGo9zrwtPcQig-1
Received: by mail-wm1-f70.google.com with SMTP id u3-20020a05600c210300b0039430c7665eso1660340wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 07:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=58rLakAFNoJNnG5Di+FTawUYlxOYFnmmF/e8CRlldJQ=;
        b=AbUfaDUrb7mqwbZuDzWhJg5N37Z1LAuNjiQPx6PYeIerW6GKok0OmNltPSdljzvVKO
         gCd/Yj+UCkwiQfwtS1QQMoz8vBlhGkaundYyaV5rdGthexcbmbollr7n84+qO0Z0UVTG
         ykX1IVG7VzC6G0Sboih2fzZxj2wab2JKASGHcb966vMK3JS1k77B/RWmOdCdQ+nIktYo
         CIIT+5dOUDb06QQN+73+3Nq8tUtDDczFQWbojI7P6d6rwrYO5PLcac1NYuE6IsmdKksJ
         5vxd+ZIolAQ4Pq9GA+1ARGSG0MmGQX2SSqS0C5UMobiaPwwLa70TbZmpqO/NfRQMMhJO
         G/Qw==
X-Gm-Message-State: AOAM533YtdGz5RS0qfoIX2EnufZXoTx6BHMxlONn9Sdul0AuG8Kyhws+
        UH7PfmKB+GmtCmr9EHjL41J59J5zcvUJf5HCgIbXlXCNssgD/kYqOhAwYu3lzBsp5ZlkvoI8ZFl
        /fjh9IElD3U0Mn2RydsqFoOPO4v8oY5KMIQyVnddH
X-Received: by 2002:a7b:cb47:0:b0:393:dd9f:e64a with SMTP id v7-20020a7bcb47000000b00393dd9fe64amr15053002wmj.170.1651502383698;
        Mon, 02 May 2022 07:39:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeSqSrtlczNXNP5eDjRGWp+ntWxu/JB9aqmsfOg0rqpKIibXazTKglVMoMhIkmYF6H1Dn/NKWLxpLeWCbfFDQ=
X-Received: by 2002:a7b:cb47:0:b0:393:dd9f:e64a with SMTP id
 v7-20020a7bcb47000000b00393dd9fe64amr15052989wmj.170.1651502383468; Mon, 02
 May 2022 07:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220420095720.3331609-1-kherbst@redhat.com>
In-Reply-To: <20220420095720.3331609-1-kherbst@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 2 May 2022 16:39:32 +0200
Message-ID: <CACO55tv6rKETHhx=1yJ7Gf91sq1cDHyNgZxEdaN48PFBRdKu2g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/i915: Fix race in __i915_vma_remove_closed
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

friendly ping.

I am not even myself completely convinced that this is the correct
patch and it might just workaround some issues, but list_debug.c does
check if a list was already deleted and throws an error if it was and
this patch indeed fixes this one issue as multiple threads could enter
__i915_vma_remove_closed on the same vma.


On Wed, Apr 20, 2022 at 11:57 AM Karol Herbst <kherbst@redhat.com> wrote:
>
> i915_vma_reopen checked if the vma is closed before without taking the
> lock. So multiple threads could attempt removing the vma.
>
> Instead the lock needs to be taken before actually checking.
>
> v2: move struct declaration
>
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/5732
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> ---
>  drivers/gpu/drm/i915/i915_vma.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_vma.c b/drivers/gpu/drm/i915/i915_vma.c
> index 162e8d83691b..2efdad2b43fa 100644
> --- a/drivers/gpu/drm/i915/i915_vma.c
> +++ b/drivers/gpu/drm/i915/i915_vma.c
> @@ -1615,17 +1615,17 @@ void i915_vma_close(struct i915_vma *vma)
>
>  static void __i915_vma_remove_closed(struct i915_vma *vma)
>  {
> -       struct intel_gt *gt = vma->vm->gt;
> -
> -       spin_lock_irq(&gt->closed_lock);
>         list_del_init(&vma->closed_link);
> -       spin_unlock_irq(&gt->closed_lock);
>  }
>
>  void i915_vma_reopen(struct i915_vma *vma)
>  {
> +       struct intel_gt *gt = vma->vm->gt;
> +
> +       spin_lock_irq(&gt->closed_lock);
>         if (i915_vma_is_closed(vma))
>                 __i915_vma_remove_closed(vma);
> +       spin_unlock_irq(&gt->closed_lock);
>  }
>
>  static void force_unbind(struct i915_vma *vma)
> @@ -1641,6 +1641,7 @@ static void force_unbind(struct i915_vma *vma)
>  static void release_references(struct i915_vma *vma, bool vm_ddestroy)
>  {
>         struct drm_i915_gem_object *obj = vma->obj;
> +       struct intel_gt *gt = vma->vm->gt;
>
>         GEM_BUG_ON(i915_vma_is_active(vma));
>
> @@ -1651,7 +1652,9 @@ static void release_references(struct i915_vma *vma, bool vm_ddestroy)
>
>         spin_unlock(&obj->vma.lock);
>
> +       spin_lock_irq(&gt->closed_lock);
>         __i915_vma_remove_closed(vma);
> +       spin_unlock_irq(&gt->closed_lock);
>
>         if (vm_ddestroy)
>                 i915_vm_resv_put(vma->vm);
> --
> 2.35.1
>

