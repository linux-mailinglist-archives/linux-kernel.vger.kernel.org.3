Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EE058BA92
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 12:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiHGKfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 06:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbiHGKfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 06:35:17 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFD1329
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 03:35:14 -0700 (PDT)
Received: from zn.tnic (p200300ea971b985f329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:985f:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8D5A21EC03B9;
        Sun,  7 Aug 2022 12:35:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1659868509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=x40mTpY8kEzZK9RIpDoiod2RNGxSlX29HilwwoJYUnQ=;
        b=T6DjGJjY1RFDQR3/xLKAKoIbOXmc74LmSddFpIKwnF3ODqcdMP06ANmfV75CiSbHDJ92un
        Xh0BtGnjZUUoyUpNhoq9Zuuh3SvArZ/h70EhnyAP4uZAUTzhphMAhKPG6dMaRJ2oVDQD0D
        KUvYt2ZmwRDOS+Qz6LOrPDOcSg2b0Us=
Date:   Sun, 7 Aug 2022 12:35:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, ira.weiny@intel.com,
        Rik van Riel <riel@surriel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 5/5] x86/entry: Store CPU info on exception entry
Message-ID: <Yu+VV8xFTYRh0D0a@zn.tnic>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
 <20220805173009.3128098-6-ira.weiny@intel.com>
 <5d62c1d0-7425-d5bb-ecb5-1dc3b4d7d245@intel.com>
 <Yu4t0jkpIY4grgxL@gmail.com>
 <Yu4wON0MRGH7h5Jv@zn.tnic>
 <Yu+Nwbn4CZUmyD14@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yu+Nwbn4CZUmyD14@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 07, 2022 at 12:02:41PM +0200, Ingo Molnar wrote:
> * Borislav Petkov <bp@alien8.de> wrote:
> > With the amount of logical cores ever increasing and how CPU packages
> > (nodes, L3 sharing, you name it) get more and more complex topology,
> > I'd say the 2 insns to show the CPU number in every exception is a good
> > thing to do.
> 
> We can show it - I'm arguing against extracting it too early, which costs

Not early - more correct. We can say which CPU executed the exception
handler *exactly*. Not which CPU executed the exception handler *maybe*.

> us 2 instructions in the exception fast path

2 insns? They don't matter at all. FWIW, they'll pull in the per-CPU
cacheline earlier which should be a net win later, for code which does
smp_processor_id().

> - while in 99.999999999% of the cases we don't use that field at all ...

See my text above about the ever-increasing complexity of CPU topology.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
