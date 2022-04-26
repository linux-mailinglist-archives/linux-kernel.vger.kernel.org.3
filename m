Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3ED5103BA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353069AbiDZQoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345421AbiDZQoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:44:03 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B56BB7CE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:40:55 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p10so32940831lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fqueYHGBpkvl2UC9CcSLlzu06+co5a0HYwKYVQXXlxQ=;
        b=Wu/cE5RmdzCdeA3QYzRxKb85+k8dUOSdgrDnfs1bHmFy29o1q3eL+ejynv2C1zYwj2
         /e08ICmkzYVL+XbYklwlwgU+etvnKR3e4QCiVdPxsiwaoGAnLSy2mvz+jni2+aIsx+sL
         IcIs8tWyE4STzyWj4xnt8DbhqTS2/1B2s+RkYy8wTaAjIbkeFIr1e04UmERJW8J54lqR
         SaIhle7LscGB8w08xoMghGyDKQFp+wqgQPkGuCDPw0LjmgBVSxiDh4eCEyLk5CaVgcFk
         XEmEx8mfjWHk/81HoPiudE3USckaPUksJgHBhBUEORvZBXRcNbalsZvZILODS92lA/mg
         mAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fqueYHGBpkvl2UC9CcSLlzu06+co5a0HYwKYVQXXlxQ=;
        b=VS+m4+QbrIdfEYxDhsuDWXHqVxrJ3l5N6hnPzrjt2c0WOVAHmT8SbR1ZLz//pBzwTu
         6T5JabmaQ7TNqlSHtabSPpywzwIUh2n/lz55mGFH6xgpXS9CAKz8qgT5AOk0oHu3vbPa
         8LHkI3BcZAEjjOGShWc6DSR/NcbnCsvm6dM8MNKcL7zYdvQaDIEQWI9yY5yDQ7HfX7HQ
         4q29pQ8Y1e66qWaJMs2RHkCVC/RANUPhl+s1NcoKDNOEt6rnLVSHkZEWnVgU7dTGRFVM
         jrPrsqX9KDJA87sFD18vNFxF6HOr8s5R+iVBtPx2TnPaxwhfvL/2cey/PqFp82CNJYul
         DSeg==
X-Gm-Message-State: AOAM533Q4IZ42RMQhLIgqFhoT70vM6tUZOEOSKX/i/P2VVFm8uwxFJb3
        lZ0++++b/Z/4kianF6+grLfRL3Ro2isw5lDTQd9oQQ==
X-Google-Smtp-Source: ABdhPJyJzubFSWnwzD9vAlMyHZanErLBPeKAQeH2atwZT+VQLnRDa34pRUDJO2+m/FtJUXlMpFMMmPypgOQHd/Y9wDc=
X-Received: by 2002:ac2:5223:0:b0:448:5100:e427 with SMTP id
 i3-20020ac25223000000b004485100e427mr17294136lfl.87.1650991253103; Tue, 26
 Apr 2022 09:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220424190811.1678416-1-masahiroy@kernel.org>
 <20220424190811.1678416-10-masahiroy@kernel.org> <CAKwvOdkac4Bk+u=v2dwSD=X0kZo2y4UxRUNHJdYiTLTPSp7=kQ@mail.gmail.com>
 <CAK7LNAR4N_OAUJJnCoZWA3OKWPFJHgOTLmsgY+DHaXRJFwGsGQ@mail.gmail.com>
In-Reply-To: <CAK7LNAR4N_OAUJJnCoZWA3OKWPFJHgOTLmsgY+DHaXRJFwGsGQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 26 Apr 2022 09:40:41 -0700
Message-ID: <CAKwvOd=W3sgPFie_WzOGqfkhht-_cfyOnWqaiCuDpFid=uibFA@mail.gmail.com>
Subject: Re: [PATCH 09/27] modpost: add sym_add_unresolved() helper
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 9:00 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Tue, Apr 26, 2022 at 3:41 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Sun, Apr 24, 2022 at 12:09 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > Add a small helper, sym_add_unresolved() to ease the further
> > > refactoring.
> > >
> > > Remove the 'weak' argument from alloc_symbol() because it is sensible
> > > only for unresolved symbols.
> >
> > I did not yet read the rest of the series to see how else your newly
> > added helper `sym_add_unresolved` is used.
> > Perhaps the callers of `alloc_symbol` should just set the symbol's
> > weak member to true if needed, and alloc_symbol can default to setting
> > it false (as the memset currently does)?
> >
> > Then, you don't need the helper, and just `handle_symbol` needs the
> > assignment when `ELF_ST_BIND(sym->st_info) == STB_WEAK`?
>
>
> I will change this in the later commit:
> https://patchwork.kernel.org/project/linux-kbuild/patch/20220424190811.1678416-11-masahiroy@kernel.org/
>
> I think this is a good case for a new helper.
>
> If you look at the entire series,
> "allocate a new symbol and connect it to the proper linked list or hash_table"
> is consistently done in a helper function.
>
>
> Also, I chose the function name as they look symmetrical.
>
>  sym_add_unresolved()
>  sym_add_exported()
>  sym_add_crc()

Ok.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
