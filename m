Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F274B0E23
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241997AbiBJNKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:10:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238484AbiBJNKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:10:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ED71A7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 05:10:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A0C260B67
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C18BC340E5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:10:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jXgH8Uz1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644498601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ijDQDPy54u9AUaU/mz0+DASk0TlJm8pfU44VX9Nz0/U=;
        b=jXgH8Uz1vJqI9EsDfmXHwsPpfTriO9X3qFaghU7oKcgy1kHExpyUW9kAYQufyLl3xPXLaZ
        LrqEyg4HO5eIa6nKS1JJtmCHpx9Guq/RlQnS/KDCO6+/bJRKYzfemqB4wTqRpTRDVCWRSh
        20btos+8mW7Z1ybC56Mr8mbJM+ou/Uw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8e83ad5c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Thu, 10 Feb 2022 13:10:01 +0000 (UTC)
Received: by mail-yb1-f176.google.com with SMTP id y129so15216732ybe.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 05:10:01 -0800 (PST)
X-Gm-Message-State: AOAM530vX06xHTLUR05ssZtfYkEh90+l4JV/ajagGQbj9LeBxfaDH7BY
        5s5TqWsPy4ieS2suy3jJn6oBKCz5l74WUMveuGY=
X-Google-Smtp-Source: ABdhPJxfn+zuTIDkInCes+74yzi8lk4ZmxaKlx5kMQFK2fSeZiiHu8ZJiPxhM//SGbiinvczvwg1Zq6Z8xfQQBnDXkg=
X-Received: by 2002:a25:ba49:: with SMTP id z9mr6761302ybj.32.1644498600321;
 Thu, 10 Feb 2022 05:10:00 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9pZB1fWf2nZNwTHw07hrnxZYYymA0_Dy=jauDt9TbF69A@mail.gmail.com>
 <20220209215406.18850-1-Jason@zx2c4.com> <YgSqAbggkgdAtkcm@owl.dominikbrodowski.net>
In-Reply-To: <YgSqAbggkgdAtkcm@owl.dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 10 Feb 2022 14:09:49 +0100
X-Gmail-Original-Message-ID: <CAHmME9oo5y08skaOOXg-q0T9pDs580dOotm6Wz0t96AssZr2Pw@mail.gmail.com>
Message-ID: <CAHmME9oo5y08skaOOXg-q0T9pDs580dOotm6Wz0t96AssZr2Pw@mail.gmail.com>
Subject: Re: [PATCH] random: tie batched entropy generation to base_crng generation
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

Hi Dominik,

On Thu, Feb 10, 2022 at 7:04 AM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> Here we do not need to take a lock (single-threaded operation), can only be
> at generation 0 or 1, and the base_crng.key has changed. Which leads me to
> ask: shouldn't we increase the generation counter always (or at least if
> arch_init is true)? And just make icnrementing crng_init to 2 depending on
> trust_cpu?

Interesting consideration. I think incrementing the generation counter
there unconditionally can't hurt. It should be done every time the
base_crng key changes, which there it clearly does since we're
extracting into it. I'll go ahead and do that.

Jason
