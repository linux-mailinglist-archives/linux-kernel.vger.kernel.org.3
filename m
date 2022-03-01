Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921754C9822
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 23:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238640AbiCAWGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 17:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiCAWGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 17:06:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F53199EFB
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 14:05:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3889CCE1FCB
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 22:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E57C340EF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 22:05:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VMYS0QEb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646172332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NROhPZBBdUhvuuqfuEPD7Pt5ktStnJaZNMKtsa5p1vc=;
        b=VMYS0QEbbI7HORgEJQ+jEqOO1cmbRNehPByu66h+/7o6NohcaziaFuRy7LdFGsjmXwQR39
        P5js2lygCQfPHUFaTJbHiOzFrNQuC/GnOPPyuA2uWNgOmBs032KIAyAV5yinwUkPhkJqy3
        AKFSeehNKzAXduWmuY1djOWYiY9t72o=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e253f58c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 1 Mar 2022 22:05:32 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2d6d0cb5da4so160228807b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 14:05:32 -0800 (PST)
X-Gm-Message-State: AOAM5315K8R5JVF7BQs9j28Wnmv3dCX6hCW3T+x5fKKh0rrPHCfDQmSm
        PwmItG8YlxnaJaUhx1b5vtXnQb8kxikzDH2Qv/8=
X-Google-Smtp-Source: ABdhPJyL6mIYvqmSei/2uxtrTkFdWxKfzERpuiL2dbtUYVGqDJ6Lo8duzN/GNSxNs3c0Fq4hLEPKypzZdDLaZpAXg5w=
X-Received: by 2002:a0d:e005:0:b0:2d7:fb79:8f36 with SMTP id
 j5-20020a0de005000000b002d7fb798f36mr28805418ywe.404.1646172331470; Tue, 01
 Mar 2022 14:05:31 -0800 (PST)
MIME-Version: 1.0
References: <20220301142528.243059-1-Jason@zx2c4.com> <Yh5tPt2LoLp442zi@mit.edu>
In-Reply-To: <Yh5tPt2LoLp442zi@mit.edu>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 1 Mar 2022 23:05:20 +0100
X-Gmail-Original-Message-ID: <CAHmME9rdm0gQ0ZA4-7tTvNwd5a+TYRaPjWbcO3Rm5VoyLZbNnw@mail.gmail.com>
Message-ID: <CAHmME9rdm0gQ0ZA4-7tTvNwd5a+TYRaPjWbcO3Rm5VoyLZbNnw@mail.gmail.com>
Subject: Re: [PATCH] random: do not export add_vmfork_randomness() unless needed
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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

Hi Ted,

On Tue, Mar 1, 2022 at 8:00 PM Theodore Ts'o <tytso@mit.edu> wrote:
> How about only exporting add_vmfork_randomness if VMGENID is compiled
> as a module?  If it's built-in to the kernel, no need to export the
> symbol.

Sure, good idea. I'll send a v2.

Jason
