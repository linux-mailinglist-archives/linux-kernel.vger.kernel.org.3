Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A35555E92D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348200AbiF1QAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 12:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348192AbiF1QAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 12:00:16 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0426E37A20
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 09:00:00 -0700 (PDT)
Received: from zn.tnic (p200300ea97156a99329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9715:6a99:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 775EA1EC018C;
        Tue, 28 Jun 2022 17:59:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1656431994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BrUtUlmZIekyNsj7MCySV2fHm1RFiOXl4lfKJ2ufHxo=;
        b=k372JxwoJjO9Djfi1xWfGmz0/Kc/GnqsOQWn0+ieBdyMkAupyeshYY98S08j8Xhz82DPgV
        aJBUvI50RBLGMviKzHW1lyUmQNWrrR265R2eea7sjaMGQemimIFjy0M8PEOgEeE4C/1hoq
        A55seH/qk6Vz/0f6GsPNwFFAj8H7AJI=
Date:   Tue, 28 Jun 2022 17:59:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH] RAS/CEC: Reduce default threshold to offline a page to
 "2"
Message-ID: <Yrsleko0MnGtwaaR@zn.tnic>
References: <20220607212015.175591-1-tony.luck@intel.com>
 <YrnBWjkX82OhXAtL@zn.tnic>
 <7da92773f7084c57814f7ef4d033bc53@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7da92773f7084c57814f7ef4d033bc53@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 05:27:57PM +0000, Luck, Tony wrote:
> Existing default is 1023 ... which is not a good choice for anyone (except
> perhaps ostriches that want to bury their heads in the sand an ignore marginal
> DIMMs for as long as possible).

Why isn't that a good choice?

I'm sure there are error rates where this fits just fine.

> So changing the threshold to "2" would be an improvement in at least
> being right for one vendor, instead of wrong for all.

So I'm pretty sure that is not needed on AMD at all.

> Linux already had a hook in the GHES code to take an error record from
> the platform and offline a page. So this "smart" code could be done
> by BIOS or BMC just providing the resulting list of pages that should
> be taken offline to Linux.

So my worry is some firmware agent interfering with our recovery
strategy. And reportedly, there are people who don't like the firmware
recovery at all and prefer it all is done in the OS.

Which then makes it a problem of how to synchronize with the firmware
about who does what in RAS. And we don't have any API here...

Anyway, this is just a worry I have from watching where it all goes
to.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
