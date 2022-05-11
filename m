Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C665234FC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244345AbiEKOEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244359AbiEKOE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:04:28 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1513C62A05;
        Wed, 11 May 2022 07:04:25 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id p8so2072538pfh.8;
        Wed, 11 May 2022 07:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FAycP/UnzSO9sp1Vuujv+0JbzgIbVmxzsc3ZoW5J4LI=;
        b=cj2tvfGjIXQI3r4HgkLQGaz3Uf/ZnofPNPHmmgCu0Pu28fJGyjxOd3NLMUIIAMyK0d
         ZXWpKJUQleWkUyMbA3QoLDaU/unVx1WSOQGz+2iOcVAjZJCRQGlnZypHKsNVo0H4zWgy
         g7ox21QKH+injHY4pd3RyNRq3fzKtqi3KU0hJGgOJ3HMWcVQaLUx3kyycrlgU7d8S3bf
         bDFufDFuTsdgGrIMArBXtn/YDJzZDkytamLyIqJBeFeYuUbS8wC2LGfwywnxHq3MPJHu
         vb7LPoGJmyvy3HQoFAbC1PA7xelQgXZADnh/0BUE8ws9DxY4ShGYeyIP79Xt8paA2dEv
         RSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FAycP/UnzSO9sp1Vuujv+0JbzgIbVmxzsc3ZoW5J4LI=;
        b=WgHMMQtUXhsMGY9XKg+0uM1wva4SwUNyPM6zJcAma+qOC9QY+o+t9QWhhqZrkacCuJ
         bFLCfSFMvryGPhgHKNyCkm4g2svGSucFqqqETq/2BKiddTgdLkVXt5lN1srMIbE6R+WI
         64CsjrtfiYshnGCCOQMcVfIaYivjipgKgVfAG3lDhDYCcoasfHHWKGYRp5bu/L/6RVGo
         ADKZN1T8N/rCgZQGMt4on6pX4Zw8rzBxEfJFrJYF78dGlIbXSVk3a+jJrpDPxKcey6Hh
         eQgYA/D4slpomk3zAK1OuVERnCMXeAjjlWFN9WIGbcp7LMIWGWtSrqV7xJb4OzyYkJpz
         jzSg==
X-Gm-Message-State: AOAM532l/xz1czWND+UDxQCNBrLVuFdHyY+95N1WGQoHx5qEd+FxoMFl
        j02LrWwBCEQ8+cieUbbtlxy1xO1Lo9TuieghaTOwFVq80330Z30=
X-Google-Smtp-Source: ABdhPJwPtjVg5lQMF/zAdpKucLIxoOqSbJxONfo3pWaeLSXOLeLvWLrJb6e3/ry5kvRIQLlW2OCtkkxf7t7y8ilaXpc=
X-Received: by 2002:a63:5564:0:b0:3ab:9d95:7a21 with SMTP id
 f36-20020a635564000000b003ab9d957a21mr21263368pgm.542.1652277864532; Wed, 11
 May 2022 07:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220510114852.1719018-1-zheyuma97@gmail.com> <CAPybu_2NCEmjVi2FZC+dPePkfZJQG9QT5qc=cRdHY4tHPEkVDg@mail.gmail.com>
In-Reply-To: <CAPybu_2NCEmjVi2FZC+dPePkfZJQG9QT5qc=cRdHY4tHPEkVDg@mail.gmail.com>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Wed, 11 May 2022 22:04:13 +0800
Message-ID: <CAMhUBjktiUAgXcYzVaF1SUsz_0P4w5D1WHgB7op29J2rwYaBkA@mail.gmail.com>
Subject: Re: [PATCH] media: imx214: Fix the error handling in imx214_probe()
To:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 8:19 PM Ricardo Ribalda Delgado
<ribalda@kernel.org> wrote:
>
> Hi Zheyu
>
> Do you have seen this issue in a real hardware?  The device enters
> idle state unconditionally after power_on during probe.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/media/i2c/imx214.c#n1008

Actually I didn't, I found the "bug" manually.
Thanks for your reminder and sorry for the false alarm.

Zheyu Ma
