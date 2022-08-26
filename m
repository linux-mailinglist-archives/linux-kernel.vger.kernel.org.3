Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950615A2221
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245429AbiHZHns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbiHZHnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:43:46 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7B6C4809
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:43:41 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kk26so1568144ejc.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=F/nfhZc46qE5/TwWod1aI4DtHV3cNbQmnQVOS7KtUiw=;
        b=oYUX+bEJ3UQh33DuSroB74rRtvLbKykp+t2RAxwDLy17IG39SixpC5Od3J6bFsciB9
         L9M6qY6VdiGRtgQ+ffqxDTDMF7lUEKPKr7vINrwUGHEY8re/XIq+N4u42bvu25JqNmnx
         Cmd7mKgbmf3nte+WkudFsZN6VizrJjzc9TgPE4ruvlZgzQQRkRawnESVH58U0GT4fPU0
         tRoOQkDndMYCPPfTQN/Y+XUZbGoqjGCeNAM++5oLIM5+9rSirKi/siCRYLx0utR8a9r/
         mg5AxwuVrD/3PVrOHuB3lC2ua2J3NC5whRotD023zrPibSXyGObsurBGEv8Fi1fiYW+p
         DrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=F/nfhZc46qE5/TwWod1aI4DtHV3cNbQmnQVOS7KtUiw=;
        b=1UgNJPOxFRI3K0UqnbO8UA1KS0q58T8tRsdQtPlywxhX6HG4PTUe7V7R8lQ3XLPFqX
         ZBTDT13U8WtnajZgs4pWLP3KhmhTCSBz/Fsio1MuKgY4ORwKTkVbQTailmVWgIMyZzBu
         bDI5zHVleqDDBA5+aIH+t0md9IAyDpzajd2cXBBh+x3S2JGzLhMaUEVWkBtlXWOEHi4n
         YwSvgNzZlU/niB1r0/OH1S4V9RnFzLjAAxKO1Usq31VNRzPtz4lbSMbemeYauo0/IvCv
         yPSjYZ/wpHnFp48VvPScXHLvvbHD9r2aX5F/vj7tk2cZVu+fQfrPD5i2UZI6OoctfNwp
         YYYg==
X-Gm-Message-State: ACgBeo0cCUd8kn5gJJIOcnOeqNU5/EimK+geDWiJVw5axH6QR+G24gqI
        z0QIjQNv5NKtBN/2reGjk/ZRWw==
X-Google-Smtp-Source: AA6agR4FR1taplTOBaRAf+gwkdsaV73At3Y63T+X4h88m7x9hmzQ6iSyIBQqF/N1LTgXniDa9N5s3g==
X-Received: by 2002:a17:906:8a5b:b0:73d:7975:567e with SMTP id gx27-20020a1709068a5b00b0073d7975567emr4601197ejc.378.1661499820198;
        Fri, 26 Aug 2022 00:43:40 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id es5-20020a056402380500b0043bc4b28464sm852979edb.34.2022.08.26.00.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 00:43:39 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:43:18 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Conor.Dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wangkefeng.wang@huawei.com, Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next v2 1/2] riscv: uaccess: rename
 __get/put_user_nocheck to __get/put_mem_nocheck
Message-ID: <20220826074318.g6nwri5ziiutiio5@kamzik>
References: <20220815032025.2685516-1-tongtiangen@huawei.com>
 <20220815032025.2685516-2-tongtiangen@huawei.com>
 <20220825105600.ezueddmwehob42rf@kamzik>
 <3541c980-7fcf-7047-cec7-3c2ca6381a99@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3541c980-7fcf-7047-cec7-3c2ca6381a99@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 02:33:47PM +0800, Tong Tiangen wrote:
> 
> 
> 在 2022/8/25 18:56, Andrew Jones 写道:
> > On Mon, Aug 15, 2022 at 03:20:24AM +0000, Tong Tiangen wrote:
> > > Current, The helpers __get/put_user_nocheck() is used by get/put_user() and
> > > __get/put_kernel_nofault(), which is not always uaccess, so the name with
> > > *user* is not appropriate.
> > > 
> > > Also rename xxx_user_xxx to xxx_mem_xx  on the call path of
> > > __get/put_user_nocheck()
> > > 
> > > Only refactor code without any functional changes.
> > > 
> > > Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> > > ---
> > >   arch/riscv/include/asm/uaccess.h | 48 ++++++++++++++++----------------
> > >   1 file changed, 24 insertions(+), 24 deletions(-)
> > > 
> > > diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> > > index 855450bed9f5..1370da055b44 100644
> > > --- a/arch/riscv/include/asm/uaccess.h
> > > +++ b/arch/riscv/include/asm/uaccess.h
> > > @@ -50,7 +50,7 @@
> > >    * call.
> > >    */
> > > -#define __get_user_asm(insn, x, ptr, err)			\
> > > +#define __get_mem_asm(insn, x, ptr, err)			\
> > >   do {								\
> > >   	__typeof__(x) __x;					\
> > >   	__asm__ __volatile__ (					\
> > > @@ -64,12 +64,12 @@ do {								\
> > >   } while (0)
> > >   #ifdef CONFIG_64BIT
> > > -#define __get_user_8(x, ptr, err) \
> > > -	__get_user_asm("ld", x, ptr, err)
> > > +#define __get_mem_8(x, ptr, err) \
> > > +	__get_mem_asm("ld", x, ptr, err)
> > >   #else /* !CONFIG_64BIT */
> > > -#define __get_user_8(x, ptr, err)				\
> > > +#define __get_mem_8(x, ptr, err)				\
> > >   do {								\
> > > -	u32 __user *__ptr = (u32 __user *)(ptr);		\
> > > +	u32 *__ptr = (u32 *)(ptr);				\
> > 
> > Doesn't casting away __user reduce sparse's utility?
> 
> From the call logic[1], the address passed into this macro is not
> necessarily __user. I understand that no problem will be introduced for
> sparse's utility.
> 
> In addition, there is no need to do a pointer conversion here, will be fixed
> next version.
> 
> [1] __get_kernel_nofault -> __get_mem_nocheck -> __get_mem_8

Yes, I understood that. My concern was for the times that the address was
__user as we'd no longer get that check for them.

Thanks,
drew
