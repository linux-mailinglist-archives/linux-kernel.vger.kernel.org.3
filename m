Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9695ADCEA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 03:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbiIFBeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 21:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiIFBeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 21:34:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52D765543
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 18:34:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E8D46009F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 01:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A351EC433D6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 01:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662428039;
        bh=7jdjCsTQ10QeWX2F6xU7ujVBgxg1gpahwxgqLaOihhc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qPJ6fecU60A87EOZ1izMltMufCNClQrCLfKIt+tunUt9d478rc5W2mefgXN0BcFf7
         IcFbO5g1d/Z9PO6TVTRic9QYONWc4RFIEQsszkQK5dfWOULEezZOx0bsS3TzLracKO
         2VC/JdgvTJPb3a3xAR6hjYRhHANAky3Gw6zW0PNTIzU1gwyY8a0EdgYrIFUiDNC7sJ
         kYScAK6Z2DdwKZpEJaU+vJJwsDDRHs8KAyA/BMGwlY1qakbgBizVnbeCMby9QYV7K2
         t6jw5bZYuOoosITjL4ROaEOQ93m041oihkBbursKrrw9AQdmxmSHKhbxcESiYAkqM/
         3wf3KGnuav1OQ==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1272fc7f51aso11613623fac.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 18:33:59 -0700 (PDT)
X-Gm-Message-State: ACgBeo062YWdRWvaAyDq/DPtFINryr0emMW5NjYM5PuRAlzvmAk7Un+1
        rD/wyiocm9ML5CfykeqpjloBWlrUdl687i+xGpE=
X-Google-Smtp-Source: AA6agR6T3PqL9F1CwsN79Krt3sajHmoioNBxuPXmIjJBV3FNIIHOOVC+gpKHm5eHaqUpZS7pDoC/tFojOR2E8gO7IhI=
X-Received: by 2002:a05:6808:150f:b0:343:3202:91cf with SMTP id
 u15-20020a056808150f00b00343320291cfmr8674404oiw.112.1662428038857; Mon, 05
 Sep 2022 18:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220905111027.2463297-1-heiko@sntech.de> <20220905111027.2463297-6-heiko@sntech.de>
In-Reply-To: <20220905111027.2463297-6-heiko@sntech.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 6 Sep 2022 09:33:45 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRB6Rq=MbFDuoEeU4-0B1N-JVjuxrHFK6YDg59ya2R9GQ@mail.gmail.com>
Message-ID: <CAJF2gTRB6Rq=MbFDuoEeU4-0B1N-JVjuxrHFK6YDg59ya2R9GQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] riscv: check for kernel config option in t-head
 memory types errata
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, apatel@ventanamicro.com,
        atishp@rivosinc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>
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

Reviewed-by: Guo Ren <guoren@kernel.org>

On Mon, Sep 5, 2022 at 7:10 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> The t-head variant of page-based memory types should also check first
> for the enabled kernel config option.
>
> Fixes: a35707c3d850 ("riscv: add memory-type errata for T-Head")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/errata/thead/errata.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> index a6f4bd8ccf3f..902e12452821 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -17,6 +17,9 @@
>  static bool errata_probe_pbmt(unsigned int stage,
>                               unsigned long arch_id, unsigned long impid)
>  {
> +       if (!IS_ENABLED(CONFIG_ERRATA_THEAD_PBMT))
> +               return false;
> +
>         if (arch_id != 0 || impid != 0)
>                 return false;
>
> --
> 2.35.1
>


-- 
Best Regards
 Guo Ren
