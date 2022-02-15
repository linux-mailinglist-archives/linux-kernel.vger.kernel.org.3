Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C65E4B6AC6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 12:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbiBOL1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 06:27:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbiBOL1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:27:15 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9C210D9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 03:27:04 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jyf1z0Wlgz4xcY;
        Tue, 15 Feb 2022 22:27:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1644924423;
        bh=2bjEo/l1VuKsDDnpXHRYc8XcSJyXSTPJfQq6nV/jw5E=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=M5vUQHwI7ONB8kQMJ2wuRbKHkhWQnv9vfiQPxHQjVjnkycLnHlI60AS+hKyV0yFO9
         a/JDvNI9HrfJb/XGRVYj8rYKZZ/oUnBgy3sDzTxpuFxk2LHP7dReNi0dbOQ06aNMKZ
         BCxeS8wb2bhs3FOz6CvIS2a6TgbRPXtbuHY0YGWsoeWokXouX3GAIOWlUdjse87WrN
         W7EL7hEB14XBpCq8wvmtkT/d7butip3fEdhlj4X3Vsk3nqJSkJUNE95w/FHY3dPKao
         CoJR36nYvgRQGtHj5UaAmRA2bx2lE7yJ1c4QHG54XUPkZwaGTsYgIu0Tvhdc2GbryG
         3YwasqFGBQRuQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Wedson Almeida Filho <wedsonaf@google.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc/module_64: use module_init_section instead of
 patching names
In-Reply-To: <CAMKQLN+Q3asVqP3MZVFZO66CvZVVfGOZn=pMXmiNqZ7t2i55wg@mail.gmail.com>
References: <20220202055123.2144842-1-wedsonaf@google.com>
 <CAMKQLN+Q3asVqP3MZVFZO66CvZVVfGOZn=pMXmiNqZ7t2i55wg@mail.gmail.com>
Date:   Tue, 15 Feb 2022 22:27:02 +1100
Message-ID: <8735kknzeh.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wedson Almeida Filho <wedsonaf@google.com> writes:
> Hi Michael,
>
> On Wed, 2 Feb 2022 at 05:53, Wedson Almeida Filho <wedsonaf@google.com> wrote:
>>
>> Without this patch, module init sections are disabled by patching their
>> names in arch-specific code when they're loaded (which prevents code in
>> layout_sections from finding init sections). This patch uses the new
>> arch-specific module_init_section instead.
>>
>> This allows modules that have .init_array sections to have the
>> initialisers properly called (on load, before init). Without this patch,
>> the initialisers are not called because .init_array is renamed to
>> _init_array, and thus isn't found by code in find_module_sections().
>>
>> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
>> ---
>>  arch/powerpc/kernel/module_64.c | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
...
>
> Would any additional clarification from my part be helpful here?

Just more patience ;)

> I got an email saying it was under review (and checks passed) but
> nothing appears to have happened since.

I actually put it in next late last week, but the emails got delayed due
to various gremlins.

cheers
