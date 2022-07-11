Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B28570AB6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 21:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiGKT1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 15:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiGKT1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:27:00 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EFE66BA6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 12:26:59 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id e15so7507355edj.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 12:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ta1QR4ob9+a8CQRUXOLxYQstmWxPgCQXNvonR9n7DMg=;
        b=bTN0FCQ8BcVloYruBfn74w+Oe4LBd6Wg+mnDACH0sFprVeIfxIg40eN90sYxoUKAWJ
         fDnJfU4pwkGjQkEb/NczwSU4QRk0EPjm7Tt/1lsmWRFKXmJO2h7dn2jxz75wFGHzp9MA
         4b5Qxo2c11xGgdeXB/d+/fjsjUfeTrFm7oJaKoNGamcNLWDowdvJE4LslpBJxPhDMCHY
         HFKEsghueHYCAjzzaj4N6P+bDK1mE0X3ZyUemaW54TBZn6S2B15ePRefCYcz4KfhtF6G
         eXrWmo9t4oOkMFH45FXUsNns9zFKMhS8onkbbxLFTmwZbobDk6ow4kzBhCbDumTai6b2
         jRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ta1QR4ob9+a8CQRUXOLxYQstmWxPgCQXNvonR9n7DMg=;
        b=7nGRA7dRiPeXgFo0CAGWDruHIb0ceV4Gd1U4P/AQguWrmYTXGVjn+Em8WTw5WmC8Ua
         pmQoxSZdcK2eV503o/WOxP/hZ0UX4bzEjJ+pjxttVlkMeYFkmTbsQKV5K5B+o1G443m2
         W4kckO9XeUV5uvpTFPpA+pa7SDfeMdVJ6VoczEY4/wpibDi9GKcUr+haX5cQspyFQ1UI
         XWwn8H2yZrp5omfEM6bzdgRM0kzbv1YBtfd/MoFl2yBXTegwJeWmMYWttph/k9NjWqBy
         FW1WBpEZlDDN5A5qD8xMsUXta7P3U3gi6s7q9xLUP4DK2zsDFZq6+fnx+Zh4W/z61vf9
         Kjrw==
X-Gm-Message-State: AJIora8BmPh/Kk4AO2r28DL+XeSY8ulfbKacRJpNRXAknLQlQLrZ7FpX
        Q6XAQ6zsh7ToiX81dY2Wv4hfQHOCWRqJ95ehPPs=
X-Google-Smtp-Source: AGRyM1veV0KKI1a1FCpRTSvVyanIEMcTDQMyQU8ME1TsXd+AgB7n0ELLQ1HlmSoi6duJCJfVVRNOhoxKErLs0Km6CuQ=
X-Received: by 2002:a05:6402:28c3:b0:43a:6d78:1b64 with SMTP id
 ef3-20020a05640228c300b0043a6d781b64mr26340254edb.93.1657567618050; Mon, 11
 Jul 2022 12:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220711191953.145518-1-andrealmeid@igalia.com> <20220711191953.145518-2-andrealmeid@igalia.com>
In-Reply-To: <20220711191953.145518-2-andrealmeid@igalia.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 11 Jul 2022 15:26:46 -0400
Message-ID: <CADnq5_Nviz6D4NX3-gj1_=0M-+-0Bi=_Lqczqsm-tjvKQp4Vsw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: Add GFXOFF registers for vangogh
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 3:20 PM Andr=C3=A9 Almeida <andrealmeid@igalia.com>=
 wrote:
>
> Add register values to access GFXOFF data for vangogh GPU.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  .../pm/swsmu/inc/pmfw_if/smu11_driver_if_vangogh.h   | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_van=
gogh.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_vangogh.h
> index 8361ebd8d876..9c7b0004d842 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_vangogh.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_vangogh.h
> @@ -279,4 +279,16 @@ typedef enum {
>  #define TILE_ISPPRE_MASK    ((1<<6) | (1<<7))
>  #define TILE_ISPPOST_MASK   ((1<<8) | (1<<9))
>
> +// Registers related to GFXOFF
> +// addressBlock: smuio_smuio_SmuSmuioDec
> +// base address: 0x5a000
> +#define mmSMUIO_GFX_MISC_CNTL                  0x00c5
> +#define mmSMUIO_GFX_MISC_CNTL_BASE_IDX         0
> +
> +//SMUIO_GFX_MISC_CNTL
> +#define SMUIO_GFX_MISC_CNTL__SMU_GFX_cold_vs_gfxoff__SHIFT     0x0
> +#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT          0x1
> +#define SMUIO_GFX_MISC_CNTL__SMU_GFX_cold_vs_gfxoff_MASK       0x0000000=
1L
> +#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK            0x0000000=
6L

These are registers rather than firmware interfaces so they don't
really belong in this header.  I'd suggest just putting these directly
in vangogh_ppt.c.  You can also squash this in with patch2 while you
are at it if you want.

Alex


> +
>  #endif
> --
> 2.37.0
>
