Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C4D52570B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 23:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358731AbiELVbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 17:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358732AbiELVbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 17:31:33 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B113E0C2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:31:31 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id j84so1301320ybc.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3GME8g6CPueWMd7lO8qXn1DRp2ceHlUdCzpOykCHbrg=;
        b=sZeZsptj07txPT3pe6bg85WLBogL/niFdujvXhGmvGHvUMdf+ubK/UMpNHCLyogLwJ
         1SzO61ddJPTl2rtfw/kEWCzbP/eORv0uCHNC9PQeJyNGrGAE73x2lB0kWBr2Kjmq3xRa
         mHwmaWFkL87Lq1cgfh194/MR4V/+H09KgB3y8gzFiALIbiGBD1RimwncOW3qBHBZ2PVs
         UJ6FI/VP/MEHjwSS79k9qDB+GAXe0Ehg7pg7yN/vCBgUpTkurP3pNm1JUOvBj2epSt4W
         zK35VaXeUyV2ai5LhbEjWsjFjQ7WQtGm92S5pR09fzSj8A5IT67/CPetqREViJP8tMHW
         dVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3GME8g6CPueWMd7lO8qXn1DRp2ceHlUdCzpOykCHbrg=;
        b=hMKaCiyiWwOC25Z7bKOA1D/9KbPrzhNbD4iel3dEp4Y7T2yAvOvEpZLR/xT/1akBFc
         +9tUaRpO2VmR8qci7XG4wmGHwj/oeCpZUXAsXcPk2sRCVaPYU5EpDgvCRCcE5wAz+g10
         CI+rTwP8mtFGNs2qH4nwmIhUNKpjZspRrV9MncmyZSibXuO4DQ7pbvpx4hvYW1XvGsht
         7ydakftTuIRFSZc0jsStQLC/nXKNiv57FS+qD7aRgnvWXMSM2fQy3AmaNKcg0XC+2JuL
         EWxi72GsDj7/g55US4J6uIUHid11uj71HEUrvWqBNFzTkO/3tmnU1Kb3L+/1iOgEaru0
         XzQQ==
X-Gm-Message-State: AOAM533iVUSwKOGpUAEMDG0yhxtCEOEYdzu7arlfgxvieH7X2kybRzya
        8VxHaWqm/BKbz9/aY6LmQlw8P5rQTru5iMYnmiHKqg==
X-Google-Smtp-Source: ABdhPJzRP9OzjWdpg6cI3ylhn4k+6QO0736A21gHd6fEDFV4tnKVbdWhReuAz2gSne+SFZ3750d7D1xL3b8UC7zpu2M=
X-Received: by 2002:a25:84c3:0:b0:64a:de2c:2b75 with SMTP id
 x3-20020a2584c3000000b0064ade2c2b75mr1889370ybm.70.1652391089597; Thu, 12 May
 2022 14:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220512211704.3158759-1-nathan@kernel.org>
In-Reply-To: <20220512211704.3158759-1-nathan@kernel.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 12 May 2022 14:30:53 -0700
Message-ID: <CABCJKucbETQeRHx4bLG1fWZBnpszbrS9N+Ryp9sr2AcAY=9sxA@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: Fix CFI violation with show_dynamic_id()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        patches@lists.linux.dev
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

On Thu, May 12, 2022 at 2:17 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> When an attribute group is created with sysfs_create_group(), the
> ->sysfs_ops() callback is set to kobj_sysfs_ops, which sets the ->show()
> callback to kobj_attr_show(). kobj_attr_show() uses container_of() to
> get the ->show() callback from the attribute it was passed, meaning the
> ->show() callback needs to be the same type as the ->show() callback in
> 'struct kobj_attribute'.
>
> However, show_dynamic_id() has the type of the ->show() callback in
> 'struct device_attribute', which causes a CFI violation when opening the
> 'id' sysfs node under drm/card0/metrics. This happens to work because
> the layout of 'struct kobj_attribute' and 'struct device_attribute' are
> the same, so the container_of() cast happens to allow the ->show()
> callback to still work.
>
> Change the type of show_dynamic_id() to match the ->show() callback in
> 'struct kobj_attributes' and update the type of sysfs_metric_id to
> match, which resolves the CFI violation.
>
> Fixes: f89823c21224 ("drm/i915/perf: Implement I915_PERF_ADD/REMOVE_CONFIG interface")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/gpu/drm/i915/i915_perf.c       | 4 ++--
>  drivers/gpu/drm/i915/i915_perf_types.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
> index 0a9c3fcc09b1..1577ab6754db 100644
> --- a/drivers/gpu/drm/i915/i915_perf.c
> +++ b/drivers/gpu/drm/i915/i915_perf.c
> @@ -4050,8 +4050,8 @@ static struct i915_oa_reg *alloc_oa_regs(struct i915_perf *perf,
>         return ERR_PTR(err);
>  }
>
> -static ssize_t show_dynamic_id(struct device *dev,
> -                              struct device_attribute *attr,
> +static ssize_t show_dynamic_id(struct kobject *kobj,
> +                              struct kobj_attribute *attr,
>                                char *buf)
>  {
>         struct i915_oa_config *oa_config =
> diff --git a/drivers/gpu/drm/i915/i915_perf_types.h b/drivers/gpu/drm/i915/i915_perf_types.h
> index 473a3c0544bb..05cb9a335a97 100644
> --- a/drivers/gpu/drm/i915/i915_perf_types.h
> +++ b/drivers/gpu/drm/i915/i915_perf_types.h
> @@ -55,7 +55,7 @@ struct i915_oa_config {
>
>         struct attribute_group sysfs_metric;
>         struct attribute *attrs[2];
> -       struct device_attribute sysfs_metric_id;
> +       struct kobj_attribute sysfs_metric_id;
>
>         struct kref ref;
>         struct rcu_head rcu;

This looks correct to me. Thanks for testing this and fixing the issue!

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
