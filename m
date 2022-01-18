Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3B8491E58
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 04:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345512AbiARDzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 22:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352217AbiARDyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 22:54:38 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13627C03544F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 19:47:49 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id s30so65444281lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 19:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZoCI2SqwGc7GNqA0zNC1cVCgm/xs2asSiAlYIoId6Go=;
        b=SaAYwj4o39rFa3sCb89Esu/rDQ+q4s/xSSfF3TxAYYQBv+CctKjiZ9I8uhFJIVV1ae
         1tpFh5nDKelPu8nuF8BWKLnXMHak4K2vIAWJgd4zjBoZr/KqhbQdDCeh9h2Ba+xubXxF
         Rv/TA7kVDT3EsHNoctH2Uf0awr9EZjGD4TYaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZoCI2SqwGc7GNqA0zNC1cVCgm/xs2asSiAlYIoId6Go=;
        b=tcfZADoJRdAcKiYRaqhPBkytatfs+zMd7qD/701sex0iXXwBIhwDESUAYKG28+LUrR
         by/ufeyT9acleFz+Jsi5mwvYZ4BSvctHoGGw6fsJubQuWbHlZhVRWtFc548B0/LMmML5
         sxaoae3y/eOausntAO0MhSZCHG5N0I8S3lpWp//lplHzIjJLT+1nwP+3F6e1JiorlTJ4
         +JTCVeqzuijFVNDQPO/Z8i4Q/4x0JLR99v0rnxt0LLAMvi5nEFiRRYA3/AYPoaTLQK2z
         Vh0sg2X9FIdmtcWmzn4uWNayzT8gbbi40iwb4tVcb4T5m0cHNKsRwKKLEog8ZWz/oQ5L
         fFaQ==
X-Gm-Message-State: AOAM533O7mowU8/Eu3YilFn9SbELiLEnUoWfmB/XpEKChaJVq3VF+xA2
        /a89VZ7oC/7FZDKmKfO1siWeIaH/fkMcqUSn0JJL1w==
X-Google-Smtp-Source: ABdhPJxaIye+D/H/s7rfEmIb8hQu9SJJU4FDDE6UaYKC50XEKqRDR5UAYARAqMvP+gAZcOfxbFUriiaP2zRCUCXa5hc=
X-Received: by 2002:a05:651c:542:: with SMTP id q2mr506484ljp.201.1642477667182;
 Mon, 17 Jan 2022 19:47:47 -0800 (PST)
MIME-Version: 1.0
References: <20220111112244.1483783-1-wenst@chromium.org> <CACRpkdZCtEwZiVwoW+QNL4nTf-10fBDRfGkwVJavf1n_w-8q_Q@mail.gmail.com>
In-Reply-To: <CACRpkdZCtEwZiVwoW+QNL4nTf-10fBDRfGkwVJavf1n_w-8q_Q@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 18 Jan 2022 11:47:36 +0800
Message-ID: <CAGXv+5GRqQFHsxZMaK0VT534rQvQTx5-h1U63mFSUQuAHRGmkA@mail.gmail.com>
Subject: Re: [PATCH 0/7] pinctrl: mediatek: Fixes and minor improvements
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Guodong Liu <guodong.liu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sun, Jan 16, 2022 at 8:49 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Jan 11, 2022 at 12:22 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> > Here are some fixes and minor improvements to generic pinconf and the
> > Mediatek Paris pinctrl driver.
>
> Looks good to me, can you rebase this on v5.17-rc1 once it is out
> and I will queue it!

Thanks for the vote of confidence! I think patch 7 still needs some work.
I will likely split that into two parts:
a. pin config readback of the advanced drive strength mode into
   PIN_CONFIG_DRIVE_STRENGTH_UA, and
b. Supporting setting advanced drive strength mode via generic pin config
   properties.

The latter would require modification of the bindings in a way that might
not be describable. More about that is in my reply to patch 7.

In exchange, I will add on a code style rework requested by Angelo.


Regards
ChenYu
