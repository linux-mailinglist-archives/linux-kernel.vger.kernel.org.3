Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC62156D13A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 22:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiGJUTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 16:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiGJUTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 16:19:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C1A11C2C;
        Sun, 10 Jul 2022 13:19:09 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z12so4640655wrq.7;
        Sun, 10 Jul 2022 13:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+4LoPEsOm9PcR/r7ehdFP74w+Fi1gnsISSscNQ2/Q78=;
        b=PkSkgPbDyvs4YxkDlBo2UKihg/1fnWxscImG+AlHErPYhCCF0P4XewLi9y6PgNyqcu
         lhmRT76a2U0h0Y0xiyVS4JhE9dhN1NKKdCkZsqUz25MQE4qdoTCsR1N/3kMOyfU5qjgQ
         aVa0LZ26Clq9Xtx0wcnXpyCVHmofwybeCkVJ2e04XWn/7aeMsnuXeilsrJBf2T5cYqVh
         BlvPc+zY7GPV9PGX2UD/tEhbmcl1szbXAqboRP3f0jtnWZKPJd/oF6oiOhFj9ktuUNol
         eugMQ+QQ6AQKXcMezphEziY1g0IZSWMpDE2x6sFbi3UPxC7G/XalxOTxPuKVp+Kwah3n
         qV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+4LoPEsOm9PcR/r7ehdFP74w+Fi1gnsISSscNQ2/Q78=;
        b=Wnj0nOcXDHG8+PE/gYGiNnLRt/bvtYrm23Urqd/fq5b2nG5yIqTfGaS2J0PqwEx78Y
         fYyn/jSA0QU8w85lOuX+m+LFa0sUMprAOwhdzgE+tGEbsL+cZIVOJZIIg+C5AF0SPfCD
         j58lOQcOz2v/I71l/XIDuBjtYvwERR7BtZxWHmtmOC9bjyaHSbKrmQ2xCWV1xuTrd+bm
         yLppSGD6PhAnDYvzlwTl+K/4phHTel80/7RsbXBPHIOwJCbMvUT9spNj1CI3KmVqvJZ8
         x/JGkidAKGmuJenyk3nQbnRpz5Nm39NuZUcVKxMSkEshtTE5wTP7zf6tMzPO00ZODcL1
         t5ug==
X-Gm-Message-State: AJIora8y+QLqcwrIqTrN+Ismic/bim4oJroNPYWGzRonVhgIHTc1N/+I
        lxo4NFMm2cNXKv/MFMV/LWRCIdJ6NugJVA==
X-Google-Smtp-Source: AGRyM1tgCCWxYVHcQrMLh985IY8zqRxEdd6qLWzO/Wy0iFFVuUCJol9zlgdT9Y7nuA/xmzN2kWuuNw==
X-Received: by 2002:adf:fe81:0:b0:21b:88ea:6981 with SMTP id l1-20020adffe81000000b0021b88ea6981mr14255998wrr.616.1657484347662;
        Sun, 10 Jul 2022 13:19:07 -0700 (PDT)
Received: from reki (62-170-35.netrun.cytanet.com.cy. [62.228.170.35])
        by smtp.gmail.com with ESMTPSA id v26-20020a1cf71a000000b003974a00697esm8142900wmh.38.2022.07.10.13.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 13:19:07 -0700 (PDT)
Date:   Sun, 10 Jul 2022 23:19:05 +0300
From:   Maxim Devaev <mdevaev@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, balbi@kernel.org,
        gregkh@linuxfoundation.org, caihuoqing@baidu.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: gadget: f_mass_storage: forced_eject attribute
Message-ID: <20220710231905.1fa80848@reki>
In-Reply-To: <YscWpjFlV60NybEA@rowland.harvard.edu>
References: <20220707170912.70505-1-mdevaev@gmail.com>
        <YscWpjFlV60NybEA@rowland.harvard.edu>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
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

=D0=92 Thu, 7 Jul 2022 13:23:50 -0400
Alan Stern <stern@rowland.harvard.edu> wrote:

> Greg's patch bot is going to complain that you didn't describe the=20
> differences between v2 and v3 at this point.

Fixed

> ...  How about putting a comment line here, explaining that this=20
> override will cause the medium to be ejected no matter what the host=20
> wants?

Yep, I've added.

> Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

Added, thank you! Submitted v4.
