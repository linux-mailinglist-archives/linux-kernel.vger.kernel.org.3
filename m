Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B3B4834D5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiACQgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiACQgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:36:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C00CC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 08:36:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D47A6114A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 16:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1DAC36AEF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 16:36:40 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VgrgPLG+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641227798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DsEvNmoTH8Azrn9drFViG44IjQFbTxtdM+ncXLPGeKc=;
        b=VgrgPLG+2jfp9CNvT+l7SwGGNferOR4ee48jIKlI1DOshAIYJQsv9hVEOeq+thzE8xTf58
        OXDlHYTFT2GX0TIdr7DWETnEXcxoMYV4IUP94DF3w0HPztVe40F8DZe7q4HUQSVrZwQYFt
        vodsI5Ah+p7AxpA/SS+vQDndl4nBUMg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 93707ad5 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 3 Jan 2022 16:36:38 +0000 (UTC)
Received: by mail-yb1-f175.google.com with SMTP id e202so57793657ybf.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 08:36:38 -0800 (PST)
X-Gm-Message-State: AOAM533gw3wLx73mQv8WstjP/6/EUxoWKprQ0c7hbKtcZEjwg+9f6F3y
        PDpAxWFJr2NrkdOvMM5POEIADCY2Z7g5hQ3K+Z8=
X-Google-Smtp-Source: ABdhPJxT1UlOMEJnw8ZNAfu41X7rYiT5nVcMjawaLZg1iCcG2QXIF3DZWJph872Tf7iFB8ZXC1zVxSA66LgJQeHYvds=
X-Received: by 2002:a25:8c4:: with SMTP id 187mr7371821ybi.245.1641227797232;
 Mon, 03 Jan 2022 08:36:37 -0800 (PST)
MIME-Version: 1.0
References: <20220103160002.1068356-1-Jason@zx2c4.com> <CAG48ez2FfXLfCiF5PZdyUM4oZVCL0MtN8+mT6Zb-7kn69-Xs8A@mail.gmail.com>
In-Reply-To: <CAG48ez2FfXLfCiF5PZdyUM4oZVCL0MtN8+mT6Zb-7kn69-Xs8A@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 3 Jan 2022 17:36:26 +0100
X-Gmail-Original-Message-ID: <CAHmME9r7QpF_SRXUMSj_rhQFwne3jaYqfDsYo_m+u1fhjeAT0A@mail.gmail.com>
Message-ID: <CAHmME9r7QpF_SRXUMSj_rhQFwne3jaYqfDsYo_m+u1fhjeAT0A@mail.gmail.com>
Subject: Re: [PATCH] random: reseed in RNDRESEEDCRNG for the !crng_ready() case
To:     Jann Horn <jannh@google.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Related discussion: https://github.com/systemd/systemd/issues/21983

As of now, I'm not totally convinced this makes sense to apply, but
we'll see where this exploration goes.

Jason
