Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5656352B25F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiERG31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiERG3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:29:20 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D99E15E1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:29:19 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id b81so671918vkf.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RIeoYLoCawjr8OpcRy+8RXVUl2WmZaXE2ovsv6gD3jM=;
        b=HVpk4jDiYKpcrU3F7PfpRsPgcA3B5SNbD0HdcyxPxjdgfPBfNvqhfiwg49kOsyu9dF
         m+fststC/MoGohWdD2sePs1rWc80DMLkG3fR7IrynJzRvi6h24/NKUWton3psSSJOfg4
         ZMEPHd46g83k7TBRN6m9txwle0WdxcbBwG76BFzdzh5XZYOb5nO/ih8F63asNdicup0d
         Jq8bWZ9cx2tKluss3Z/mDUBbhve49vU3ffvN9t4D/gt3M4eGo05NDVjemOenaF+6eX26
         dG7GFKfxTQ5Gwlj4M58Pv6HgMKjIbagG0vQItm0O4Uno0ixoXYnuayZ6pHL/Qu/YBiMG
         VQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RIeoYLoCawjr8OpcRy+8RXVUl2WmZaXE2ovsv6gD3jM=;
        b=EV2x3geC19nHG3yW+M1d4E+z0CqANFMbSs9E3tOMRU6Wfnwfo5qzUV9MUy20dQtFKY
         FsKIP+lc9IrgfdWYuqZwzxEX1kuEW04/AClnZp6d/GT7ryel+HckTTpftZPb0ltaP3vQ
         ZeCOlG5/F+q+xfe5I7qLNBL8bgg9UOMFGTCtE/XQpW4jaqpKp+rNwNvx2ySNiGs9eb77
         WIpdWWGaPO70rFYiULELYE4KgqI8bShqpRpHlzBDZT16ePUiH12QYtJEdbnhzb1v9XP+
         ASp4snoEl4qAZkZOz4ePqLkOvegFypOjDucf80LCX+DLYcPEboWBdASzSgf0La1iYHXy
         3zoA==
X-Gm-Message-State: AOAM5318o+mEBk+gZ8/H3gdIVFxYu1re8pr/i5InUA3MMmKyByK/PKYw
        aj5gJ2wT3r5RYaX5oKPQzqKRR1fsFEOR5VnItic=
X-Google-Smtp-Source: ABdhPJzuLENCd8jFqBpHMfs/wCiwPM6MHZ8OldrK2KTXTjINlvd+Q9NrzUL1ddmS2FnGnFgUuqqztZuBGmhA0mGi4gg=
X-Received: by 2002:a05:6122:a0e:b0:352:1914:b7ae with SMTP id
 14-20020a0561220a0e00b003521914b7aemr10166403vkn.10.1652855358560; Tue, 17
 May 2022 23:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220512034652.61134-1-linmq006@gmail.com>
In-Reply-To: <20220512034652.61134-1-linmq006@gmail.com>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Wed, 18 May 2022 08:29:07 +0200
Message-ID: <CABgxDoK-0r+LYbTfV3jHh986rw63J2HZ8_gKZ-hodZdnV6NSPQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: mstar: Fix refcount leaks
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Daniel Palmer <daniel@thingy.jp>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi,

Le jeu. 12 mai 2022 =C3=A0 05:47, Miaoqian Lin <linmq006@gmail.com> a =C3=
=A9crit :
>
> of_find_compatible_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> Add missing of_node_put() to avoid refcount leak.
>
> Fixes: 5919eec0f092 ("ARM: mstar: SMP support")
> Fixes: 312b62b6610c ("ARM: mstar: Add machine for MStar/Sigmastar Armv7 S=
oCs")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Looks good to me,

Reviewed-by: Romain Perier <romain.perier@gmail.com>
