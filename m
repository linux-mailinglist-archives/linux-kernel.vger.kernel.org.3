Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E311951375C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348659AbiD1OzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348639AbiD1OzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:55:07 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A7F5D5E7;
        Thu, 28 Apr 2022 07:51:52 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id d23-20020a17090a115700b001d2bde6c234so5980024pje.1;
        Thu, 28 Apr 2022 07:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u9jjxzFqyEv8LBWVsrZtYT4OxlKeAvkfQsoOT8XO85M=;
        b=Eo9pYlKYZkJpqf31dxcbCDkgVISHZnUiOPR5gJATEANdzGnDNxlo7Yahv5R1ctQee5
         bhsphKUBm5UdIl3TBHZtHHw8KW8AwPkGlZn1OfaZhzn/qjhFAd47hmnNY4VRyJ1kd3km
         UCuuoJEpezzIv4/nWOUTOvsiHjuUq16RoBvyw5pGTRCV2ncKp0ExCyStDmL+GBS5SWFz
         Bz7YgTdAdWJFoOUriJJvEHLbu+XJ9lDNE7fxqKvInyUi5DHD5btdg9Im39MbF9U6EzOR
         o2UIXa2E8oOO9eNFlULEYoj5w6ijpqiTJdTHzG1DUeZmGcAuENmSCNnPkDqW8UG99YXH
         L66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u9jjxzFqyEv8LBWVsrZtYT4OxlKeAvkfQsoOT8XO85M=;
        b=s5SJcOegtitazo+6lT+kPLcMEJbLN7Rf4A69knyB4s2RphQqetV5HDjzXOnreAqvgZ
         WkNlC+eU2/wP0mE4tLZnkpOTjRpjuLLxS7mmmH8vqIK41lHt8i+djwIfJWjLILXpTjuE
         OW706mpgKrFRRja1+p1o6J+jFqykdHAplNNHNFTvC7oQtho/5PD7QQnIwbVxEsfoy4Fn
         wEYiBQsQ3gktOoH/ORUqJOHQu9N2dKaQGzpqbPeScgnlg/0G6aAOenui0SG2nDaW4uEU
         jqg+gJVByeygb+Z0KwpDM/I6h4Bj+11AiKWQXmZsvZ9ilsRx0XU4B/GVonhnO/u2JOnl
         84yA==
X-Gm-Message-State: AOAM530AFm9VA70a+yCWkXSmQApV+Jh4H1NSF9IfLzBmjy1XeudIvS7q
        EGIoHKnWOKc58rliyJXSPuyZ5JPPO/Rn7NkbkzM=
X-Google-Smtp-Source: ABdhPJxIL1GSLaYMCrNZgOMOzrkbrH8EbxUnGtoLQMMClEdi0B+tr5FBUwfsx9F5E/E5vZQrHQaEKf8q8QovbJXGBJM=
X-Received: by 2002:a17:90a:ec0e:b0:1d9:7f4d:23be with SMTP id
 l14-20020a17090aec0e00b001d97f4d23bemr22629798pjy.181.1651157512300; Thu, 28
 Apr 2022 07:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_6A5CCC9FB9221C4A1414E1534A3DFFC62008@qq.com>
In-Reply-To: <tencent_6A5CCC9FB9221C4A1414E1534A3DFFC62008@qq.com>
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Date:   Thu, 28 Apr 2022 08:51:30 -0600
Message-ID: <CAOCk7Np+tVPtSXGzdwHJZqfgVseVKKZ4znThPx_9ApxMOqRZyA@mail.gmail.com>
Subject: Re: [PATCH] iommu/msm: add a check for the return of kzalloc()
To:     xkernel.wang@foxmail.com
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        lkml <linux-kernel@vger.kernel.org>
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

On Fri, Mar 25, 2022 at 2:13 PM <xkernel.wang@foxmail.com> wrote:
>
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
>
> kzalloc() is a memory allocation function which can return NULL when
> some internal memory errors happen. So it is better to check it to
> prevent potential wrong memory access.
>
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  drivers/iommu/msm_iommu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 3a38352..697ad63 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -597,6 +597,10 @@ static void insert_iommu_master(struct device *dev,
>
>         if (list_empty(&(*iommu)->ctx_list)) {
>                 master = kzalloc(sizeof(*master), GFP_ATOMIC);
> +               if (!master) {
> +                       dev_err(dev, "Failed to allocate iommu_master\n");

How do you reconcile this with chapter 14 of the coding style document?

"These generic allocation functions all emit a stack dump on failure when used
without __GFP_NOWARN so there is no use in emitting an additional failure
message when NULL is returned."

> +                       return;
> +               }
>                 master->of_node = dev->of_node;
>                 list_add(&master->list, &(*iommu)->ctx_list);
>                 dev_iommu_priv_set(dev, master);
> --
