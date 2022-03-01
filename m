Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45574C8E30
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbiCAOtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbiCAOtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:49:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D859026117;
        Tue,  1 Mar 2022 06:48:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ECE5615F6;
        Tue,  1 Mar 2022 14:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020FCC340F5;
        Tue,  1 Mar 2022 14:48:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="MIKfIgKS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646146104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sTjicXiZ2l1Y9kAoFdOBsAXD0LvL/+rvWOIagMywydg=;
        b=MIKfIgKSvJBVSfT2kZ9ovWudUuDVXItuuKFjN7sZsnJHvdO1msqOUOxqPR7W/pSWYRaYNB
        GLW718QygSith3HD5YrXZkGz8+SDx9Tkr9BGFapqfrlULtumzRYI0xEJah4UOS0g4TVzQh
        Cx4pkNCvnjaLnstW5EsXWU6NM9msu38=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 014099f1 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 1 Mar 2022 14:48:24 +0000 (UTC)
Received: by mail-yb1-f179.google.com with SMTP id w16so1722370ybi.12;
        Tue, 01 Mar 2022 06:48:24 -0800 (PST)
X-Gm-Message-State: AOAM531W+8mS4zfOTv0cqz+XpD7PNUrdXgTRBN6y00hQQxVOb75UfRrc
        HHhq4l1dxu11NvrcsHKxF+CYVHDGjHbjekKekDc=
X-Google-Smtp-Source: ABdhPJzZ269VLh5r9kyKWgSwmAVQqfXHExVe0/9lCmEs/JzghS/gQ2GJ4ety+JFuYmObjnNAFzdP4Sx92Pz/R9yImsc=
X-Received: by 2002:a25:238d:0:b0:619:3e19:b06b with SMTP id
 j135-20020a25238d000000b006193e19b06bmr23509931ybj.382.1646146102986; Tue, 01
 Mar 2022 06:48:22 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9qHnvwrxEue4Pdm_E1qZQGXFuR9orJSKCWj8fH5TSh6fA@mail.gmail.com>
 <20220228183355.9090-1-Jason@zx2c4.com> <e9bfc654-5504-29ff-5a5a-b73f24691600@redhat.com>
 <Yh4sz8tpNxUecRQw@smile.fi.intel.com>
In-Reply-To: <Yh4sz8tpNxUecRQw@smile.fi.intel.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 1 Mar 2022 15:48:12 +0100
X-Gmail-Original-Message-ID: <CAHmME9o5RnN5a7KVHndtYHMzcNzYcw-0Q8CcnkMtYWguz6dnmA@mail.gmail.com>
Message-ID: <CAHmME9o5RnN5a7KVHndtYHMzcNzYcw-0Q8CcnkMtYWguz6dnmA@mail.gmail.com>
Subject: Re: [PATCH 2/3 v6] ACPI: allow longer device IDs
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>
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

On Tue, Mar 1, 2022 at 3:26 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Mar 01, 2022 at 11:35:12AM +0100, Hans de Goede wrote:
> > On 2/28/22 19:33, Jason A. Donenfeld wrote:
>
> > > Co-authored-by: Jason A. Donenfeld <Jason@zx2c4.com>
>
> Official tag is Co-developed-by

Thanks, will adjust.
