Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257A151D42C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 11:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390411AbiEFJYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 05:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbiEFJYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 05:24:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084B464BE3
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 02:20:50 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651828848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ByGMit4bInofkI4sp0URUqarfW2TZeUZlukIgdPUvmI=;
        b=2xLeSLrZtbphqBEHpyBD6Jp8lUHc9pa8DxvTNRq18TNLO7sGo+vzptVDKo/gLFsakfbJZD
        kI7CaEPdDu02nj1WPhve0bW0S8a6PKnotGP2Kcy2AENcJStC1kz/1L433P0J0orBXR+OEK
        fs9UBw4pUxHF6X/xq/AJ7nUw9QU1l6wQZGZRN3DT8B1QCWL2DT3YoQjfimAh1KJWhKC3o3
        2qamUtne30lYqw+s+3bC+URgqNjjiIP2L2otEJ6eh38BSCUxMkqM75uyhrhMhJkm0BIXlc
        gM4Yq0em3GnaTHi3ICqQTirV6ibRirsY/Pc5bV+N5FURqr751Jk96B+ZWdQdhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651828848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ByGMit4bInofkI4sp0URUqarfW2TZeUZlukIgdPUvmI=;
        b=RBSAE2VBBVWieZu/LaOmvSElA6Yx5ZMtPFrmrn3/HspTF7dIczN+W7SFimeJZj9XZ3nhSY
        3NxH8BEdpamHiwBQ==
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH printk v5 1/1] printk: extend console_lock for
 per-console locking
In-Reply-To: <b7c81f02-039e-e877-d7c3-6834728d2117@samsung.com>
References: <Ymfgis0EAw0Oxoa5@alley> <Ymfwk+X0CHq6ex3s@alley>
 <CGME20220427070833eucas1p27a32ce7c41c0da26f05bd52155f0031c@eucas1p2.samsung.com>
 <2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com>
 <Ymjy3rHRenba7r7R@alley>
 <b6c1a8ac-c691-a84d-d3a1-f99984d32f06@samsung.com>
 <87fslyv6y3.fsf@jogness.linutronix.de>
 <51dfc4a0-f6cf-092f-109f-a04eeb240655@samsung.com>
 <87k0b6blz2.fsf@jogness.linutronix.de>
 <32bba8f8-dec7-78aa-f2e5-f62928412eda@samsung.com>
 <Ym/Z7PYPqvWPEjuL@alley>
 <45849b63-d7a8-5cc3-26ad-256a28d09991@samsung.com>
 <87pmktm2a9.fsf@jogness.linutronix.de>
 <87a6bwapij.fsf@jogness.linutronix.de>
 <87zgjvd2zb.fsf@jogness.linutronix.de>
 <b7c81f02-039e-e877-d7c3-6834728d2117@samsung.com>
Date:   Fri, 06 May 2022 11:26:48 +0206
Message-ID: <87pmkrkoen.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-06, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> Could you try booting the meson hardware with the following change? (And
>> removing any previous debug changes I posted?)
>
> Bingo! It looks that the startup() is called when getty initializes 
> console. This fixed the issues observed on the Amlogic Meson based boards.
>
> Feel free to add:
>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks Marek. I will post an official patch on the correct people/lists.

John
