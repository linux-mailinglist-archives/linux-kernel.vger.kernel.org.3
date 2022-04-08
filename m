Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47C74F9B9D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237550AbiDHR1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiDHR1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:27:42 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA7B11DD1D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 10:25:33 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id a5so8023688qvx.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 10:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lU0csIEsZDzE41MwkALBCybhlERErvcPF+sfVBonqHs=;
        b=NM88+nbc35Zqm447HFRboPxAt50UQeRlmnPlgfN20A29ljQsY9vkOMUn+VGqIdiWmY
         Dcn8FOGQwYIcz83pr07P1FQYr6vwSF168HwNftLKO4abFG8/IwPYns3EvDN/fcJxbIbY
         w7vIf4RBx1g4q3Ri2kXbLAXvpdEwJy1duKfUJOEWtvx9rfX3Exe/iecmR4HWTjR04Ani
         /Smkf5jNYD6+B+EzB8Q1X9JR50QuruKTnTU6dno+QdtD2FxdZem31j8NxXnJ3scSE4kw
         B43o+ngT5M6F8XdvPxgHNI7EdJSlPinoNv2vkzs7G4rHMYRsy1eIXoGixwbv95JVebLQ
         Wi4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lU0csIEsZDzE41MwkALBCybhlERErvcPF+sfVBonqHs=;
        b=m49jQ+aag8orUB5tMBgckG0IWxTKHXYjFyJaRtObUbPAvo64cGumV/+EYzz3G/diJd
         pmneK2xxAD/DZasodKVZNpnF1ea7mIg4AlZ0htE0jYkfwtCDcsOPJ0YmbtGL4liGwO0F
         vkZ8TDyKOi0VxJFTDbnYyeQIM7xeRYqemRxGbaySAK+ALw1yLKbTJPEJpRrwsqi12D/1
         dhAIyy1nziePAuwmp/qgs2ECBhlLr9etLRpLftkHiOFF5oo7PdM4SxjQrISFfezdg1O8
         1FKzG7oRPfe7Fmzj/1DiA8uDxoZcjtzjuijYj7QL8+sylmPO9ScBINbmQJv4Tf0hALGg
         NfOw==
X-Gm-Message-State: AOAM531+S7++k5VtLCiX6QBuZM80yYhYZWJhySQk3LFmT69qDi7XnDlm
        QgVeh0ngVbyMKsNZlvDCb3nf/eYKy9XXp/4qbdU=
X-Google-Smtp-Source: ABdhPJwsC8qGfq7jporc/xc6KftTZwUAsHdQsV0w1jvXD4QNmiObbUO6QV0MUeae7mZ/1a1STd2v+f/xOoq03oWzOuA=
X-Received: by 2002:a05:6214:20a6:b0:443:5818:ade2 with SMTP id
 6-20020a05621420a600b004435818ade2mr17297303qvd.84.1649438732926; Fri, 08 Apr
 2022 10:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsNVp=R5zC9B3PXWJ5nddtt3gkRzDsAsRKvhXq7exGjSAg@mail.gmail.com>
 <f3bc34e1-0eaf-84ef-486e-b7759e60b792@amd.com> <CABXGCsOD+tDdFcM37NP_1nS9eLym7qC=jUQy3iqYkc1m2iQgxw@mail.gmail.com>
 <0d5f66d8-9852-b6a9-0e27-9eb9e736d698@amd.com> <CABXGCsPi68Lyvg+6UjTK2aJm6PVBs83YJuP6x68mcrzAQgpuZg@mail.gmail.com>
 <eef04fc4-741d-606c-c2c6-f054e4e3fffd@amd.com>
In-Reply-To: <eef04fc4-741d-606c-c2c6-f054e4e3fffd@amd.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Fri, 8 Apr 2022 22:25:22 +0500
Message-ID: <CABXGCsNNwEjo_dvWJL7GLULBPy+RmwsC9ObpowR_M1nQ3fKt3g@mail.gmail.com>
Subject: Re: [Bug][5.18-rc0] Between commits ed4643521e6a and 34af78c4e616,
 appears warning "WARNING: CPU: 31 PID: 51848 at drivers/dma-buf/dma-fence-array.c:191
 dma_fence_array_create+0x101/0x120" and some games stopped working.
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Ken.Xue@amd.com, "Deucher, Alexander" <alexander.deucher@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        thomas.hellstrom@linux.intel.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
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

On Fri, 8 Apr 2022 at 19:27, Christian K=C3=B6nig <christian.koenig@amd.com=
> wrote:
>
> Please test the attached patch, it just re-introduce the lock without
> doing much else.
>
> And does your branch contain the following patch:
>
> commit d18b8eadd83e3d8d63a45f9479478640dbcfca02
> Author: Christian K=C3=B6nig <christian.koenig@amd.com>
> Date:   Wed Feb 23 14:35:31 2022 +0100
>
>      drm/amdgpu: install ctx entities with cmpxchg
>
>      Since we removed the context lock we need to make sure that not two
> threads
>      are trying to install an entity at the same time.
>
>      Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>      Fixes: 461fa7b0ac565e ("drm/amdgpu: remove ctx->lock")
>      Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>      Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

The all listed games are now working with an attached patch.
Also flood messages "WARNING: CPU: 31 PID: 51848 at
drivers/dma-buf/dma-fence-array.c:191
dma_fence_array_create+0x101/0x120" has gone.

Thanks.

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

--=20
Best Regards,
Mike Gavrilov.
