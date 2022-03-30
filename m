Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6170E4ECDA7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 22:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344990AbiC3UBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 16:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbiC3UBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 16:01:18 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0373821256
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 12:59:33 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id p22so26109451iod.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 12:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gC0uk57Ku0uf244iRsCcqiEQThdW6a3NXZ/6v4Rmslw=;
        b=ma04PNC7uu8gYiv38NUXP7EYl5caBKgorkoA48dW8JgXzkLJX7Vfuf2XgflqVpTpxs
         6RRV6XZrHp8mCE+PKM68b/yfYdg+FM2YLRxqB7BWpB7oHFqJDOGLBSJgFWYusBcqyuNq
         D78z7z+felPE8JjEegH+BTHnm6foOC0JbcVLmTTsqAQCRCQqaz9aLq1Qr6etLCCPNrFP
         TxADqRha/MBQ/ueTTRPc/qBuqv5mq9AQHzspNn1tfTJt2YoLTXVuCUOJS9T1qCY0Pxa8
         qmxejgtkTnXfy1GbjYzQJDLWmrnFDEaXl4bEam+GSqiWv5jLjeFXuSopWpCgZ9lOk96w
         ulCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gC0uk57Ku0uf244iRsCcqiEQThdW6a3NXZ/6v4Rmslw=;
        b=TWGnob++Ylo1DkWOE/HKVktRWrn1LkyEEhJliaV0H0EdZj3ACJmfmVT3UFS6tDusOW
         ECMM+XxJPWAMbS7Jql3cervAoMnpDvm0KH0MANEh3gfNFs3W2XlGUttmUW8WLpd/WEyk
         HIejft46K5Zb9Zk+d3BjzOWQL6mAhwDYOpg/87VNndvJNaI8ZlNgsvDRP10ykLWEGncL
         +u/SHvi4BjW8r/FaKpPGlaCtMuS/1v3LxsB/QZAzYtuT7c5Sv5XGL3o4Y3beCmAn2LQo
         HvblxTNp9ywv4RZkhEN8BfzkNGgy2M8xf2p0PkNcrLbp9mhivI2tM1nkRf0pmD9aqRDs
         UxPw==
X-Gm-Message-State: AOAM532GfcSCyRBWjNHoHPUTpHjSclDV8P+JfuwYPLWTXfI01cMaMAM/
        YFPSoU5Giv0Uo27cweR3Ku57yxXnZAt+/ccPcHW0Rw==
X-Google-Smtp-Source: ABdhPJwUv2J6SmfQenhMgf3tkXJDaqsUVYxZOa3k+udE9+yPKzytM1W9PNBunHZXT6YsxYz87vKM4BGt3ZmgsQAF0xM=
X-Received: by 2002:a5d:9c0f:0:b0:645:bc04:fd5 with SMTP id
 15-20020a5d9c0f000000b00645bc040fd5mr12651956ioe.28.1648670372176; Wed, 30
 Mar 2022 12:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220207163409.19c3bc4c@xps13> <20220330182816.1177341-1-jmeurin@google.com>
In-Reply-To: <20220330182816.1177341-1-jmeurin@google.com>
From:   Jean-Marc Eurin <jmeurin@google.com>
Date:   Wed, 30 Mar 2022 12:59:21 -0700
Message-ID: <CAL3wywXEdgL=NepfinTx_WdbKpDPowuDjuTEGSYPc6hRTLJTiw@mail.gmail.com>
Subject: Re: [PATCH] Fix the size of the header read buffer.
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 11:28 AM Jean-Marc Eurin <jmeurin@google.com> wrote:
>
> The read buffer size depends on the MTDOOPS_HEADER_SIZE.
>
> Tested: Changed the header size, it doesn't panic, header is still
> read/written correctly.
>
> Signed-off-by: Jean-Marc Eurin <jmeurin@google.com>
> ---
>  drivers/mtd/mtdoops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
> index 227df24387df..09a26747f490 100644
> --- a/drivers/mtd/mtdoops.c
> +++ b/drivers/mtd/mtdoops.c
> @@ -223,7 +223,7 @@ static void find_next_position(struct mtdoops_context *cxt)
>  {
>         struct mtd_info *mtd = cxt->mtd;
>         int ret, page, maxpos = 0;
> -       u32 count[2], maxcount = 0xffffffff;
> +       u32 count[MTDOOPS_HEADER_SIZE/sizeof(u32)], maxcount = 0xffffffff;
>         size_t retlen;
>
>         for (page = 0; page < cxt->oops_pages; page++) {
> --
> 2.35.0.rc2.247.g8bbb082509-goog
>

Sorry, please ignore this duplicate patch/email.

Jean-Marc
