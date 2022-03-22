Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058804E37C7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 05:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236273AbiCVECO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 00:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiCVECG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 00:02:06 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017615F93
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 21:00:39 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 5so9561420lfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 21:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JLOgWgapC5LbjRMZnf3mts13pKbjy4ygNLAd0qKfGls=;
        b=cdc7GpVrI0zcK39IPv9L+gcUSEhYmB2rprwN8ri5f073/Vz2TjFezln5gK5nPCGVfT
         36UbdGnLCUJfLBzDJbKRl70yPyADMWXvUGe2v5xJ5KvYvagUsbBSsnyN4KNBaID63jAY
         QBSe5FrF7RHN+8wn0oGyv2YoXciL3vHSkcFeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JLOgWgapC5LbjRMZnf3mts13pKbjy4ygNLAd0qKfGls=;
        b=3/JvZQwO/zOHD8Ndj6/MfltMH4SX9/L2+u+pEpFvzVrtdhN45H/boLJtxmGFHqHEk9
         4xzWRigS+jvtqnMlghtvY25WWGiUpbkk5D7twqsLx7qrfH51ymcxGq8MCdgZHHjBJoi4
         GQqEcek5BviPR+u2v92tOKIsizcUngzE9c0Rw5t1gzAEDfzmpBV3TXSQtT+h4OlGg1/+
         HNgUUu2zgLM2ztHZ/lDuRpSvOzeNSHFD4LrXPyBGgnhOtY1cHwI63s7XNbZEczZJRjCB
         i6vvUPwSpPNipEjtiC/kaCpgVvJl8yMMYEZwmYe4L1oHVAArF0BLC12kiV9sFsCfh600
         +Tnw==
X-Gm-Message-State: AOAM531ftRaXMecvC9ILq6dhzUvb+cdXB030nC/YXz99KJ10IBkmMD1H
        mqdvgYFYpLHKKw1fLBvngta4YhVN+oY7t5Y3z2w=
X-Google-Smtp-Source: ABdhPJwoOOPCZXyEc2Nt8k6aMzmVH7j5SqY1rEbWd3PQp6MZpjuSeX2c1T6X3kEBacMSmW0xDzU07g==
X-Received: by 2002:a05:6512:131a:b0:44a:35fd:993a with SMTP id x26-20020a056512131a00b0044a35fd993amr2557188lfu.652.1647921638121;
        Mon, 21 Mar 2022 21:00:38 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id i6-20020a0565123e0600b0044a359aa456sm266893lfv.212.2022.03.21.21.00.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 21:00:37 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id bu29so27817766lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 21:00:36 -0700 (PDT)
X-Received: by 2002:ac2:4f92:0:b0:448:7eab:c004 with SMTP id
 z18-20020ac24f92000000b004487eabc004mr16561843lfs.27.1647921636431; Mon, 21
 Mar 2022 21:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <164786764630.1025645.12332376420230352947.stgit@warthog.procyon.org.uk>
In-Reply-To: <164786764630.1025645.12332376420230352947.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Mar 2022 21:00:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wipjbxwH+w-w8QMjPY7f0UFskLOb4smmDRe_7HtyxoHEw@mail.gmail.com>
Message-ID: <CAHk-=wipjbxwH+w-w8QMjPY7f0UFskLOb4smmDRe_7HtyxoHEw@mail.gmail.com>
Subject: Re: [PATCH 0/2] watch_queue: A couple more fixes
To:     David Howells <dhowells@redhat.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Jann Horn <jannh@google.com>, keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 6:01 AM David Howells <dhowells@redhat.com> wrote:
>
> The fixes are also available through git:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=keys-fixes

You have the dubious distinction of being the second pull today that
didn't use a signed tag.

Of 46 pulls today, only two were untagged branches, with the rest
using signed tags.

              Linus
