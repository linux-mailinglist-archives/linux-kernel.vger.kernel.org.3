Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A283959CAF1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 23:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238149AbiHVVhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 17:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbiHVVhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 17:37:00 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520EF53001
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 14:36:55 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98b2329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98b2:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C407F1EC0645;
        Mon, 22 Aug 2022 23:36:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1661204209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GM4p6K/MhEh+Um7C63wrny15ZaDe+tYLO6GoXOH8A5M=;
        b=Ppb7yfgjpCchvGQteNdVjlB+M6JUQ/bofHi7hNfrNlKVfajCRCT7zMOzGvN6vEHD+JYUJV
        5h8W4JbFig1Ga5oYPPeG3CGHSRXCPXMd2Rs1txBFhSgItSnnhLM1FyD9J3xeaI9DtXLGNm
        6OUnVRETaEtFwG4dHthEpNTLQJua6zw=
Date:   Mon, 22 Aug 2022 23:36:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
Message-ID: <YwP27a6/9Yq8LBM3@zn.tnic>
References: <20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220728034420.648314-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Yv5KNyX992ddvVtD@zn.tnic>
 <20abfa00-b70c-f151-9ee4-5668f09f4ace@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20abfa00-b70c-f151-9ee4-5668f09f4ace@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 02:19:44PM -0700, Dave Hansen wrote:
> This actually shows up to apps, though.

Blergh.

> They'll actually be opening /dev/tdx. When the other driver comes
> along, they'll all need to change to /dev/tdx-guest. That seems a bit
> unkind to those poor app developers.

So do you really wanna call the attestation driver "tdx-guest"?

But that's not really an attestation driver - there's tdx/tdx.c which is
all the guest code and there's an attestation "driver" in it.

So maybe this "attestation driver" thing is just an additional "ability"
of the tdx-guest driver.

Might wanna take out your cristal ball and think what you wanna call it
now so that it doesn't change because...

> BTW, do we consider these kernel names be part of the ABI? Seems like
> we should.

... yap, that.

If apps open this, then this is an ABI and cast in stone.

I'd say.

Which makes my initial suggestion of calling this whole guest
functionality a "tdx" driver not such a bad idea... Depends on
whether there will be a split at all or it'll continue gaining more
functionality.

Or so.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
