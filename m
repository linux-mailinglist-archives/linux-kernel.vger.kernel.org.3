Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC20582A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbiG0QPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiG0QPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:15:15 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB4221BF;
        Wed, 27 Jul 2022 09:15:14 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id tk8so32344128ejc.7;
        Wed, 27 Jul 2022 09:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nEQIzIbqw9tVaGjrZxnadiXsV/LO+6rSYxOknhZz9+0=;
        b=UEhGj5bYowOxm7P9F3F1YOg14wIJ4SyZm+OQo126czghjj3mQZZ3esFdQR5dQyE730
         cCJbhN+DzrfMyJIASQVc1/4mFNOP6+760mtO7Smhrkk49G26rJAYVN08p94Rg7JgZiR+
         jFNUonYSPuFUc2o1leXKOGd6I3i7ZBFaAWuA4jIuro45hBMdu0HpsRl8iIXTbpXqR36n
         koVk+yNAxVouLWt2XVEIx7x/m0P4QZjNKQ2pMBGbLExXLFw4SJ7bViOhwyUKN2/n+ge9
         QIvAzIsvPLXiX64gOvCHPbtnPK9Hl/b3RAK2I7yzj2M9mwYB7kQZTtxcjRdDaYiJcxs0
         mMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nEQIzIbqw9tVaGjrZxnadiXsV/LO+6rSYxOknhZz9+0=;
        b=NAY1fkYCe3QqJbK9kJrLuUEU3c2Zv2ta3adOoCXSCCAtGKJL0PsIfbg2Thch6eRD6F
         CMqC3YuJh2OlC0Wd9jy0t6WBlhW0DqdveuCHEt+eXZijMwU3czyXZ/UirT3Lqbjmp6Pc
         sCBL9TLVsNZPwTozlKpJcTpXypShqb298heyWKA/o0TRM7qFYwijQKu7eHuocJSzSItl
         5p20vihYeS8g4pPv+/y6r1uX+LIfxv3oAql2R9tnOKCUkuQg/DwG7287TTu83giWz3zH
         1Jqm4ETyQi1tCfg5/AdOcMZgrWAtdN6Cx6W0dyB4u7wHabkdGCdokjKtowzJXn7ZVl8v
         2kWQ==
X-Gm-Message-State: AJIora+4GpEvRmJlz7PSF57Sw5t9dbJi1b21q49PTNq81U4303kX/yfC
        KWh/J6FLZkyf3HyfMi6tkBxvndQIZQkJxjETyORW8n1A
X-Google-Smtp-Source: AGRyM1v/y62b9L2Sj88bKJD1ZgQN6QQwveKYmTFbg9xiUSSMShe/d05MOog5wiSu5RMvcuJdcI/0Tn3ZhAGpfY1NTyA=
X-Received: by 2002:a17:907:a0c6:b0:72d:3fd2:5daa with SMTP id
 hw6-20020a170907a0c600b0072d3fd25daamr18633865ejc.728.1658938513064; Wed, 27
 Jul 2022 09:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220726205458.0b5ca446@canb.auug.org.au> <87leseabci.fsf@mpe.ellerman.id.au>
In-Reply-To: <87leseabci.fsf@mpe.ellerman.id.au>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 27 Jul 2022 12:15:01 -0400
Message-ID: <CADnq5_OkWWO+hNz-n+bw5Wptn3JsfyuXe+ScXYTKwFz6JJf8fQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the amdgpu and
 powerpc-fixes trees
To:     Michael Ellerman <mpe@ellerman.id.au>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        Melissa Wen <mwen@igalia.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Rodrigo, Melissa

On Wed, Jul 27, 2022 at 10:17 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> > Hi all,
> >
> > After merging the amdgpu tree, today's linux-next build (powerpc
> > allyesconfig) failed like this:
> >
> > ld: drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.o uses hard float, drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.o uses soft float
> > ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.o
> >
> > I have reverted commit
> >
> >   c653c591789b ("drm/amdgpu: Re-enable DCN for 64-bit powerpc")
> >
> > for today.
>
> It bisects to:
>
>   40b31e5355ba ("drm/amd/display: Remove FPU flags from DCN30 Makefile")
>
> So I guess there's still some float code in dcn30?
>
> cheers
