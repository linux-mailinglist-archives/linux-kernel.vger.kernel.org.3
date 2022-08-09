Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C81C58DFDC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345313AbiHITHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348266AbiHITGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:06:36 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F9226130
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 11:49:53 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9800329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B3C051EC0554;
        Tue,  9 Aug 2022 20:49:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660070987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HAWeFjEr6a86qg5T2PUHfhtUCjZcdPiI5JbTaTzEVlQ=;
        b=h5xJ6rCbwZJLqfKKmiXghsOccehJCw/2uaI1NHjuiTBzpNtlQnTqiHGGIhX9tMH6EoCPeo
        st9B+gkeKhN6dioHjHWgcA08VZ9Vwh3y+ZOj7UZGuupa43FF/pL8+SIT4cxcP8jFfqp9xQ
        70eStUxzMWeyA7L7nxEHJZPHMtAQ06I=
Date:   Tue, 9 Aug 2022 20:49:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 2/5] entry: Add calls for save/restore auxiliary
 pt_regs
Message-ID: <YvKsS3QuOu4JVzZU@zn.tnic>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
 <20220805173009.3128098-3-ira.weiny@intel.com>
 <YvJNe2rzXfcogFFX@zn.tnic>
 <YvKpi/CVHko50PNQ@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvKpi/CVHko50PNQ@iweiny-desk3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 11:38:03AM -0700, Ira Weiny wrote:
> Thomas did a lot of work to make the entry code generic. So I was
> keeping that work consistent. This also helps to ensure I did not miss
> any places.

How about you worry about the other arches when you actually cross that
bridge?

> I don't believe this is correct because instrumentation is not enabled
> here.

Why do you have to run

	arch_save_aux_pt_regs()

with instrumentation enabled?

Patch 5 does

+       struct pt_regs_auxiliary *aux_pt_regs = &to_extended_pt_regs(regs)->aux;
+
+       aux_pt_regs->cpu = raw_smp_processor_id();

only?

Why does that need to run with instrumentation enabled?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
