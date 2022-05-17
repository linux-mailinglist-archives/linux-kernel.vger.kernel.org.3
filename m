Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B7452ABDF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 21:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352677AbiEQTWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 15:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241252AbiEQTWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 15:22:09 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8619C42ED0;
        Tue, 17 May 2022 12:22:07 -0700 (PDT)
Received: from zn.tnic (p200300ea97465748329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:5748:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E99E11EC0494;
        Tue, 17 May 2022 21:22:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652815322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=IULBMfEGpOw9HxNHCKRwR6+0MRbfXrGSt3zlfqBRSkQ=;
        b=M5sfRUAfnZRyTytNX27nGdm7GTOJdPyCh2go8W+YApmL/RwEnT7JuzgZz+P7LU8Ghf8Oj6
        2frl1NRX0fbyU3Ozt2FC1ji4QXPIPIbEQHi55dO2f1d2u/oJTqcXx9lRat8zJ6q3rKU/5Y
        11ksitcfYivI/VNweYM4nMnGcMS40eQ=
Date:   Tue, 17 May 2022 21:21:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Vit Kabele <vit@kabele.me>
Cc:     platform-driver-x86@vger.kernel.org, r.marek@assembler.cz,
        x86@kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org,
        mingo@redhat.com
Subject: Re: [PATCH v2] arch/x86: Check validity of EBDA pointer in mpparse.c
Message-ID: <YoP11ZNZv2/Z7B0g@zn.tnic>
References: <CAJZ5v0gBbdzUO9MRxbKESEnaeaNAu-+3oP6ADMretch=iHPNJA@mail.gmail.com>
 <Yk/2dh4kDobivStp@czspare1-lap.sysgo.cz>
 <YnFoIzmt1qJSucAd@zn.tnic>
 <YoIc1AHLK4pfR4AI@czspare1-lap.sysgo.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YoIc1AHLK4pfR4AI@czspare1-lap.sysgo.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 11:43:48AM +0200, Vit Kabele wrote:
>  And the valid upper bound of the EBDA pointer is also different
> for these two use-cases. (The mpparse.c usage is interested in EBDA
> pointer only if it ends 1KiB before the end of low memory, while the
> ebda.c accepts even the values in the last KiB below 640KiB).

And I still don't know why this difference in the upper bounds is really
relevant and why you can't simply use the code in reserve_bios_regions()
after carving it out in a helper?

The latter considers ebda_start valid when it is between BIOS_START_MIN
and bios_start, after having sanitized that bios_start to 640K if "out
of bounds".

Why can't default_find_smp_config() simply scan the last KiB below
640KiB twice for the sake of simpler code?

I.e., there needs to be a single get_bios_ebda() - the current one can
be renamed to __get_bios_ebda() - and that get_bios_ebda() should give
either a sane EBDA address or 0 if the checks don't pass. And all code
should use that.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
