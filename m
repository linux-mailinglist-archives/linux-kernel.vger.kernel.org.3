Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C11515B44
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 10:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351175AbiD3IFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 04:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbiD3IF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 04:05:28 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB043FDAB;
        Sat, 30 Apr 2022 01:02:07 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id p10so17578436lfa.12;
        Sat, 30 Apr 2022 01:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sizE2uAhLOdIpK4PYIm9/SX9qwFF46VOJ/Mu1QH+sAU=;
        b=ivqPOtuhIWK5Luzjj5fIuFopqP7WsOxEBI7gsiEuZQ02HuFwpSEOI2sxwa+vu/S4IY
         ekd3Nd05oSFqbjFLpgPdWEBHgd077JQYfv1wcfzzHr3ElLlq1tFlr2S5jaLBfvkOaQQ0
         R+EUDKaICfwZzH5JBW80/r95jZTrzTtvhzrdZawYdBUnRtsF8trOm6s6FatXRnu1FyYQ
         JNIDQR5Tu/9OUlNO6dnk4H9HMc5VEBIiPT2GcA6AQcs6drF2QTQkkXLfvM8fQ9piDTBb
         gomzblUosUUWxKciRI7WiGC2m676o5pO3Q0brvazd922eai8KIfZ1RPxKb/bvLSpjyQY
         DHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sizE2uAhLOdIpK4PYIm9/SX9qwFF46VOJ/Mu1QH+sAU=;
        b=JUf24l73lzAYEAGDDKVV093md+xlOPSI4tIVDc1xQgt85SHteuP6Pl7IXyehbKFrKF
         HJXHHJOeczWVo5Xbe6hEjKucU/RK+MB+QKaZpidYF2/8yxFjWqb7cqEJOKbVySIPe+O2
         SDkBukNZT73WjUfUl99W5A6+oVL9JZf0mIwVrxJjnYit5XI11bnXYNmWpQ8z+XOoQa6f
         qojm5mwKuKf4b2+wy6OqBUsS4/boWx4pV1imJMWU92dnwyqPD065qqZFLwJC2pfsyW7A
         74p3GvbAO8EtX8PRY+vFt2l8iNtPXuP4z5e+vFECHQSG972uTlxXwFgf9kavRy0v4yIq
         cF/g==
X-Gm-Message-State: AOAM531vAhxd/dErrl6Fv0M1d4kzeLLsqqHMRPEIbpAi3NKcPgcI6ITy
        i+NFArvQG0El/IJChqdZDUFQw6TMl16zoreTuZsHQKt7
X-Google-Smtp-Source: ABdhPJz8v4NabgEUNKzFO+vw4AKDefEwMDouG1OfJRZ7v8qVlPUJp7vJxfJA8odNiUpbyixbB2cmhiuOxzIPjDA9o3g=
X-Received: by 2002:ac2:51a1:0:b0:472:154:4065 with SMTP id
 f1-20020ac251a1000000b0047201544065mr2251303lfk.590.1651305725701; Sat, 30
 Apr 2022 01:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220428154138.257250-1-zhangxuezhi1@coolpad.com>
In-Reply-To: <20220428154138.257250-1-zhangxuezhi1@coolpad.com>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Sat, 30 Apr 2022 18:01:53 +1000
Message-ID: <CAGRGNgX=oVxEhwvubLVC7=j-Tfgg3nyMBEObD0XjGbu2WDXBaA@mail.gmail.com>
Subject: Re: [PATCH v2] scsi: pmcraid: convert sysfs snprintf to sysfs_emit
To:     Xuezhi Zhang <zhangxuezhi1@coolpad.com>
Cc:     "James E. J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xuezhi,

On Sat, Apr 30, 2022 at 2:18 PM Xuezhi Zhang <zhangxuezhi1@coolpad.com> wrote:
>
> Fix the following coccicheck warnings:
> drivers/scsi/pmcraid.c:3591:8-16:
> WARNING: use scnprintf or sprintf
> drivers/scsi/pmcraid.c:3557:8-16:
> WARNING: use scnprintf or sprintf
> drivers/scsi/pmcraid.c:3496:8-16:
> WARNING: use scnprintf or sprintf
>
> Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
> ---
> v2: fix the sysfs_emt error.
> ---
>  arch/arm64/configs/defconfig | 4 ++++
>  drivers/scsi/pmcraid.c       | 8 +++-----
>  2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 476c5a9488d0..8688ed761cfd 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1295,3 +1295,7 @@ CONFIG_DEBUG_KERNEL=y
>  # CONFIG_DEBUG_PREEMPT is not set
>  # CONFIG_FTRACE is not set
>  CONFIG_MEMTEST=y
> +CONFIG_UEVENT_HELPER=y
> +CONFIG_UEVENT_HELPER_PATH="/sbin/mdev"
> +CONFIG_INITRAMFS_SOURCE="_install_arm64"
> +

Did you mean to include this change?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
