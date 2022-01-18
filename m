Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B7A492E3F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 20:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348276AbiARTPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 14:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239978AbiARTPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:15:09 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37924C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 11:15:09 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id w204so216731pfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 11:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=dpimc9u9mWkTK2A7AIN/PlilWYzlyB0scr3gag0ePtk=;
        b=CfkJVLW4r80ivRVQPJwJKCrpdoVWkBV++jB7iUVM64kpcJgpAALPeiIScDIO3d31ms
         lN6LoDSvcfC/9yTipXqEtuZ4ykX91Jut5J7rP3MMqXhgbeiKzNqVeV7/2gW1d2wwpn0z
         ndpBjQx1ABZI/B2dwtU45Tcy7zk6ZJunfbvj695FUZzzrhNKnLWZKozy16vEGHPZqZD/
         ZdmQmlucYW9dW+W7/uw+NiPNFmfJsIRCLJNKdOFVzDWRXTPo0NK6EF47jD0G7sRkmnMa
         Azf0PDRGSxYFwUPbUej0tAw1vpv4E8WPiZpFzMA/8us7qK7cEaMJQ7OXHSMxfskYm4Y5
         vH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=dpimc9u9mWkTK2A7AIN/PlilWYzlyB0scr3gag0ePtk=;
        b=USuDlMruhQYl/3O3AHezldvXQjFfcow/L6E5gTsnuOgFzwgKO2vDlNjn5ayCm3pfDp
         M5DMOTOxrNp9iAIkl48N9WazqzqBL2NdqosFtrOHxA3b8eA/S3+0FchS9wfSAmhsivqv
         WIKaFJg3DNGrkX93dV2+ZBhaIdphh6cIGwkrDhwb+0SXuEepqV/NrkuxtIc8/hPPoqAC
         6iLXdNeiPT0Ba0Lvt8OIFrpaI/Kk5DSItGRgWka70BdTPxQyoYSgHl6lAxVORuHMg/S/
         +ZrhKkEgHAPiQ5Q1Sq25bBY/GKFLpT66AzTX8tcER4HQJuc9YCuR9dgvsqvqnCNGwlnl
         ndZw==
X-Gm-Message-State: AOAM532kmJdP13vQlfrcbDVm4ZObNJWimOLIYJAZHKk3mUu60HTxOa4f
        JL7cFLTC/uco2kc1r7ZKrArvsg==
X-Google-Smtp-Source: ABdhPJzt5P1Hi+ik4AbUuPNtdbsh5ykdqMC2K8UwzvX288Kd4zpJkeMi7TfOgZfnRVlS2NqHzscIqQ==
X-Received: by 2002:a05:6a00:9a9:b0:4c1:c43e:75e4 with SMTP id u41-20020a056a0009a900b004c1c43e75e4mr27279237pfg.83.1642533308696;
        Tue, 18 Jan 2022 11:15:08 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id e18sm17402375pfc.150.2022.01.18.11.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 11:15:08 -0800 (PST)
Date:   Tue, 18 Jan 2022 11:15:08 -0800 (PST)
X-Google-Original-Date: Tue, 18 Jan 2022 11:14:41 PST (-0800)
Subject:     Re: [PATCH v2 0/5] riscv: mm: init clean up #ifdefs
In-Reply-To: <20211206150353.731-1-jszhang@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        alex@ghiti.fr, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang@kernel.org
Message-ID: <mhng-56a04ad9-5ae1-412c-9862-071c4e1b8391@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Dec 2021 07:03:48 PST (-0800), jszhang@kernel.org wrote:
> To support NOMMU, XIP, the arch/riscv/mm/init.c becomes much complex
> due to lots of #ifdefs, this not only impacts the code readability,
> compile coverage, but may also bring bugs. For example, I believe one
> recently fixed bug[1] is caused by this issue when merging.
>
> This series tries to clean up unnecessary #ifdefs as much as possible.
>
> Further cleanups may need to refactor the XIP code as Alexandre's patch
> does.
>
> [1] http://lists.infradead.org/pipermail/linux-riscv/2021-December/010607.html
>
>
> Since v1:
>  - collect Reviewed-by tag.
>  - remove the __maybe_unused used in max_mapped_addr declaration.
>  - remove the BUG_ON check of mapping the last 4K bytes of the
>    addressable memory since "this is true for every kernel actually"
>    as pointed out by Alexandre.
>
> Jisheng Zhang (5):
>   riscv: mm: init: remove unnecessary "#ifdef CONFIG_CRASH_DUMP"
>   riscv: mm: init: try best to use IS_ENABLED(CONFIG_64BIT) instead of
>     #ifdef
>   riscv: mm: init: remove _pt_ops and use pt_ops directly
>   riscv: mm: init: try IS_ENABLED(CONFIG_XIP_KERNEL) instead of #ifdef
>   riscv: mm: init: try best to remove #ifdef CONFIG_XIP_KERNEL usage
>
>  arch/riscv/mm/init.c | 76 ++++++++++++++++----------------------------
>  1 file changed, 27 insertions(+), 49 deletions(-)

Thanks, these look good.  I've put them on a staging branch that will 
soon be for-next, I'd like to start from after my recent PR's merge 
(assuming it's merged).
