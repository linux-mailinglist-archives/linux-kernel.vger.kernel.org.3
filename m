Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB364B775B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243118AbiBOSh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:37:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbiBOShy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:37:54 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A33414024
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:37:43 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 998CC1EC054C;
        Tue, 15 Feb 2022 19:37:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644950257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=eiZd7abZTRheawir5Eg8sRvKVeTjedCspWOLi0oO0Q8=;
        b=ZASfpJnOyyx9GrybIozgD8hHdpUS3Xz1NbNDelvsopu9Ax6a2AUExdHxr7JYDTqmIbOA+J
        6jZnpRW0oj8IqXPoCk/6Oey3g0bgCGs+vkog26gKFyf5AB08LhLFlJwAkn3PXINPeSPbqz
        EnjKIWbDpIice0X1kA9B+7kYIP8BQPE=
Date:   Tue, 15 Feb 2022 19:37:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        daniel.kiper@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH 1/2] x86/boot: Fix memremap of setup_indirect structures
Message-ID: <Ygvy8j9E7WPo6dx0@zn.tnic>
References: <1643303056-22272-1-git-send-email-ross.philipson@oracle.com>
 <1643303056-22272-2-git-send-email-ross.philipson@oracle.com>
 <YgabtFd4Nkpgi+oW@zn.tnic>
 <2e584fc4-163a-0af4-abe0-9c14996918f2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2e584fc4-163a-0af4-abe0-9c14996918f2@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 06:34:43AM -0500, Ross Philipson wrote:
> It can if you run out of slots in the fixed map.

Right. Or if any of the checks in __early_ioremap() fail. But those
would at least warn.

> The only reason I did not check it for NULL was because it was not
> checked elsewhere for NULL.

Elsewhere in the tree or elsewhere in this file or in the setup_indirect
adding code?

> I guess there are two questions:
> 
> 1. Should I also fix it elsewhere in the code I am touching?

Yes pls.

> 2. What should I do on an allocation failure? In a routine like this it
> seems to be a critical early boot failure.

How so?

I'd expect in the case of e820__reserve_setup_data(), for example, to
not call e820__range_update* and not have those indirect ranges present
in the e820 map. What the user intended might not work but it'll at
least boot instead of floating dead in the water.

And similar approach in the other places you're touching.

You could even issue a warning or so so that users at least know what's
going on. I'd say...

> I guess the original intention might have been to let it just blow up
> since there is no recovery but that is just conjecture...

The original intention?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
