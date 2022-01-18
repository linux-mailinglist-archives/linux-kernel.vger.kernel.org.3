Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C3C492FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 22:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343890AbiARVP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 16:15:28 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48564 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234887AbiARVP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 16:15:28 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DE21B1EC050B;
        Tue, 18 Jan 2022 22:15:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642540523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8OxrBxrzagGixrln8fc5UoIuJNeRrms0gk4nYSHMDm8=;
        b=FBHt+nHAkgKryazNCsUTBggMF2lumDMJyJ704UrEN9kdPQu0rYYwRzgb/q/HkZ499Rw9/6
        XMtVymAR8RmG/fyiBzhfhsKq7KFskryeEcZTRdPkCZsGRi1cGzxLszn+G2pp8jXgR/PviJ
        ZhzxGkpo/isc0GUeoECzmePzmy4Hdh0=
Date:   Tue, 18 Jan 2022 22:15:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, patches@lists.linux.dev
Subject: Re: [PATCH 1/5] x86/ras: Merge Intel and AMD ppin_init() functions
Message-ID: <Yect7WSUSmj54yBG@zn.tnic>
References: <20220107225442.1690165-1-tony.luck@intel.com>
 <20220107225442.1690165-2-tony.luck@intel.com>
 <YecY/Ri6hvJGqNTT@zn.tnic>
 <YecrF15C0d0tudUN@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YecrF15C0d0tudUN@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 01:03:19PM -0800, Luck, Tony wrote:
> You are much braver than I :-)  How confident are you
> that nobody implicitly depends on those?

So I'm willing to do it just to piss off all those who do, frankly.
Because that's a kernel-internal define and *nothing* should use it...

But looking at print_cpu_modalias(), that thing issues uevents and am
I willing to guarantee that nothing in luserspace uses those naked
numbers?

Probably not. ;-\

That's how it looks like here and there's ven0002.

/sys/devices/system/cpu/cpu11/uevent:MODALIAS=cpu:type:x86,ven0002fam0017mod0008:feature:,0000,0001,0002,0003,0004,0005,0006,
0007,0008,0009,000B,000C,000D,000E,000F,0010,0011,0013,0017,0018,0019,001A,001C,0020,0021,0022,0023,0024,0025,0026,0027,0028,
0029,002B,002C,002D,002E,002F,0030,0031,0034,0036,0037,0038,0039,003A,003B,003D,0064,0068,006E,0070,0072,0074,0075,0078,0079,
007A,007C,007D,0080,0081,0083,0089,008C,008D,0093,0094,0096,0097,0099,009A,009B,009C,009D,009E,00C0,00C1,00C2,00C3,00C4,00C5,
00C6,00C7,00C8,00C9,00CC,00CD,00D1,00D6,00D7,00D8,00DA,00DC,00DD,00E2,00E8,00EC,00ED,00F1,00F3,00F5,00F8,00FA,00FC,010F,0120,
0123,0125,0127,0128,0132,0133,0134,0137,013D,0140,0141,0142,0143,0165,01A0,01A1,01A2,01AC,01C2,01E0,01E1,01E2,01E3,01E4,01E5,
01E6,01E7,01EA,01EB,01EC,01ED,01EF,01F0,0220,0221,0223,0224,0260,0261,0262,0263

> Is it worth the risk/churn just to save 12 bytes in the ppin_info[]
> array?

It doesn't look like it.

> I'll fix up all the other stuff you found and post a V2 soon. Thanks
> for the review.

Please hold off until I've looked at the rest.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
