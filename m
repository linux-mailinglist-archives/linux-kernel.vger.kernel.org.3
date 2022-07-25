Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31091580346
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 19:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbiGYREm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 13:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiGYREk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 13:04:40 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B817DF88
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 10:04:39 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t17so6758435lfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 10:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iItHm3Vk6EW6BDSEYYaGs+JJjW4XNUHsFzmNCV9XOzc=;
        b=YwOUo1G3f6D5LB/r1XJsmOwujkGirm8R4FRenyogUGCgdgc+RQafd3FV9kdoNZxSjA
         G7CYMubVI7Ujd1mssOntAkIDIgUblWYYJfsTRt6U8P6YqNjK1hNzIT9iLnKxMm7ZY3cl
         vmrqUzGt2l/uvs3PU9EkeHsLM7xkjt6Xp2ygefHpOXFjKl/yyEAGto77IwnrP8VO/dAL
         iD5bDhgevSbJytibVPDfLJuAczZW72pPxFNs2B0FouBzz6CoEP6710cwUXq+mNnAvrW9
         tNqd9LAFfU/zG3GKYkwl1L8TFaUr5gcQp/iWSwvRS6tEmeg1gis4Xx6lcmjQOrGeuuwt
         AVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iItHm3Vk6EW6BDSEYYaGs+JJjW4XNUHsFzmNCV9XOzc=;
        b=nqTIcmey/ccAWZMJtEYgjOH3BiqiSwO7R+V+IMjV/MePyoW5t5t7eC1+qxuTBzG2HY
         KeMSkd+Qm/XjTK/niVSVOU+uaBjVBs+Cw0aBDwHXbQdyyvVO6z1oy4Uc8ykLnLovYsqD
         btnde2tZW62Fk968bPV8pqkcuzP6vLHHwYZ0fr1fANqASBmHSW3tRfhHDG6kN0KOxj3r
         EPxEP7lJUn4Nl/BYir42xyO+/TWI9ZmoSWCAThaKCrJkQpoMp5DRydf/0lVWXNP4qYKq
         FIYxqq8Hg3BPXq4S8Hg0gWjdmu1bOM79dHVnNug54jEdAeSojwI/EeoCNKws1YxDRo0f
         Xg8w==
X-Gm-Message-State: AJIora+jhyCkLdoCZcUIGBbln+2Hd0Mx+hp4X+Q1ykJnuKh+aTmpGbGs
        T8CJS85LqAygvdVmPHVQIR453qrHwRCmUUDweOMY6TNs3lo=
X-Google-Smtp-Source: AGRyM1sY17PsqKCQbUAdQNzNI5/Y5hFTaglHXruR7TzVZZJLrEfcHXIv6bMs3FDgGcpw/02ABTmuUqKCAFTKtoqDL8g=
X-Received: by 2002:a05:6512:1190:b0:48a:19d5:ef23 with SMTP id
 g16-20020a056512119000b0048a19d5ef23mr4715562lfr.401.1658768677590; Mon, 25
 Jul 2022 10:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220725021902.625630-1-masahiroy@kernel.org>
In-Reply-To: <20220725021902.625630-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Jul 2022 10:04:25 -0700
Message-ID: <CAKwvOdmv=pGh_ye_PfTjKf-YpJiV8Ps+OHmdMEna3rw7qT0Vrg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] riscv/purgatory: hard-code obj-y in Makefile
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Borislav Petkov <bp@suse.de>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        linux-kernel@vger.kernel.org
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

On Sun, Jul 24, 2022 at 7:21 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The purgatory/ directory is entirely guarded in arch/riscv/Kbuild.
> CONFIG_ARCH_HAS_KEXEC_PURGATORY is bool type.
>
> $(CONFIG_ARCH_HAS_KEXEC_PURGATORY) is always 'y' when Kbuild visits
> this Makefile for building.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> (no changes since v1)
>
>  arch/riscv/purgatory/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
> index d4df200f7edf..c2d14e2f345d 100644
> --- a/arch/riscv/purgatory/Makefile
> +++ b/arch/riscv/purgatory/Makefile
> @@ -92,4 +92,4 @@ quiet_cmd_bin2c = BIN2C   $@
>  $(obj)/kexec-purgatory.c: $(obj)/purgatory.ro $(obj)/purgatory.chk FORCE
>         $(call if_changed,bin2c)
>
> -obj-$(CONFIG_ARCH_HAS_KEXEC_PURGATORY) += kexec-purgatory.o
> +obj-y += kexec-purgatory.o
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers
