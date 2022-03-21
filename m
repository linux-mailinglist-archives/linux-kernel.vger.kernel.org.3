Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3044E3022
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 19:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352256AbiCUSkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 14:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243386AbiCUSkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 14:40:12 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4454349E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 11:38:45 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id s18so753487vsr.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 11:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O2bACGeOCwnvZUjBmMkeAql3W9c1PsU+eEoImw6H0WE=;
        b=gvUzCFZWGuHWDVIr1L6Rk7VDWw6Q02bskZP1po8Vb3ZXg44MpD8su40Kk8PXf5gnZ0
         ZJj5jaK4VOcGU751sQjiaevPam+0kq33+g7Mrzp6KgDaqgy1aQeLZLVNrUFjWUFKUwGA
         EBERMr1zaSox8sEnCLA8nHbU3wWNlS0lTBXAyR3wWCSVwJ+9dcC+6xDFdKGEn88KpryH
         xm9RGBPaNqniBuiLmxlqaNkl2ms01cquWqlHUPb0zc64CxZ8oaFtLYYycQMvTvvukHOk
         zR3i5q+iKbSkzLwg1aw+j9GUqoUsa8wOmV1u8o3hA+mQY5nVnuDVqXNBt8Ie9DKfyLd8
         AnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O2bACGeOCwnvZUjBmMkeAql3W9c1PsU+eEoImw6H0WE=;
        b=Hcl18nPY0jAFAEW9D3TQwx0yovEvdIppnQScpAZ3oeEwZi11AlD7h//TLLPEe6NTRB
         xeUYvSdH4KZhKKafXupNgeRKMnmjPwXIlhVZ2WR3jcggZ5hnaVX3GTERji63hDcp/Lna
         sY/4c/9USoB/wdG7lv/gJqJG8TOtH2ECicmOLloPCOeXBm+MSSHIY61ql613TroFn0ZI
         1ZABJ5eaU4c9IIgvXE62KmivkUJsX0iVPP5BHX/XQWTEQZWj9rCyT06AwS0R40xvaVaQ
         Irb2e3Unkxx45GpvUo9MeMGGqgZP0uz66AXFf7evupF1t+dng9gSLebFoCO3+6zRKkmL
         bgdw==
X-Gm-Message-State: AOAM5326oUhGAdCmlV9069W/d3IgzA9fRoLXAc78jeb3ywExghCAddq+
        J5MagZCM8U9/vvZ/Tt8DCRZ6/n6ZjCw3tPL6h/Y=
X-Google-Smtp-Source: ABdhPJy7nvHcZWKav0Rnnbh+UsUrB/8MI7Air5eUiET+wAuPr8sKptE3jfG0UtNLLDHjk41No4tIDuzDwdEIB9E60d8=
X-Received: by 2002:a05:6102:83c:b0:324:e435:eb01 with SMTP id
 k28-20020a056102083c00b00324e435eb01mr5273876vsb.13.1647887924960; Mon, 21
 Mar 2022 11:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220321123712.3068778-1-jakobkoschel@gmail.com>
In-Reply-To: <20220321123712.3068778-1-jakobkoschel@gmail.com>
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
Date:   Tue, 22 Mar 2022 00:08:07 +0530
Message-ID: <CAAs364-uRFrWbB4JmCZkRKeJ3+ejgrLJOY_OUM1h6r-JsDXBbA@mail.gmail.com>
Subject: Re: [PATCH] staging: greybus: codecs: use dedicated list iterator variable
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
        linux-staging@lists.linux.dev, Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 6:07 PM Jakob Koschel <jakobkoschel@gmail.com> wrote:
>
> In preparation to limit the scope of the list iterator to the list
> traversal loop, use a dedicated pointer to point to the found element [1].
>
> Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  drivers/staging/greybus/audio_codec.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
> index b589cf6b1d03..a446d6455fbd 100644
> --- a/drivers/staging/greybus/audio_codec.c
> +++ b/drivers/staging/greybus/audio_codec.c
> @@ -497,7 +497,7 @@ static int gbcodec_prepare(struct snd_pcm_substream *substream,
>                            struct snd_soc_dai *dai)
>  {
>         int ret;
> -       struct gbaudio_module_info *module;
> +       struct gbaudio_module_info *module = NULL, *iter;
>         struct gbaudio_data_connection *data;
>         struct gb_bundle *bundle;
>         struct gbaudio_codec_info *codec = dev_get_drvdata(dai->dev);
> @@ -511,11 +511,13 @@ static int gbcodec_prepare(struct snd_pcm_substream *substream,
>                 return -ENODEV;
>         }
>
> -       list_for_each_entry(module, &codec->module_list, list) {
> +       list_for_each_entry(iter, &codec->module_list, list) {
>                 /* find the dai */
> -               data = find_data(module, dai->id);
> -               if (data)
> +               data = find_data(iter, dai->id);
> +               if (data) {
> +                       module = iter;
>                         break;
> +               }
>         }
>         if (!data) {
>                 dev_err(dai->dev, "DATA connection missing\n");
> @@ -563,7 +565,7 @@ static int gbcodec_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
>  {
>         int ret;
>         struct gbaudio_data_connection *data;
> -       struct gbaudio_module_info *module;
> +       struct gbaudio_module_info *module = NULL, *iter;
>         struct gb_bundle *bundle;
>         struct gbaudio_codec_info *codec = dev_get_drvdata(dai->dev);
>         struct gbaudio_stream_params *params;
> @@ -592,11 +594,13 @@ static int gbcodec_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
>                 return ret;
>         }
>
> -       list_for_each_entry(module, &codec->module_list, list) {
> +       list_for_each_entry(iter, &codec->module_list, list) {
>                 /* find the dai */
> -               data = find_data(module, dai->id);
> -               if (data)
> +               data = find_data(iter, dai->id);
> +               if (data) {
> +                       module = iter;
>                         break;
> +               }
>         }
>         if (!data) {
>                 dev_err(dai->dev, "%s:%s DATA connection missing\n",
>
> base-commit: f443e374ae131c168a065ea1748feac6b2e76613

Thanks for sharing this patch Jakob.
Reviewed-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>

> --
> 2.25.1
>
