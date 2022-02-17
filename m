Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62E34BABB3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 22:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245152AbiBQV0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 16:26:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239342AbiBQV0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 16:26:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C488D80234;
        Thu, 17 Feb 2022 13:26:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E97561353;
        Thu, 17 Feb 2022 21:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA85C340EC;
        Thu, 17 Feb 2022 21:26:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="geSpcPba"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645133163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pDt/1zff5PrpvG09nzyrh7Dd+LUHe32c1AnCH3rTZCw=;
        b=geSpcPbasn9GYff9ulOtNHs6sTsPBC88K4fSr+xgzqStnivBDKiIpzlZQbPyKJXcRZ45lx
        MIYmahTkTzIyJGUM+CNxOL4ZyRfMkpMNQZmvejtlZPWBsHdYL5j13SYBImhirLx6EvPLaH
        2wToSRfWFgBSBqWSSzPv8/bL1zrecW8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fba0ad9e (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 17 Feb 2022 21:26:03 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id p5so15579739ybd.13;
        Thu, 17 Feb 2022 13:26:03 -0800 (PST)
X-Gm-Message-State: AOAM5339L5Os7xWvbJSu0oPHPnPyLBz+E9Suz4xKjALEw+nZ64nn2IRs
        B7jToiSmy5cxJ5H6HQ0wrr7I+QUdoHMWXWIKQP4=
X-Google-Smtp-Source: ABdhPJxwSjDman9ef6QcevzXe3EiZBcaksQ4ae+AOZCETekzaV2QN7JT0646k78d4nWhkwpDuGhLCQqF0Bve0A6+7D0=
X-Received: by 2002:a25:e204:0:b0:610:cb53:b753 with SMTP id
 h4-20020a25e204000000b00610cb53b753mr4405496ybe.267.1645133161340; Thu, 17
 Feb 2022 13:26:01 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9prO9dop7iBRwN54=GMtLH7amS3m_VqGUzL44G1h=R+2A@mail.gmail.com>
 <20220217180409.13151-1-Jason@zx2c4.com> <Yg6fbwtNghu76z2V@linutronix.de>
In-Reply-To: <Yg6fbwtNghu76z2V@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 17 Feb 2022 22:25:50 +0100
X-Gmail-Original-Message-ID: <CAHmME9qD_8pZ9wTut+KgFAYW5O6GxNAa8gg6JT8H7hGwTwCMzQ@mail.gmail.com>
Message-ID: <CAHmME9qD_8pZ9wTut+KgFAYW5O6GxNAa8gg6JT8H7hGwTwCMzQ@mail.gmail.com>
Subject: Re: [PATCH v6] random: clear fast pool, crng, and batches in cpuhp
 bring up
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
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

Hi Sebstian,

On Thu, Feb 17, 2022 at 8:18 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> Perfect thank you.
> Did you miss my question regarding cross-CPU init in
> random_prepare_cpu()?

I saw your suggestion to do cross-CPU init and rejected the proposal
for not actually solving a problem. My email about that was here:
https://lore.kernel.org/lkml/CAHmME9prO9dop7iBRwN54=GMtLH7amS3m_VqGUzL44G1h=R+2A@mail.gmail.com/

Do you think you could ack this v6?

Thanks,
Jason
