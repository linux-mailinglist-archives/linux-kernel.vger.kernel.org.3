Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E89B513EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 00:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353006AbiD1Wsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 18:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353002AbiD1Wsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 18:48:51 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DA76D959
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:45:35 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2f7bb893309so68307447b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkmOscz6Mc+5H3+Udfs/NfG990JbZUB2dYQyp2GJrN4=;
        b=vz7NRauf0EG54juKPujkkZltzo2l0Om4ePkuCtqObvhSgW9DzlI01iuA+iEA87Cnk2
         5UROHJCTf5USpL8Q5U9qYPiMMTNYC6BedG8sZWKavsjbyETCYhOpufuSMx5bNzazCwHz
         2ICG2PszXuo2lNUkraa/BDHrxyaHhUQQCsSB32YVCTLqqVEenn4PDqreNDAdZnIjNocr
         iLg/2Xa1KrqS0oLofQ/xMGYj3VdTF1VNbr4XwVLqtY+W7U2x30S0DSrm+48AQjLahUv2
         COgiq/fC43iEO1o6hiR6VTYCqIcPlbRJ7QpKd2CZsdiToW9Uf+bPTxIKdwBuYuiTcafY
         izrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkmOscz6Mc+5H3+Udfs/NfG990JbZUB2dYQyp2GJrN4=;
        b=jdjJo70v1M7aAa73oo2xidFtqCgRlqKRSo9YX5U8Ppb8ApFXtEjm0O0q4QpUPT7Isi
         gO/xMMCEu1sT4kyztdwWZ96wJPAkJzy7g/5G/hn/x4qnfuj8oeFFxpIYQBXB7l7xALQ4
         fKezwbc268MCrvFhKga6ow+uSe3OMyS4NefcNnUNDtrFheAnVbLwTQGG20WdOwEw1QQk
         ry5f3eJp8/gFlApB3V0m2MhcXvQ1G/wCpi9GGLnrDIwIvi2ZRjNwFttduXEw986UdvD8
         xuKXotLYzGb+4dIeG4SKy+LTAcnUcpsvPnOWCkjgoeGUCHcAQbIexcsPXBv2XaIFwKRB
         UMzw==
X-Gm-Message-State: AOAM531aT+rRW/eEnzoEcBFDn7AeORnvgEbaoc7he2KJnECKCgTPFofN
        O4eo/UJYW7Ie//uW14hKl8JR+ecHChp4+j2gjaVbc6lXi9A=
X-Google-Smtp-Source: ABdhPJzw7XuraGWrI21FSLFrmhDpjLx/u33zjKNE4bsiu3MkHN+XYiH7I2lzcvIBcLkrw+Eb1CwHBmXQ9wAHjKMlL/M=
X-Received: by 2002:a81:1d48:0:b0:2f1:8ebf:25f3 with SMTP id
 d69-20020a811d48000000b002f18ebf25f3mr34394977ywd.118.1651185935049; Thu, 28
 Apr 2022 15:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220401131534.241205-1-chenzhongjin@huawei.com>
In-Reply-To: <20220401131534.241205-1-chenzhongjin@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Apr 2022 00:45:24 +0200
Message-ID: <CACRpkdbxDyasZxNeJXa9-AniTbgrzsuoLcu9CBJmzOLDg3hy5w@mail.gmail.com>
Subject: Re: [PATCH v4] ARM: module: Add all unwind tables when load module
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux@armlinux.org.uk, alexander.sverdlin@nokia.com,
        ardb@kernel.org, nico@fluxnic.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 1, 2022 at 3:16 PM Chen Zhongjin <chenzhongjin@huawei.com> wrote:

> For EABI stack unwinding, when loading .ko module
> the EXIDX sections will be added to a unwind_table list.
>
> However not all EXIDX sections are added because EXIDX
> sections are searched by hardcoded section names.
>
> For functions in other sections such as .ref.text
> or .kprobes.text, gcc generates seprated EXIDX sections
> (such as .ARM.exidx.ref.text or .ARM.exidx.kprobes.text).
>
> These extra EXIDX sections are not loaded, so when unwinding
> functions in these sections, we will failed with:
>
>         unwind: Index not found xxx
>
> To fix that, I refactor the code for searching and adding
> EXIDX sections:
>
> - Check section type to search EXIDX tables (0x70000001)
> instead of strcmp() the hardcoded names. Then find the
> corresponding text sections by their section names.
>
> - Add a unwind_table list in module->arch to save their own
> unwind_table instead of the fixed-lenth array.
>
> - Save .ARM.exidx.init.text section ptr, because it should
> be cleaned after module init.
>
> Now all EXIDX sections of .ko can be added correctly.
>
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>

This looks reasonable to me:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

If no one else comments I would say you should put this
into Russell's patch tracker for consideration.

Yours,
Linus Walleij
