Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A192597957
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 23:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbiHQV4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 17:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241445AbiHQV4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 17:56:09 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F36A74EB
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:56:08 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98b0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98b0:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F08891EC0543;
        Wed, 17 Aug 2022 23:56:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660773363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=r0jlbpMJVou7x794vi2z4haqJSBxGRGHrpPPlFFtOVc=;
        b=DBENMokpexUIUTGJ8DxiBtQGSx8RKbsZVJu9CbAXZW94mbNO9alQjA5YHQWBdCKUco0Ldg
        ZH4wbCJsgTRvMQ7BHjI7subPmRi1BlwdBjJRB+2R/gCRKKMl0/3K+x+st9vZtcdrpvb52B
        hzCUiNa/WPEzbETbpB4FDN2wCML7JQA=
Date:   Wed, 17 Aug 2022 23:56:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Ashok Raj <ashok_raj@linux.intel.com>, X86 ML <x86@kernel.org>,
        Andrew Cooper <amc96@srcf.net>,
        LKML <linux-kernel@vger.kernel.org>,
        =?utf-8?Q?=C8=98tefan?= Talpalaru <stefantalpalaru@yahoo.com>
Subject: Re: [PATCH] x86/microcode/AMD: Attempt applying on every logical
 thread
Message-ID: <Yv1j8v7o3lOniUoH@zn.tnic>
References: <20220814120026.16118-1-bp@alien8.de>
 <YvtcGEHX8eSFpALX@araj-dh-work>
 <YvuQgx698T5cgF+C@zn.tnic>
 <YvzbFXnBjNjK+UJK@araj-dh-work>
 <Yvz53AAh+p5Db7CK@zn.tnic>
 <Yv0JQGa/2BlbQChZ@araj-dh-work>
 <Yv0vu6OqCptK6gc+@zn.tnic>
 <Yv1WXxcIXSQ7nMji@araj-dh-work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yv1WXxcIXSQ7nMji@araj-dh-work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 08:58:07PM +0000, Ashok Raj wrote:
> For this specific patch in question, its not for testing though.. Its
> required for functional purposes?

From its commit message:

"However, there are microcode patches which do per-thread modification,
see Link tag below.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216211"

TL;DR - the application needs to happen on *every* logical CPU.

> In effect you can test applying the same microcode over and over again
> without having any special patches. 

Right now, you cannot downgrade on Zen but apparently applying the same
patch over and over again works.

The patch cache still has a version check and that prevents it but
that's ugly.

I need to test how it behaves on older families first and then think
about how to do this right. Maybe use cpuinfo_x86.microcode to record
what has been applied until now...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
