Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCEC56541E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbiGDLsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbiGDLsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:48:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEB830D;
        Mon,  4 Jul 2022 04:48:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A38B660AE0;
        Mon,  4 Jul 2022 11:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C587C341CF;
        Mon,  4 Jul 2022 11:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656935309;
        bh=lEhyQTPqbnb0qaLyB8fV9ShNcZX9KnoEMwg8oP3XPXo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fJZcg2YIEpiEHrl3wUjKcpxH28YXBcPnLdS5XvkAxnYcmpCQ1+6v1D0WjcA2ITQ1P
         Fc/PIfLE3WguvQ+rGB8hTh09C6gsXeyolZJeLnqQbjEzLuSAaJu7TkM6nGVfaAR0JY
         Q2usMLbx2u8Uo1JssJAVR63yMQC29W0c2ye0Zz2NXHQMbCC3lXezQRPZVhTrgHeeap
         5Nn2gk1e4/FiQ28Tnm4va47K61FIxeCchdNoQIBFRSVhw8ZkD93QbUjQTc6gLmlc3B
         hxBl9TzDNuJmr3Ayg7lSit67PqeDTjYXAzwRGDuewpInqRSsVSodN5qAAW7GL9CSWJ
         8dv4NoK4VEt7w==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-31c89653790so28528077b3.13;
        Mon, 04 Jul 2022 04:48:28 -0700 (PDT)
X-Gm-Message-State: AJIora9UPfu+pItcA2eh/gFvmbBBAq78sNd1skZa6KiEqX9Vjw5NrF+L
        I4qEYmSb3XdqnqC09oaLIcWyTwcTaFGm2P3RcNc=
X-Google-Smtp-Source: AGRyM1tzspPjx1oBGlRK+b4v7HjFxhNVeLwzzvyBnf7TghUn5Qa2tYmn1MZVvuYvvCpUtENB9jxcfuAz5b0rnz2nEZk=
X-Received: by 2002:a0d:fec3:0:b0:31b:c2d6:34ea with SMTP id
 o186-20020a0dfec3000000b0031bc2d634eamr32642370ywf.62.1656935308108; Mon, 04
 Jul 2022 04:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <7112242cb741443d6abc18ebc210431f0c4ffa18.1656880577.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <7112242cb741443d6abc18ebc210431f0c4ffa18.1656880577.git.christophe.jaillet@wanadoo.fr>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 4 Jul 2022 14:48:01 +0300
X-Gmail-Original-Message-ID: <CAFCwf10SQ6E85Vyyx4P=pq-CwYrH874vPp73J5EdObFZ4=YNwA@mail.gmail.com>
Message-ID: <CAFCwf10SQ6E85Vyyx4P=pq-CwYrH874vPp73J5EdObFZ4=YNwA@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Use the bitmap API to allocate bitmaps
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 3, 2022 at 11:36 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.
>
> It is less verbose and it improves the semantic.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/misc/habanalabs/common/asid.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/common/asid.c b/drivers/misc/habanalabs/common/asid.c
> index ede04c032b6e..c9c2619cc43d 100644
> --- a/drivers/misc/habanalabs/common/asid.c
> +++ b/drivers/misc/habanalabs/common/asid.c
> @@ -11,8 +11,7 @@
>
>  int hl_asid_init(struct hl_device *hdev)
>  {
> -       hdev->asid_bitmap = kcalloc(BITS_TO_LONGS(hdev->asic_prop.max_asid),
> -                                       sizeof(*hdev->asid_bitmap), GFP_KERNEL);
> +       hdev->asid_bitmap = bitmap_zalloc(hdev->asic_prop.max_asid, GFP_KERNEL);
>         if (!hdev->asid_bitmap)
>                 return -ENOMEM;
>
> @@ -27,7 +26,7 @@ int hl_asid_init(struct hl_device *hdev)
>  void hl_asid_fini(struct hl_device *hdev)
>  {
>         mutex_destroy(&hdev->asid_mutex);
> -       kfree(hdev->asid_bitmap);
> +       bitmap_free(hdev->asid_bitmap);
>  }
>
>  unsigned long hl_asid_alloc(struct hl_device *hdev)
> --
> 2.34.1
>

Thanks!
This patch is
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Applied to -next.
Oded
