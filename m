Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4FD4B559C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356087AbiBNQHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:07:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbiBNQHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:07:52 -0500
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49BAC73
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:07:44 -0800 (PST)
Received: by mail-io1-f48.google.com with SMTP id d188so20414602iof.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:07:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yx9dZuPcrLt3Jj+xgr3ullm7ftsWlVftIJw02v6qQ4Q=;
        b=K0aRz9jzV9OhAVzivEPb4uaeAxihzMoacMpRDpEFSFycwUrVVZVffrJWb7VW7c0/lk
         PQpHgGq5Hfl0cGg2zHJUqM/bmKCh32dzdzaOPEqdaT/7wWCt86jZL+aOF4p28FJGDsQ/
         mJWMDdfYFnrLPoR9GkmxlSps1K0Mr1MVp7ANf6IFAf+dOoEuxz2Mk/I45T27x0VG42k0
         eloyr44EyIO5kBznZIigfIuP+Ae4yaj0IlWXtB4P/T+ura+7wAhKixMvwu7IYvthQObp
         EbgQdJRc1ZDkIzvN+6IrrR71WTWvcunZbSNvoUn2zUABOLT9R4cedNufdQpvzjqZLjrb
         jKXw==
X-Gm-Message-State: AOAM531Uy0kEpUy66Hld2ACVlxth0KRbvXYho1e5jTqzPv3R6Ai1aHXX
        vYkJy4z/DGT9SQ/hbFiBAqmeRYzxzpSdQQUZ2OE=
X-Google-Smtp-Source: ABdhPJzvzoPpmI4kQbwahiXCjfk4KMpMCoZDBvGJc98Pl3kNpRh7Q0xtePotYf8bUDMNNdnPfe6LYIO3ObpZ4iZIWZ4=
X-Received: by 2002:a02:c916:: with SMTP id t22mr245398jao.300.1644854864060;
 Mon, 14 Feb 2022 08:07:44 -0800 (PST)
MIME-Version: 1.0
References: <20220214155518.2980270-1-icenowy@aosc.io>
In-Reply-To: <20220214155518.2980270-1-icenowy@aosc.io>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Mon, 14 Feb 2022 11:07:33 -0500
Message-ID: <CAKb7UvjRoS-z1f6a=p0TknPruZJBKmUEiAFOR9Ka5LgJ765Ybg@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/bios: Use HWSQ entry 1 for PowerBook6,1
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not saying this is wrong, but could you file a bug at
gitlab.freedesktop.org/drm/nouveau/-/issues and include the VBIOS
(/sys/kernel/debug/dri/0/vbios.rom)? That would make it easier to
review the full situation.

On Mon, Feb 14, 2022 at 11:03 AM Icenowy Zheng <icenowy@aosc.io> wrote:
>
> On PowerBook6,1 (PowerBook G4 867 12") HWSQ entry 0 (which is currently
> always used by nouveau) fails, but the BIOS declares 2 HWSQ entries and
> entry 1 works.
>
> Add a quirk to use HWSQ entry 1.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/gpu/drm/nouveau/nouveau_bios.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_bios.c b/drivers/gpu/drm/nouveau/nouveau_bios.c
> index e8c445eb11004..2691d0e0cf9f1 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_bios.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_bios.c
> @@ -1977,6 +1977,13 @@ static int load_nv17_hw_sequencer_ucode(struct drm_device *dev,
>         if (!hwsq_offset)
>                 return 0;
>
> +#ifdef __powerpc__
> +       /* HWSQ entry 0 fails on PowerBook G4 867 12" (Al) */
> +       if (of_machine_is_compatible("PowerBook6,1"))
> +               return load_nv17_hwsq_ucode_entry(dev, bios,
> +                                                 hwsq_offset + sz, 1);
> +#endif
> +
>         /* always use entry 0? */
>         return load_nv17_hwsq_ucode_entry(dev, bios, hwsq_offset + sz, 0);
>  }
> --
> 2.30.2
>
