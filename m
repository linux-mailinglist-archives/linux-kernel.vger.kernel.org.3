Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8692563C28
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 00:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiGAWFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 18:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbiGAWFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 18:05:18 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC1C5C9CA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 15:05:17 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x3so6014663lfd.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 15:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=26m3QrqDOEetx8CkGkMNVENfZC6JApBC8b4D3WMfsqY=;
        b=PHG7MYwuMLYjj6+14AcnjpSzpFo5v7V6cjn2MuZ887lLw24RKH8Av0rnK3qntWEsWq
         P/DkZdiv3ZI+1US/j7Zn+xQbLqMQm4kJ4aopjXaHZQPzo76ycGzdyL0IQpaPf+3GLaDi
         qtA7fciGyvzv9jLr4ocVSBm0OmY14IFNAD5tSL7aqyDR8+5toM/8Re3hTkIeNGnG7L/B
         Ipv9Zuvxn6AYdzlfwzPftqUvsU5PaFXAF64C2bvQjpYeTMPB0KcnkJJCp2eS0ucTjIts
         9HQUoXe2BtbWiQ0p5bhqebbzpF1jAsnMsMwcGcd4Yf+jXaSGLoQHUVcEnjNpnHAZ54lb
         Mn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=26m3QrqDOEetx8CkGkMNVENfZC6JApBC8b4D3WMfsqY=;
        b=WmNKTXxlgFx+XfZ4fr8GG+YMwR9jfU6xTJNJ4b2k0aWpoX3Q/WuT6sk2U8oOrawix9
         HDr9lkuIzw/XwZkz2Hr9tyUO1AdNnjQmAf2MfRqu5xDf/4D13JK3c4NYWF/V2Xannsx0
         HybZQ2jYRCVhl0ZnA+F5tuUijJrpQsNo9mDEaJFqpkBcQMP7/GDb0hHA+Qyjl/uZTiNG
         HYER/QWs+ixQnOCZgwPFmx6rYbyoWLvSCt9IVNwTtyaanfflohDZBjuK2hZCSIzZKiPf
         nuwNukfc68CZerWfrFBMaNOszNm+QG/7LIChsVO9ErtKu4Xzwu3jGXJYFxqbVnUQFyy4
         zIRw==
X-Gm-Message-State: AJIora/Wez2Wd/cXM6v9E5kofhpZssyduEvgTjLH0TMcYjh1+NytmJMO
        fhipTBB10iBmkm656MDgL5xMUe2qjHlJFeJNxrPJhQ==
X-Google-Smtp-Source: AGRyM1sk/RELW5TrL/N4TtgXDUTQaosHEdmojIwAlf799F2Uauf6sAJCI6KQBsdsb6ppiSECv5V0YqEKpAtb2jETcaA=
X-Received: by 2002:ac2:4d22:0:b0:47f:65b5:35ec with SMTP id
 h2-20020ac24d22000000b0047f65b535ecmr10770649lfk.432.1656713115906; Fri, 01
 Jul 2022 15:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220316213118.2352683-1-morbo@google.com> <20220321174912.164113-1-morbo@google.com>
 <Ypp3MA9s01bWrm2i@penguin>
In-Reply-To: <Ypp3MA9s01bWrm2i@penguin>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 1 Jul 2022 15:05:03 -0700
Message-ID: <CAKwvOdnwCVFpMgOih4bf1RAzb6n0Q0+AqaHZxGfnafT+XzAL4A@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: smem: use correct format characters
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Bill Wendling <morbo@google.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Justin Stitt <jstitt007@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,
Would you be able to merge this patch through the arm-soc tree? The
maintainers appear to be MIA here.
https://lore.kernel.org/lkml/20220321174912.164113-1-morbo@google.com/

On Fri, Jun 3, 2022 at 2:03 PM Justin Stitt <jstitt007@gmail.com> wrote:
>
> On Mon, Mar 21, 2022 at 10:49:12AM -0700, Bill Wendling wrote:
> > When compiling with -Wformat, clang emits the following warnings:
> >
> > drivers/soc/qcom/smem.c:847:41: warning: format specifies type 'unsigned
> > short' but the argument has type 'unsigned int' [-Wformat]
> >                         dev_err(smem->dev, "bad host %hu\n", remote_host);
> >                                                      ~~~     ^~~~~~~~~~~
> >                                                      %u
> > ./include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
> >         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
> >                                                                ~~~     ^~~~~~~~~~~
> > ./include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
> >                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
> >                              ~~~    ^~~~~~~~~~~
> > drivers/soc/qcom/smem.c:852:47: warning: format specifies type 'unsigned
> > short' but the argument has type 'unsigned int' [-Wformat]
> >                         dev_err(smem->dev, "duplicate host %hu\n", remote_host);
> >                                                            ~~~     ^~~~~~~~~~~
> >                                                            %u
> > ./include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
> >         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
> >                                                                ~~~     ^~~~~~~~~~~
> > ./include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
> >                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
> >                              ~~~    ^~~~~~~~~~~
> >
> > The types of these arguments are unconditionally defined, so this patch
> > updates the format character to the correct one and change type of
> > remote_host to "u16" to match with other types.
> >
>
> This patch LGTM and fixes -Wformat warning.
>
> Tested-by: Justin Stitt <jstitt007@gmail.com>
> Reviewed-by: Justin Stitt <jstitt007@gmail.com>
>
> > Link: https://github.com/ClangBuiltLinux/linux/issues/378
> > Signed-off-by: Bill Wendling <morbo@google.com>
> > ---
> >  drivers/soc/qcom/smem.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> > index e2057d8f1eff..9dd325df5682 100644
> > --- a/drivers/soc/qcom/smem.c
> > +++ b/drivers/soc/qcom/smem.c
> > @@ -819,7 +819,7 @@ qcom_smem_enumerate_partitions(struct qcom_smem *smem, u16 local_host)
> >       struct smem_partition_header *header;
> >       struct smem_ptable_entry *entry;
> >       struct smem_ptable *ptable;
> > -     unsigned int remote_host;
> > +     u16 remote_host;
> >       u16 host0, host1;
> >       int i;
> >
> > @@ -844,12 +844,12 @@ qcom_smem_enumerate_partitions(struct qcom_smem *smem, u16 local_host)
> >                       continue;
> >
> >               if (remote_host >= SMEM_HOST_COUNT) {
> > -                     dev_err(smem->dev, "bad host %hu\n", remote_host);
> > +                     dev_err(smem->dev, "bad host %u\n", remote_host);
> >                       return -EINVAL;
> >               }
> >
> >               if (smem->partitions[remote_host]) {
> > -                     dev_err(smem->dev, "duplicate host %hu\n", remote_host);
> > +                     dev_err(smem->dev, "duplicate host %u\n", remote_host);
> >                       return -EINVAL;
> >               }
> >
> > --
> > 2.35.1.894.gb6a874cedc-goog
> >
> >
>


-- 
Thanks,
~Nick Desaulniers
