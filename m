Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD4359FEE6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbiHXP4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238135AbiHXP4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:56:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F53E79EEB
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:56:17 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9859329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9859:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D758F1EC056A;
        Wed, 24 Aug 2022 17:56:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1661356571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=597nyabWH/euYfInu4TMyRneXI4eRxz/mWO4MBAwbZ8=;
        b=fE79Ej2xuWRrdBwqklqQS5kNxmPtqQgtbTrRQLfv5+kxBWWYRidPpdEGY2YnmAiC68DQ+2
        ya/Qvw3mPXX1ha8+f6y6knjGI3pV19lmrdLauNA6NiZftztNnNfDp8+3A2NYy6gygyY+JP
        KWpTdAjoeZ2ystCgn+CQ8QkDCqiZSwo=
Date:   Wed, 24 Aug 2022 17:56:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/6] x86/tdx: Add TDX Guest attestation interface
 driver
Message-ID: <YwZKGzXloHWeFV/k@zn.tnic>
References: <20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220728034420.648314-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Yv5KNyX992ddvVtD@zn.tnic>
 <20abfa00-b70c-f151-9ee4-5668f09f4ace@intel.com>
 <YwP27a6/9Yq8LBM3@zn.tnic>
 <be080a46-e6c2-995b-9064-a8506c38bef8@intel.com>
 <08c5b818-a030-4c97-80f7-52ee42dc1f79@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08c5b818-a030-4c97-80f7-52ee42dc1f79@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 03:41:00PM -0700, Sathyanarayanan Kuppuswamy wrote:
> In addition to above, I think there is a possibility to add IOCTL to get
> storage keys from the ACPI SVKL table. Storage Volume Key Table (SVKL) is
> used by the VBIOS to share keys required to access encrypted drives. Although
> we don't have a clear requirement, I suspect that we might add IOCTL for it.

So this all sounds like a single tdx-guest driver to me which services a
bunch of ioctls... not separate drivers.

Hmm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
