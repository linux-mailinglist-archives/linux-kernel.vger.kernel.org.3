Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0094B537006
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 08:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiE2GdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 02:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiE2GdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 02:33:12 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA44E939EC;
        Sat, 28 May 2022 23:33:10 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id t144so10490774oie.7;
        Sat, 28 May 2022 23:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wCcFMFR31NBokalaM7jIaRNzVLN7MLT7I/IimszoCVU=;
        b=Xs5+4zNHWV1wHaqtc329Ptc1CPSkfOiOFmq5USV/njSzqoi0sPjOUPKFhOEHAKqAdf
         IQGb534cZm1ZR9Z68THwySAXMM2m5hUfU40tnEeNK+VcI9jOv/s4RfBxF99ZFyhiGxva
         0mkdtVdbD+LzRakApD8IhCN4/yrrySQFSU4Yl3dDcvKb2JUwHZg8hK9ZavCWGjKc1Ibu
         R3O9wEjsmIrFIlDkvmvgxPSZbCeBoqYhPT+8kPVP81yvXLHwGQrrmPL48xct+NWwyJ2C
         iDFF3ZpMo2mnjZB+r3SSV1xQQBT7iJjx1ONGOMYV5zm3j0sBiTYieQBC6jIxws6KWeTn
         3veg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wCcFMFR31NBokalaM7jIaRNzVLN7MLT7I/IimszoCVU=;
        b=BY93TkJnXk8qbKktRil0Tv6VXRDOzUsr5jO+JFKnqjWLXXkpA9Dv/yXURvgqlloBuP
         HDypyQcOmD9398b/oeNZ2YOeFD/XxNyChGkI+4iv+/rwViwrym9exrc6iPyiyg+ltpAQ
         r9DkG1rMXgYTUao96jheosgogBS2PP5xNCYqMVnGa7RRHOZqHZyXaG4E3H3AFPdFxLlg
         ypiN85oGxgcp7W6DXP9nD2U0Syl+wuD7JZloeOTpmBfcVfUoOz/EPsiWeuxvIvr/cHWa
         J+weV7eVeqp0VUGDWADwY7SVs16RKwmrutn6taybatqWvBYUCPEmrjn9zsmqSw/fiLya
         akrw==
X-Gm-Message-State: AOAM533xd+roLi/ILkyqwMFiHnNokF1UxADiTkC0idyiQguPdIFObi8w
        2n339jSLFnU35jm+qe8VlR4=
X-Google-Smtp-Source: ABdhPJwtskMurg5hTIh9/T1r1LMa/L2/1CeRajTfPhgZnOmqelUXvhQw4A1L8IYCxSqz/d0u6yIV7A==
X-Received: by 2002:a05:6808:344:b0:32a:f6d8:82cc with SMTP id j4-20020a056808034400b0032af6d882ccmr7477989oie.200.1653805990222;
        Sat, 28 May 2022 23:33:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w62-20020a9d3644000000b0060603221276sm3646163otb.70.2022.05.28.23.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 May 2022 23:33:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5bcf1c62-80ac-4523-6e2f-b4b788909a26@roeck-us.net>
Date:   Sat, 28 May 2022 23:33:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] kbuild: ignore *.cmd files for objects that come from
 libgcc.a
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-csky@vger.kernel.org
References: <20220529042318.2630379-1-masahiroy@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220529042318.2630379-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/22 21:23, Masahiro Yamada wrote:
> Guenter Roeck reported the build breakage for parisc and csky.
> I confirmed nios2 and openrisc are broken as well.
> 
> The reason is that they borrow libgcc.a from the toolchains.
> 
> For example, see this line in arch/parisc/Makefile:
> 
>      LIBGCC          := $(shell $(CC) -print-libgcc-file-name)
> 
> Some objects in libgcc.a are linked to vmlinux.o, but they do not have
> .*.cmd files.
> 
> Obviously, there is no EXPORT_SYMBOL in external objects. Ignore them.
> 
> (Most of the architectures import library code into the kernel tree.
> Perhaps those 4 architectures can do similar, but I am not sure.)
> 
> Fixes: f292d875d0dc ("modpost: extract symbol versions from *.cmd files")
> Link: https://lore.kernel.org/linux-kbuild/20220528224745.GA2501857@roeck-us.net/T/#mac65c20c71c3e272db0350ecfba53fcd8905b0a0
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
>   scripts/link-vmlinux.sh | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index a7f6196c7e41..68e4be463a76 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -344,9 +344,16 @@ ${MAKE} -f "${srctree}/scripts/Makefile.build" obj=init need-builtin=1
>   modpost_link vmlinux.o
>   objtool_link vmlinux.o
>   
> -# Generate the list of objects in vmlinux
> +# Generate the list of in-tree objects in vmlinux
> +#
> +# This is used to retrieve symbol versions generated by genksyms.
>   for f in ${KBUILD_VMLINUX_OBJS} ${KBUILD_VMLINUX_LIBS}; do
>   	case ${f} in
> +	*libgcc.a)
> +		# Some architectures do '$(CC) --print-libgcc-file-name' to
> +		# borrow libgcc.a from the toolchain.
> +		# There is no EXPORT_SYMBOL in external objects. Ignore this.
> +		;;
>   	*.a)
>   		${AR} t ${f} ;;
>   	*)

