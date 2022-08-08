Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FBC58C810
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbiHHMBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiHHMBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:01:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14191C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 05:01:34 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98cb329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98cb:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5A7C11EC0324;
        Mon,  8 Aug 2022 14:01:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1659960088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nBLAaFekvB4UROPSYy0EokULKWsU7NSZCJuG4pSa0Is=;
        b=FuEV0bvhEJZuuPTpUqMfrARo0ASiX9RNOv98ZVWvXbJY25sKhNLGfTKtjRWxDIUqGWgSSP
        dQPAkHaletlc65jN1qrvt/osVP1Z0FpV9JxlP9XB1un3ugOFlFBoa10KCWeVjgn260cL91
        W/YOSRyBck340cjOCnCRL6Bj8Ll+6Vc=
Date:   Mon, 8 Aug 2022 14:01:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Rik van Riel <riel@surriel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 5/5] x86/entry: Store CPU info on exception entry
Message-ID: <YvD7FNovYh7UzrAc@zn.tnic>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
 <20220805173009.3128098-6-ira.weiny@intel.com>
 <5d62c1d0-7425-d5bb-ecb5-1dc3b4d7d245@intel.com>
 <Yu4t0jkpIY4grgxL@gmail.com>
 <Yu4wON0MRGH7h5Jv@zn.tnic>
 <Yu+Nwbn4CZUmyD14@gmail.com>
 <Yu+VV8xFTYRh0D0a@zn.tnic>
 <YvAaXet3sBg3mRDe@iweiny-desk3>
 <YvDtfKRyMGenRMU5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvDtfKRyMGenRMU5@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 01:03:24PM +0200, Ingo Molnar wrote:
> I'd like to hear what Andy Lutomirski thinks about the notion that
> "2 instructions don't matter at all" ...
> 
> Especially since it's now 4 instructions:

He wasn't opposed to it when we talked on IRC last week.

> ... 4 instructions in the exception path is a non-trivial impact.

How do I measure this "impact"?

Hell, we recently added retbleed - and IBRS especially on Intel - on
the entry path which is whopping 30% perf impact in some cases. And
now we're arguing about a handful of insns. I'm sceptical they'll be
anything else but "in-the-noise" in any sensible workload.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
