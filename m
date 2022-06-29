Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CA5560573
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiF2QJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbiF2QJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:09:38 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E7622B0A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:09:37 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id n15so19526580ljg.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RjA9yoeKJEit30gXR1L+5b7fCv6aeEhkvnEzo2CvTOo=;
        b=c9zgsASaoXDw3UAW9z/JyC6raq4R+K2Q4R5Z9gkF1HRMSOOFEaRhvK6xNxvAtLHyOa
         V8lFlr0suG13wcricDo1rlod8JeQ+DESqcE88LClj6NyK86MP1vakz5pXdujIq2fUHu8
         arLYYncHkJ3E1IDHpZwqDEWzK+1Ip9QbtVtDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RjA9yoeKJEit30gXR1L+5b7fCv6aeEhkvnEzo2CvTOo=;
        b=baoAOGnqkdncAXssnGdQRlPtS6y9d1BOaNQ1nMCYqzrcaI0dxzZrfcEieTi8mpPXWd
         OXfEPPTpqBluAu2JQUFEJFFLmZm1MEWWiGMfS0Dpz91R5tRQCxh4kL30xqtGNRdywuI/
         W9QRl45FXovZM4itGP87OmLgsN5DbXDKBUnqL7niPZDaxY6cVmlEhqMqk2eEU6i99wwi
         QoirbSKNDOe1ypByFQRhCpMNEWeUq33rJhLeS5X/c7RCMqiZAaWDjslL5qeSS6Gl8sRw
         +cYZs35jk3MraWCnyZpd3w6i8/4Z5zQ7IMZMvKisbTnP6oJfIxvHZZ1xmIBglggCxZHe
         GF3Q==
X-Gm-Message-State: AJIora/RLkiNJ2udznOoITEtTxY0FeA4NjeDHUC/X4ppfw8WZ2gaGGze
        d1u+xIgK88nLY3U9d1er9B/SeMw7DZJHGpANS3oldg==
X-Google-Smtp-Source: AGRyM1troXfDF2PbFQdMbX3rjPYO2u7G7NCrGjw/WOULU33WWRfa+1zKQEAFOp2U02qZYxdlV5POzxub3MBhKXJ88tc=
X-Received: by 2002:a2e:9656:0:b0:25a:7584:b095 with SMTP id
 z22-20020a2e9656000000b0025a7584b095mr2171675ljh.17.1656518974178; Wed, 29
 Jun 2022 09:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220510190823.1552920-1-markyacoub@chromium.org>
 <878rr0fvcs.fsf@intel.com> <CAJUqKUpk4=oOYUmEAqEK2q_+xNiLfpvixPMXiC8sDu1pkwUyfQ@mail.gmail.com>
In-Reply-To: <CAJUqKUpk4=oOYUmEAqEK2q_+xNiLfpvixPMXiC8sDu1pkwUyfQ@mail.gmail.com>
From:   Mark Yacoub <markyacoub@chromium.org>
Date:   Wed, 29 Jun 2022 12:09:23 -0400
Message-ID: <CAJUqKUpae5cf-GD1LPQrxfHAMb3K+gY5Q4yxiVCafW9_A9gxfw@mail.gmail.com>
Subject: Re: [PATCH] drm: Create support for Write-Only property blob
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        seanpaul@chromium.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>, markyacoub@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jani, let me know if you need more info or more changes are needed. Thanks!

