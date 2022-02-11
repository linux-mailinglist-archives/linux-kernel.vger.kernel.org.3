Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37ABB4B1D55
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 05:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243246AbiBKE2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 23:28:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiBKE2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 23:28:18 -0500
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959642655;
        Thu, 10 Feb 2022 20:28:17 -0800 (PST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 21B4RiCx007739;
        Fri, 11 Feb 2022 13:27:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 21B4RiCx007739
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644553664;
        bh=RlpxWh2Mu1l8iL7mBcRuNEMC5R3LGI3pTx/23psC1Mc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b499rrOFKuO5a8Iaz2kyPibcaoGaOvRrMeKIMj4KqjqktHMyHRl19kQzCbcAfdDk2
         cCk2JTh0K6LbABqrN8pw0t/OZ6mQvk6huipJSWfb/3YwQy+zZ6PtrrFDQC8xaB2z4b
         VaqmBxq90NjGA8iAc0r+BCXBSdt8SYiT91MKjf2p5dAVJZL4S0Nx7LT6c2aMfZwG0E
         hmSPwyQxFgKJcQWqZNI5fmWB3ru87mLgjp8EhbSR7OwEaj4iqRKfqDUmX94quNIv0V
         h3hsAndEM7W9xWr/yxgeX9UiT6wzVqIN7vuKxw1kTOlFMemaM18tchEg7tVZFhXxF0
         8RoubFfB/GLAQ==
X-Nifty-SrcIP: [209.85.214.169]
Received: by mail-pl1-f169.google.com with SMTP id w1so3690649plb.6;
        Thu, 10 Feb 2022 20:27:44 -0800 (PST)
X-Gm-Message-State: AOAM533vC3sL111IibCTVlfG+GSc+fiYAVAUNAIuXF6pZqXgrY7UYcAQ
        R/49l2+ghVI1CgWL5Z/QLOh5d9au0zADctBrMG4=
X-Google-Smtp-Source: ABdhPJzRF/OHWiPVKjd5NDzPVATAyiKpTGDXouwzX7kNnv7ghxNgM/Nf/zSA71ifM6Lq8b25FRTmEypz28n1O/aBvCw=
X-Received: by 2002:a17:902:6948:: with SMTP id k8mr10720087plt.136.1644553663556;
 Thu, 10 Feb 2022 20:27:43 -0800 (PST)
MIME-Version: 1.0
References: <20220210062953.21285-1-3090101217@zju.edu.cn>
In-Reply-To: <20220210062953.21285-1-3090101217@zju.edu.cn>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 11 Feb 2022 13:27:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNASrwE3FcoZGK73-0TeH-omk9Yjp1fjcMCOLPpu_xv9_og@mail.gmail.com>
Message-ID: <CAK7LNASrwE3FcoZGK73-0TeH-omk9Yjp1fjcMCOLPpu_xv9_og@mail.gmail.com>
Subject: Re: [PATCH] kconfig: fix failing to generate auto.conf
To:     3090101217@zju.edu.cn
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jing Leng <jleng@ambarella.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 3:40 PM <3090101217@zju.edu.cn> wrote:
>
> From: Jing Leng <jleng@ambarella.com>
>
> When the KCONFIG_AUTOCONFIG is specified (e.g. export \
> KCONFIG_AUTOCONFIG=output/config/auto.conf), the directory of
> include/config/ will not be created, so kconfig can't create deps
> files in it and auto.conf can't be generated.
>
> Signed-off-by: Jing Leng <jleng@ambarella.com>
> ---
>  scripts/kconfig/confdata.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> index 59717be31210..800ecf9934bc 100644
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -994,14 +994,15 @@ static int conf_write_autoconf_cmd(const char *autoconf_name)
>
>  static int conf_touch_deps(void)
>  {
> -       const char *name;
> +       const char *name, *tmp;
>         struct symbol *sym;
>         int res, i;
>
> -       strcpy(depfile_path, "include/config/");
> -       depfile_prefix_len = strlen(depfile_path);
> -
>         name = conf_get_autoconfig_name();
> +       depfile_prefix_len = ((tmp = strrchr(name, '/'))) ? (tmp - name) + 1 : 0;
> +       strncpy(depfile_path, name, depfile_prefix_len);
> +       depfile_path[depfile_prefix_len] = 0;
> +
>         conf_read_simple(name, S_DEF_AUTO);
>         sym_calc_value(modules_sym);
>
> --
> 2.17.1
>


Thanks.

I wanted to pick up this patch, but
could not find it in the patchwork
(https://patchwork.kernel.org/project/linux-kbuild/list/)
despite you apparently CC'ed the kbuild ML.

Do you know why?
(I do not know if the kbuild/kernel ML requires subscription...)



If you have a chance for re-submission,
can you change the code like follows?

     depfile_prefix_len = ((tmp = strrchr(name, '/'))) ? (tmp - name) + 1 : 0;


     tmp = tmp = strrchr(name, '/');
     depfile_prefix_len = tmp ? tmp - name + 1 : 0;


Too many parentheses make the code unreadable.





-- 
Best Regards
Masahiro Yamada
