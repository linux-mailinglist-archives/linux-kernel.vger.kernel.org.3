Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6778448B933
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 22:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237153AbiAKVMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 16:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbiAKVMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 16:12:39 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3BEC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 13:12:39 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so7665050pjf.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 13:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sHIrLuWSttD4lmfZ9Q8HhbdiLbHiGuhFTojquYXKcA0=;
        b=fNoM72BJOADBZrfkcZR2kFweu7XYah6CaTKDHnvkleM4auBTmmlsE5Pkscb5JTVK75
         6MgHTAz6RXt/80FxFsPoPFGnyyXwQL6qa3qRAkEoUMSiUEWP9jqS6DoRfJwrxHcqYGt5
         JKZml3WD650oQTKOJ6kLrlT/5hilSRpqNDF+MoAD98Fp7IMy6e/yNS++xqxwcdw1IIR4
         Ox2cvnvE/QxC9Kt2Knd1QN6oBXcIDgQegdj19fCsbzLFQsZCP1DA5c7nohfd9ble18hR
         PA1WYdAi+i5y7ddD9u/SANIpmJD6zXQnZD4Lh27qVlJs44ePzx8H+PuC2++O3aS9LsTL
         +qnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sHIrLuWSttD4lmfZ9Q8HhbdiLbHiGuhFTojquYXKcA0=;
        b=TcCW6OTJWn2xjz49o37Xo59zL/kgSzi/x1cC1xli/K/hoV0Tlv4MURTFdof3fy+YOu
         65xUE9y6+2D7OQTVvvsx7lVJ7LaagBzuynt/CuRz8k4yEPUcrpMNN9pPTvbaIPrgPsuV
         +NWcFYaBEZclzKyYrlp1J9OQz48r7ihxssB16115FfbhVikSqp/T3HMGwUGCQoGkQl5E
         jLaP4cNfX8uH6yqo6dRCYhDC04Mg1GmyFL6NghrGZGi4zW6SJmb/cQjgUT9KU0bunXji
         LcNCv4fmzOzfSii9dGxtgc//r22ntU1U3PccyswZqgYW13TJwNZd0Y7mGVANi+d2Sz19
         xrhw==
X-Gm-Message-State: AOAM533lT3eLN/0re7uXmKeWudrV6NryBVfOrf8YPMfh6h6byJCeDMaf
        /X5J8FsY/ZZTjSAZ5uYSTUE=
X-Google-Smtp-Source: ABdhPJxxSpK9L+cVEjOtSqpwT/SvuTp7xmQuCE6EPRu0m4WF+SEtKmuZHoQoYXopsaa18qeWmEAENg==
X-Received: by 2002:a05:6a00:1582:b0:4ba:e636:391 with SMTP id u2-20020a056a00158200b004bae6360391mr6387750pfk.55.1641935558715;
        Tue, 11 Jan 2022 13:12:38 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id g11sm1269385pfv.136.2022.01.11.13.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 13:12:37 -0800 (PST)
Date:   Wed, 12 Jan 2022 06:12:36 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Randy Dunlap <rdunlap@infradead.org>,
        Openrisc <openrisc@lists.librecores.org>
Subject: Re: [PATCH] openrisc: init: Add support for common clk
Message-ID: <Yd3yxCPpK81psViU@antec>
References: <20220111030055.2043568-1-shorne@gmail.com>
 <CAMuHMdUUShmJfRWUCS+CQ_OUW9cUHuZQS3aTPznt-i+TT0Tgtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUUShmJfRWUCS+CQ_OUW9cUHuZQS3aTPznt-i+TT0Tgtw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 05:31:05PM +0100, Geert Uytterhoeven wrote:
> Hi Stafford,
> 
> On Tue, Jan 11, 2022 at 4:01 AM Stafford Horne <shorne@gmail.com> wrote:
> > When testing the new litex_mmc driver it was found to not work on
> > OpenRISC due to missing support for common clk.  This patch does the
> > basic initialization to allow OpenRISC to use the common clk framework.
> >
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> 
> Thanks for your patch!
> 
> This matches what other architectures are doing, and is IMHO the way
> forward for sharing FPGA drivers among architectures.
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thank you.

-Stafford
