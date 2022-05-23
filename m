Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708115318A1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242199AbiEWS2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244550AbiEWS0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 14:26:17 -0400
Received: from condef-05.nifty.com (condef-05.nifty.com [202.248.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EDD9D4F5;
        Mon, 23 May 2022 10:59:59 -0700 (PDT)
Received: from conssluserg-04.nifty.com ([10.126.8.83])by condef-05.nifty.com with ESMTP id 24NHsVbB010676;
        Tue, 24 May 2022 02:54:31 +0900
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 24NHs68f030856;
        Tue, 24 May 2022 02:54:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 24NHs68f030856
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653328447;
        bh=dBNWfUQZFF9+bb53ddySLO4pxcaDK6Q56t+DuFejwTQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YPJU5jZglHmdJwUdf3fnigknfY4oOOpL20Ktso2K43HKC/WvVbzhIzA/jezTbwsv7
         etbq0bAlxhbxIHJREfB+0YsXaeGrvsL5b/uYYU/qjxmWS6s0tr0nvErfvfbCQu4Pbs
         Gli6n1+H0MR+8jpqmsa0Q1zfRYSDGnpfKQ3ESQuZC6gWD29eyTn+tJovl92cLbtUNh
         UMS0nB8TD2TuQCXCr7LtVUn24t9HQjXwQGh4ZfkNQqBelD9Fth9OZJpQEsArosaRvp
         r7Una5mA7A03DN1LDoafUdgmM1udQsZvE3lvn6jLy/omLSMGd/QUbmQLrhPEiAmHpK
         vetgIOir8o3oA==
X-Nifty-SrcIP: [209.85.167.173]
Received: by mail-oi1-f173.google.com with SMTP id e189so18692231oia.8;
        Mon, 23 May 2022 10:54:06 -0700 (PDT)
X-Gm-Message-State: AOAM5306K2pylWQ7wBKnuYK4qU0mlooJzjFK07dRNVC+vVtzJoptB77b
        FweYBbdygK2S5RPY9gbxlf4lLGmrS1dtG1yBB8s=
X-Google-Smtp-Source: ABdhPJydFROQRPLEMNo6nNdOMTyK1LJ+VThHesO2oiz688jMIImNNSAgs59aHnxolEncb9HDmJvuAvA6S5mjHt72qNU=
X-Received: by 2002:a05:6808:1805:b0:32b:17e3:c7b with SMTP id
 bh5-20020a056808180500b0032b17e30c7bmr110519oib.37.1653328445708; Mon, 23 May
 2022 10:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220517105128.9720-1-3090101217@zju.edu.cn>
In-Reply-To: <20220517105128.9720-1-3090101217@zju.edu.cn>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 24 May 2022 02:52:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNARs__+bdMMb0c8whxxzfkcN7U1yjm5PCddqZqshW2o=Cw@mail.gmail.com>
Message-ID: <CAK7LNARs__+bdMMb0c8whxxzfkcN7U1yjm5PCddqZqshW2o=Cw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Fix include path in scripts/Makefile.modpost
To:     3090101217@zju.edu.cn
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
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

On Tue, May 17, 2022 at 7:51 PM <3090101217@zju.edu.cn> wrote:
>
> From: Jing Leng <jleng@ambarella.com>
>
> When building an external module, if users don't need to separate the
> compilation output and source code, they run the following command:
> "make -C $(LINUX_SRC_DIR) M=$(PWD)". At this point, "$(KBUILD_EXTMOD)"
> and "$(src)" are the same.
>
> If they need to separate them, they run "make -C $(KERNEL_SRC_DIR)
> O=$(KERNEL_OUT_DIR) M=$(OUT_DIR) src=$(PWD)". Before running the
> command, they need to copy "Kbuild" or "Makefile" to "$(OUT_DIR)" to
> prevent compilation failure.
>
> So the kernel should change the included path to avoid the copy operation.
>
> Signed-off-by: Jing Leng <jleng@ambarella.com>
> ---
>  scripts/Makefile.modpost | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index 48585c4d04ad..0273bf7375e2 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -87,8 +87,7 @@ obj := $(KBUILD_EXTMOD)
>  src := $(obj)
>
>  # Include the module's Makefile to find KBUILD_EXTRA_SYMBOLS
> -include $(if $(wildcard $(KBUILD_EXTMOD)/Kbuild), \
> -             $(KBUILD_EXTMOD)/Kbuild, $(KBUILD_EXTMOD)/Makefile)
> +include $(if $(wildcard $(src)/Kbuild), $(src)/Kbuild, $(src)/Makefile)
>
>  # modpost option for external modules
>  MODPOST += -e
> --
> 2.17.1
>


I do not think "M=$(OUT_DIR) src=$(PWD)" is the official way,
but this patch is a clean up.

Applied to linux-kbuild. Thanks.


-- 
Best Regards
Masahiro Yamada
