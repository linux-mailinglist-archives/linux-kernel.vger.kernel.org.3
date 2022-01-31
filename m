Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D46E4A472F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 13:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244741AbiAaMcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 07:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiAaMb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 07:31:58 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A95C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 04:31:58 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8A4B11EC0347;
        Mon, 31 Jan 2022 13:31:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643632312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1SoicR7UKOmr0W6uZ7Xe3Ldzoz24hMVVrL7plnjNYRc=;
        b=pq4x6Ly9oyqYsc5iEoLZwyq3z989FZ0ucKBMdPvdFg/TyI0hEvj2vCf6s8X98XmlbwPMO2
        YdfXaWtjITZxlSeoHn9F9rex1qdjOKfVAkRFlPQCLlXNB5xI9twtmpMatXxBqdsu1L0ppZ
        Sf5UT1gnPYS2MnX/pITULfhVIRiiSvQ=
Date:   Mon, 31 Jan 2022 13:31:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, patches@lists.linux.dev
Subject: Re: [PATCH v2 0/6] PPIN (Protected Processor Inventory Number)
 updates
Message-ID: <YffWtTq2y6K8+gHF@zn.tnic>
References: <20220107225442.1690165-1-tony.luck@intel.com>
 <20220121174743.1875294-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220121174743.1875294-1-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 09:47:37AM -0800, Tony Luck wrote:
> ...

They look good so far on my PPIN-enabled AMD box.

> 5) Add "ppin" to /sys/devices/system/cpu/cpu*/topology/ppin
> 
> The big question for this part is whether there is a better
> place to expose this value. I'm open to other suggestions.

Yeah, I'm not sure about that either. I have

$ grep -r . /sys/devices/system/cpu/cpu*/topology/ppin | cut -d: -f 2 | uniq -c
     32 0xxxxx

32 times the same number.

Wouldn't

/sys/devices/system/node/

be a better place?

Even if those were logical nodes, it would still be less needless
replication and that would be one more way for root to figure out which
logical nodes belong to the same physical package... :-)

Hmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
