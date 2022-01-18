Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CFF491DF6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 04:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344946AbiARDpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 22:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345363AbiARCxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 21:53:30 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFBBC02B8D7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 18:43:39 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id v7so20974868qtw.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 18:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=7X1Uvba4FRzkQNs3e8K7RvJSO7H6HBoP1FkghXLwh2c=;
        b=sek46a/hazwPyMk4wZVq+CDV4DXbWpOPFHYhLYiac0qW5R9X8PC+vOBPuJJ4JiuRED
         xoa95ljAZ9cBaVn0FL4qmVapGqBEKb1bdNvS7O3/woJEXd19uz44IxDyWj1c2i+KXA4L
         61rF2Tz5gsSoldFd1ZDBtCS/UOhlxD4X1VHPGqnSJLp/9aNmbSNuBwyJmfSq9M68WBGo
         uJoOwy5gyw0WXWcERPCo4U1BkMpkxTYkbVFbztGmvZzfOe6ljJDT+PN2Z7FyLRKLGFiK
         JZ2EpM0xhjpEjoaIcpcuhKcL/760jVA5N8PbjcnG7EEaqavoCTpcFLsH16Hx+va7WLf/
         8oDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=7X1Uvba4FRzkQNs3e8K7RvJSO7H6HBoP1FkghXLwh2c=;
        b=HObDdxvr4id8Y0k2Mt8lr8QzOPK4VcvbRBF863N5raoGYg9xkkTORmE9SB9aiAV91p
         fuU/GqmOd9hpHIFFm+m/YqUTZdV3rHkOGJxaI73fDTKfU5AKSA51t5jxzVpTCuAsoOwX
         gRv9fN3CVPNGwII4ObKjBlC9zYIlPdwXTwO7bJsMQVSKHmowFFtkWrpXfp0F0L6eDM3V
         Dx68kybYne1+iDZTiyOIgno1zaaTi/BZPHHfSisHtqWNhp1ogX5fNPn1ATumvOBx9bE0
         D2mK/l8JKL0gLkQzc9zuZcvfVjkXkv+cX/Gp7+1eQsDfqwlQ+g0XfOx5BO75/zyg9OJH
         VM5A==
X-Gm-Message-State: AOAM533URRbX/177K3ilblz1E9vC6dPPTNKNXdFw7+Bdk9NbQUi4IV/F
        +uIG1VqfowncUR3/JYHLc+kc4Q==
X-Google-Smtp-Source: ABdhPJwZsjq2fQPyjmZ+V+4fehDe7Yi6eO75Umlfh+sZ96vubkEVxgbNhUHzyQcaGPg2Ev5vHPupZA==
X-Received: by 2002:ac8:5bd6:: with SMTP id b22mr18740815qtb.481.1642473818298;
        Mon, 17 Jan 2022 18:43:38 -0800 (PST)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id g20sm3644704qtb.49.2022.01.17.18.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 18:43:37 -0800 (PST)
Message-ID: <26cd15bc1c5dfe3acf8bb280cf7542657cb8b291.camel@ndufresne.ca>
Subject: Re: [PATCH v1 2/2] media: staging: tegra-vde: Support V4L stateless
 video decoder API
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 17 Jan 2022 21:43:36 -0500
In-Reply-To: <0ae51264-8578-0b4f-4348-7f7a239c98dc@gmail.com>
References: <20220112153952.1291-1-digetx@gmail.com>
         <20220112153952.1291-3-digetx@gmail.com>
         <e5bcc0a6d283ce3ed0cfe7d318232fb878c1b47d.camel@ndufresne.ca>
         <0ae51264-8578-0b4f-4348-7f7a239c98dc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 12 janvier 2022 à 22:04 +0300, Dmitry Osipenko a écrit :
> > If so, I may suggest to drop this fallback, and propose an amendment to the
> > spec, we can require flagging KEYFRAME/PFRAME/BFRAME on the OUTPUT buffer,
> > this
> > won't break any drivers/userland on other HW, and will benefit possibly
> > other HW
> > in the future. I can volunteer to patch GStreamer and LibreELEC ffmpeg if we
> > agree to this. Not sure how it works for Chromium, or if it actually make
> > sense
> > to support here.
> > 
> > (expecting feedback from Hans and Ezequiel here)
> 
> Amending the spec will be great, although it's not clear how to flag
> frame that consists of slices having different types.

As per spec, all slices of a frame must be of the same type. In short, there is
no problem, adding new flags to the decode_params.flags is fine, and is backward
compatible. I had a second thought that I'd probably prefer this over using the
v4l2_buffer flags, but either way seems backward compatible.

In H264, but also other CODEC, slices are have two types of parameters, some of
the parameters are invariant between slices, but still duplicated so you can
decode some of the frame, even if the very first slice is lost. We tried our
best to place all the slice invariant parameters in decode_params to keep the
slice_params as small as we could.

regards,
Nicolas

