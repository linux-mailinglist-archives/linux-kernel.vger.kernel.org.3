Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D9E528826
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245151AbiEPPLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbiEPPLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:11:00 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA63A8
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:10:59 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s27so18547512ljd.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=I6V1S0+Ubt23S/fwZR+LgVaPvZqetjpsa3a8fOpRjX4=;
        b=f1SK0jcc+OeDOC8PPLG5ClBeeAkO62gvr8Eq3RI2ZTOXjogKMWL69gT2x9855jS/JF
         PWqjkoSrKChyGSIImOnjgcUYwVHDHH3EihM4tAm3O1N+iUIeiRKBURilv1YOWFqONnmM
         Upur3CRBYUAsJpu9YTUpE8COBZa4iUi4ISqFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=I6V1S0+Ubt23S/fwZR+LgVaPvZqetjpsa3a8fOpRjX4=;
        b=V+EBCjQKEZ1E7MuQe6B9qJD0jtpU6ATdSVEaluYY7hhVdktA6tpsr1m0C+7ZzxSkU+
         jptbW/8Q5JKwJX1U08AZRB4b6UyVjcsBY8gKGT3PnerikXXOS3KsH79+hcX1GJykVjqR
         pssxy+Y9B2nWsluzS1631qCg1N++bXlol7XPL0dhdUZGt6UpKPgVwGwZ9uIloSEtYufe
         c4vahAUxZuuqFvHIr4oyuDcL73fLd0OVnCt6iC0AJAT0PGMoXj5Z5j5UqtioqwLgkIiN
         eSO7L8k2U5oi4iL6jkdoCc0gz3LPgjqe7ZpOnB/R2eHSN6cTuvbJoxVezMAPRDEz8g+0
         miPw==
X-Gm-Message-State: AOAM533SP8P9yKKv+cxzKEQUQ9Gp57v7g1t5yXs9zffZZAAytGNI2sZB
        /nLtt+5Hz4ESi1ELnaikHdeatMY2JGK8PcG0bQEz1A==
X-Received: by 2002:a05:651c:158b:b0:250:a056:7e48 with SMTP id
 h11-20020a05651c158b00b00250a0567e48mt4435924ljq.64.1652713857732; Mon, 16
 May 2022 08:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220510190823.1552920-1-markyacoub@chromium.org>
In-Reply-To: <20220510190823.1552920-1-markyacoub@chromium.org>
From:   Mark Yacoub <markyacoub@chromium.org>
Date:   Mon, 16 May 2022 11:10:46 -0400
Message-ID: <CAJUqKUr0sp5hEu=L+80pQ-Ba963WY6-G24dbob+KA5f+dhEypA@mail.gmail.com>
Subject: Re: [PATCH] drm: Create support for Write-Only property blob
Cc:     seanpaul@chromium.org, markyacoub@google.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

friendly ping :))

On Tue, May 10, 2022 at 3:08 PM Mark Yacoub <markyacoub@chromium.org> wrote:
>
> [Why]
> User space might need to inject data into the kernel without allowing it
> to be read again by any user space.
> An example of where this is particularly useful is secret keys fetched
> by user space and injected into the kernel to enable content protection.
>
> [How]
> Create a DRM_MODE_CREATE_BLOB_WRITE_ONLY flag used by user space to
> create a blob and mark the blob as write only.
> On reading back the blob, data will be not be copied if it's a write
> only blob
>
> Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
>
> ---
>  drivers/gpu/drm/drm_property.c | 3 ++-
>  include/drm/drm_property.h     | 2 ++
>  include/uapi/drm/drm_mode.h    | 6 ++++++
>  3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
> index dfec479830e4..afedf7109d00 100644
> --- a/drivers/gpu/drm/drm_property.c
> +++ b/drivers/gpu/drm/drm_property.c
> @@ -765,7 +765,7 @@ int drm_mode_getblob_ioctl(struct drm_device *dev,
>         if (!blob)
>                 return -ENOENT;
>
> -       if (out_resp->length == blob->length) {
> +       if (out_resp->length == blob->length && !blob->is_write_only) {
>                 if (copy_to_user(u64_to_user_ptr(out_resp->data),
>                                  blob->data,
>                                  blob->length)) {
> @@ -800,6 +800,7 @@ int drm_mode_createblob_ioctl(struct drm_device *dev,
>                 ret = -EFAULT;
>                 goto out_blob;
>         }
> +       blob->is_write_only = out_resp->flags & DRM_MODE_CREATE_BLOB_WRITE_ONLY;
>
>         /* Dropping the lock between create_blob and our access here is safe
>          * as only the same file_priv can remove the blob; at this point, it is
> diff --git a/include/drm/drm_property.h b/include/drm/drm_property.h
> index 65bc9710a470..700782f021b9 100644
> --- a/include/drm/drm_property.h
> +++ b/include/drm/drm_property.h
> @@ -205,6 +205,7 @@ struct drm_property {
>   *     &drm_mode_config.property_blob_list.
>   * @head_file: entry on the per-file blob list in &drm_file.blobs list.
>   * @length: size of the blob in bytes, invariant over the lifetime of the object
> + * @is_write_only: user space can't read the blob data.
>   * @data: actual data, embedded at the end of this structure
>   *
>   * Blobs are used to store bigger values than what fits directly into the 64
> @@ -219,6 +220,7 @@ struct drm_property_blob {
>         struct list_head head_global;
>         struct list_head head_file;
>         size_t length;
> +       bool is_write_only;
>         void *data;
>  };
>
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index 0a0d56a6158e..de192d3813e9 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -1107,6 +1107,9 @@ struct drm_format_modifier {
>         __u64 modifier;
>  };
>
> +#define DRM_MODE_CREATE_BLOB_WRITE_ONLY                                        \
> +       (1 << 0) /* data of the blob can't be read by user space */
> +
>  /**
>   * struct drm_mode_create_blob - Create New blob property
>   *
> @@ -1120,6 +1123,9 @@ struct drm_mode_create_blob {
>         __u32 length;
>         /** @blob_id: Return: new property ID. */
>         __u32 blob_id;
> +       /** Flags for special handling. */
> +       __u32 flags;
> +       __u32 pad;
>  };
>
>  /**
> --
> 2.36.0.512.ge40c2bad7a-goog
>
