Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7459C549BB2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243590AbiFMSiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343558AbiFMShy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:37:54 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6550D12C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 08:39:12 -0700 (PDT)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CA0F93FBEC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 15:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1655134750;
        bh=qIyjHtlgmZ2mGqkFBQdbyeKZViSqALiGs38sp6wvC98=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=NWN6xl1rQc3IeMce4T2C756RdXCnpI1wKrY5L8VKAvWYMxLujkqawnukKEnyt1my3
         PlpPqe8rew0yUFUlmBh0aEuY2RA3WzPwx2aGyNtF8G3FqU31jE0Hi5in50rae8OJZc
         ISbwryEsg6LZoidnoUz8GA2pbNylVk6sy3f63FiqLJWy+Y1ZowcVyx5I900y8CTZLi
         7AN/yZdQ1qMD85BxpHC1RUiqfy3LWy8EetociBl8ho+cR/7XUDyLy98UVcvl37WNUU
         zOjCnwlWNXCwxSSa53ucXz880GTB/XKNH7tr5GqeW8/VA+51ElXKvt9ov9rra+oLh8
         lB0SbW5ZZmBNw==
Received: by mail-il1-f198.google.com with SMTP id a2-20020a923302000000b002d1ad5053feso4795442ilf.17
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 08:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qIyjHtlgmZ2mGqkFBQdbyeKZViSqALiGs38sp6wvC98=;
        b=3A2oqwtceBHJRzkIYOgD0d0tJLbOZS7sxSJ148MyVNSEbyi737ZPam3SmzU6O/m+Jc
         43VFMQuK4AAmsWuZwrQ2awQaS5G+5FlcgLWQVnttIajJ8nhfoPuCwo3eFwtFSlG3KYNM
         PQ5L2pBInn5qf/bYj34Xk8nkxO+xbJy83Cocfy/nEi2ppxBBM0Dica37sIzVvz/xTgqW
         AEde7JnDgYNGx9qgvh+atdstpVuXWbhSfKNE9Eh13prkncGeNY3eQQ+74532zNUFnrzR
         j3WFd0yr806KwNserpOXs0QIO6nc/DSogDAeNs0ywwkAf6hMMknSyTwNnFQmgp6frgY1
         /FhA==
X-Gm-Message-State: AOAM533O2y9FakibhCBf+DPCRHxAyYJXjRDMPPNF/LZuXrQk7pDhVtE6
        B1yeaWQuNG9auuOzSicUKMzbSsHvuqRxcnBw27DRYdYSGnGwsBEX401mw79NKBOpbk1r36bFETL
        TIuvKX1/TiLrfOcHBykV7SkJV7lp+F3EZWyXqqKU0H3O/+c7jgVCqLStpRQ==
X-Received: by 2002:a05:6638:144d:b0:332:fa9:28a9 with SMTP id l13-20020a056638144d00b003320fa928a9mr201877jad.237.1655134749717;
        Mon, 13 Jun 2022 08:39:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXNtA+ciI6OWgaT4ebrOdHTZuUKQ3+cRYrYw1j3M7psuLRVjd2hmONX/3HkZzlJ0grCgnTwnE68cXxcjLf3ns=
X-Received: by 2002:a05:6638:144d:b0:332:fa9:28a9 with SMTP id
 l13-20020a056638144d00b003320fa928a9mr201863jad.237.1655134749505; Mon, 13
 Jun 2022 08:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220516103329.516952-1-dimitri.ledkov@canonical.com>
In-Reply-To: <20220516103329.516952-1-dimitri.ledkov@canonical.com>
From:   =?UTF-8?B?RGltaXRyaSBKb2huIExlZGtvdiDwn4+z77iP4oCN8J+MiA==?= 
        <dimitri.ledkov@canonical.com>
Date:   Mon, 13 Jun 2022 16:38:33 +0100
Message-ID: <CADWks+ZBZo1OQyV4wwx9=tnXa4Vn+KVNpQyAZq7HULJmO1D97A@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btintel: Correctly declare all module
 firmware files
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel

Does this v2 patch address the concerns you mentioned in your review
of the v1 patch at
https://lore.kernel.org/linux-bluetooth/3EA82A93-D167-482D-AAF4-D781B77A4646@holtmann.org/
?

Or can you explain a bit more how I misunderstood your request?

This patch correctly documents the strict patterns of dozens or so
existing firmware files which this driver can load for each of the hw
variants.

On Mon, 16 May 2022 at 11:33, Dimitri John Ledkov
<dimitri.ledkov@canonical.com> wrote:
>
> Strictly encode patterns of supported hw_variants of firmware files
> the kernel driver supports requesting. This now includes many missing
> and previously undeclared module firmware files for 0x07, 0x08,
> 0x11-0x14 hw_variants.
>
> This especially affects environments that only install firmware files
> declared and referenced by the kernel modules. In such environments,
> only the declared firmware files are copied resulting in most Intel
> Bluetooth devices not working. I.e. host-only dracut-install initrds,
> or Ubuntu Core kernel snaps.
>
> BugLink: https://bugs.launchpad.net/bugs/1970819
> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> ---
>
>  Changes since v1:
>  - encode strict patterns of supported firmware files for each of the
>    supported hw_variant generations.
>
>  v1 submission link
>   https://lore.kernel.org/linux-bluetooth/20220509163259.1513242-1-dimitri.ledkov@canonical.com/
>
>  drivers/bluetooth/btintel.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 06514ed66022..17022758b5bd 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2654,7 +2654,22 @@ MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
>  MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
>  MODULE_VERSION(VERSION);
>  MODULE_LICENSE("GPL");
> -MODULE_FIRMWARE("intel/ibt-11-5.sfi");
> -MODULE_FIRMWARE("intel/ibt-11-5.ddc");
> -MODULE_FIRMWARE("intel/ibt-12-16.sfi");
> -MODULE_FIRMWARE("intel/ibt-12-16.ddc");
> +/* hw_variant 0x07 0x08 */
> +MODULE_FIRMWARE("intel/ibt-hw-37.7.*-fw-*.*.*.*.*.bseq");
> +MODULE_FIRMWARE("intel/ibt-hw-37.7.bseq");
> +MODULE_FIRMWARE("intel/ibt-hw-37.8.*-fw-*.*.*.*.*.bseq");
> +MODULE_FIRMWARE("intel/ibt-hw-37.8.bseq");
> +/* hw_variant 0x0b 0x0c */
> +MODULE_FIRMWARE("intel/ibt-11-*.sfi");
> +MODULE_FIRMWARE("intel/ibt-12-*.sfi");
> +MODULE_FIRMWARE("intel/ibt-11-*.ddc");
> +MODULE_FIRMWARE("intel/ibt-12-*.ddc");
> +/* hw_variant 0x11 0x12 0x13 0x14 */
> +MODULE_FIRMWARE("intel/ibt-17-*-*.sfi");
> +MODULE_FIRMWARE("intel/ibt-18-*-*.sfi");
> +MODULE_FIRMWARE("intel/ibt-19-*-*.sfi");
> +MODULE_FIRMWARE("intel/ibt-20-*-*.sfi");
> +MODULE_FIRMWARE("intel/ibt-17-*-*.ddc");
> +MODULE_FIRMWARE("intel/ibt-18-*-*.ddc");
> +MODULE_FIRMWARE("intel/ibt-19-*-*.ddc");
> +MODULE_FIRMWARE("intel/ibt-20-*-*.ddc");
> --
> 2.32.0
>


-- 
Happy Pride,

Dimitri
