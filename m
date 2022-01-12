Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379C648C02A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351731AbiALIp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351576AbiALIpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:45:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB175C06173F;
        Wed, 12 Jan 2022 00:45:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9357161862;
        Wed, 12 Jan 2022 08:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00035C36AEA;
        Wed, 12 Jan 2022 08:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641977124;
        bh=A1BNQxX5hhN6LMUftJiJl5KYRUs0KN8/aVOTnWXXYEE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YtDWqJopTi8jviRc3wrsKp2i58dyPAAacPWTNmfvJsYLhg20ixwBvu6ciqSN/NvFA
         76k8b8sar7oSHJ0w8TuaTMMW5TuDZN1aocp3xbKoR3c/bzdXx8+WIlGRaK1LxX2h3i
         KTXWK7A5Jiq7IKOv5QtOUZf1KvQ/v896s+couNJ7bL2mclgnT5zERTYN2Kk/8a4jYn
         W6HIh/1LNlGyd812cCTJdK2+C0nnOdEOqWcGIxnTVMYE+q6QUxZxFtyLxd9tNQ+uX0
         +Qjcj5Nj9PB7ur65/ZsiBKjqN1Xo6agOweoUB1Pwx/nwQDgOGirO/hSD+HSiknWR0G
         fwfJcfo4v5yAA==
Received: by mail-wr1-f50.google.com with SMTP id t28so2832595wrb.4;
        Wed, 12 Jan 2022 00:45:23 -0800 (PST)
X-Gm-Message-State: AOAM530KWev2uG6v8q2pHdmcOuYdgCr8/FYLwlp6l1oSbG/kzOg27x1V
        CsdeM9vJTevgRs4uf+aYEhr45OTOpbMolSywTVU=
X-Google-Smtp-Source: ABdhPJy/lXKvM9dFCXSNNlMl0JeSwIZoPOICLPOHEfMVTypdxjTEaJq8GTTZpUx+/HM3IC5VCKqn5doJTSNL1xkusGU=
X-Received: by 2002:adf:fd46:: with SMTP id h6mr7059333wrs.192.1641977122328;
 Wed, 12 Jan 2022 00:45:22 -0800 (PST)
MIME-Version: 1.0
References: <2614912.mvXUDI8C0e@kreacher>
In-Reply-To: <2614912.mvXUDI8C0e@kreacher>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 12 Jan 2022 09:45:06 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1vQj10a4ztj8KfSuxGkOfooB=6q0xj_s5pmhzoS00S1w@mail.gmail.com>
Message-ID: <CAK8P3a1vQj10a4ztj8KfSuxGkOfooB=6q0xj_s5pmhzoS00S1w@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Use uintptr_t and offsetof() in Linux kernel builds
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 4:55 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> To avoid "performing pointer subtraction with a null pointer has
> undefined behavior" compiler warnings, use uintptr_t and offsetof()
> that are always available during Linux kernel builds to define
> acpi_uintptr_t and the ACPI_TO_INTEGER() and ACPI_OFFSET() macros.
>
> Based on earlier proposal from Arnd Bergmann.
>
> Link: https://lore.kernel.org/linux-acpi/20210927121338.938994-1-arnd@kernel.org
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks for the follow-up. I can't easily test this at the moment, but
it looks correct to
me. I had a different approach that I had planned to eventually
submit, but yours
looks better anyway, so let's go with this.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
