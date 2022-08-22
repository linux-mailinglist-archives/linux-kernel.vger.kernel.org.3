Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E72059C09E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbiHVNbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbiHVNbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:31:43 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0339C3204E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:31:41 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id r10so6381815oie.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=6WVjOrRJCECWMxjcl8nSD1ItRBPOEa+Itaj/XCvb2go=;
        b=oAGzPeSTZ0vxyJxjypstEFq2wlDSFbqy4W20nT26f4IonPW2btsHWwoI6TFovQKtPH
         OVt0yKLAzY8ARGBubtDDx784QNp0bnfaQ5A7omPby/nVq0RAYC4O2m6qo+sNnDzyV/EF
         ZbMR5HZWcC5IxJ/NHIOlo55BXThBNYjTLXxUuDXCLVm2KCd2vmcIML7uF2CuwVqvMpx5
         PGWBdLdq95Y+GINSqToObZG5MY9yQv9MidDw4sH88GN1vK1y8Mr1pH+EyASoC6hGi6fm
         CkGXP7qMVDbz+MA5+Dt2pVfOiYYxaA6k3Mi6ex+jHIBZeCR9E5Jl7AHHkVhXYpNpVNGB
         nXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=6WVjOrRJCECWMxjcl8nSD1ItRBPOEa+Itaj/XCvb2go=;
        b=k3qcSDruZ3mqpyyALFOe1jvblIYuaS6gHldWQLRFXgIHVdaXh+HZt2jlTYl1c/QXI1
         WMwCwzz9CFR9gL8i15lKPZN+WzxpWGhuv7QTr7BP5ncs2g4Vr5ZU+GKWmY+XbEFIcC8u
         kx2FOJWyPYbwYOG9bNFJagFwWB6Vyms/3Ia0qGGDbJfc6VKWXP+gBnPKG6jOMX2szQ77
         P6UL+KUHQRLMWaD+bMP0SlB2JJyOlLAJUu5UXNDAE/AvhWzvV6gEOkbH5x3PQQ/BQxll
         LnjAFddr/Wp3RCDzOipDwwqvfYTHFdC8O7UKvW6MhkFn8KO2xF/ttZf3rSnlEZsT3JMb
         IsQg==
X-Gm-Message-State: ACgBeo2VQIRO/Ldy8aSAb5UIkhtuiN3kJwPYlKILsWGyjv0Brz3TDtZz
        qvYCAC4FaemBV92gZE28BPIPLjkSsbUM7dB6H/w=
X-Google-Smtp-Source: AA6agR6Cwk55gcuoQgIgnKhgffJRYAliThwIfgR7aCZCIUD7OUGPbbQunhOd6bmeVuKzHCAom2dWtNzACZFk33vO/JA=
X-Received: by 2002:a05:6808:ecb:b0:33a:3b54:37f9 with SMTP id
 q11-20020a0568080ecb00b0033a3b5437f9mr8913358oiv.33.1661175101159; Mon, 22
 Aug 2022 06:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220819210112.7924-1-rdunlap@infradead.org> <87o7wdkkt4.fsf@mpe.ellerman.id.au>
 <YwNovfuf3pDBh2Zk@infradead.org>
In-Reply-To: <YwNovfuf3pDBh2Zk@infradead.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 22 Aug 2022 09:31:30 -0400
Message-ID: <CADnq5_NOedr2TGH0W9wVAPkrJyyJ_+eAkEUORbYvShY4UW90sw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: export cpu_smallcore_map for modules
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
        amd-gfx@lists.freedesktop.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Tejun Heo <tj@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        linuxppc-dev@lists.ozlabs.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Mon, Aug 22, 2022 at 9:16 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Aug 22, 2022 at 01:40:23PM +1000, Michael Ellerman wrote:
> > Randy Dunlap <rdunlap@infradead.org> writes:
> > > drivers/gpu/drm/amd/amdkfd/kfd_device.c calls cpu_smt_mask().
> > > This is an inline function on powerpc which references
> > > cpu_smallcore_map.
> > >
> > > Fixes: 425752c63b6f ("powerpc: Detect the presence of big-cores via "ibm, thread-groups"")
> > > Fixes: 7bc913085765 ("drm/amdkfd: Try to schedule bottom half on same core")
> >
> > That 2nd commit is not in mainline, only linux-next.
> >
> > I don't mind merging this fix preemptively, but is that SHA stable?
>
> I really do not think this has any business being exported at all.
>
> kfd_queue_work is not something that should be done in a driver.
> Something like this belongs into the workqueue core, not in an
> underdocumented helper in a random driver.
>
> Drm guys:  once again, please please work with the maintainers instead
> of just making up random stuff in the drivers.

Discussions are already ongoing with the workqueue folks.  I'll drop
this for now.

Alex
