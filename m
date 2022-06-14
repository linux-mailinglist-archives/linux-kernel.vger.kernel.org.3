Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7334C54B9F5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 21:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344263AbiFNTBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 15:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357706AbiFNTBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 15:01:14 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE2521B1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 11:59:55 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h23so10798439ljl.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 11:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8CLjdm0fv8JCDmSYjgnWu5fkb8HC9HIzs0HHNU0IgVE=;
        b=DK8cpE1V6UMumzHAkRyd1w9x4mo+MEOSq6zru7t9LG18M5czUGkCsUs2EH9j1u4iHL
         LezrPxUpihEdcOokbl+dCMk30RmUolnINcwzTq0O+zn+E9nm/zz14C9bl90HItDPjOKl
         ERLItC0N42ryT5EVISS92P/0yKv70hgcnsJJNWXZ+9Etj4J/2tpwTPWContHA2JZvT1o
         5n3mgto6vkYIYGXkau8ei41v6T735IsjgvOQ1gln4RE9vX/3EmjuCzMtGP7516gzpQo1
         yO8OIyQv3p11rhwu5RSVdrVRMRguDlSCuDEChIy0QkxPKNzkWECvLC2W6FVXUUXrTL3k
         g16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8CLjdm0fv8JCDmSYjgnWu5fkb8HC9HIzs0HHNU0IgVE=;
        b=CULIblZfVTdHImoHHgxNLK/FrvULWL6L9152ehclYJrZCS/YJcLE9TGMHYVhk8elzF
         TzWl+JXa9npKDg6m1lzHu+PNiMaVsyxnBF8kEibCdSvfW6VuCo1XsKdyjSDN0p4h/sXC
         ANegypKByqU9fAZaiE77STw17e5VagIOCLkgJWfnt4bj243P34zy1Vi2A0XZabfVDHNh
         sdoDs+Ki0gcX0IngKTxwd/imtC88z/RLnFwJpbF0He0glfcOu7D2yf0jaRqATcXWyuJb
         FEmqlDXVKXlng6aHvw5DovasKCMYpiomERVhWs50IZXyHQQeCFM2wB0IKdDh6Fcq3K/C
         m1BQ==
X-Gm-Message-State: AJIora8IddB1MmwUJ29qArzF/xD4mg0Gyv+94j3fwcnYQlKDxJzk+Wn3
        UtaAggRfHd+fUGk59oAfBrvUvo9nxPrwypPfoOirGg==
X-Google-Smtp-Source: AGRyM1vEBCTUhPhDtXrKLEbsOE+r55A+HtUc7YmYWYz5meaQwiyvwOHmtqy2QzAWoa8+f58p9jQwavLDWb803hojJiU=
X-Received: by 2002:a05:651c:50b:b0:259:957:f2c6 with SMTP id
 o11-20020a05651c050b00b002590957f2c6mr3275924ljp.26.1655233193050; Tue, 14
 Jun 2022 11:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220614055149.1900535-1-masahiroy@kernel.org>
In-Reply-To: <20220614055149.1900535-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 Jun 2022 11:59:41 -0700
Message-ID: <CAKwvOdmcLCV6J+PYXCugH=0Pt_=yARZ-Y3SEmYy8F+oBpb1UYw@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: remove sed command from cmd_ar_builtin
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 10:53 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Replace a pipeline of echo and sed with printf to decrease process forks.

If you're trying to minimize process forks, is it possible to remove
the use of xargs as well and just invoke $(AR) with the parameters
splatted out? I don't know myself, but maybe you're creative enough?

Otherwise,
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> Changes in v2:
>   - Avoid the pipeline if there is no object to put in the archive
>
>  scripts/Makefile.build | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index cac070aee791..784f46d41959 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -358,9 +358,8 @@ $(subdir-modorder): $(obj)/%/modules.order: $(obj)/% ;
>
>  quiet_cmd_ar_builtin = AR      $@
>        cmd_ar_builtin = rm -f $@; \
> -               echo $(patsubst $(obj)/%,%,$(real-prereqs)) | \
> -               sed -E 's:([^ ]+):$(obj)/\1:g' | \
> -               xargs $(AR) cDPrST $@
> +       $(if $(real-prereqs), printf "$(obj)/%s " $(patsubst $(obj)/%,%,$(real-prereqs)) | xargs) \
> +       $(AR) cDPrST $@
>
>  $(obj)/built-in.a: $(real-obj-y) FORCE
>         $(call if_changed,ar_builtin)
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
