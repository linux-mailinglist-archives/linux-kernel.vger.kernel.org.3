Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D4C58B4BB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 11:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbiHFJLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 05:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiHFJLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 05:11:33 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB3E16583
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 02:11:31 -0700 (PDT)
Received: from zn.tnic (p200300ea971b986e329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:986e:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EABCE1EC064A;
        Sat,  6 Aug 2022 11:11:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1659777085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=K/JEm6qsqObxv5k42BECF3rRNZFaVIF4KqwrFKnMaTk=;
        b=XUEJgqyqcfRJVUKXij21BB7HfTe+CT2HIFR7YHWoac0g6o0m/9Mxr1yniLLpJ1x+NuUD8x
        UEBPe9/wfWtWgVinboUYy/5nmBvx/wDfh0QpUcYlmxGBBHf41t1lm8Sa+qT/EsPv4FCzJh
        Ufd9ifoHtmKkvU1ZTpi2CgwYvhTx5Zs=
Date:   Sat, 6 Aug 2022 11:11:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, ira.weiny@intel.com,
        Rik van Riel <riel@surriel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 5/5] x86/entry: Store CPU info on exception entry
Message-ID: <Yu4wON0MRGH7h5Jv@zn.tnic>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
 <20220805173009.3128098-6-ira.weiny@intel.com>
 <5d62c1d0-7425-d5bb-ecb5-1dc3b4d7d245@intel.com>
 <Yu4t0jkpIY4grgxL@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yu4t0jkpIY4grgxL@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2022 at 11:01:06AM +0200, Ingo Molnar wrote:
> It's still 2 instructions more than what we had before, while the 
> fault-time CPU number is only needed infrequently AFAICS.

With the amount of logical cores ever increasing and how CPU packages
(nodes, L3 sharing, you name it) get more and more complex topology,
I'd say the 2 insns to show the CPU number in every exception is a good
thing to do.

Arguably, we probably should've even done it already...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
