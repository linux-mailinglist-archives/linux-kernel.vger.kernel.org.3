Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56894B63C5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 07:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbiBOGuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 01:50:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiBOGuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:50:01 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC3C13DD7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 22:49:52 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id l19so27518614pfu.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 22:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xxNE0TFx978UWTdZuF/X+Zjl/Zu9B/EL8TKg3OsvIYY=;
        b=TwRuwjv5NQx8hyoVuJc3q1UScxc4G6geUNNju6BBx3rxlr507gzM3/q+3cJRq7JbJL
         rQBa6ZMNFUY8R7ThS0GDaHZLiKeE3VSgPJqaRafTxyZF/RO5UsHOyPBZpfq9fyWkrN1X
         TQLns8TdWSW2uSYd5VdU8i+qeitKzOPpW4/AHK5wSG1zkHTuK+MaEFvV89tIE45FHH/I
         XNlNoDy2raD6uycXHzuYtzbAnAbiDV/kzVCyGijRuA8c8YATKYrLr9fPpjGkIp1Pf71K
         XNRqZxKfp/ges7iowGzN6LieEiYIUjEn/VhGBFPp/+vzqQ7DRPA4RYtB7mxTDBZLgIp0
         V7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xxNE0TFx978UWTdZuF/X+Zjl/Zu9B/EL8TKg3OsvIYY=;
        b=7c/zk/yyPwkp1pw/6yQQ7N0QDJq5u1a2CsqM9LvWq0cAnl1+v/4gwuj6lxxC8BsMWS
         icxg2gggW6UOXrqctfyyjuU095xg5/R5G2MWL8ZrAXIMJXD5fvDmk7V34VjwGU8ExVcZ
         SmlOPJ3l5b9yA361snV1GE0bfTT/FOnJxnK+GHnjwHQgwilQtzduE58q7Nhps1p3921G
         Uwtu8VIfmvZZBhOkpj3E/nIWCBGabvqADb0LKtDnMq+AepU1B8V9/q6USIio2FRBeBF1
         wj/hhgRnMs3pFMB8KjwLEQm5HliomcqR7WlozclANWzwEcaMhUy+GRWYQQlOFKsrEaf3
         MLFA==
X-Gm-Message-State: AOAM531562NY5kcELynfnmGtrWxsvSEp40k0QoP0mLTOTZL9wJ0sZGC+
        CErT8XqcnJk0t+JP9wh5uaQRtEyPqzK36kQ58O5q5g==
X-Google-Smtp-Source: ABdhPJx/ODP9Hm8TkDdnwXGyaE1kHCna584PGsxkj7xtAGMlrAdDlFdQAiedlezUQ3iZ/KnsenM/Pe3ZX6p/HyXTAVU=
X-Received: by 2002:a63:1518:: with SMTP id v24mr359768pgl.568.1644907792253;
 Mon, 14 Feb 2022 22:49:52 -0800 (PST)
MIME-Version: 1.0
References: <20220209032745.38570-1-cai.huoqing@linux.dev> <302e8426-5a22-23dd-2b3b-7eb6d0ee2e8d@amd.com>
In-Reply-To: <302e8426-5a22-23dd-2b3b-7eb6d0ee2e8d@amd.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 15 Feb 2022 07:49:41 +0100
Message-ID: <CAHUa44G0UY9a7v6KTCx4LdChDZyS1Y0zCmKEXzyddsshFLgv8g@mail.gmail.com>
Subject: Re: [PATCH] tee: amdtee: Make use of the helper macro LIST_HEAD()
To:     Rijo Thomas <Rijo-john.Thomas@amd.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Sumit Garg <sumit.garg@linaro.org>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 9, 2022 at 8:16 AM Rijo Thomas <Rijo-john.Thomas@amd.com> wrote:
>
>
>
> On 2/9/2022 8:57 AM, Cai Huoqing wrote:
> > Replace "struct list_head head = LIST_HEAD_INIT(head)" with
> > "LIST_HEAD(head)" to simplify the code.
> >
> > Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> > ---
> >  drivers/tee/amdtee/call.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
> > index 07f36ac834c8..cec6e70f0ac9 100644
> > --- a/drivers/tee/amdtee/call.c
> > +++ b/drivers/tee/amdtee/call.c
> > @@ -122,7 +122,7 @@ static int amd_params_to_tee_params(struct tee_param *tee, u32 count,
> >  }
> >
> >  static DEFINE_MUTEX(ta_refcount_mutex);
> > -static struct list_head ta_list = LIST_HEAD_INIT(ta_list);
> > +static LIST_HEAD(ta_list);
> >
>
> Reviewed-by: Rijo Thomas <Rijo-john.Thomas@amd.com>

I'm picking up this.

Thanks,
Jens

>
> Thanks,
> Rijo
>
> >  static u32 get_ta_refcount(u32 ta_handle)
> >  {
> >
