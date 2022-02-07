Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6854AC1B2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 15:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383150AbiBGOoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 09:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392210AbiBGOYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:24:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE0BC0401C2;
        Mon,  7 Feb 2022 06:24:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3C17B8136F;
        Mon,  7 Feb 2022 14:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5159CC340F2;
        Mon,  7 Feb 2022 14:24:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EJptf/Rh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644243865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sat8E1tiLvvQuV2M3dRQ4694vndy92NxnxVuIgUTXSc=;
        b=EJptf/RhjGMCdfLndkTh9BWEo1yaVHQLl1dbMCOOrXfx3iHwPorpgBFQ9oiHhtRf9wQw7Z
        XLj+Nk2l0fsdTK6ybx1+pnzksfgnkNO37yWTdB/pfY0/jngXKOgrghme08PCmw22+L5nF4
        ixQhsy5m5zEhNl7MSwTMd6EHnaejtRM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f3059567 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 7 Feb 2022 14:24:24 +0000 (UTC)
Received: by mail-yb1-f176.google.com with SMTP id c6so40468845ybk.3;
        Mon, 07 Feb 2022 06:24:24 -0800 (PST)
X-Gm-Message-State: AOAM5326qtY9y41DMqlHX/wquVfTbxTF3opwO6t2OqjFjrq1s4VeX6p5
        GIaxVHNx8EuqDIISRapI5xitD5hdlFdgv5y8tG0=
X-Google-Smtp-Source: ABdhPJxAjn/rrKuByy78SS8kJGQwbNV9PXyg238aFeegpeUk+TR0DXSdKE+I6jzCEEx8VFLKmMWCbH7vhOMa2/KS16U=
X-Received: by 2002:a81:c646:: with SMTP id q6mr5732607ywj.485.1644243863259;
 Mon, 07 Feb 2022 06:24:23 -0800 (PST)
MIME-Version: 1.0
References: <20220204135325.8327-1-Jason@zx2c4.com> <20220204135325.8327-2-Jason@zx2c4.com>
 <Yf4z+Rc+69siZ0/N@owl.dominikbrodowski.net> <CAHmME9pTDCUb7pAMeCMnU=jiAQd=ctrWN4K7s=8DqCtiOqbkrg@mail.gmail.com>
 <CAHmME9q-hfSRegD0azEX0Z+5uNGCyS3N4VhMPqp206zP+WjZtg@mail.gmail.com>
In-Reply-To: <CAHmME9q-hfSRegD0azEX0Z+5uNGCyS3N4VhMPqp206zP+WjZtg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 7 Feb 2022 15:24:11 +0100
X-Gmail-Original-Message-ID: <CAHmME9po1ybEsM6G7=2o73cVV5ESdrwcNO6QW+CdOSmorbQq_Q@mail.gmail.com>
Message-ID: <CAHmME9po1ybEsM6G7=2o73cVV5ESdrwcNO6QW+CdOSmorbQq_Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] random: use computational hash for entropy extraction
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Dominik,

I just noticed that we use RDSEED in crng_reseed(). I would think we
could remove that and stick to having RDSEED used in extract entropy
as you suggested. I'm now pretty sure the older decision boiled down
to the 10 bytes vs 5 minutes thing, as discussed before. So please
feel free to send a patch doing just this.

Jason
