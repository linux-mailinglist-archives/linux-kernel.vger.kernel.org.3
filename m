Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F13A48D891
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 14:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235040AbiAMNNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 08:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiAMNNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 08:13:15 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2591C06173F;
        Thu, 13 Jan 2022 05:13:14 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id i68so96362ybg.7;
        Thu, 13 Jan 2022 05:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2g1mOmaucLb7XHs8JQUVqK6opVNl2Di7/j45TJR+WOs=;
        b=GUkpUVFLcgKxF9APCPN+kpP9/OgHaz3ibPzyeczCSWzl/VApI+iGGZcYDqvSgtz3PP
         GOYVr9+LmHsvoCh8KyhOxLq8jDf00dyNAoGIqH62Y2flIeUN+Mzsj8Hs6C8g7CHRt8di
         UGZ+NFc5kCHdgCRoVW4O5s9TWtT8sr4YONnBSXyK5PjVLMxMuN2WbksYpkkomFYy4HwT
         5Y0LPfRNOkUHbFCWJbf2azHgrxE7NH0qOS7qDJF6Kwa+IBzTfs3M4r4uMPggO1VZzCLZ
         AGk3DrXcTriTZhqluocUNWIa9s9+fVvuDUt9bI35ghl8pefvyjvGIuV2eYFdTAnPsNwd
         2WUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2g1mOmaucLb7XHs8JQUVqK6opVNl2Di7/j45TJR+WOs=;
        b=XZzMaOUQdF2GepUxQZXcDMjEgFutsGz/w0lXr2avjM5qCc1W0JWX6koO5F5OBIqR3v
         F2dA3lJdP3j+yHnteW/jTVBoG0dJAiBI55B0WGkVzMgV/hP0j2oeQ9KuIRgE/c0Z10Me
         Jico3jqOHajJ1XlUXOBHs31dqGxixeasKsfY0M0DcwORqMIQwC4IAMIVB74e59xymKwS
         gHx9KNhN33I02K00yhlKeSm4GBCrd1sSObRbg0fEdbCTKIkBuO8B4SxBeZr0AflGqYWn
         8sG499UA27MxKM1BSXQDQiS4xsNUf+aDzbRlFy0K0I5lRqP46t2MsJfSTRhSwODRNviL
         7Npw==
X-Gm-Message-State: AOAM533SX/qY1izRqHMMvQHBeTc0oLT4piJ6Gwe5RDDcHRiQfk58YY5h
        Izd5OPfijyLkMaflaQbHKANyhWXolcTB5oYj+88=
X-Google-Smtp-Source: ABdhPJy6/bFgiqUi0Vw/oTvUtA1ZdJOqxBOpdRCOAxD3OyBZrdffGioQDjLfY1gmbMNtOi5Sw1oQ0oJ7FIxILzyauSs=
X-Received: by 2002:a5b:281:: with SMTP id x1mr5627475ybl.41.1642079593957;
 Thu, 13 Jan 2022 05:13:13 -0800 (PST)
MIME-Version: 1.0
References: <20220111002314.15213-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220111002314.15213-10-prabhakar.mahadev-lad.rj@bp.renesas.com> <d66a7182-825f-b9a3-afc9-c0117ea846a2@xs4all.nl>
In-Reply-To: <d66a7182-825f-b9a3-afc9-c0117ea846a2@xs4all.nl>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 13 Jan 2022 13:12:48 +0000
Message-ID: <CA+V-a8s9s9Q=-NiwZYhpUNuiHyTzREqzMrH60mkdcR9uUYN+2A@mail.gmail.com>
Subject: Re: [PATCH v2 09/13] media: mtk-vcodec: Drop unnecessary call to platform_get_resource()
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-media <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Thu, Jan 13, 2022 at 1:05 PM Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>
> Hi Prabhakar,
>
> I'm skipping this patch since if I am not mistaken this patch fixes this as well
> (as part of a larger overhaul):
>
> https://patchwork.linuxtv.org/project/linux-media/patch/20220113041055.25213-9-yunfei.dong@mediatek.com/
>
> I posted a PR for that series, so that's on the way in.
>
> Please confirm so I can mark your patch as Superseded.
>
Ack.

Cheers,
Prabhakar
