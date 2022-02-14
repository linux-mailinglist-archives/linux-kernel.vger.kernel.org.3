Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F364B5E6D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 00:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiBNXti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 18:49:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiBNXth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 18:49:37 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C176D14031
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:49:28 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id t4-20020a17090a510400b001b8c4a6cd5dso595854pjh.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=GyZGTEHBo5D8EwjhOvRtD6BQCez2VkVTZwNRgtd0HSU=;
        b=UcNIqbaZcuM1KdO7qywwCle4/8NkbBx5t2AanIGbHhjHDZ4WxbVVpgVg08PbhrIw0V
         PkOwB5yKDjJexBEajf6reo1lb2Im/CvZFMLHMxqL/kFmMi1iCCHKxOXuwThQ7zESPvRL
         x0LYJGtpL3q9TKFJPLVjugGSIh8DSTRZJOfx4Etv3jpoQ2yFhw5s9xJKItJu1ktlTbbq
         KfeuK/wM0xNqeHq8fwtfL+J+dB1lHqKuzJWziUbmgIESW5aA8ebYcGBlsDlWVWXCdhev
         swdBxfHBWE01KGP+heyDM/SpPmX7bi+m4h5iiCO/Zf53sqbBqeMxU7htZcCKvMmXJtC8
         Ki8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=GyZGTEHBo5D8EwjhOvRtD6BQCez2VkVTZwNRgtd0HSU=;
        b=4SUDiTqwiux1Jnwm+ol/k4dbJOfM7vVX6qAua8jAOOx8DubQC9/AfLPH5eG+o0JEcr
         5IRb0i7o4oPszQKEmjUnMdA5EDVSXgINxvxvDSHH7vnd1TtVesV4G9XnJNldt3ufEZX0
         OUARZtp5Hc56BpSyG0IBm1eOXvFxDvO8KQCLa9QH6R26TL/hg3xeytAQjzZ+iK7Twr+F
         HmJLpn6U7006Ub+Olrb0dKV1DmIT3s7nV1XV5V2xqacn+QpBBrmrJ4Nffb3qJy1xfKvl
         O5+kmKdo0/wxCi3eR4RbNeReK6/ElWu2aYIsvfsmyrHrSaeQ+0g0EFpOovaEERr3PjFf
         NDGQ==
X-Gm-Message-State: AOAM533Elg1/femQmKRA4gA9YSdlVzUv2lHewPnaBOfGPfJnjwGoJmxQ
        izFqOczF0YeIwqXxkqhONRTijA==
X-Google-Smtp-Source: ABdhPJygPmJsBkq1gCtMbrwH0RAghVDJYLeuiOyFXUMDyKnMeZaO9UltK2YmW94SrCJ+nJTsXF2gYg==
X-Received: by 2002:a17:902:d3c6:: with SMTP id w6mr1405267plb.4.1644882568233;
        Mon, 14 Feb 2022 15:49:28 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id l22sm39388785pfc.191.2022.02.14.15.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 15:49:27 -0800 (PST)
Date:   Mon, 14 Feb 2022 15:49:27 -0800 (PST)
X-Google-Original-Date: Mon, 14 Feb 2022 15:49:02 PST (-0800)
Subject:     Re: [PATCH] riscv: mm: init: mark satp_mode __ro_after_init
In-Reply-To: <20220125160012.3884-1-jszhang@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang@kernel.org
Message-ID: <mhng-dc214a08-e4be-4459-a9e4-347ec084d02b@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 08:00:12 PST (-0800), jszhang@kernel.org wrote:
> satp_mode is never modified after init, so it can be marked as
> __ro_after_init.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/mm/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 8347d0fda8cd..35586688a1b6 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -38,9 +38,9 @@ EXPORT_SYMBOL(kernel_map);
>  #endif
>
>  #ifdef CONFIG_64BIT
> -u64 satp_mode = !IS_ENABLED(CONFIG_XIP_KERNEL) ? SATP_MODE_48 : SATP_MODE_39;
> +u64 satp_mode __ro_after_init = !IS_ENABLED(CONFIG_XIP_KERNEL) ? SATP_MODE_48 : SATP_MODE_39;
>  #else
> -u64 satp_mode = SATP_MODE_32;
> +u64 satp_mode __ro_after_init = SATP_MODE_32;
>  #endif
>  EXPORT_SYMBOL(satp_mode);

Thanks, this is on for-next.
