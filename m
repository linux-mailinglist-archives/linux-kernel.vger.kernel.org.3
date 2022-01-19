Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA644937D0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353351AbiASJ4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:56:02 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54730 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351759AbiASJz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:55:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57DB7B81916;
        Wed, 19 Jan 2022 09:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3027C340EB;
        Wed, 19 Jan 2022 09:55:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Z/xBQThn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642586150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SKXS+607Wp2jjel6Jj9GRFNgGoTj5LRUomKHD9Jf0q0=;
        b=Z/xBQThn4dOhNbf+0kibnSc52nIZkMM3KQQxp6U9/1PgFCghS+nrTjPXu2s8WSSy8FMcYx
        tYTVWvwPY2JziclQmFYDrbeAwzmBUuaVu3EFPRPnNdtpZBp/gFMngqNefAYQp8bjWPcZyQ
        x+dqCCo+Ttvr6Bf8Or8iuFC4+gxjQI4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8c2e8ff7 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 19 Jan 2022 09:55:50 +0000 (UTC)
Received: by mail-yb1-f172.google.com with SMTP id l68so5169215ybl.0;
        Wed, 19 Jan 2022 01:55:50 -0800 (PST)
X-Gm-Message-State: AOAM533138uD0ajhc3xrRGVEa1ynTtpFNbO9uirNIWYUjdA5svQzbFX2
        cIYMAoxNhB4A2/G6HKyJB0vIWOrA8WgoLBKzqyQ=
X-Google-Smtp-Source: ABdhPJxRwv4/wvglAbm3F6pwOwbbu4Fs+IC9Ms5MBl/Up/EpNJDUYPYHj1w6P04OD+aB/2YfZnyy2UCxrn9RxDSrXeo=
X-Received: by 2002:a25:c709:: with SMTP id w9mr16348576ybe.638.1642586148339;
 Wed, 19 Jan 2022 01:55:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:209:b0:11c:1b85:d007 with HTTP; Wed, 19 Jan 2022
 01:55:47 -0800 (PST)
In-Reply-To: <20220119092440.4045-1-miles.chen@mediatek.com>
References: <CAHmME9pv4WWATjdqZgwrtHDmq3sX4ABfB9PoNT9Z4tSEduR2Lw@mail.gmail.com>
 <20220119092440.4045-1-miles.chen@mediatek.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 19 Jan 2022 10:55:47 +0100
X-Gmail-Original-Message-ID: <CAHmME9oX+4Ek81xy0nBOegqABH0xYqyONAqinsu7GZ7AaQaqYQ@mail.gmail.com>
Message-ID: <CAHmME9oX+4Ek81xy0nBOegqABH0xYqyONAqinsu7GZ7AaQaqYQ@mail.gmail.com>
Subject: Re: [PATCH] lib/crypto: blake2s: fix a CFI failure
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     ndesaulniers@google.com, nathan@kernel.org, ardb@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        herbert@gondor.apana.org.au, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miles,

I'm actually not able to reproduce your oops. I'm using vanilla clang
13, cross compiling for arm64, with thin LTO enabled and CFI enabled.
Kernel seems to run fine.

Are there other settings that are needed to trigger this? Do you see
it in upstream clang or just the Android fork of clang?

Jason
