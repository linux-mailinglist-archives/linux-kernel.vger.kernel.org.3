Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E4749C244
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 04:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbiAZDqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 22:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237262AbiAZDqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 22:46:18 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BAEC061744
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 19:46:17 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id k17so12427816ybk.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 19:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=zagVcLcxW/306zQ95MLQdaR817NjpVNSNXTFCb2vwNM=;
        b=FpJr/rdGsJKk5iPxlVsB2ENh0i8xgNEGbbPu6t+Tx7aw41QuydVieaMAYWaUkhxdGd
         L5DQGIUDul8c9f0UyUqF6Z8DlhHE/Wpq8a/G/Xl0Ws/s7FB2g3KlKrqTMyDbS6p2ZCSI
         27aNR/0vhNESca8Yd9kQGHxPyLlM6aGpJw8EegC1GxIw8Oquy89LT8Eqier1mPTPHdRL
         DhJWJQ+89N7S+zaPU2qYjuaqRVl2GcalhPjzwNxSB7hJU+O78lwYhg0/QZs88EpYUMG4
         bI3P9EbH/OGwHTtfdxBObxqIue5BudY4N1cERlXMqX/5Ueo51SMVFc9scvA+ROpIyX1k
         q1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zagVcLcxW/306zQ95MLQdaR817NjpVNSNXTFCb2vwNM=;
        b=MIloT6sNJ8KP7+s64xpfn7rsQTgy++ABWwZWpSGDchXKSa4skPwZXa831F1Nkm1KJI
         HK/PD84hkgR6IWiQstj4OuhK0dTQBSKsHQeQS4Pw6J4RyGlGaRY8BNU9nOeOYU5pSzWg
         cz/79KSyFJ8CpfvVAs8OatD/X0VNsiroYeBuU1Ok3iscmgh2np+D3mrq6lNjnrDgLMPR
         84hyj89QS4yvcreHRelyzwISxqoORZ+gyrfxdNHLKpfK+KF/oENP2CnAts3He74Ueh4T
         WYEH+aetQyLbpy0JezytYQNBkesxWL0HCpSQauFAwEjsutWBfCUcZ60kHNZKyGPLuOgw
         XTvQ==
X-Gm-Message-State: AOAM533imYj3Qrff1nSNlVtNOop7Txy6+z3Jf97KeLrAaUJBq7RDNEOo
        wWZlfXu8MiUMPtInuG2DGl2ujb0ZW8yd7XRc+tYdM8971Nk=
X-Google-Smtp-Source: ABdhPJwWOuZTNstXu1gAx61m06SEgUumKLVHt+fhYawa0tif34I+N9ojyP6jF7B2Eh6k73GppraZmQft40K++2kJmrw=
X-Received: by 2002:a25:afd2:: with SMTP id d18mr33511928ybj.709.1643168776676;
 Tue, 25 Jan 2022 19:46:16 -0800 (PST)
MIME-Version: 1.0
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 25 Jan 2022 19:45:40 -0800
Message-ID: <CAGETcx_4ATDk3nNfu6kBwUVN4nfxcHHUMnCKYsLTDoA1TFLmrw@mail.gmail.com>
Subject: Relation between MMC_CAP_WAIT_WHILE_BUSY and card_busy()
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to understand the MMC suspend path a bit.

I looked at the commit message of 6fa79651cc808f68db6f6f297be5a950ccd5dffb.

IIUC, if MMC_CAP_WAIT_WHILE_BUSY is set then the mmc framework is
going to depend on the card_busy() op to ensure correctness instead of
using the S_A_TIMEOUT value from the card.

But I see a lot of mmc host drivers that implement card_busy() but
don't set the MMC_CAP_WAIT_WHILE_BUSY flag. That doesn't seem right to
me if my understanding is correct.

If it's supposed to be "we'll use card_busy() if
MMC_CAP_WAIT_WHILE_BUSY isn't set", then why do we have some mmc host
drivers that have both?

What am I misunderstanding?

-Saravana
