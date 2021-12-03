Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB86466F04
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 02:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbhLCBO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 20:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbhLCBO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 20:14:56 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6B0C061757;
        Thu,  2 Dec 2021 17:11:32 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J4vsv3CSNz4xbC;
        Fri,  3 Dec 2021 12:11:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1638493891;
        bh=+JylP2RVIbtJzYpK2ZtaZSsm+v7AMw7cQapVbRNSwI8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=j/t8FbUTVygIvVEoxzzZeVOIlusztuSn4HuxDqsS5CfLp5BE/rNBKoWcnGHmhPitv
         PzUTw22HhaYWs+WvRmGOXGuScXvgCT3wxz6PIV4ZAjlb8kRYnDCZKhmuQW3vM3TeSi
         nIz+9c9qz9/3zi1SF13P9qFNiJIWHQqMSGAQnj272Jkd/hMLVJQQTDguqSFB2aQmWj
         QZp81bpe2lrteGS8N190rWVOJU3dCiIKDgqeB16b+oM2pmF17lblSKI/ydd7qxTCNM
         kOsh7WJS7l225DTMkC6wTJh7ppHqwW1i1WX+A60L+imI6V/Xhbm2ecGQnWdX3d9ZDu
         CnBhtLuPtJOLA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>
Cc:     Calvin Zhang <calvinzhang.cool@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] of: unmap memory regions in /memreserve node
In-Reply-To: <YaiRAD40xCK7u3Hl@FVFF77S0Q05N>
References: <20211124133347.3861391-1-calvinzhang.cool@gmail.com>
 <YaapE8oys5zQEdD5@robh.at.kernel.org> <YaiRAD40xCK7u3Hl@FVFF77S0Q05N>
Date:   Fri, 03 Dec 2021 12:11:26 +1100
Message-ID: <874k7qpk5d.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Rutland <mark.rutland@arm.com> writes:
> On Tue, Nov 30, 2021 at 04:43:31PM -0600, Rob Herring wrote:
>> +linuxppc-dev
 
Sorry missed this until now ...

>> On Wed, Nov 24, 2021 at 09:33:47PM +0800, Calvin Zhang wrote:
>> > Reserved memory regions in /memreserve node aren't and shouldn't
>> > be referenced elsewhere. So mark them no-map to skip direct mapping
>> > for them.
>> 
>> I suspect this has a high chance of breaking some platform. There's no 
>> rule a region can't be accessed.
>
> The subtlety is that the region shouldn't be explicitly accessed (e.g.
> modified),

I think "modified" is the key there, reserved means Linux doesn't use
the range for its own data, but may still read from whatever is in the
range.

On some platforms the initrd will be marked as reserved, which Linux
obviously needs to read from.

> but the OS is permitted to have the region mapped. In ePAPR this is
> described as:
>
>    This requirement is necessary because the client program is permitted to map
>    memory with storage attributes specified as not Write Through Required, not
>    Caching Inhibited, and Memory Coherence Required (i.e., WIMG = 0b001x), and
>    VLE=0 where supported. The client program may use large virtual pages that
>    contain reserved memory. However, the client program may not modify reserved
>    memory, so the boot program may perform accesses to reserved memory as Write
>    Through Required where conflicting values for this storage attribute are
>    architecturally permissible.
>
> Historically arm64 relied upon this for spin-table to work, and I *think* we
> might not need that any more I agree that there's a high chance this will break
> something (especially on 16K or 64K page size kernels), so I'd prefer to leave
> it as-is.

Yeah I agree. On powerpc we still use large pages for the linear mapping
(direct map), so reserved regions will be incidentally mapped as
described above.

> If someone requires no-map behaviour, they should use a /reserved-memory entry
> with a no-map property, which will work today and document their requirement
> explicitly.

+1.

cheers
