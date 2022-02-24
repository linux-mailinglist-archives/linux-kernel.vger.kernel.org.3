Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4344C2D75
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbiBXNna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbiBXNn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:43:29 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E50B189AAE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 05:42:58 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CE4D21EC0528;
        Thu, 24 Feb 2022 14:42:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645710173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ClKSToBqueVFilIpbe2DHEQU7dVy9VDlaqNSq5MfQd4=;
        b=XyEQjTb0sUr0uaUsGPdD6PdqNBHd4r59PJfkKWWyZ6Xd8FfbT1zZKXu99dWRc1IY6UTNgg
        zcft490dIeHjvPdEOFsdctq0tpodcuK0QDAH7tYtHn8sjxKt3gM+k2Ck2KOcOBn1L9kb17
        SgaAOcbHTeNB5DRGu9DCCWsw90OO3d4=
Date:   Thu, 24 Feb 2022 14:42:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        daniel.kiper@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH 1/2] x86/boot: Fix memremap of setup_indirect structures
Message-ID: <YheLYDdG3w6WGhSM@zn.tnic>
References: <1643303056-22272-1-git-send-email-ross.philipson@oracle.com>
 <1643303056-22272-2-git-send-email-ross.philipson@oracle.com>
 <YgabtFd4Nkpgi+oW@zn.tnic>
 <2e584fc4-163a-0af4-abe0-9c14996918f2@oracle.com>
 <Ygvy8j9E7WPo6dx0@zn.tnic>
 <6e5763be-3e9c-0199-24ea-e4f5b226d990@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e5763be-3e9c-0199-24ea-e4f5b226d990@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 04:01:32PM -0500, Ross Philipson wrote:
> In the ioremap.c module, the check for NULL is only missing in the
> functions we updated but the lack of a check was already there before
> these changes went in.
> 
> In the setup.c and e820.c modules, the check for NULL is missing in the
> functions we updated but the lack of a check was already there before
> these changes went in in those functions. The lack of early_memremap()
> NULL checks can also be found in other functions in those modules.

I don't know how to understand this statement: are you saying that,
because there are other cases where - for whatever reason - the retval
check is not taking place - you should not do it either?

Because I can see other places where the return value is checked. I
mean, if the return value check doesn't matter, why not make this
function simply void and not bother at all?

> Fixing it in other functions and possibly elsewhere in the arch/x86 code
> seems to be out of scope for this patch set. We could send separate
> patches and hunt down other places this check is missing.

That would be appreciated.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
