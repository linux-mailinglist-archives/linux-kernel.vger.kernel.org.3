Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8E9533A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 12:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240819AbiEYKBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 06:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiEYKBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 06:01:40 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4EA6574
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 03:01:38 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id i11so35372685ybq.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 03:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=RHg0IRw/JjYWqQBlPuCoBLLl8Q24LMwn3Zk4agmW7sk=;
        b=WK1kKU9ta4P1BQytTco5Ipd8SnzdMP7gXkvxminU2LtnuRpLIG1i1zEQM7gs5SlcBd
         neoWereRdGfu6O2PdGa8xgWfznlSZuUReouEzhkPZRfUuofXnVEf6kh/tnq1QUzLeXF/
         S63Y7gU3PTLISKdtf7ruGfZCbMQZZW4wvBsaD4EUInEWx9u+4tqQaAp7RX/ikvmibqkJ
         ko0zeBrB0EZ7CWc6j1trlP1Q18rTPX4ZM8aE9Z0/Xw+7rWafgkYBY7KsY/d6D31JL0aj
         uMYVi8oFT5xgUrnxIMGuJQVpi7dPDm7K/9doc+X2+XhbusBMtRdzVN+QEBJ9BTcpu7Bj
         7Bkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=RHg0IRw/JjYWqQBlPuCoBLLl8Q24LMwn3Zk4agmW7sk=;
        b=343yay/9g//jA4U3aSMEIkgvcpQPAhXvtUn74YubnW/jJfHu3Qhj5ZA49qRVpSvgUm
         jatTPHNN4FmVcLPkQXeJLXQwG+KfytMeN7ax1Zssh+ABC88zjvXSNTTWAB44yLDD7/ND
         8pGCJ3igrksYbURIxMn47fC4/85lK1/qZv1m2vGQ2UPoHvzZwX0zY+FOVvs55KKN3Gpp
         Ryzludemhl67Mfb7/DRmucdIzig3/ZkzNFkvTgBPTE/YxhBHH8Bc+DFIiMC7qDWOg0iN
         UesVhXTLjZm2qX7TlGLyjdoKo1UIw14cF5uiAcawG3iYncvcsq7mFNbuVs61TlxDs2iX
         4xNg==
X-Gm-Message-State: AOAM533ueMtuQ35hTvtMFENODpqubvjMVcas0421mIR2C4c8e1BdAs0Y
        Z325KQuH4WWdan0H0ImsicynhbIurcJFHIUPndY=
X-Google-Smtp-Source: ABdhPJxKUyA1rNGT9vVQqi+5Pti+A1DzbQvEt9+B57NrdVyMd8LLZTYdplG3JWZm/qxKctUil23yrMigFynPET6xVpg=
X-Received: by 2002:a25:e745:0:b0:655:87ce:f60e with SMTP id
 e66-20020a25e745000000b0065587cef60emr3446390ybh.101.1653472897746; Wed, 25
 May 2022 03:01:37 -0700 (PDT)
MIME-Version: 1.0
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Wed, 25 May 2022 18:01:26 +0800
Message-ID: <CAJNi4rNwPQf747UM_hiYYwL=HDxg8QnPpfFPv1PfrtN9ZP1y1g@mail.gmail.com>
Subject: Question about SPIs' interrupt trigger type restrictions
To:     maz@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

For below code snippet about SPI interrupt trigger type:

static int gic_set_type(struct irq_data *d, unsigned int type)
{
        ...
        /* SPIs have restrictions on the supported types */
        if ((range == SPI_RANGE || range == ESPI_RANGE) &&
            type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
                return -EINVAL;
        ...
}

We have a device at hand whose interrupt type is SPI, Falling edge
will trigger the interrupt. But the request_irq(50, handler,
IRQ_TYPE_EDGE_FALLING, ...) will return -EINVAL.

The question is, why must the SPI interrupt use IRQ_TYPE_EDGE_RISING
instead of IRQ_TYPE_EDGE_FALLING?

Thanks,
