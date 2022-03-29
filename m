Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2CB4EA91B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbiC2IY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbiC2IYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:24:22 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742A5986F1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 01:22:39 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id s11so15213193pfu.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 01:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=u+eOiR/JQGj21WH/g/6/ThX1ZxYwYrc08hxhIyZJdXw=;
        b=do8wrfbyUYPlF15QBTTaREmSpP6vTRJgsYPGDwNovTThFdcraXgHXhwuE2i55wYGkq
         x5DRkt/cIVY5f9pASZvp7SrOPBnk+C0GcEC8eiqJ7S6v43n4DaEiDJAavYMQfelINO0s
         3uE9LQ45q28F0mY3ezOhg7cDfQ0+Bx3yERur+R+ek7zpMbaFs38Rw3N+RPFRMYreUTSa
         9nRICKCV1ewJd4GFZdOOCrirGOKqnuxQE/+fr6tbFb0yZLjMFuetmOzIN1gFCkto1/q/
         O1s5ETecjelfbM5E1Z77X7jxxi+kZwRD8OZy/8HPz/2JRs69uWaFFofNpjwGBnS79e9L
         RXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=u+eOiR/JQGj21WH/g/6/ThX1ZxYwYrc08hxhIyZJdXw=;
        b=rzThZ00WWDV2hcCXbqamtP6rVx0vylBteTfrEf81lolD+NoUythQqsU5NG2ZuloAej
         sKl87hbP+Klr+MVSzKZbbCNpvDrzX/O4ZCJpXaTF4PCa4T9+HXPn7A1lWux2sLvU0Jir
         1iaDPQk6uE7CR8eyJeKwSGbqGN9AvE4Ydae6vAJYlh01cRAfu9WJ/m5eg9M2Y8IjJKuH
         4fdFvXqcTVSSyh+R8r4shn0XhFDYzzgDcXhp+eImLUNLJFZUMZKX8qQlelXwZc6XA4FS
         lnJOV5sP+9R+KmMuVV+VvGW8U2EnO1BLNZmzLBqKqqro+x8eamtwM7b/hc3kIKX6Dw5N
         kNcw==
X-Gm-Message-State: AOAM532MSwmGfB7yjWIbEhPfMZFjXuisNhRuD+i92S5D7h7MKic1lDmf
        8ecaVMCcWHa79jmMYLdszzw=
X-Google-Smtp-Source: ABdhPJwHEY8IZNGIbEt08JmgXbNuNgvYuXk6DC6Cg5y9CY0T2RgfV1IjinLIYrKIM8PHMCXXTXVnrQ==
X-Received: by 2002:a05:6a00:1c9e:b0:4fa:d946:378b with SMTP id y30-20020a056a001c9e00b004fad946378bmr27137436pfw.46.1648542158916;
        Tue, 29 Mar 2022 01:22:38 -0700 (PDT)
Received: from localhost (58-6-255-110.tpgi.com.au. [58.6.255.110])
        by smtp.gmail.com with ESMTPSA id v22-20020a17090ad59600b001b7deb42251sm1879863pju.15.2022.03.29.01.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 01:22:38 -0700 (PDT)
Date:   Tue, 29 Mar 2022 18:22:28 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/64: Fix build failure with allyesconfig in
 book3s_64_entry.S
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <89cf27bf43ee07a0b2879b9e8e2f5cd6386a3645.1648366338.git.christophe.leroy@csgroup.eu>
In-Reply-To: <89cf27bf43ee07a0b2879b9e8e2f5cd6386a3645.1648366338.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1648542114.vy2hyu1uzt.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of March 27, 2022 5:32 pm:
> Using conditional branches between two files is hasardous,
> they may get linked to far from each other.
>=20
> 	arch/powerpc/kvm/book3s_64_entry.o:(.text+0x3ec): relocation truncated
> 	to fit: R_PPC64_REL14 (stub) against symbol `system_reset_common'
> 	defined in .text section in arch/powerpc/kernel/head_64.o
>=20
> Reorganise the code to use non conditional branches.

Thanks for the fix, I agree this is better.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>=20
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Fixes: 89d35b239101 ("KVM: PPC: Book3S HV P9: Implement the rest of the P=
9 path in C")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kvm/book3s_64_entry.S | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_entry.S b/arch/powerpc/kvm/book3s=
_64_entry.S
> index 05e003eb5d90..99fa36df36fa 100644
> --- a/arch/powerpc/kvm/book3s_64_entry.S
> +++ b/arch/powerpc/kvm/book3s_64_entry.S
> @@ -414,10 +414,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_DAWR1)
>  	 */
>  	ld	r10,HSTATE_SCRATCH0(r13)
>  	cmpwi	r10,BOOK3S_INTERRUPT_MACHINE_CHECK
> -	beq	machine_check_common
> +	beq	1f
> =20
>  	cmpwi	r10,BOOK3S_INTERRUPT_SYSTEM_RESET
> -	beq	system_reset_common
> +	bne	.
> =20
> -	b	.
> +	b	system_reset_common
> +1:	b	machine_check_common
>  #endif
> --=20
> 2.35.1
>=20
>=20
