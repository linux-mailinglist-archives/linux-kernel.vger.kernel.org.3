Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7FE52B3D8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbiERHpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiERHpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:45:05 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DA8115C8F
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:45:04 -0700 (PDT)
Received: from zn.tnic (p200300ea974657d0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:57d0:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 527C91EC0666;
        Wed, 18 May 2022 09:44:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652859898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a8Szr4z7U3LLWZpmFRmG29wYOgRi5MD6X+p5qsug0OA=;
        b=Pob2AA/6Vhjy47GRjAV39j87RoTblM7SFu97DnhIry+QeDLbyAQdHuDrgFDWIiEnpC4bm/
        Xi/iAffzZviq9amZHlIwnWlB180E1+Fa+9cjED1quaEIpjZb08y2XM+M/dfSOZpW8uPJ98
        G1U8sQiSeFJI7pnTBmLcMFUjPrbkZYw=
Date:   Wed, 18 May 2022 09:44:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 11/11] drm/i915: Fix undefined behavior due to shift
 overflowing the constant
Message-ID: <YoSj9O/6yA0nn/xW@zn.tnic>
References: <20220405151517.29753-1-bp@alien8.de>
 <20220405151517.29753-12-bp@alien8.de>
 <78e67e42-7e1e-e9fa-036d-441168100731@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78e67e42-7e1e-e9fa-036d-441168100731@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 04:05:46PM -0700, Randy Dunlap wrote:
> 
> 
> On 4/5/22 08:15, Borislav Petkov wrote:
> > From: Borislav Petkov <bp@suse.de>
> > 
> > Fix:
> > 
> >   In file included from <command-line>:0:0:
> >   drivers/gpu/drm/i915/gt/uc/intel_guc.c: In function ‘intel_guc_send_mmio’:
> >   ././include/linux/compiler_types.h:352:38: error: call to ‘__compiletime_assert_1047’ \
> >   declared with attribute error: FIELD_PREP: mask is not constant
> >     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> > 
> > and other build errors due to shift overflowing values.
> > 
> > See https://lore.kernel.org/r/YkwQ6%2BtIH8GQpuct@zn.tnic for the gory
> > details as to why it triggers with older gccs only.
> > 
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Is this merged anywhere?

It's state is "new" in their patchwork:

https://patchwork.freedesktop.org/patch/480756/

so I guess not yet.

> It could/should at least be in linux-next so that other people
> don't waste time on it.

-ETOOMANYPATCHES I guess. :-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