On Wed, May 25, 2022 at 3:31 PM Mark Yacoub <markyacoub@chromium.org> wrote:
>
> Hi Jani, thanks for your review. I got all the user space
> implementation ready to see it in context.
>
> libdrm patch to wrap this functionality:
> https://www.spinics.net/lists/dri-devel/msg347318.html
>
> Chromium user space implementation making direct use of the new prop flag:
> crrev.com/c/3655850
> The first call made to such functionality is in
> https://chromium-review.googlesource.com/c/chromium/src/+/3655850/2/ui/display/manager/content_protection_key_manager.cc#137
> where the call stack flows to the libdrm wrapper call at
> https://chromium-review.googlesource.com/c/chromium/src/+/3655850/2/ui/ozone/platform/drm/gpu/drm_display.cc#203
>
> I also wrote an IGT test to verify the intended behavior:
> https://patchwork.freedesktop.org/patch/487331/?series=104373&rev=1
>
> Let me know if I would need to update the commit message with any of
> the aforementioned context.
>
> Thanks!
> -Mark Yacoub
>
> On Tue, May 17, 2022 at 3:53 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> >
> > On Tue, 10 May 2022, Mark Yacoub <markyacoub@chromium.org> wrote:
> > > [Why]
> > > User space might need to inject data into the kernel without allowing it
> > > to be read again by any user space.
> > > An example of where this is particularly useful is secret keys fetched
> > > by user space and injected into the kernel to enable content protection.
> >
> > I think we're going to need more than an example in the commit
> > message. See Documentation/gpu/drm-uapi.rst.
> >
> > BR,
> > Jani.
> >
> >
> > >
> > > [How]
> > > Create a DRM_MODE_CREATE_BLOB_WRITE_ONLY flag used by user space to
> > > create a blob and mark the blob as write only.
> > > On reading back the blob, data will be not be copied if it's a write
> > > only blob
> > >
> > > Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
> > >
> > > ---
> > >  drivers/gpu/drm/drm_property.c | 3 ++-
> > >  include/drm/drm_property.h     | 2 ++
> > >  include/uapi/drm/drm_mode.h    | 6 ++++++
> > >  3 files changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
> > > index dfec479830e4..afedf7109d00 100644
> > > --- a/drivers/gpu/drm/drm_property.c
> > > +++ b/drivers/gpu/drm/drm_property.c
> > > @@ -765,7 +765,7 @@ int drm_mode_getblob_ioctl(struct drm_device *dev,
> > >       if (!blob)
> > >               return -ENOENT;
> > >
> > > -     if (out_resp->length == blob->length) {
> > > +     if (out_resp->length == blob->length && !blob->is_write_only) {
> > >               if (copy_to_user(u64_to_user_ptr(out_resp->data),
> > >                                blob->data,
> > >                                blob->length)) {
> > > @@ -800,6 +800,7 @@ int drm_mode_createblob_ioctl(struct drm_device *dev,
> > >               ret = -EFAULT;
> > >               goto out_blob;
> > >       }
> > > +     blob->is_write_only = out_resp->flags & DRM_MODE_CREATE_BLOB_WRITE_ONLY;
> > >
> > >       /* Dropping the lock between create_blob and our access here is safe
> > >        * as only the same file_priv can remove the blob; at this point, it is
> > > diff --git a/include/drm/drm_property.h b/include/drm/drm_property.h
> > > index 65bc9710a470..700782f021b9 100644
> > > --- a/include/drm/drm_property.h
> > > +++ b/include/drm/drm_property.h
> > > @@ -205,6 +205,7 @@ struct drm_property {
> > >   *   &drm_mode_config.property_blob_list.
> > >   * @head_file: entry on the per-file blob list in &drm_file.blobs list.
> > >   * @length: size of the blob in bytes, invariant over the lifetime of the object
> > > + * @is_write_only: user space can't read the blob data.
> > >   * @data: actual data, embedded at the end of this structure
> > >   *
> > >   * Blobs are used to store bigger values than what fits directly into the 64
> > > @@ -219,6 +220,7 @@ struct drm_property_blob {
> > >       struct list_head head_global;
> > >       struct list_head head_file;
> > >       size_t length;
> > > +     bool is_write_only;
> > >       void *data;
> > >  };
> > >
> > > diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> > > index 0a0d56a6158e..de192d3813e9 100644
> > > --- a/include/uapi/drm/drm_mode.h
> > > +++ b/include/uapi/drm/drm_mode.h
> > > @@ -1107,6 +1107,9 @@ struct drm_format_modifier {
> > >       __u64 modifier;
> > >  };
> > >
> > > +#define DRM_MODE_CREATE_BLOB_WRITE_ONLY                                        \
> > > +     (1 << 0) /* data of the blob can't be read by user space */
> > > +
> > >  /**
> > >   * struct drm_mode_create_blob - Create New blob property
> > >   *
> > > @@ -1120,6 +1123,9 @@ struct drm_mode_create_blob {
> > >       __u32 length;
> > >       /** @blob_id: Return: new property ID. */
> > >       __u32 blob_id;
> > > +     /** Flags for special handling. */
> > > +     __u32 flags;
> > > +     __u32 pad;
> > >  };
> > >
> > >  /**
> >
> > --
> > Jani Nikula, Intel Open Source Graphics Center
