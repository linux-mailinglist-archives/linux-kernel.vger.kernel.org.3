Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EAB4C6359
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 07:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbiB1Gtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 01:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiB1Gti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 01:49:38 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CC547AE8;
        Sun, 27 Feb 2022 22:49:00 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id p9so22720920ejd.6;
        Sun, 27 Feb 2022 22:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VtdxgxKnpOzp/IOMEe55+hGAU7UnYBpWIDnMsFXjwTk=;
        b=S9WuuRUM63iMiQEObW/gLBEXcaHpVI0fOM4zz16PKm673tMquxmRXAUGIeFxLZKTKO
         mMI6nFJRkOwwTRxuUQ5xt8LG6gPHVcOt3q1g+QSFro4DDwMGf47c3VCc/rctOC/mTeE4
         ZaBawDtRzxAdwH+g3o3Wjaxvc8dxAfRXz1U0ZgsdLVA2Pj3nr/2HxeWA2Slcwk6hnINz
         Rc5HF3FrCyfyGHsNdntAa87x23Kn6dvC54xddzmo1mfUMwBiOaUMvh3js/nxmzgts6m4
         A7WDgsMKbIhULisN5vuNGIWuKNoMRTMfviJzxkUNrW3h1Njug+ZLNHRioQ2csQ3YxvJW
         3XJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VtdxgxKnpOzp/IOMEe55+hGAU7UnYBpWIDnMsFXjwTk=;
        b=vm2keuvs2RRL3EPNZnmKU84juBb9Y7K650u2lX3DNKFWMxPbn+TleBOLKZn3Dwhc5S
         jmgXN+qfz+edcPNe0V6qwmsLm1cTCPsLltOvH4xrcOMg35L0qvQGDNq9x3pH9Z6UPV74
         /Veqvw6+AZBpdUodgPebdClAylZFwG+XylZ4YiJTrUqBMDElQUK99mumum6JotxkkI0M
         kD6wmd0lFVUAHqgwFWyeURVZ5TPn6c5XfZ5PbW0pC4oMPLR0jjBziiBd0eyQEjJksWSX
         mHsg5uT7yIA3jMRON2TwdwIDJQlJ2SXmJYLzEckzopXjz24Qsanw4Tu/y+5XytJXZFXW
         sscQ==
X-Gm-Message-State: AOAM530l4G1TxXsly+Eryfn8jiNg3kN5W8A52xUlF7+432CjEuWnsREi
        sECF7j7UiUrgcctKmBPMKhA2GFpOu+kblSU7Cgg=
X-Google-Smtp-Source: ABdhPJzzNIWTAShQGm7kD0MeqfACwMltUD0PL56BN40U1IPBItne3Wp4n7o1hgAfEgBtYEEBf6XPc2GB4M32bqbPFxc=
X-Received: by 2002:a17:907:7663:b0:6ce:fdd:762d with SMTP id
 kk3-20020a170907766300b006ce0fdd762dmr14202783ejc.750.1646030938535; Sun, 27
 Feb 2022 22:48:58 -0800 (PST)
MIME-Version: 1.0
References: <20220225164231.904173-1-broonie@kernel.org> <CAJMQK-jGCX6Zp0gkfgqeA6=0zuWiSbWbytUixH3VFiwX9wtLNQ@mail.gmail.com>
In-Reply-To: <CAJMQK-jGCX6Zp0gkfgqeA6=0zuWiSbWbytUixH3VFiwX9wtLNQ@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 28 Feb 2022 16:48:47 +1000
Message-ID: <CAPM=9tz0igKq1W3N_QseF97jqCY2Q9iSYwoFBVx2qJ8rWeVx-w@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the drm tree
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Mark Brown <broonie@kernel.org>, Dave Airlie <airlied@linux.ie>,
        Allen Chen <allen.chen@ite.com.tw>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robert Foss <robert.foss@linaro.org>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
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

