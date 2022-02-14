Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC984B5395
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355268AbiBNOnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:43:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiBNOnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:43:17 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514B549FB8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:43:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A2216CE16FF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 14:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1A4C340F1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 14:43:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nk0yicDi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644849783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L1/A2sgnOG6SwapQuBr82hR2cRlnGZGQzKquDbzv/Jc=;
        b=nk0yicDiotDwcFOXVsFYJfYhDzyDQmVS/rRpAFjtYHISOtfqce5/EDTFk08iA+4SZ/3kHf
        I/5NfMsBfMjfCsScEGPTUz6sE2RnSdXrlvW0D8q0KdrrawFPS97CBoyecJ4NBMmxZyKhzP
        Af77Kn3muhIBfCZUk1zeuWF30wNLUEQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 582acfce (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 14 Feb 2022 14:43:03 +0000 (UTC)
Received: by mail-yb1-f182.google.com with SMTP id y6so46740105ybc.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:43:02 -0800 (PST)
X-Gm-Message-State: AOAM530N5PBWNVEuXGgJZD9Z92BNxLKdwUodqvGOb62pKyS8vKo3UHJu
        4P2/uVmMKYC/WJNZQDJ7ixH4tmh+V5BX94ZNRrc=
X-Google-Smtp-Source: ABdhPJzjQej7toXtC+WHEYR0YumYLQb1qtZKk39kwuFu9iGrIKIhs0xZsPKnwU/Po4JYFP3SgLGuL0WLNVT0NfVy5vU=
X-Received: by 2002:a81:f10b:: with SMTP id h11mr14610607ywm.396.1644849781133;
 Mon, 14 Feb 2022 06:43:01 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9rAnh6nSRNYo56Ty6VSrY17ej35AoNkSjunFO0AQp1D9Q@mail.gmail.com>
 <20220214133735.966528-1-Jason@zx2c4.com> <Ygpkej/vnMvUDIlP@linutronix.de>
In-Reply-To: <Ygpkej/vnMvUDIlP@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 14 Feb 2022 15:42:50 +0100
X-Gmail-Original-Message-ID: <CAHmME9ruM85U+dp4coBRJUBdk=iHXFZq3ZvHSiDXmpV+BoZEVw@mail.gmail.com>
Message-ID: <CAHmME9ruM85U+dp4coBRJUBdk=iHXFZq3ZvHSiDXmpV+BoZEVw@mail.gmail.com>
Subject: Re: [PATCH v2] random: set fast pool count to zero in cpuhp teardown
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
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

Hi Sebastian,

If we move this to startup, is there a phase during which no interrupt
will arrive? That is, can this happen very very early in startup, so
that zeroing out count happens *before* ++count?

Jason
