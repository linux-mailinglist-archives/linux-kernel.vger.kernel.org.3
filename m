Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59651547353
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 11:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbiFKJij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 05:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbiFKJid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 05:38:33 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A941532ECA
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 02:38:32 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 25B9cJqT013061
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 18:38:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 25B9cJqT013061
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654940300;
        bh=dvQLqE9CD0Sc31TfKaAdiORJwqPYnVIClrdVtOr8MuU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VQRRIgL3RaBwbAb8zlsjU/+y8z7S4bPBtkzV2F3eoVaSN2nqeiiouM3JjXiSZwPif
         QrU11WA67/+x5QVZKqO8abfFxTxi9/K0zSLaujSd+f0t9XdHrKR/d7soaLwqc9mtUl
         zNc9BaGaqIYr6DKiwp2p/YpKKy0QHEPfqfnbod0wI16QgGPIr6geIpNmJFNSoFKuZM
         DjMhbcVfKcy+XPHyM64ao1YZQDhOzSRP+h36+NzP1yHrB8i30j94oXxeWyIeWGCkDK
         hsQrBwU71+Mpny5s4+LmQyQCQ9CwvHcxbq557kQmVmb1FWMcQJuNpv5LAdwyOPmXqu
         a9b28AwXa41qA==
X-Nifty-SrcIP: [209.85.128.50]
Received: by mail-wm1-f50.google.com with SMTP id z9so582025wmf.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 02:38:19 -0700 (PDT)
X-Gm-Message-State: AOAM531sefQuD4CoFHhnGurqsWN4eyPtEEJ6DWRjOJo+osMLmDrEuqqg
        6Jf++7GQXUmy52UNJ3QY7zPe2qAiPlpvcE9VLNg=
X-Google-Smtp-Source: ABdhPJzZVNw7ql3vh1nekhMh6vBUEJO0ZE52meBw8QyxqYw1a6qL2nlFf1hcJ8FXJAo3pYzjIBY6d+gFSFhDl6mYWUo=
X-Received: by 2002:a05:600c:35c2:b0:39b:fa1f:4f38 with SMTP id
 r2-20020a05600c35c200b0039bfa1f4f38mr4083537wmq.22.1654940298310; Sat, 11 Jun
 2022 02:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220610071500.9656-1-Kuan-Ying.Lee@mediatek.com>
In-Reply-To: <20220610071500.9656-1-Kuan-Ying.Lee@mediatek.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 11 Jun 2022 18:37:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNATknxrmnAXKkz-XzkGn1kprPiQLrjKSdp4wKCRhPczcmA@mail.gmail.com>
Message-ID: <CAK7LNATknxrmnAXKkz-XzkGn1kprPiQLrjKSdp4wKCRhPczcmA@mail.gmail.com>
Subject: Re: [PATCH] scripts/gdb: change kernel config dumping method
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        chinwen.chang@mediatek.com, nicholas.tang@mediatek.com,
        casper.li@mediatek.com, andrew.yang@mediatek.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 4:15 PM Kuan-Ying Lee
<Kuan-Ying.Lee@mediatek.com> wrote:
>
> MAGIC_START("IKCFG_ST") and MAGIC_END("IKCFG_ED") are moved out
> from the kernel_config_data variable [1].
>
> Thus, we parse kernel_config_data directly instead of considering
> offset of MAGIC_START and MAGIC_END.
>
> [1] https://lore.kernel.org/lkml/1550108893-21226-1-git-send-email-yamada.masahiro@socionext.com/
>
> Fixes: 13610aa908dc ("kernel/configs: use .incbin directive to embed config_data.gz")
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>


Thanks for the fix.

Applied to linux-kbuild/fixes.




> ---
>  scripts/gdb/linux/config.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/gdb/linux/config.py b/scripts/gdb/linux/config.py
> index 90e1565b1967..8843ab3cbadd 100644
> --- a/scripts/gdb/linux/config.py
> +++ b/scripts/gdb/linux/config.py
> @@ -24,9 +24,9 @@ class LxConfigDump(gdb.Command):
>              filename = arg
>
>          try:
> -            py_config_ptr = gdb.parse_and_eval("kernel_config_data + 8")
> -            py_config_size = gdb.parse_and_eval(
> -                    "sizeof(kernel_config_data) - 1 - 8 * 2")
> +            py_config_ptr = gdb.parse_and_eval("&kernel_config_data")
> +            py_config_ptr_end = gdb.parse_and_eval("&kernel_config_data_end")
> +            py_config_size = py_config_ptr_end - py_config_ptr
>          except gdb.error as e:
>              raise gdb.GdbError("Can't find config, enable CONFIG_IKCONFIG?")
>
> --
> 2.18.0
>


-- 
Best Regards
Masahiro Yamada