On Mon, 28 Feb 2022 at 16:44, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> On Sat, Feb 26, 2022 at 12:43 AM <broonie@kernel.org> wrote:
> >
> > Hi all,
> >
> > After merging the drm tree, today's linux-next build (x86 allmodconfig)
> > failed like this:
> >
> > lib/strncpy_from_user.o: warning: objtool: strncpy_from_user()+0x10b: call to do_strncpy_from_user() with UACCESS enabled
> > lib/strnlen_user.o: warning: objtool: strnlen_user()+0xbb: call to do_strnlen_user() with UACCESS enabled
> > /tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c: In function 'receive_timing_debugfs_show':
> > /tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3077:23: error: array subscript 4096 is outside array bounds of 'u8[200]' {aka 'unsigned char[200]'} [-Werror=array-bounds]
> >  3077 |  u8 *str = read_buf, *end = read_buf + PAGE_SIZE;
> >       |                       ^~~
> > /tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3076:5: note: while referencing 'read_buf'
> >  3076 |  u8 read_buf[READ_BUFFER_SIZE];
> >       |     ^~~~~~~~
> > /tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3077:23: error: array subscript 4096 is outside array bounds of 'u8[200]' {aka 'unsigned char[200]'} [-Werror=array-bounds]
> >  3077 |  u8 *str = read_buf, *end = read_buf + PAGE_SIZE;
> >       |                       ^~~
> > /tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3076:5: note: while referencing 'read_buf'
> >  3076 |  u8 read_buf[READ_BUFFER_SIZE];
> >       |     ^~~~~~~~
> > /tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3077:23: error: array subscript 4096 is outside array bounds of 'u8[200]' {aka 'unsigned char[200]'} [-Werror=array-bounds]
> >  3077 |  u8 *str = read_buf, *end = read_buf + PAGE_SIZE;
> >       |                       ^~~
> > /tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3076:5: note: while referencing 'read_buf'
> >  3076 |  u8 read_buf[READ_BUFFER_SIZE];
> >       |     ^~~~~~~~
> > /tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3077:23: error: array subscript 4096 is outside array bounds of 'u8[200]' {aka 'unsigned char[200]'} [-Werror=array-bounds]
> >  3077 |  u8 *str = read_buf, *end = read_buf + PAGE_SIZE;
> >       |                       ^~~
> > /tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3076:5: note: while referencing 'read_buf'
> >  3076 |  u8 read_buf[READ_BUFFER_SIZE];
> >       |     ^~~~~~~~
> > /tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3077:23: error: array subscript 4096 is outside array bounds of 'u8[200]' {aka 'unsigned char[200]'} [-Werror=array-bounds]
> >  3077 |  u8 *str = read_buf, *end = read_buf + PAGE_SIZE;
> >       |                       ^~~
> > /tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3076:5: note: while referencing 'read_buf'
> >  3076 |  u8 read_buf[READ_BUFFER_SIZE];
> >       |     ^~~~~~~~
> > /tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3077:23: error: array subscript 4096 is outside array bounds of 'u8[200]' {aka 'unsigned char[200]'} [-Werror=array-bounds]
> >  3077 |  u8 *str = read_buf, *end = read_buf + PAGE_SIZE;
> >       |                       ^~~
> > /tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3076:5: note: while referencing 'read_buf'
> >  3076 |  u8 read_buf[READ_BUFFER_SIZE];
> >       |     ^~~~~~~~
> > /tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3077:23: error: array subscript 4096 is outside array bounds of 'u8[200]' {aka 'unsigned char[200]'} [-Werror=array-bounds]
> >  3077 |  u8 *str = read_buf, *end = read_buf + PAGE_SIZE;
> >       |                       ^~~
> > /tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3076:5: note: while referencing 'read_buf'
> >  3076 |  u8 read_buf[READ_BUFFER_SIZE];
> >       |     ^~~~~~~~
> > /tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3077:23: error: array subscript 4096 is outside array bounds of 'u8[200]' {aka 'unsigned char[200]'} [-Werror=array-bounds]
> >  3077 |  u8 *str = read_buf, *end = read_buf + PAGE_SIZE;
> >       |                       ^~~
> > /tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3076:5: note: while referencing 'read_buf'
> >  3076 |  u8 read_buf[READ_BUFFER_SIZE];
> >       |     ^~~~~~~~
> > /tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3077:23: error: array subscript 4096 is outside array bounds of 'u8[200]' {aka 'unsigned char[200]'} [-Werror=array-bounds]
> >  3077 |  u8 *str = read_buf, *end = read_buf + PAGE_SIZE;
> >       |                       ^~~
> > /tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3076:5: note: while referencing 'read_buf'
> >  3076 |  u8 read_buf[READ_BUFFER_SIZE];
> >       |     ^~~~~~~~
> > /tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3077:23: error: array subscript 4096 is outside array bounds of 'u8[200]' {aka 'unsigned char[200]'} [-Werror=array-bounds]
> >  3077 |  u8 *str = read_buf, *end = read_buf + PAGE_SIZE;
> >       |                       ^~~
> > /tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3076:5: note: while referencing 'read_buf'
> >  3076 |  u8 read_buf[READ_BUFFER_SIZE];
> >       |     ^~~~~~~~
> > /tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3077:23: error: array subscript 4096 is outside array bounds of 'u8[200]' {aka 'unsigned char[200]'} [-Werror=array-bounds]
> >  3077 |  u8 *str = read_buf, *end = read_buf + PAGE_SIZE;
> >       |                       ^~~
> > /tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3076:5: note: while referencing 'read_buf'
> >  3076 |  u8 read_buf[READ_BUFFER_SIZE];
> >       |     ^~~~~~~~
> > cc1: all warnings being treated as errors
> >
> > Caused by commit
> >
> >   b5c84a9edcd418 ("drm/bridge: add it6505 driver")
> >
> > I have used the drm tree from yesterday instead.
>
> hi all,
>
> The following fix should be able to address the errors. Should it be
> squashed into b5c84a9edcd418 ("drm/bridge: add it6505 driver")?

Can you send a patch with this to dri-devel? It's far too far down the
tree to sqaush anything at this point.

Dave.
>
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c
> b/drivers/gpu/drm/bridge/ite-it6505.c
> index fb16a176822d81..f2f101220ade94 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -289,7 +289,7 @@
>  #define WORD_LENGTH_20BIT 2
>  #define WORD_LENGTH_24BIT 3
>  #define DEBUGFS_DIR_NAME "it6505-debugfs"
> -#define READ_BUFFER_SIZE 200
> +#define READ_BUFFER_SIZE 400
>
>  /* Vendor option */
>  #define HDCP_DESIRED 1
> @@ -3074,7 +3074,7 @@ static ssize_t
> receive_timing_debugfs_show(struct file *file, char __user *buf,
>         struct it6505 *it6505 = file->private_data;
>         struct drm_display_mode *vid = &it6505->video_info;
>         u8 read_buf[READ_BUFFER_SIZE];
> -       u8 *str = read_buf, *end = read_buf + PAGE_SIZE;
> +       u8 *str = read_buf, *end = read_buf + READ_BUFFER_SIZE;
>         ssize_t ret, count;
>
>         if (!it6505)
