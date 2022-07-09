Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD5956C889
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 11:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiGIJuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 05:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiGIJtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 05:49:47 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9ECE54
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 02:49:39 -0700 (PDT)
Received: from zn.tnic (p200300ea970ff6b1329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:970f:f6b1:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A6BB91EC01E0;
        Sat,  9 Jul 2022 11:49:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1657360173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MyDsTOCGKUyWoK+q/bmZssZe+uVz4fzGASfB3e10sGQ=;
        b=q7hfMTeuZH3kOYrAgqh9pGzCvf9hwsdBGAp4Umg1MMHxss+NdjigeBoMhFTgSDWI1+AQJq
        FPPgWwlj60UlQDhXRZi0hlN9hls+CmLSr+diTGQ4vQ0jTAGDjL9xOdEDdRvEOdt9DOgHK3
        Ge8n1rFJgOHZagWU8DakuV6M+zXHGaM=
Date:   Sat, 9 Jul 2022 11:49:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH tip v8] x86/setup: Use rng seeds from setup_data
Message-ID: <YslPKbrmwF0uSm7p@zn.tnic>
References: <20220707000852.523788-1-Jason@zx2c4.com>
 <20220708113907.891319-1-Jason@zx2c4.com>
 <ddba81dd-cc92-699c-5274-785396a17fb5@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ddba81dd-cc92-699c-5274-785396a17fb5@zytor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 06:51:16PM -0700, H. Peter Anvin wrote:
> #define SETUP_ENUM_MAX	SETUP_RNG_SEED
> #define SETUP_INDIRECT	(1<<31)
> #define SETUP_TYPE_MAX	(SETUP_ENUM_MAX | SETUP_INDIRECT)

Wait, if we get to add a new number, SETUP_ENUM_MAX and thus
SETUP_TYPE_MAX will change. And they're uapi too...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
