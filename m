Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8954658AB91
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 15:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240702AbiHEN0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 09:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiHEN0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 09:26:06 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C6A24F21
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 06:26:02 -0700 (PDT)
Received: from zn.tnic (p200300ea971b986e329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:986e:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A7B5D1EC0681;
        Fri,  5 Aug 2022 15:25:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1659705956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6MNYFh3knJQqjTyK3tQne7TyY6FmwOU1SnwBH6n2hhI=;
        b=RdHEq0y2/CWwiYi9bjnj9fDdOcaHx2cJCeDvadwM/02MevNjc1AmWrevnZW2BRcofX3+ew
        Z++75LriEHcsppePOVQgVubVuCb2rUphMRXhPo7ZZmUF/mzJMbCDGklEvqcvdaYK/CFLrO
        /Y0QMAHjY/VY2EYfnSZUGhI1jMHpeDs=
Date:   Fri, 5 Aug 2022 15:25:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Rik van Riel <riel@surriel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Thomas Gleixner <tglx@linutronix.de>, Dave Jones <dsj@fb.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2]  x86,mm: print likely CPU at segfault time
Message-ID: <Yu0aYIbCAjFtEBVZ@zn.tnic>
References: <20220804155450.08c5b87e@imladris.surriel.com>
 <YuzsJfHi+qV6Z16E@zn.tnic>
 <2239a6e4f5e9d12ef7a55da6dba716df681201ff.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2239a6e4f5e9d12ef7a55da6dba716df681201ff.camel@surriel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 08:53:46AM -0400, Rik van Riel wrote:
> Having a small percentage of the segfaults show up on
> cores other than the broken one does not cause issues with
> detection or diagnosis.

I'm sorry but I'm not buying any of this: this should either be 100%
correct or it can stay on your kernels.

> We could, but then we would be reading the CPU number
> on every page fault, just in case it's a segfault.
> 
> That does not seem like a worthwhile tradeoff, given
> how much of a hot path page faults are, and how rare
> segfaults are.

Oh wow, a whopping single instruction:

	movl %gs:cpu_number(%rip), %eax # cpu_number, pfo_val__

What tradeoff?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
