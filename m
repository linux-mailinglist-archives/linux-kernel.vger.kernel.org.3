Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E8F4B3646
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 17:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbiBLQQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 11:16:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236934AbiBLQQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 11:16:07 -0500
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0C2197;
        Sat, 12 Feb 2022 08:16:03 -0800 (PST)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 21CGFcHK017947;
        Sun, 13 Feb 2022 01:15:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 21CGFcHK017947
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644682539;
        bh=xmWtzPLhF/OLvHEyW1KWegHYFa8ohGMKtNkmkoThUD8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xuhs5Kg/QZz9Yjkq+QVgvmaPyGxQuwQzNZNzh/Vwm4A7eeP5ViFD7KLsk/vs55q+q
         RwOIdP9tzcdkKGCi3QpWSJhkQRijB4XfE0Sl8hrKXo8lUsfPbWAf4DIZObkS5UA+VF
         ABS4gHXsEdTAubA8XFvrID8ucxAHks/t9f1Kfp6S9IprZHLVk4FuF0ntGfeIGPBr4K
         tp0ngIYI3OdIgPJhgdhDIOEziH3bsqmMMMh5aM30hLOa7PEegNvw7PHH8sV9VXCBIl
         CdAlYBMylC7UAbt6OeW2GjcwK4jphwMr7kF6YdqAoaMTE4nOc/TKSZJoccQnoQeWMS
         YVBDdBimeUs3Q==
X-Nifty-SrcIP: [209.85.210.174]
Received: by mail-pf1-f174.google.com with SMTP id l19so15772686pfu.2;
        Sat, 12 Feb 2022 08:15:38 -0800 (PST)
X-Gm-Message-State: AOAM533LHMqZ6D/c60Ru/w+8inVaLaD1gMX0KwG7AhRM9C76UK7/926g
        pluaAvX0v8QT+ygfprUeL3/C0IwyX7E3dtyaiKg=
X-Google-Smtp-Source: ABdhPJzN+z1G5lnhkil4j0r24lok6aNoY603WJZvoFzmuTCFaAaPwaJApjQveXrCpBFO3SyeDIBw8otaVaNNlcL3PHc=
X-Received: by 2002:a05:6a00:240a:: with SMTP id z10mr6767863pfh.68.1644682538081;
 Sat, 12 Feb 2022 08:15:38 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNASrwE3FcoZGK73-0TeH-omk9Yjp1fjcMCOLPpu_xv9_og@mail.gmail.com>
 <20220211092736.7623-1-3090101217@zju.edu.cn>
In-Reply-To: <20220211092736.7623-1-3090101217@zju.edu.cn>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 13 Feb 2022 01:15:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT=b8t7voOJQrSPQr8xwcudWs_bJSCjN3Z8doM+bs_wkw@mail.gmail.com>
Message-ID: <CAK7LNAT=b8t7voOJQrSPQr8xwcudWs_bJSCjN3Z8doM+bs_wkw@mail.gmail.com>
Subject: Re: [PATCH v2] kconfig: fix failing to generate auto.conf
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

On Fri, Feb 11, 2022 at 6:29 PM <3090101217@zju.edu.cn> wrote:
>
> From: Jing Leng <jleng@ambarella.com>
>
> When the KCONFIG_AUTOCONFIG is specified (e.g. export \
> KCONFIG_AUTOCONFIG=output/config/auto.conf), the directory of
> include/config/ will not be created, so kconfig can't create deps
> files in it and auto.conf can't be generated.
>
> Signed-off-by: Jing Leng <jleng@ambarella.com>

Applied to linux-kbuild/fixes.
Thanks.


> ---
>  scripts/kconfig/confdata.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> index 59717be31210..974a079e8901 100644
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -994,14 +994,19 @@ static int conf_write_autoconf_cmd(const char *autoconf_name)
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
> +       tmp = strrchr(name, '/');
> +       depfile_prefix_len = tmp ? (tmp - name) + 1 : 0;
> +       if (depfile_prefix_len + 1 > sizeof(depfile_path))
> +               return -1;
> +
> +       strncpy(depfile_path, name, depfile_prefix_len);
> +       depfile_path[depfile_prefix_len] = 0;
> +
>         conf_read_simple(name, S_DEF_AUTO);
>         sym_calc_value(modules_sym);
>
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
