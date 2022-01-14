Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C69348E432
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239334AbiANGVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiANGVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:21:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4871C061574;
        Thu, 13 Jan 2022 22:21:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5427B82358;
        Fri, 14 Jan 2022 06:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1516C36AEA;
        Fri, 14 Jan 2022 06:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642141306;
        bh=jMMCQqHtQybK+7j6b9dRuEYkttlsElUrZOATTRYk3nY=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=mydq9O2zMax5L27z6DbdkN0K82YjLUhFbSLtKQQt/heZwXE1An/F2Yzn7KVXt1wMt
         0tXCzSPrTl5B0zVq5IkiZqyo9IynB6SKEtxfv9OBEVmSx5qHYqGxYP7B7C+/e9rNeb
         w1APZwq+KfpwJTTDx+MUVwowlyakdjzOrpkPq8+SVfQm/A9nCFj3/5KvR+6gZrh9jC
         g2BZIkviW35EC7kT0N+XfGr/Gfld7PLqKmIg5jBAkKIjzPSJT6nUBjRY57v6DVHweD
         XDFEvPJ8hxAGMWgTJkQcyJd34O0Ni4x6Bqei7JWY94fOfqLFZYpxoqbxY33c7ydV0I
         50q7eEmF/Lirw==
References: <20211202191630.12450-1-jaschultz@microsoft.com>
 <20211202191630.12450-3-jaschultz@microsoft.com>
 <CAMuHMdUPwo7pCSwY8_9xTaDruTHt6d=wHiNHvRmE71k8hWeLBw@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 28.0.90
From:   Felipe Balbi <balbi@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jarrett Schultz <jaschultzms@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Jarrett Schultz <jaschultz@microsoft.com>
Subject: Re: [PATCH 2/5] platform: surface: Propagate ACPI Dependency
Date:   Fri, 14 Jan 2022 08:20:41 +0200
In-reply-to: <CAMuHMdUPwo7pCSwY8_9xTaDruTHt6d=wHiNHvRmE71k8hWeLBw@mail.gmail.com>
Message-ID: <87czku4z2i.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Geert Uytterhoeven <geert@linux-m68k.org> writes:
> Hi Jarrett,
>
> On Mon, Dec 6, 2021 at 4:03 PM Jarrett Schultz <jaschultzms@gmail.com> wrote:
>> Since the Surface XBL Driver does not depend on ACPI, the
>> platform/surface directory as a whole no longer depends on ACPI. With
>> respect to this, the ACPI dependency is moved into each config that depends
>> on ACPI individually.
>>
>> Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
>
> Thanks for your patch, which is now commit 272479928172edf0 ("platform:
> surface: Propagate ACPI Dependency").
>
>> --- a/drivers/platform/surface/Kconfig
>> +++ b/drivers/platform/surface/Kconfig
>> @@ -5,7 +5,6 @@
>>
>>  menuconfig SURFACE_PLATFORMS
>>         bool "Microsoft Surface Platform-Specific Device Drivers"
>> -       depends on ACPI
>>         default y
>>         help
>>           Say Y here to get to see options for platform-specific device drivers
>
> Without any dependency, all users configuring a kernel are now asked
> about this. Is there any other platform dependency that can be used
> instead?

there's probably no symbol that would be true for x86 and arm64 while
being false for everything else. Any ideas?

In any case, what's the problem of being asked about a new symbol? That
happens all the time whenever new drivers are merged, right?

-- 
balbi
