Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51745476F35
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbhLPKxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbhLPKxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:53:07 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4698BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 02:53:07 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id a11so22879279qkh.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 02:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Z1eZM6laZOzleTxsTd2Yd1uJMPVObidWq6Pg28q0B8=;
        b=YwL+7Ov0F9P8hlFfI4+8VXPE1f0fi+LhoVaqVgJXb5YybMSw//S+7sZE0eAMf+OEKN
         HK4XnzaUrJIcaz5iVHHssarFwBcZvqJfwIkFqX4ASqFjix/Q4UQ+so6x2e5L7SiGfmav
         MhlVzfrKR4E81MGDAyD789gE4TNgqcGoMmooiQeKw9ZWS3b1foRuq/t7WktCxd/schbT
         CijZBqsgqvSVbedJc1+G8tbTQgPd0+fXku8PQLS7ixGfyVBDrUQ6Mo3stkHpKGh/v7BW
         48H2/1wn6zMAfSDQqfJWvlYNr4pJ/dJ2XguLBGsdflzN+z/SSim6abHH0DsfslOHYQgh
         YIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Z1eZM6laZOzleTxsTd2Yd1uJMPVObidWq6Pg28q0B8=;
        b=OptVcSt16a0ERKdUpUdbrgGQop585oVu/gi97UuCfMvZxl6DnDiyB40Bl06UXBWcBk
         wRg3Y/Fpct2j4lN4eIezaT1h0LT0q3sbJFp3gtL92XGsuGqdOF7mrJtaoaxzgftxa0VI
         Ok6AUdRtK82tjNEbhypfH1AhkKySaDXiWs3FWcejMfkjlgWgwwhuO806QGlh9/Cnhw5o
         YkMr6UwvHZ7xsueZFKl16KlQNelnbMbMIHMEk5Aim3/Xaceh4s2LWMbhabp+D71e4q63
         PXoS5OrMOwWqwYofTsmLGu8Yutx6y3Ck9ILW/AofjPYCcVqhBmJbKGAdm9zgM51Dojuy
         MVdw==
X-Gm-Message-State: AOAM5318bD/H4bN+ye0+fKVFWn4/u7O2s3aSy1R7Do9583tYAnOvFpAR
        d+3BJUWPX5Qt/q8tp5hRaro6ITlOhH/dW3mBltwcoA==
X-Google-Smtp-Source: ABdhPJwfx+YQqnle2PZIvmsDdgqby2XPINbWo7FHmc3PDptq2jz4xj+tpFna/PKxz2fndVE64sWMnTJ77kCK15Ng3Dw=
X-Received: by 2002:a05:620a:e0c:: with SMTP id y12mr11446382qkm.109.1639651986199;
 Thu, 16 Dec 2021 02:53:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639432170.git.andreyknvl@google.com> <e82b75533a93a5fc85e24b782c6177457af0755d.1639432170.git.andreyknvl@google.com>
In-Reply-To: <e82b75533a93a5fc85e24b782c6177457af0755d.1639432170.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Dec 2021 11:52:30 +0100
Message-ID: <CAG_fn=U8LjS4yH=mGgvJu+AUOV=DgHaPDbTBFtf1LjxexWB8hg@mail.gmail.com>
Subject: Re: [PATCH mm v3 15/38] kasan: clean up metadata byte definitions
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 10:53 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Most of the metadata byte values are only used for Generic KASAN.
>
> Remove KASAN_KMALLOC_FREETRACK definition for !CONFIG_KASAN_GENERIC
> case, and put it along with other metadata values for the Generic
> mode under a corresponding ifdef.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
