Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE744F169F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376643AbiDDN7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345774AbiDDN7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:59:48 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE313E5F5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 06:57:49 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id o15so6343390qtv.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 06:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D3y+W+WKQd7hPp6d6usVi59eLjz9RE6hzmPFo/q5LYE=;
        b=Z7m3IGQOWxEQ6wb4iVBGeG++3wXZfta6HY7K4JiG0d3POhLqBT4vbOceRkr5zrUPLy
         O4gi86Lj9mqotWTTem24S0OPcioMGv2y3wcNuOBuS48KJ3s6ucNfYCQiyIBTV4PbF9Fc
         U3GWXQKcHaiJ2ReurjHphYZWiYQYazs9Qbe/+Xeag+aknvVHc9gvn5vUqGADaYH4yjwP
         Dh4ULsJCiOhTm1omJdeSP5El5/1fdeIrH6C93d9uYcf2OdBQXg0oDM7gIM1r2AsRElQr
         FkM9AciYYxCZLyVgsP+3m6k4dGQ3YV3Ao5ktki11NbwT9rIghpJzo4El7VVqkEzFi1g/
         e+UQ==
X-Gm-Message-State: AOAM531ddcfPR0gvE/bxsXsnVly8SJ49gUIm05zZl3VBOKYYjOB8xWIg
        lOy3BrUH7XpbBbJBrL1drODXEYt/rSsFjw==
X-Google-Smtp-Source: ABdhPJwgkIAK8Bgwh+VX6P0VnvvAJ+WPFhB2SSHlsLFN8nDUQ7SVTxClL3a5rpXbFDIajf5t6piTaQ==
X-Received: by 2002:ac8:7d03:0:b0:2e0:66e9:e43a with SMTP id g3-20020ac87d03000000b002e066e9e43amr80518qtb.561.1649080668059;
        Mon, 04 Apr 2022 06:57:48 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id q123-20020a378e81000000b0067eb3d6f605sm6282597qkd.0.2022.04.04.06.57.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 06:57:47 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id f23so17718689ybj.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 06:57:47 -0700 (PDT)
X-Received: by 2002:a5b:24e:0:b0:63d:cba0:3d55 with SMTP id
 g14-20020a5b024e000000b0063dcba03d55mr4760604ybp.613.1649080667232; Mon, 04
 Apr 2022 06:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220403222510.12670-1-rdunlap@infradead.org>
In-Reply-To: <20220403222510.12670-1-rdunlap@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Apr 2022 15:57:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUCdGKE04U4yMqv7TPUztwfih7aLwoTfEP5vcATW=CCxw@mail.gmail.com>
Message-ID: <CAMuHMdUCdGKE04U4yMqv7TPUztwfih7aLwoTfEP5vcATW=CCxw@mail.gmail.com>
Subject: Re: [PATCH v2] sound/oss/dmasound: fix build when drivers are mixed =y/=m
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Mon, Apr 4, 2022 at 12:25 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> When CONFIG_DMASOUND_ATARI=m and CONFIG_DMASOUND_Q40=y (or vice versa),
> dmasound_core.o can be built without dmasound_deinit() being defined,
> causing a build error:
>
> ERROR: modpost: "dmasound_deinit" [sound/oss/dmasound/dmasound_atari.ko] undefined!
>
> Modify dmasound_core.c so that dmasound_deinit() is always available.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks for spending more time on this ;-)

> --- linux-next-20220401.orig/sound/oss/dmasound/dmasound_core.c
> +++ linux-next-20220401/sound/oss/dmasound/dmasound_core.c
> @@ -1424,27 +1424,29 @@ int dmasound_init(void)
>         return 0;
>  }
>
> -#ifdef MODULE
> -
>  void dmasound_deinit(void)
>  {
> +#ifdef MODULE

I think this #ifdef must not be added: if the modular subdriver
calls dmasound_deinit(), the resources should be freed, else a subsequent
reload of the subdriver will not work.  This does mean all variables
protected by "#ifdef MODULE" must exist unconditionally.

Alternatively, the test can be replaced by "#ifdef CONFIG_MODULES".

One big caveat below...

>         if (irq_installed) {
>                 sound_silence();
>                 dmasound.mach.irqcleanup();
>                 irq_installed = 0;
>         }
> +#endif
>
>         write_sq_release_buffers();
>
> +#ifdef MODULE

Likewise.

>         if (mixer_unit >= 0)
>                 unregister_sound_mixer(mixer_unit);
>         if (state_unit >= 0)
>                 unregister_sound_special(state_unit);
>         if (sq_unit >= 0)
>                 unregister_sound_dsp(sq_unit);
> +#endif
>  }
>
> -#else /* !MODULE */
> +#ifndef MODULE
>
>  static int dmasound_setup(char *str)
>  {

> --- linux-next-20220401.orig/sound/oss/dmasound/dmasound.h
> +++ linux-next-20220401/sound/oss/dmasound/dmasound.h
> @@ -88,11 +88,7 @@ static inline int ioctl_return(int __use
>       */
>
>  extern int dmasound_init(void);
> -#ifdef MODULE
>  extern void dmasound_deinit(void);
> -#else
> -#define dmasound_deinit()      do { } while (0)
> -#endif
>
>  /* description of the set-up applies to either hard or soft settings */

... Below, there is:

    typedef struct {
        [...]
    #ifdef MODULE
        void (*irqcleanup)(void);
    #endif
        [...]
    } MACHINE;

This means the MACHINE struct is not compatible between builtin
and modular code :-(  Hence the "#ifdef MODULE" should be removed,
or replaced by "#ifdef CONFIG_MODULES", too.

P.S. I think the younger myself is responsible for this mess.
     Please accept my apologies, after +25 years...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
