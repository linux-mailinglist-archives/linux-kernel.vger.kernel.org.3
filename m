Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B30C48BC40
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347593AbiALBOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:14:43 -0500
Received: from thorn.bewilderbeest.net ([71.19.156.171]:52161 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiALBOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:14:42 -0500
Received: from hatter.bewilderbeest.net (174-21-190-118.tukw.qwest.net [174.21.190.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id C2F2F293;
        Tue, 11 Jan 2022 17:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1641950082;
        bh=ZT9PJgDrRvnP2QDGwtXPPP/4k5HNYE0wgsYa9UJT854=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K2ve6+e/Wb3O8ZduDSRjEZzuxJGea+jfax//ksc/Hy/zXpM/RKo3AxqWPb4van+yu
         pHP13cg1diJKrks2OVy0GJPVKmcSpdRDsNTVhvvjh8TOuhdaz5GLPl/fpRKt7cLhlG
         0wSnqA17NpekCGWo1D57vLEge9d/c9YC9lO+Z0I0=
Date:   Tue, 11 Jan 2022 17:14:38 -0800
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Neil Horman <neil.horman@privafy.com>,
        Anthony Jenkins <anthony.jenkins@privafy.com>
Subject: Re: [PATCH] ARM: dts: aspeed: Add ASRock ROMED8HM3 BMC
Message-ID: <Yd4rfi/iICQ5EjGh@hatter.bewilderbeest.net>
References: <20220105101719.7093-1-zev@bewilderbeest.net>
 <CACPK8XeHyoo0D1vQm=L8m284kC5n-O+FEMp1HN+ROWJfx7qjhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACPK8XeHyoo0D1vQm=L8m284kC5n-O+FEMp1HN+ROWJfx7qjhQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 02:59:28AM PST, Joel Stanley wrote:
>On Wed, 5 Jan 2022 at 23:10, Zev Weiss <zev@bewilderbeest.net> wrote:
>>
>> This is a half-width, single-socket Epyc server board with an AST2500
>> BMC.  This device tree is sufficient for basic OpenBMC functionality,
>> but we'll need to add a few more devices (as driver support becomes
>> available) before it's fully usable.
>>
>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>
>Reviewed-by: Joel Stanley <joel@jms.id.au>
>

Thanks!

>Have you considered using the openbmc gpio naming scheme for the
>gpio-line-names?
>

I looked at it, but decided not to for a few reasons:

  - For systems that are in the early stages of a porting effort (like 
    this one currently is), I'm still referring to hardware schematics 
    fairly often, and using the same identifiers in software that are 
    used in the schematics simplifies things by avoiding an extra
    translation step between the two.

  - Most of the GPIO-related userspace components (that I'm dealing with 
    anyway, e.g. x86-power-control and host-error-monitor) already have 
    their own GPIO line-name configuration/remapping mechanisms that need 
    to be set up anyway.

  - There's a solid mix of GPIOs that would be covered by the naming 
    guidelines and others that aren't; having a mix of the two styles 
    seems a bit awkward to me.

That said, I sympathize with the motivation behind it and I'm not 
vehemently opposed on the whole, so if there's a strong preference to 
follow that scheme I could probably be talked into changing it.


Zev

