Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E047B4B4D7E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349602AbiBNKxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:53:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349230AbiBNKwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:52:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C49B6D4F3;
        Mon, 14 Feb 2022 02:17:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0BE7B80CE1;
        Mon, 14 Feb 2022 10:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294DFC340E9;
        Mon, 14 Feb 2022 10:17:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GMTy9/EB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644833843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jw405377p5pf78FxoLUva1syQCUGCgspeYSlO0IejV4=;
        b=GMTy9/EB5tvbuSzl4i1XKCjQG22qMWmmiWB8Q58w0XqR+nii/eKMIhotStFOmv4KY2OBN6
        EquKXuFi7KfMaCw8qrdT86DvNbBT06mgQrXpHtXOV+vO8wZxyHfoEMXrtr/F9xNqQLE//8
        V22IUBtaU+ur+GAOhx8pMm3Cx/tk0lI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cbe58d8c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 14 Feb 2022 10:17:23 +0000 (UTC)
Received: by mail-yb1-f175.google.com with SMTP id y129so44506406ybe.7;
        Mon, 14 Feb 2022 02:17:22 -0800 (PST)
X-Gm-Message-State: AOAM531Zj1WK4Jf1vUTLCheS+MTrUDHffZ+aNaeNfGl+M9nc1kfEXHN5
        YX5u0Ggcg4LZZQjDXfhJ5aGQ1X2a5P7xySPiweY=
X-Google-Smtp-Source: ABdhPJypKR734I9ZoaN1nIvZPaPH70+bSE5lKqUpay4t8mJCk+EWO5LpYh+k6Jm4Xufe+s0nfpAKcWEa/qD1EiRVksw=
X-Received: by 2002:a25:c006:: with SMTP id c6mr11165505ybf.457.1644833841790;
 Mon, 14 Feb 2022 02:17:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:88a:b0:15e:9450:8ed4 with HTTP; Mon, 14 Feb 2022
 02:17:20 -0800 (PST)
In-Reply-To: <YgoeBYJ5nwc8BTG3@linutronix.de>
References: <YgZ6IEbiDgz5X1ON@linutronix.de> <20220211162515.554867-1-Jason@zx2c4.com>
 <YgaSYlVEBOxfJbSD@linutronix.de> <CAHmME9rC_q4LGq2JaAAeGbtRA2cibTe9bnvhMLng+QnzAy2DVg@mail.gmail.com>
 <YgaV0UZO1KfmtLLh@linutronix.de> <CAHmME9rsOWuprpYqo9G9eUboQwUxRgWqYRYgyHG7cNOG16c5EA@mail.gmail.com>
 <YgoeBYJ5nwc8BTG3@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 14 Feb 2022 11:17:20 +0100
X-Gmail-Original-Message-ID: <CAHmME9otmV1QCX29D_DXsHB-41puTKurWtyZ39huPZtD4mt5ng@mail.gmail.com>
Message-ID: <CAHmME9otmV1QCX29D_DXsHB-41puTKurWtyZ39huPZtD4mt5ng@mail.gmail.com>
Subject: Re: [PATCH v6] random: defer fast pool mixing to worker
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
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

On 2/14/22, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> to
> | - Does anything anywhere call get_random_xx() before the worker has a
> |   chance to run?
>
> Once you queue a work item I don't think that the scheduler needs to put
> it on the CPU right away. It may have already have other tasks waiting
> including some with a RT priority.
> Also, the lock is irqsave() so they can be users in an interrupt
> handler. I remember the original reason why I made it irqsave is because
> something did kmalloc() and SLUB somehow asked for random bits.

Right. So there are two sides of the questions: 1) how bad is this
actual race, and are there any drivers that do regularly get bit by
this? 2) There's a largeish window between workqueue_init_early()
setting up the system highprio workqueue, and workqueue_init()
enabling queued workers to actually run. Interrupts also get enabled
in the interim. Does anything get bit by that window?

Jason
