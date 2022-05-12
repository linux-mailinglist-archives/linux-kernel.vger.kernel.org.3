Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E02524FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355246AbiELOW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355245AbiELOWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:22:52 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3839424FD9D
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:22:51 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id v4so6690705ljd.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=R7CyVR4lsGxaBDvi/tZkzeeDdlAI4Jbhq0bK8oxoN98=;
        b=UW+LZniv1uCACyBiOURR6spV91E5bhZT/m9U6V91hrroq4OZ6fM7E76dUnf/bifgj9
         SAVjEMGDpkTGdJSYA5f1veSEhpOrxrF4hR7rkSZcLGrbDx77JDBcvEa4I3gExRxG+q1S
         fZFUrDCzUfS0+xLgPulHgj5M/JZLY0nsHA02o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=R7CyVR4lsGxaBDvi/tZkzeeDdlAI4Jbhq0bK8oxoN98=;
        b=Zt+tizyRA63MnjeVuTU/sGumwB8OyuYgpBHCpM+lcuWk85B7KOf9dsQTaz9otkt4lB
         KuRC8Bv/yQJIzptAw6SNNVcffUCecM9sA71diWRGlmHslhhVeT4ds1SfEhdxa3Ds8vHz
         BDayBLTqxgFlHUGMFZrjlojSV6OvyciGcCbC3mbnDBz3qdAWQkNKSaF5z0dQpc44ydGp
         evw/T2CMC9ulVh38u4gToL8xaV8/KKwvplmmjhbKQy3toE/AkpXG5kfSHmNuaa+rLsJ8
         FxkmS08e238Z0do5ICqFB364g+OVbQDO3mRMwuRIY0Bl11QTwv+fLXmFpnpxnexXKFBE
         Wr/A==
X-Gm-Message-State: AOAM530kV56RzdhBgITSEjmXWaDwW84Jp+DDr8/o6tm++ci8SmjNe60G
        ZWNXK+r49W+Qov5yIoKMvakAZpfgHeTBdlB0/enRDA==
X-Received: by 2002:a2e:818a:0:b0:24f:17b0:e36f with SMTP id
 e10-20020a2e818a000000b0024f17b0e36fmt71310ljg.89.1652365369442; Thu, 12 May
 2022 07:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220510190823.1552920-1-markyacoub@chromium.org>
In-Reply-To: <20220510190823.1552920-1-markyacoub@chromium.org>
From:   Mark Yacoub <markyacoub@chromium.org>
Date:   Thu, 12 May 2022 10:22:38 -0400
Message-ID: <CAJUqKUpP=YeGdAi5oD7FGjUREc7PRFc3ZvOfenXi3BZJ8_75xw@mail.gmail.com>
Subject: Re: [PATCH] drm: Create support for Write-Only property blob
Cc:     seanpaul@chromium.org, markyacoub@google.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

friendly ping :)

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
