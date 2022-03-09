Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602AC4D3223
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 16:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbiCIPtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 10:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbiCIPty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:49:54 -0500
X-Greylist: delayed 16117 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Mar 2022 07:48:54 PST
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77AB123428;
        Wed,  9 Mar 2022 07:48:53 -0800 (PST)
Received: from zn.tnic (p200300ea97193859703755baa7c6e9ad.dip0.t-ipconnect.de [IPv6:2003:ea:9719:3859:7037:55ba:a7c6:e9ad])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B23A51EC04A6;
        Wed,  9 Mar 2022 16:48:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646840927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=La1XrlyNpE+yY/g5MBtL2GPKP7BcdtWqaFLgaoB6dTM=;
        b=GxaD8VCMNowjJlO+ctS/0njsHg/FhTIspM8DkSkoSe0F6jy2R2HWvtUiUxcnPNwmbP2v1r
        3BReKBmGh7ZqqxOZzdqEVcXuICENQR2lgHppr+LZRlCFXrafDq8Vakt2a8fbGffSZ/V9Z/
        FNwKr68Jj0P/ALopSenTalhZqs7qwac=
Date:   Wed, 9 Mar 2022 16:48:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Cathy Zhang <cathy.zhang@intel.com>, linux-sgx@vger.kernel.org,
        x86@kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 09/11] x86/microcode: Expose EUPDATESVN procedure via
 sysfs
Message-ID: <YijMZTc49m/OXRKg@zn.tnic>
References: <20220309104050.18207-1-cathy.zhang@intel.com>
 <20220309104050.18207-10-cathy.zhang@intel.com>
 <YiiNPWdsYtWiULZm@zn.tnic>
 <35449b18-d77e-387b-f802-48f8013dfdf9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <35449b18-d77e-387b-f802-48f8013dfdf9@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 07:42:21AM -0800, Dave Hansen wrote:
> There's a little bit in the cover letter that _implies_ why EUPDATESVN
> isn't called during the actual microcode update:
> 
> > This series implements the infrastructure needed to track and tear
> > down bare-metal enclaves and then run EUPDATESVN. This is expected
> > to be triggered by administrators via sysfs at some convenient time
> > after a microcode update, probably by the microcode update tooling
> > itself.
> 
> This allows the (non-destructive) ucode update and the destructive
> EUPDATESVN procedure to happen at different times.

Which means, that this has even less to do with the microcode loader.
That whole glue can be somewhere in arch/x86/...sgx/ land and be
completely independent.

> If we just want to make the ucode update itself call EUPDATESVN via
> microcode_check(), that makes the ucode update itself destructive to SGX
> enclaves.  That's not the end of the world, but this series is going to
> some amount of trouble (including new ABI) to avoid it.
> 
> Perhaps we need to hear more about why this is so much of an issue.

Yah, it all sounds weird.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
