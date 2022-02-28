Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BD14C7D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiB1WSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiB1WR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:17:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5375E541E;
        Mon, 28 Feb 2022 14:17:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B6A2612B9;
        Mon, 28 Feb 2022 22:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40280C340EE;
        Mon, 28 Feb 2022 22:17:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="P/zIgOUK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646086635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sAKetnr2EhMoW3k+0j02uuYtCp2oLcTPh7O9hPB+Aw4=;
        b=P/zIgOUKRnMBFNSiD1fww8gYaDuWROWP+ND1MrrLQIYv4NgW5ZIuND5YURZl0nrnnZAdKG
        2HfFE2+hiT0Ued3SdYbRNmOHG88NUXqvuMuOrT1KeRpEI9UA6scNbplSiuQ56/KEOBEPmM
        XbF4PNGQEtMhwsTGrNW8Lc3EoDXb+bk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 48c81fe5 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 28 Feb 2022 22:17:15 +0000 (UTC)
Received: by mail-yb1-f172.google.com with SMTP id p19so23480228ybc.6;
        Mon, 28 Feb 2022 14:17:14 -0800 (PST)
X-Gm-Message-State: AOAM532DGRv7OT6Mb9M03CDJbJ+1ke/pgcSVzQgMEIml1HVLsuR3We2X
        YltedZTgvf+t+NL2EF5Mga2S7eONY9OgcfsLRGo=
X-Google-Smtp-Source: ABdhPJx6/Go5x/wo1BzS9P2jXa+wbkcJxKyTGIJj8bKgs2uVEKsxk1ylGZOMVZCrXnA6zMiZuC3v2FXCJrmkJ6AqwTw=
X-Received: by 2002:a05:6902:693:b0:613:7f4f:2e63 with SMTP id
 i19-20020a056902069300b006137f4f2e63mr21147415ybt.271.1646086633504; Mon, 28
 Feb 2022 14:17:13 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9qHnvwrxEue4Pdm_E1qZQGXFuR9orJSKCWj8fH5TSh6fA@mail.gmail.com>
 <20220228183355.9090-1-Jason@zx2c4.com> <CAHp75VcjrD3kwN1BfWpjKXaVpG7MHfftMUscSGhcJfStm4b-Xg@mail.gmail.com>
 <CAMj1kXFmEAKJRHCiuXyGECCmOs0+xX9AVeBDxfuD0XuX2TQ2Uw@mail.gmail.com>
 <Yh0+LA8B1jw8tnl9@smile.fi.intel.com> <CAHmME9qW4EiYU6_kTffMdK5ijJY1DF6YRt=gDjj1vKqDxB0Raw@mail.gmail.com>
 <MN0PR21MB3098981B77F513976A62CA57D7019@MN0PR21MB3098.namprd21.prod.outlook.com>
In-Reply-To: <MN0PR21MB3098981B77F513976A62CA57D7019@MN0PR21MB3098.namprd21.prod.outlook.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 28 Feb 2022 23:17:02 +0100
X-Gmail-Original-Message-ID: <CAHmME9o7eE5Ldci90VeoQTt3=YOCYCaUiBWEKu7HTN-H4MJyyQ@mail.gmail.com>
Message-ID: <CAHmME9o7eE5Ldci90VeoQTt3=YOCYCaUiBWEKu7HTN-H4MJyyQ@mail.gmail.com>
Subject: Re: [PATCH 2/3 v6] ACPI: allow longer device IDs
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Mon, Feb 28, 2022 at 11:14 PM Michael Kelley (LINUX)
<mikelley@microsoft.com> wrote:
> the wild to consume the new identifier.   As a result, at this point Hyper-V
> is not planning to change anything.
>
> It's a lousy state-of-affairs, but as mentioned previously in this thread,
> it seems to be one that we will have to live with.

I should note that QEMU and VMware also support this too. So, yea, I
guess that boat has sailed.

Should that Hyper-V team do the ECR thing Andy was talking about?

Jason
