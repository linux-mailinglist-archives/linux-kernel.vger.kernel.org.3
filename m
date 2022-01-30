Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62EF4A3AA9
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 23:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347305AbiA3WLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 17:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbiA3WLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 17:11:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3F9C061714;
        Sun, 30 Jan 2022 14:11:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C8B960F56;
        Sun, 30 Jan 2022 22:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A79C340F0;
        Sun, 30 Jan 2022 22:11:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZieIF+Zt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1643580694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uRZLXEx3stOo+Fw99m6DF9FCecBK8WcMAuX7T5+D73s=;
        b=ZieIF+ZtkbrhNcYR4XYuYkpQrGwBvJAyUsxhxAdVdOVcw0jTSphQXPxgG8GQIIdTO7P93c
        9TZBs2qHS7qSQcxpwsJuCLmzBcTOSMcd6AIRyzfq5C7cy1jYwl3dDpW/Iq8Wpv0M53IRwh
        4iZQBr0Z3BRSYUR7RVNyMqFQyf4nVMc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fa973cf0 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 30 Jan 2022 22:11:33 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id i62so34922631ybg.5;
        Sun, 30 Jan 2022 14:11:33 -0800 (PST)
X-Gm-Message-State: AOAM530gT4EZmKL14vD1KNxuiG3pzoi/STrI+dnIPNOhhWmSGTP1nxnl
        +DA6MRBUNVoR7D5X5sbLOkkVnWEfHl4bdQTVKFE=
X-Google-Smtp-Source: ABdhPJym+NAKdv9tbiCVpR0v+0fMfgUraCnN2KqjfK7jOGa5zM7lfhOgLkURjTemEAhRav6fRDnIgjkbqKUeAVRIYp8=
X-Received: by 2002:a25:c70f:: with SMTP id w15mr26945635ybe.32.1643580692837;
 Sun, 30 Jan 2022 14:11:32 -0800 (PST)
MIME-Version: 1.0
References: <20220130210320.3997-1-linux@dominikbrodowski.net> <20220130210320.3997-2-linux@dominikbrodowski.net>
In-Reply-To: <20220130210320.3997-2-linux@dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 30 Jan 2022 23:11:22 +0100
X-Gmail-Original-Message-ID: <CAHmME9rqoweMb5zO95B1QsAHRFkSmcumbJKZTA+tqqRHN3mzGw@mail.gmail.com>
Message-ID: <CAHmME9rqoweMb5zO95B1QsAHRFkSmcumbJKZTA+tqqRHN3mzGw@mail.gmail.com>
Subject: Re: [PATCH 2/2] random: only call crng_finalize_init() for primary_crng
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I'll apply this. I do wonder, though, do we have locking
concerns around crng_init transitioning from 1 to 2, or with calls to
crng_need_final_init? For example, can crng_reseed be called at the
same time as rand_initialize? Or are we still single core at this
point in the boot sequence? I don't think that this patch changes
anything from that perspective, which is why it seems reasonable to
apply, but I do wonder.

Jason
