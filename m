Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84B854E30D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377555AbiFPOKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 10:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377001AbiFPOKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 10:10:31 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3182848E7A;
        Thu, 16 Jun 2022 07:10:30 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id y17so982553ilj.11;
        Thu, 16 Jun 2022 07:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Bdf9wkC1ypzciNLF7AiRIhEs9K16sQ5cIuAUnPzMikk=;
        b=ZWodJQhmXLXE1RedHEMpYdSASnmddcGHxa5T59oKWc51cGr9E5AFR654iHtEegPMRR
         t4L6ssnlsCkpQkPTBtWkQ6VKXX3uP86mvrZduYgi4VBb/UGzLpOlv+aTSwrE2gPKqhN0
         IpLF0vDp4DOlCVhaeuCoyYzLboQOxh97nghIvoPWHAzhnKQ+bowapO2quJf5gUXKnTS+
         rI2JDokfDD+LFD3qxlCK6XeITkOqqmhQ8I2UpDnGD8IH8yFBARrc5l9yWAMs2dRkKe3i
         XiYebs2Gw+i2kzsVkjji+oTC2EjfkwrnmrIa6iojWe+364ugu13wK1R7ydQyiNKhcG6+
         lRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Bdf9wkC1ypzciNLF7AiRIhEs9K16sQ5cIuAUnPzMikk=;
        b=VJvuSP1LoVqJAQp0E9RITTsWNwNb1IdIDKXPi4a7rq8aOPKxppwQLyL13a7ibMFl2d
         qVP0LKapTqmegBfVguW5LS9iYvppBNmyYccVpTIJlLYxouJ0M5tCV+YzNt8mrbg7Frbd
         c3wzbiEyKjLAUaA3QRj08x65u9wWmS4ywbq6aKlGWr9m5Y+T9nQOIgAOLCcgxwdW+sts
         pi4EvAJ4v4Ggq/YqXiPg3JTaW7F40d8yw9sOsTE3i08/LvqcEXvCUAIXsuoeoAZMzlkT
         lBW/NZDzscdFKojHV4wuYCInAhsZcnaaNWDSQVmgFMAmvDLUdis+JswNFHP0Y4kuqnGr
         8mAg==
X-Gm-Message-State: AJIora9Kc2wfRWuMiBj2zp9rcEAX67f066ZVVaWFZbsz0aIEejjTW5tV
        bMOBlTU85YlKosoLViWZVGBChGwLdIyHAZzeSrY=
X-Google-Smtp-Source: AGRyM1uF1dgR9LB8AcfmubAS/fV5ozPDW9988MJGQz4BmDtQ4Q5NIKIyFg1XE1Z997ESXU2WP3xdezmOfB0Liz4c4yk=
X-Received: by 2002:a92:280a:0:b0:2d7:7cdc:8426 with SMTP id
 l10-20020a92280a000000b002d77cdc8426mr2835712ilf.245.1655388629564; Thu, 16
 Jun 2022 07:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220616104541.16289-1-jslaby@suse.cz>
In-Reply-To: <20220616104541.16289-1-jslaby@suse.cz>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 16 Jun 2022 16:09:53 +0200
Message-ID: <CA+icZUW8O-HUSpw-656o6YZOiR2ZiCXjxsJwm2kctT6DHrs=4g@mail.gmail.com>
Subject: Re: [PATCH] kbuild: pass jobserver to cmd_ld_vmlinux.o
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     masahiroy@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 12:45 PM Jiri Slaby <jslaby@suse.cz> wrote:
>
> Until the link-vmlinux.sh split (cf. the commit below), the linker was
> run with jobserver set in MAKEFLAGS. After the split, the command in
> Makefile.vmlinux_o is not prefixed by "+" anymore, so this information
> is lost.
>
> Restore it as linkers working in parallel (esp. the LTO ones) make a use
> of it.
>
> Cc: Sedat Dilek <sedat.dilek@gmail.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Fixes: 5d45950dfbb1 (kbuild: move vmlinux.o link to scripts/Makefile.vmlinux_o)
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Nice catch.
( I have seen some slowdown in my build-time. Will test and report. )

Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>

-Sedat-

> ---
>  scripts/Makefile.vmlinux_o | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
> index 3c97a1564947..d032f625b576 100644
> --- a/scripts/Makefile.vmlinux_o
> +++ b/scripts/Makefile.vmlinux_o
> @@ -65,7 +65,7 @@ define rule_ld_vmlinux.o
>  endef
>
>  vmlinux.o: $(initcalls-lds) $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS) FORCE
> -       $(call if_changed_rule,ld_vmlinux.o)
> +       +$(call if_changed_rule,ld_vmlinux.o)
>
>  targets += vmlinux.o
>
> --
> 2.36.1
>
