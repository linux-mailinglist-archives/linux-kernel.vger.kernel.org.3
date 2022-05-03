Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3B651909F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 23:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243119AbiECVrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243100AbiECVrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:47:18 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601984162E
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 14:43:40 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id j4so32467038lfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 14:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C756m5N+PAgQRKxR49lEWlxtJ+9ZyoDvXSPO8NFP/os=;
        b=e0s9a83f4XxcDt4qv0Yq1NGegacSoMfk1kUMm4iSF83ip1Tf+H2yXLO9VDCeKV7C4c
         /8Fmu1KMTzgp6siIjz8JWGnr3cdCc8kiVoE5MzTOiLMNsIhmDYLoE5F97ElfwQKZOrcW
         OEhiqQJIZE73f1Aiyi7UfXo/aixlTJlwy22uL5drkN77lnAKcv8aBj1f8PWsKA0vcKKn
         RcBS9VX50JEaj+xuhLkaBUifaAVgRauwnUb4L3k2gBQukgd93q3BQ/3OdSnKWPkanfqn
         mgpAkATGRsyCTEZkwnyUNdbSJetOKwkzvx95wVmWpYQqq6YyZYOAQmE1eJR+hTcPA08/
         lSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C756m5N+PAgQRKxR49lEWlxtJ+9ZyoDvXSPO8NFP/os=;
        b=QfKfO8b9F+1yz2eJieoxnOgfBxhvdTFt+6rQc69pxU4bnXscOC4014FBnlge1mQQ4t
         cTRhdkV2AzD61deDIhIRG+07kQZsgKly2M6/9bPbIvajbDteug0uaYySCd83FzAK8WJR
         qxf8ig8oWJ8+13SHLpA9TSmX9uXLXoa7e7Q5YRJ1JepjboZHY6U+1tngP/0p+ZSEP/zn
         lRcOms1A7N5aVORJp9HGhNtrqPkPtZtRfwM19SR4R8jZoYeR+seC4isLQweZ+eeuxSxT
         RTWw+55+tG8JeuI9wP1B4Z7wjwD1UelnRz7sJeii0gK/vy7ZByn4LsosP1vnfbyKEGuS
         LBzA==
X-Gm-Message-State: AOAM5325OK5cLcHDwxMuAlpxE3P2r30/iu5TJP6G7Vc4++A/x+pOql/e
        zGrc4O2dVn0I4JGNk+DrqVCXqMCS7yf0uVCfWD1fzuNtO10=
X-Google-Smtp-Source: ABdhPJxlgenGdZiH7n9vBibI6qkAxNk/xO71M6pNC8Y64omRpD6gBOoI9tnHyN+y+6OlRQe66kztnErFQ3ZDPAGTT9I=
X-Received: by 2002:a05:6512:1150:b0:473:bdf0:6267 with SMTP id
 m16-20020a056512115000b00473bdf06267mr179381lfg.87.1651614218457; Tue, 03 May
 2022 14:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220501084032.1025918-1-masahiroy@kernel.org> <20220501084032.1025918-2-masahiroy@kernel.org>
In-Reply-To: <20220501084032.1025918-2-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 3 May 2022 14:43:26 -0700
Message-ID: <CAKwvOdkuWSBShjA2uQEYj5Puyn0bJLdK1JE9Y-P+q9uxNk1A5w@mail.gmail.com>
Subject: Re: [PATCH v2 01/26] modpost: use bool type where appropriate
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 1, 2022 at 1:42 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> index 96d6b3a16ca2..7ccfcc8899c1 100644
> --- a/scripts/mod/modpost.h
> +++ b/scripts/mod/modpost.h
> @@ -1,4 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +#include <stdbool.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <stdarg.h>
> @@ -111,11 +112,10 @@ struct module {
>         struct module *next;
>         int gpl_compatible;
>         struct symbol *unres;
> -       int from_dump;  /* 1 if module was loaded from *.symvers */
> -       int is_vmlinux;
> -       int seen;
> -       int has_init;
> -       int has_cleanup;
> +       bool from_dump;         /* true if module was loaded from *.symvers */
> +       bool is_vmlinux;
> +       bool seen;
> +       bool has_init, has_cleanup;

Consider keeping these on separate lines. Either way:
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
