Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448E25A41F4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 06:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiH2Ebs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 00:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH2Ebp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 00:31:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883603DBFE
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 21:31:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13EAA60FC5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 04:31:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7163BC433D6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 04:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661747503;
        bh=Q5uwaCjtDZodNXDw9HyknG6gzbEe16cPiJSOg5tENmc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NHuBauu2FP+OcxS2EPGDkVr6rA8U6LMoQlOLsXoYLT69JDEWfXPXwr+SDDfefBX8R
         jE8c0j4X1PgpujpUKq/wCgE/bLfOfVhxOAk8vBH1uhSKR+IndqAU/gJqAvOsB6hJeB
         pk8PpiylYbjN9QR55v8vsLbPeGD8btv5i44CP9Utxi4waSEzYA43Seb/3fk+PXLlTk
         rUxAGgwUEOSgz16hp9/2NCxTzj2UTATQ2kbyckfdqoIaZXfCWwHx9SsK4D+JNcyLqE
         FNtFPLwrDqAO/6aS8lQ7BQGcTwoDdkTu3hs9En/ZUSSEsZBiKuo95U5hzk+hVgj096
         Y30Niq58yNKOw==
Received: by mail-vk1-f173.google.com with SMTP id c2so272842vkm.9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 21:31:43 -0700 (PDT)
X-Gm-Message-State: ACgBeo1sPgnBJgkgZEUf+pdgnFnqRCGyelnR78/jsPyiwNC87Hu5klvi
        eXFpnJjH4WpnPw92Kz8DCrwEOnHkrf6B5X/q/sM=
X-Google-Smtp-Source: AA6agR4dmeOeOK0vxhiFuG208OrUj6NfbW7j6umrxJPeb6QxPEF1TTgdICNm31n02rks+npAxVttdG4VFIBUViZHmlU=
X-Received: by 2002:a1f:9b90:0:b0:374:f09c:876f with SMTP id
 d138-20020a1f9b90000000b00374f09c876fmr2725218vke.12.1661747502405; Sun, 28
 Aug 2022 21:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220827175436.156464-1-xry111@xry111.site> <20220827175436.156464-2-xry111@xry111.site>
 <CAAhV-H7-MNd9WsnB3r2kxRN7LveixGwQZ=qTVHB_XvW+uU9q4Q@mail.gmail.com> <fbbcf45a1f54333e8abfea3c121f37ad56651dbc.camel@xry111.site>
In-Reply-To: <fbbcf45a1f54333e8abfea3c121f37ad56651dbc.camel@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 29 Aug 2022 12:31:31 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Gz5pGO0-bRWu_x5TZrOX77_uJjfEQPGo+Fgyk7irRdA@mail.gmail.com>
Message-ID: <CAAhV-H4Gz5pGO0-bRWu_x5TZrOX77_uJjfEQPGo+Fgyk7irRdA@mail.gmail.com>
Subject: Re: [PATCH 1/8] LoongArch: Add CONFIG_CC_HAS_EXPLICIT_RELOCS
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 12:20 AM Xi Ruoyao <xry111@xry111.site> wrote:
>
> On Sun, 2022-08-28 at 22:15 +0800, Huacai Chen wrote:
> > > +config CC_HAS_EXPLICIT_RELOCS
> > > +       def_bool $(cc-option,-mexplicit-relocs) && $(as-
> > > instr,x:pcalau12i \$t0$(comma)%pc_hi20(x))
> > Is it possible that we only change the Makefile and not touch Kconfig?
>
> I guess we can, but if we'll introduce objtool we can
>
>   select HAVE_OBJTOOL if CC_HAS_EXPLICIT_RELOCS
>
> then.
OK, you can keep your way.

Huacai
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
