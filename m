Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B4F547875
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 06:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbiFLELc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 00:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiFLELa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 00:11:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AC54BB90
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 21:11:22 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y19so5122540ejq.6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 21:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZSnySfFVFF1WlkzCsM8N2GrUnx5OLR53QsPe7K3hn/4=;
        b=fAFtXxKAtah80tBf6iqAqB5bsHRSCOqHvagsu0WUhkIfnkkLJ6E+fvFABl1dX0xmKY
         5R4R41LgzbxN32GIYKtRmquaRu9cZJYlpZ9wP16aRfYt2hHgYUkJzm6uq13FvH2Vi5Rh
         Ij8VIVS8uWX7CHjV5oQ9zqSql+oAdfKsZKlkC7ZgOu+wCph54lkwIrTdsitbrrtrhOaT
         y7hwXMaLkHT6TQ8gxK3TKnAsBmTvjfNd4DKeXSwcFV7FB7Ib+QReLTGvWWANz+bZVcL8
         FBk0bGF4f7lYEYsr8CHHLzQlfY9rdgOGxMQEHnHS2ACmAf3EiBrvJJhUzINJ6tWjdZZA
         IHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZSnySfFVFF1WlkzCsM8N2GrUnx5OLR53QsPe7K3hn/4=;
        b=xyjyq92yv2tFoyOdXPdk3uy9J8whFIKy+ilqc74RojQZF+MaOAZ7oi0DEuMHxqmMDN
         E+ZFYjdvgNjhnt26jTeKclQJw/tBvmYT7D4buCwo20WmCUdprvHZ4aSE+ZiYfcTZjNYK
         k/ASKjqV3QlMkG3BOxE0LZIh0WQd3py7FJtDxlLlvdwJ53bGub5AJXYFtAwDcJRAaOyl
         za2dNaoG1TKEfg5FlpUyA9TZUtyrgKREYZSdYfIIlzRmV+JF5oKp8faODATAco4WhecJ
         fBs1MpEuoYUiZbFfEq5B1vt1lVlaJSUy7gsFmibFazBbrtnIgsa3Rs5e9uMBQDSueAfo
         aSnQ==
X-Gm-Message-State: AOAM5315SLyPvAyUW3LZIEt4ZvYkZr8k+jaJyb0p/r0RRN7hLXwv5Dpk
        G61dPCfSkZpjiDppOgfCxOsBiYVjhGSR+dZyS6s=
X-Google-Smtp-Source: ABdhPJzC1phMjHFmG6iCLs810bJS0tkmxtQPRW62lh5ZaTSCky8H7TCW5DuzbjLEndxFENtSnFsPBR+b3jkM58QMp0g=
X-Received: by 2002:a17:906:f51:b0:6fe:cf1c:cdbf with SMTP id
 h17-20020a1709060f5100b006fecf1ccdbfmr46593552ejj.695.1655007080806; Sat, 11
 Jun 2022 21:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220602104223.54527-1-linmq006@gmail.com>
In-Reply-To: <20220602104223.54527-1-linmq006@gmail.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Sat, 11 Jun 2022 21:11:09 -0700
Message-ID: <CAPaKu7She7neKq8c7G1hH4+To=y26dvZ0kP4BfJ4FghFRf+KqA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/virtio: Fix NULL vs IS_ERR checking in virtio_gpu_object_shmem_init
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO CORE, NET AND BLOCK DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 2, 2022 at 3:42 AM Miaoqian Lin <linmq006@gmail.com> wrote:
>
> Since drm_prime_pages_to_sg() function return error pointers.
> The drm_gem_shmem_get_sg_table() function returns error pointers too.
> Using IS_ERR() to check the return value to fix this.
>
> Fixes: 2f2aa13724d5 ("drm/virtio: move virtio_gpu_mem_entry initialization to new function")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> changes in v2:
> - Update Fixes tag.
> - rebase the working tree.
> v1 Link: https://lore.kernel.org/all/20211222072649.18169-1-linmq006@gmail.com/
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
