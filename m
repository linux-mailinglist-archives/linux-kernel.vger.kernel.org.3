Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5994D550D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 00:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiFSWbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 18:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiFSWbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 18:31:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A06A448
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 15:31:37 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655677894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N660GOHC6hN+7Tg/gydyH7WIwLnrHE0R2PPkXSp3Hlg=;
        b=ZWk4UQY9HLN78iWjKIDe9q97C9mHwTrEq6rI8JjWC/yWlBwttF52H8uX6FbxpNH0pvRMxB
        lPAP0RZMRnPffpaR9AwJpkrarxchlyOcT9YxqY9Eeq/nFhPSCHDN0RTD+EahUpub09/lRS
        4aL5sAL7gYQAqpBq1JOj8AlEHwB/IyzjI3dPbryqSKpWpezBfeTWTXnOrFgfFAkckGw//q
        cBgx5mZV3CLZ2QR0KHNYmpnxbxS4mm88Kig7yvNj2QleWNm1bKRAcdmSqzcE2elfJ8Fj91
        hRvr/lFLS2CLRSsPKwRC8sqz29c8kzfVEnNOOQHo6iF/lLLkBZLFxr1PSBrqCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655677894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N660GOHC6hN+7Tg/gydyH7WIwLnrHE0R2PPkXSp3Hlg=;
        b=zM1LX+kSc0GxQvc7Rpln+k75ICxT9bgg7KavOaFTAWCDjLZ4yURnoSJWIibgEfeonIdzgE
        JSBTslasUMH3PiAQ==
To:     Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Boot stall regression from "printk for 5.19" merge
In-Reply-To: <87r13kwawb.fsf@jogness.linutronix.de>
References: <20220619204949.50d9154d@thinkpad>
 <87r13kwawb.fsf@jogness.linutronix.de>
Date:   Mon, 20 Jun 2022 00:37:34 +0206
Message-ID: <87o7yowaih.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-20, John Ogness <john.ogness@linutronix.de> wrote:
> On 2022-06-19, Marek Beh=C3=BAn <kabel@kernel.org> wrote:
>> the series
>> https://lore.kernel.org/linux-kernel/YouKQw72H7y9EJQK@alley/
>> merged by commit 537e62c865dc ("Merge tag 'printk-for-5.19' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux")
>>
>> and in particular the commit 09c5ba0aa2fc ("printk: add kthread console
>> printers")
>>
>> causes a regression on arm64 (Marvell CN9130-CRB board) where the
>> system boot freezes in most cases (and is unusable until restarted by
>> watchdog), or, in some cases boots, but the console output gets mangled
>> for a while (the serial console spits garbage characters).

Also, have you tried 5.19-rc3? There were several fixes that came in
after rc2.

John Ogness
