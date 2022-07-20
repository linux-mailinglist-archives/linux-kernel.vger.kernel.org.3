Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6586A57B8B4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 16:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbiGTOpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 10:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiGTOpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 10:45:43 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7210A4C61F;
        Wed, 20 Jul 2022 07:45:42 -0700 (PDT)
Received: from zn.tnic (p200300ea97297623329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9729:7623:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C39411EC04C2;
        Wed, 20 Jul 2022 16:45:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1658328336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GomAiikQXemvYg3b1ovZcgbVbLjxaAUBHsLJ+OumhCw=;
        b=JiJIyRKOkht9nnXGcmBNfhkS+yTY0LTYP3V+PLHp38y5y+W63fmn1+nkfrVx8CJ9dqeIg9
        UmyuYLKYACHL00IetJt8uJ8EdbYhewEZNq/Mc+Ts70OVVbN0kzARrSBerTUwOnOg2YYphc
        WCTe/li1zSitiyYViMkbqFpSMCs08oA=
Date:   Wed, 20 Jul 2022 16:45:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Clemens Ladisch <clemens@ladisch.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, dave.hansen@linux.intel.com,
        linux-hwmon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        babu.moger@amd.com, yazen.ghannam@amd.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 RESEND 0/6] Add support for upcoming chips to k10temp
 and amd_nb
Message-ID: <YtgVDEQnZpjnIG0k@zn.tnic>
References: <20220719195256.1516-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220719195256.1516-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 02:52:50PM -0500, Mario Limonciello wrote:
> This series started as what looked like a correction to previous
> commits, but I missed that the previous commits were for a different
> family with the same chip models.  So while fixing up the series I also
> noticed that a few upcoming chips have new PCIe IDs and CCD offsets not
> yet supported, so add them to amd_nb/k10temp.
> 
> v2->v3
>  * Pick up tags
>  * Group "ROOT" PCI IDs with others in patches 2 and 3.
> v1->v2:
>  * Correct commit messages
>  * Add more missing chips and offsets
>  * since so much changed, do not include Bjorn's Ack.
> 
> V3 original submission:
> * https://lore.kernel.org/lkml/20220613192956.4911-1-mario.limonciello@amd.com/#t
> 
> Mario Limonciello (6):
>   x86/amd_nb: Add AMD Family 17h A0-AF IDs
>   x86/amd_nb: Add Family 19h model 70h-7Fh IDs
>   x86/amd_nb: Add Family 19h model 60h-6Fh IDs
>   hwmon: (k10temp): Add support for family 17h models A0h-AFh
>   hwmon: (k10temp): Add support for family 19h models 70h-7Fh
>   hwmon: (k10temp): Add support for family 19h models 60h-6Fh

Is there any particular reason why those are split into such small
pieces?

I'd expect one patch adding all PCI IDs and a second patch doing the
k10temp changes.

If no particular reason, I'll compact them all 6 into 2.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
