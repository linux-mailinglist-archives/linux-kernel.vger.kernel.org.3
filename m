Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9554C844D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 07:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbiCAGsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 01:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiCAGsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 01:48:09 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9FFC2;
        Mon, 28 Feb 2022 22:47:27 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id 11so9177656qtt.9;
        Mon, 28 Feb 2022 22:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jlE+aw4vKQP7l4rMDwOyrdUiA+p3i6LYl1waIrS2FnY=;
        b=LK0pxIWS+C7nL82UcRra+sUQYOg3g9q51kLePI4iqnnsyMYo/deFFUIQWRWGhLoSil
         zLqlARYibdVb3+Ndqikvb4qbgre9TcF3muzIIm9/+KwT5vJk0nGmD25gEm+Cxn31r/nI
         UVPbduLqGDKOiG8UYVSXYsYoVqEbRn2Rg5bYiJTtrFmDrYC72TPWAbiFStPAFAytq8OZ
         EJq0274++kDkgqJJ8qwoRCbuMie0J+/7R5YB6U+oBouAEDYP0E85C10S5FLDK1WeFKQP
         6NX3SEIgwVMSxX0CfqF2Pe41KMXxzJLEa4JKafCr5718dL/UcYMAyqpFMvqbggo4UiTX
         1yuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jlE+aw4vKQP7l4rMDwOyrdUiA+p3i6LYl1waIrS2FnY=;
        b=6VWt1xUj/OaJiEFKcRqsWgvIX8lSvjsNVn66TJ0lMOroCz25pxFUuAR5Sk+a1Sk0te
         0Z3CkZC+2bN37w1i9oAwEJo6oxmmQWtlv5p5qIX3Ja4hldwB2NUuiCsMFAe95GfdeiPA
         VNZ3ky+L9P7aokj2QvygXtVfUvd/duWuhI9n8gpM05chsV+h13fM2JvlfTiqsSbBH852
         gZbYJq+icWIpIlspBzFGg5jnG/1q4w/LgAHsin7VXrg+ehYlDRnq2Grs2GgEOsFxkx5h
         QBFrBb3NtTsdJ7DQFT/sOp/gCF7LRCUB2bxFLn1Wa46qc+0rHbGBZNCOVrUYXeVCmh2h
         xFVw==
X-Gm-Message-State: AOAM530JM6ET7TQ8qd9ECvyWQ84N3oLSD7NLscgqiS+WBxCR7iZ1W7xr
        cfEun54MOO5emVPbQGELWwPY6eGXnZy16KgefY0=
X-Google-Smtp-Source: ABdhPJwPCa0jMqSrvLn61FRp2pIKH/PoSyey0WyJQSP95GLF/cLiU1nD6hdWqS3r8lgXiPbd4u4TV4u5GGEa1OuNHXM=
X-Received: by 2002:ac8:7f51:0:b0:2dd:3339:dfe5 with SMTP id
 g17-20020ac87f51000000b002dd3339dfe5mr18914162qtk.269.1646117246333; Mon, 28
 Feb 2022 22:47:26 -0800 (PST)
MIME-Version: 1.0
References: <20220301011507.15494-1-ilya.lipnitskiy@gmail.com>
In-Reply-To: <20220301011507.15494-1-ilya.lipnitskiy@gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 1 Mar 2022 07:47:15 +0100
Message-ID: <CAMhs-H-oqhGd2UrWN6OOPhmOqiOHhbvNvHwbc9gxF+zNSEBmjA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: ralink: mt7621: use bitwise NOT instead of logical
To:     Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
Cc:     John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

Hi Ilya,

On Tue, Mar 1, 2022 at 2:49 AM Ilya Lipnitskiy
<ilya.lipnitskiy@gmail.com> wrote:
>
> It was the intention to reverse the bits, not make them all zero by
> using logical NOT operator.
>
> Fixes: cc19db8b312a ("MIPS: ralink: mt7621: do memory detection on KSEG1")
> Suggested-by: Chuanhong Guo <gch981213@gmail.com>
> Signed-off-by: Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
> ---
>  arch/mips/ralink/mt7621.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
