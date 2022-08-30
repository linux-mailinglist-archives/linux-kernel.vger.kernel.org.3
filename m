Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903E95A59A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 04:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiH3C7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 22:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiH3C7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 22:59:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F131A0255
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 19:59:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5C85B8161C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B08C433B5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661828366;
        bh=uNIKNr+2DaG/P9DNzldoJcM41XPNHC67GNm04zL0qLI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=girHF86FaR/pUzoshF74IByQy8jMI/3lxYidsT4GJ9bd+/NzkDCNAzotYp6YaGHq6
         y4UPVnxQfe3oT9j5qpOChZbtj202oCql/zbxX+WkbwMqkB8jPh5sIZJz3ikLKeHwNx
         QDwN3b+gYEWYXRBYoBIFgjL66/xTi8XGxaRpp6SWPUg8foLODge7xN9KeRWH73zH3Z
         R2vFNAnZL6JSJivLHZDlnwhVRAsUt7VhOJaNFS8qW1Rd4QelBaAo8VjpuDaqd6X1gB
         UXfg6WZrRMjyvmj8TrgcEeovMldKo84HV4NEej9Qp+lI2rQGSPKJO3QW33Pi7tpSBQ
         xCVu4K7tavUPg==
Received: by mail-vs1-f43.google.com with SMTP id f185so5413547vsc.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 19:59:26 -0700 (PDT)
X-Gm-Message-State: ACgBeo2i4GKOy8GQ090fVCkw6V6GXQcykPfOAUDuZgiub9GSMOHRYqVe
        v+YJt8+jnWka+a1cxFcrGjbi2g+9Xarq3DHSi34=
X-Google-Smtp-Source: AA6agR5aa/+9fmI3UgDnKHulj5t7CkvEMKPngTIGKKs0aVLZtV0W3TCDW2/1f9SUhmQmHA6rfXzeuos28fOOFXBtK+E=
X-Received: by 2002:a05:6102:390d:b0:387:78b9:bf9c with SMTP id
 e13-20020a056102390d00b0038778b9bf9cmr4426414vsu.43.1661828365502; Mon, 29
 Aug 2022 19:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <1661827800-8463-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1661827800-8463-1-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 30 Aug 2022 10:59:14 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7zLOm-=vnKkOW8E8TNOr79GGJ1kP0nH8_1Ksh1MxTesw@mail.gmail.com>
Message-ID: <CAAhV-H7zLOm-=vnKkOW8E8TNOr79GGJ1kP0nH8_1Ksh1MxTesw@mail.gmail.com>
Subject: Re: [PATCH v2] checksyscalls: Ignore fstat to silence build warning
 on LoongArch
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>, Arnd Bergmann <arnd@arndb.de>,
        loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
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

Hi, Tiezhu,

On Tue, Aug 30, 2022 at 10:50 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> fstat is replaced by statx on the new architecture, so an exception
> is added to the checksyscalls script to silence the following build
> warning on LoongArch:
>
>   CALL    scripts/checksyscalls.sh
> <stdin>:569:2: warning: #warning syscall fstat not implemented [-Wcpp]
>
> Suggested-by: WANG Xuerui <kernel@xen0n.name>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>
> Hi Xuerui and Arnd,
>
> Thank you for your reviews and suggestions.
>
> v2:
>   -- Change scripts/checksyscalls.sh
>   -- Modify patch subject and commit message
>
>  scripts/checksyscalls.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
> index f33e61a..c0a093c 100755
> --- a/scripts/checksyscalls.sh
> +++ b/scripts/checksyscalls.sh
> @@ -114,7 +114,6 @@ cat << EOF
>  #define __IGNORE_truncate
>  #define __IGNORE_stat
>  #define __IGNORE_lstat
> -#define __IGNORE_fstat
>  #define __IGNORE_fcntl
>  #define __IGNORE_fadvise64
>  #define __IGNORE_newfstatat
> @@ -253,6 +252,7 @@ cat << EOF
>  #define __IGNORE_vserver
>
>  /* 64-bit ports never needed these, and new 32-bit ports can use statx */
I think the comment here should be modified to reflect the new fact,
and I think all syscalls controlled by __ARCH_WANT_NEW_STAT should be
listed.

Huacai

> +#define __IGNORE_fstat
>  #define __IGNORE_fstat64
>  #define __IGNORE_fstatat64
>  EOF
> --
> 2.1.0
>
>
