Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D32E56D05B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 19:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiGJRNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 13:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGJRNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 13:13:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70136170
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 10:13:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9213CB80884
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 17:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A174C3411E;
        Sun, 10 Jul 2022 17:13:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Ny2WSnoL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657473216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hykMBEkXPUYdiX3Z8LYItfJxdLwifoFGMunUA1CuzMY=;
        b=Ny2WSnoLbkBEwDYJGoKEvJYdvIQ0BySRooLJw2AyiQ7zldSDvR1dryYrHjbafA2PSLQ+sg
        X2z0N/+JYORGaxnnBlfyvihuEhGY1liMJQ5x3zL5pDq7Ee/rlyT0e8zSIbxT53S9h64UaZ
        EzN6yWCU98OOGR/yNIRriBtgK0z68Bk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 657d090f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 10 Jul 2022 17:13:36 +0000 (UTC)
Date:   Sun, 10 Jul 2022 19:13:18 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH tip v8] x86/setup: Use rng seeds from setup_data
Message-ID: <YssIrgLqlAyxRzHC@zx2c4.com>
References: <20220707000852.523788-1-Jason@zx2c4.com>
 <20220708113907.891319-1-Jason@zx2c4.com>
 <ddba81dd-cc92-699c-5274-785396a17fb5@zytor.com>
 <YslPKbrmwF0uSm7p@zn.tnic>
 <191d8f96-7573-bd0e-9ca4-3fc22c5c9a49@zytor.com>
 <Ysn5uvBKBpcZ4j6m@zn.tnic>
 <8e5eb2db-ce31-3dc8-8f75-3959036686f8@zytor.com>
 <YsqfuPeB5jhFU9g5@zn.tnic>
 <CAHmME9rBRvU1z5Je1B2ahiTWuBaeJ9mHmohMAxLeoPMubT1+zw@mail.gmail.com>
 <YsrFoaQzoO7NlgPN@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YsrFoaQzoO7NlgPN@zn.tnic>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2022 at 02:27:13PM +0200, Borislav Petkov wrote:
> On Sun, Jul 10, 2022 at 01:11:16PM +0200, Jason A. Donenfeld wrote:
> > Do you want me to rebase mine on top of the 5.19 fixup? Or is that
> > trivial enough that you'll just do it when applying?
> 
> Yeah, I'll take care of it, no worries.

Actually, I need to send another revision anyway, as kernel test bot
just barked at me for something dumb. Incoming...

Jason
