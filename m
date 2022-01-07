Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B9A48795B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239529AbiAGO5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239219AbiAGO5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:57:19 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B97C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 06:57:18 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id l3so7329821iol.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 06:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MmKzdxi5tqqXaV9pr7x7K4Gv2kquAOpSYKeE1KvCgP0=;
        b=C/TWWdHnG3Yy7oClfhVjhBYGKp0/W9wPweqNH480cAcO/Ghf9bAVQ/l2Xi2PefoEpS
         QJ29L8NMETfujIGdiRKYv0HVnGajKrxfskdROkKulfal/11XXNlvo57XjyM92q0Ca5rK
         jkLHuCVfempPfBnXeIUxvbzUlIxCmR1qD19TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MmKzdxi5tqqXaV9pr7x7K4Gv2kquAOpSYKeE1KvCgP0=;
        b=Or0jRdlmiagg5hA92fA1oRgwaUeG7JHczp0SNDn+A71alVqCcOi0ie/+WtKtR3juIT
         6SK78arrwSRHY9OuDSsvsSPWmWgCjaf4IR4kSdFB8aNttyDJy1XsjBLnM7sGSS4j+C/c
         MjNldblLalJjVniJgUUESot+SsgzRJCreKZ7B1uk1NGL2V9oWcJn5xyTc0/8YI54IYFl
         y0AD23lmU+8qgqRlfd9xJoZelRmkNsaon+9qvgoTN5CalwyNzdaKmAvIP9ksbs5Cc6Lz
         4VQUeC6Ws/rMKpBI/W4P211QMei93rIshpFytjuDH6iWoNfjiHHyusqaWxpy1YDsVToA
         0ebA==
X-Gm-Message-State: AOAM533Lex5EbMvGj2QYNTYywqGkARnGO1mrWkegSuKhgficn5MpuBx/
        7OPs9num4w0HC3N9K9sh+a4NlraBHnuVrg==
X-Google-Smtp-Source: ABdhPJwZDFHrSRrz3MV15s8u/GijoRMXFdGSsVLjdHKZaolzsNTg2Le35FhrlrV+2gxvqUoQFVB3HA==
X-Received: by 2002:a02:aa8f:: with SMTP id u15mr30020688jai.63.1641567437927;
        Fri, 07 Jan 2022 06:57:17 -0800 (PST)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id b5sm2984205ilj.9.2022.01.07.06.57.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 06:57:17 -0800 (PST)
Received: by mail-io1-f44.google.com with SMTP id s6so7460541ioj.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 06:57:17 -0800 (PST)
X-Received: by 2002:a6b:e508:: with SMTP id y8mr28973111ioc.177.1641567437115;
 Fri, 07 Jan 2022 06:57:17 -0800 (PST)
MIME-Version: 1.0
References: <20220107103056.1.Ifc6ce6bb655ddb8ebbb0f340fcaaa58369bb009c@changeid>
In-Reply-To: <20220107103056.1.Ifc6ce6bb655ddb8ebbb0f340fcaaa58369bb009c@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 7 Jan 2022 06:57:05 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U0-W_H=-u-GDc5GYm8GHSix0F1dKF+3eMNixP30fhtrQ@mail.gmail.com>
Message-ID: <CAD=FV=U0-W_H=-u-GDc5GYm8GHSix0F1dKF+3eMNixP30fhtrQ@mail.gmail.com>
Subject: Re: [PATCH] nvmem: qfprom: Increase fuse blow timeout to prevent
 write fail.
To:     Knox Chiou <knoxchiou@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 6, 2022 at 6:31 PM Knox Chiou <knoxchiou@chromium.org> wrote:
>
> sc7180 blow fuses got slightly chances to hit qfprom_reg_write timeout.
> Current timeout is simply too low. Since blowing fuses is a
> very rare operation, so the risk associated with overestimating this
> number is low.
> Increase fuse blow timeout from 1ms to 10ms.
>
> Signed-off-by: Knox Chiou <knoxchiou@chromium.org>
> ---
>
>  drivers/nvmem/qfprom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Slight nit that ${SUBJECT} for patches usually doesn't end with a
period. Presumably if Srinivas cares he can fix it while applying.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
