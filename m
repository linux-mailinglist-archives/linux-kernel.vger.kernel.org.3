Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E9D4B3B8D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 14:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbiBMNQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 08:16:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiBMNQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 08:16:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9083A5E14E
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 05:16:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DD9661183
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 13:16:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404D4C340F0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 13:16:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lNBamou8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644758208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/ixzl5PJzZcYy5WFIrfxd1NHQZrCmlZLEceiWPqAQiQ=;
        b=lNBamou87EdrsttTKiYn2f7mneNOAY1KoaEJi81lnPBZkEt2pFqi0yKfoSYk6SorDK9Aib
        yIcR4WG50vJO8P4KtCSA1kew+IkRHsZy1X3r39+XpZftb639DH/oqw2MhWIFgduqqNubhQ
        fh72zHQbxZq32uduPt9RIZhJF6Ua7nQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 27f18566 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Sun, 13 Feb 2022 13:16:48 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id j2so38763711ybu.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 05:16:48 -0800 (PST)
X-Gm-Message-State: AOAM530QvPsMyBUF8POijCe9KXOQeD/hWt6BkHoKcMYuuHibm7KtvV6X
        nbWE3EH29qXDzuWsR47Gcder90ItNpr4GCnp4Pc=
X-Google-Smtp-Source: ABdhPJytYqsvMfU+iwWILnuTpVjldne4dvYJ+na6RRmhRiUQVczem+KPnQAgEN/aBgbb7l6yZL5uoaPJXf9Zz/bT8Ao=
X-Received: by 2002:a25:42:: with SMTP id 63mr8282410yba.245.1644758207397;
 Sun, 13 Feb 2022 05:16:47 -0800 (PST)
MIME-Version: 1.0
References: <20220212122318.623435-1-Jason@zx2c4.com> <20220212122318.623435-8-Jason@zx2c4.com>
 <YgirNWqk6d4y/Z0k@owl.dominikbrodowski.net>
In-Reply-To: <YgirNWqk6d4y/Z0k@owl.dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 13 Feb 2022 14:16:36 +0100
X-Gmail-Original-Message-ID: <CAHmME9qneKvE8WKS8Y=BXkLUg3UvpARjibZmbLDERLkqmFsFVg@mail.gmail.com>
Message-ID: <CAHmME9qneKvE8WKS8Y=BXkLUg3UvpARjibZmbLDERLkqmFsFVg@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] random: group entropy collection functions
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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

Nice catch. Fixed.

Jason
