Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF2E53D6F5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 15:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347483AbiFDNMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 09:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347023AbiFDNL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 09:11:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CAB3AB;
        Sat,  4 Jun 2022 06:11:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A32A9B80171;
        Sat,  4 Jun 2022 13:11:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70099C36AE2;
        Sat,  4 Jun 2022 13:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654348314;
        bh=LigdOMTiHU3JDXFoM3FYPWJ+NL2sB0dXjxk5b2cv4K0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HzqQlSUxQbpKcoQlGjyaiU7sKZUSmKiO7KqjdDFu7oUA8K0R+3hiuL6MMoUuuk8/F
         0ThbEFLH80drR0uSZTltIbNjH3D9mLsiMK/Q9MKV74Ou4fhRDXi+ZAgR9H6TQiyL+o
         4SUyW2lqg9yVLNnVsyX6wubN4qDopeabXx6cm60C14J6l7wlsJdh6657Xf8YUHAvjz
         CjrkaVAIPCczwRYosz0ARYCH6MRb3kUfexwcUxyC2vW7+E2R7Old3DlUMXaUh+/wvV
         5C3SaueY1Ia2qGb9P0r/sJ50JFgq3XLIa/ZFUDYegOgaum0zopF6SvnbbqxxndXLQT
         23v/fDIUeMqAQ==
Received: by mail-il1-f174.google.com with SMTP id u2so8237885iln.2;
        Sat, 04 Jun 2022 06:11:54 -0700 (PDT)
X-Gm-Message-State: AOAM533ZyP4STw7F0IpFIwkpAkwh1HuBL+S/NLjz70FBeXFm29w0tYyZ
        Xjr2V1JeBzv91X0hlQyXzLr8BlmtEzpnFekIRgk=
X-Google-Smtp-Source: ABdhPJxUEf+MMefg9IiUMQhY92XfBtlnMp/f5td6s1NaICWD0XhC31UFdHFnXRGex9ZTTi4ra7SinOJIonay9rX4K38=
X-Received: by 2002:a05:6e02:12b4:b0:2d3:a822:3a16 with SMTP id
 f20-20020a056e0212b400b002d3a8223a16mr8187552ilr.279.1654348313547; Sat, 04
 Jun 2022 06:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220604124052.1550-1-jiaxun.yang@flygoat.com> <20220604124052.1550-2-jiaxun.yang@flygoat.com>
In-Reply-To: <20220604124052.1550-2-jiaxun.yang@flygoat.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 4 Jun 2022 21:11:34 +0800
X-Gmail-Original-Message-ID: <CAAhV-H42rRE5w2qThfO3fEa8PZVfRQp-mzUqw8pWx1x2JYo9Pw@mail.gmail.com>
Message-ID: <CAAhV-H42rRE5w2qThfO3fEa8PZVfRQp-mzUqw8pWx1x2JYo9Pw@mail.gmail.com>
Subject: Re: [PATCH for-5.19 2/2] loongarch: Mask out higher bits for get_csr_cpuid
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, Marc Zyngier <maz@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jiaxun,

On Sat, Jun 4, 2022 at 8:41 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> Only low 9 bits of CPUID CSR represents coreid, higher bits
> are marked as reserved. In case Loongson may define higher
> bits in future, just mask them out for get_csr_cpuid.
I think we needn't to modify, until the high bits actually get defined. :)

Huacai

>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/loongarch/include/asm/loongarch.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
> index 3ba4f7e87cd2..7f3933f747f9 100644
> --- a/arch/loongarch/include/asm/loongarch.h
> +++ b/arch/loongarch/include/asm/loongarch.h
> @@ -1200,7 +1200,7 @@ static inline u64 drdtime(void)
>
>  static inline unsigned int get_csr_cpuid(void)
>  {
> -       return csr_read32(LOONGARCH_CSR_CPUID);
> +       return csr_read32(LOONGARCH_CSR_CPUID) & CSR_CPUID_COREID;
>  }
>
>  static inline void csr_any_send(unsigned int addr, unsigned int data,
> --
> 2.25.1
>
