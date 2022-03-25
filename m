Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6D14E6CE4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 04:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244221AbiCYDtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 23:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbiCYDta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 23:49:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A827BB0B2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 20:47:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A72DEB827C4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 03:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4CCC340E9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 03:47:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hay/H5rk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1648180072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xulmJ1jFNqsOCGcDUXK3DqjCnnbDqbqX/gtAMSJJRDY=;
        b=hay/H5rktyQ2XrNBJ6d09aRhUYd7fMqMCKowwHBLopj7ytDpKVbleLefgG8DPnctUwNP6F
        XFfMoum1a4AkqvI3q8O07Hxf2Tr9IMwuQhZcUs4NjxixpRQzrUXhbXkENpEF/gnQ+z87ro
        hOuhwIku5fCtJ7skGXQTglu7QDYTBKY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 22447ea9 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 25 Mar 2022 03:47:52 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2d07ae0b1c4so70469517b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 20:47:51 -0700 (PDT)
X-Gm-Message-State: AOAM533XJYKe1oLjHzw1uuGSsAM1v/dDb/skIuGn+9hZzFxzTHpaySEw
        uJKIXsDOQgjpkxcbVNVIrgSz29YR0Bh9RkbhHL4=
X-Google-Smtp-Source: ABdhPJwi5q7hhixfFwxGcECEz2UImoZKXg6EdyKpMlnWkBtHQjnOuOvtQNZmKycRVjXg027BIWhSpt2gyrSNUPgqQrs=
X-Received: by 2002:a0d:e005:0:b0:2d7:fb79:8f36 with SMTP id
 j5-20020a0de005000000b002d7fb798f36mr8948958ywe.404.1648180070825; Thu, 24
 Mar 2022 20:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <1648149621-2335-1-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1648149621-2335-1-git-send-email-mikelley@microsoft.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 24 Mar 2022 21:47:40 -0600
X-Gmail-Original-Message-ID: <CAHmME9p4C1Vbbe86+KBFZOGUJmNqLCF1LU5X3x+fugiUJeOEPg@mail.gmail.com>
Message-ID: <CAHmME9p4C1Vbbe86+KBFZOGUJmNqLCF1LU5X3x+fugiUJeOEPg@mail.gmail.com>
Subject: Re: [PATCH 1/1] virt: vmgenid: Recognize new CID added by Hyper-V
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Ard Biesheuvel <ardb@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexander Graf <graf@amazon.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

Hi Michael,

On Thu, Mar 24, 2022 at 1:20 PM Michael Kelley <mikelley@microsoft.com> wrote:
>
> In the Windows spec for VM Generation ID, the originally
> specified CID is longer than allowed by the ACPI spec.
> Hyper-V has added "VMGENCTR" as a second valid CID
> that is conformant, while retaining the original CID
> for compatibility with Windows guests.
>
> Add this new CID to the list recognized by the driver.

Thanks for the patch. Applied to crng/random.git.

Jason
