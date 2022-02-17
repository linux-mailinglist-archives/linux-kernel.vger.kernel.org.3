Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0E94B9F97
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 13:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240138AbiBQMCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 07:02:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240210AbiBQMCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:02:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4246305
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 04:02:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D568A612D1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 12:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F390C340E9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 12:02:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BorPETqJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645099325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nCRtd9pKms2My+4fOdrY97sIPH9oqF8HF91XcKL/ML8=;
        b=BorPETqJnKcA2ZaG6Dd0heLU3Uw1v4lq0ptLs8emoe9Hax8xPVho8wbXhlLBYIeoQI4ez3
        cyFbWvG7QNkiMPEGPF9B7z5DVl0KyyZR6g+hjDCIO9i4LzJEATS1Is7+/fiScq9cvJo8qW
        Mt2wEEpL+l0VMXT69nSojPn8FaNS4O0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 22c7d7c1 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Thu, 17 Feb 2022 12:02:05 +0000 (UTC)
Received: by mail-yb1-f175.google.com with SMTP id j12so12508965ybh.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 04:02:05 -0800 (PST)
X-Gm-Message-State: AOAM532izqWFD78u0trhsx/pR6Mz/PIuXJLjGJwoVSpDFx8exEuwR72/
        +c/QN1rI6XSpJzG/wHwN8fhXRGlGNWh7JTRmUOY=
X-Google-Smtp-Source: ABdhPJxqV4CruHjyDFnQhvVF5c53pQ5L7IK+pVx9YR4U6Y4OL7sR35z1LgqYdFsXMSHCqeiaOq2jR5n9jnixhfs3BvU=
X-Received: by 2002:a05:6902:102a:b0:614:105b:33a6 with SMTP id
 x10-20020a056902102a00b00614105b33a6mr2066427ybt.457.1645099324181; Thu, 17
 Feb 2022 04:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20220215212255.273253-1-Jason@zx2c4.com> <20220215212255.273253-2-Jason@zx2c4.com>
In-Reply-To: <20220215212255.273253-2-Jason@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 17 Feb 2022 13:01:53 +0100
X-Gmail-Original-Message-ID: <CAHmME9q6gv8mseUUsYvj7t=m6h0cCfzj7TvFBJW-MSpV8L4fcQ@mail.gmail.com>
Message-ID: <CAHmME9q6gv8mseUUsYvj7t=m6h0cCfzj7TvFBJW-MSpV8L4fcQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] random: set fast pool count to zero in cpuhp prepare
To:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>
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

Alas I've finally realized the rollback logic makes this inoperable
too, in which those workers are unbound at one phase, but then we
never hit this stage, so we never zero them back. So, a v5 is coming
up, where I'll implement basically your exact suggestion from before.
