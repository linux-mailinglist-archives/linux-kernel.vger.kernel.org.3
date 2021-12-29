Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88BE3481687
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhL2UDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:03:18 -0500
Received: from polaris.svanheule.net ([84.16.241.116]:37880 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbhL2UDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:03:17 -0500
Received: from [IPv6:2a02:a03f:eafe:c901:bb38:31d0:45d2:689b] (unknown [IPv6:2a02:a03f:eafe:c901:bb38:31d0:45d2:689b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 0E96628997C;
        Wed, 29 Dec 2021 21:03:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1640808196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9r89ta2jJHkQ/ecMndRJFDOX7vYNBNPWMZRvoAUYTlI=;
        b=L+3KiH4ccDiwjYwMd/c3ibu39FGLpfIe1YELBJlLtkptw1xpDhWEUAjml4QK5BJtkm4Vw5
        bLELIB2gIusPWywywzkd85Co2Vx3+AkLkBidqxPFCJS1pKhzkXUDxJLWm+t6Vj+o3cSxs3
        kb5xZxLFOXh4s3x1vYjkvgzJUExHR+Y3bv4JRSiaChTvTwHij2Rfd1lOgmR5px7iPI9LgA
        SghBX40wfy1ycHPavkSelvXgWaGbLiMRpaRHqjrtZJX4owUkJ6jCEBkECsif+/0YrIX4PU
        tnIezaoCA4mnw1CrMMMuyrrHW23GmPJOI2ljNn76vA4jkse/4udOAm8MGof2FA==
Message-ID: <f5e752abc5929cfc8fffd55f5991ab48f141c200.camel@svanheule.net>
Subject: Re: [RFC PATCH v2 0/5] Rework realtek-rtl IRQ driver
From:   Sander Vanheule <sander@svanheule.net>
To:     Birger Koblitz <mail@birger-koblitz.de>
Cc:     linux-kernel@vger.kernel.org, bert@biot.com, john@phrozen.org,
        tglx@linutronix.de, maz@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Date:   Wed, 29 Dec 2021 21:03:15 +0100
In-Reply-To: <0086fb07-c5d3-9600-4b62-d7497b192461@birger-koblitz.de>
References: <cover.1640548009.git.sander@svanheule.net>
         <90a3ce57-875f-d34a-0714-f815acae12d4@birger-koblitz.de>
         <bvv98e.r4rs9b.2rw3hx-qmf@polaris.svanheule.net>
         <0086fb07-c5d3-9600-4b62-d7497b192461@birger-koblitz.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Birger,

On Tue, 2021-12-28 at 09:09 +0100, Birger Koblitz wrote:
> Hi Sander,
> > I haven't tested this with VSMP, because it is out of scope for this series. For the
> > binding, I expect that would only require N register ranges instead of one; one per
> > CPU. I think the driver should then be able to perform the IRQ balancing based on that
> > information alone, given that the parent IRQs are available at each CPU.
> 
> whether this is out of the scope of this series is not the point. In my experience you
> only see issues with locking and race conditions with the IRQ driver if you test with
> VSMP enabled,
> because only with VSMP you can be in the IRQ code multiple times at the same time. Since
> you want to change routing logic and hierarchies I would believe it to be a very good
> idea
> to test that. The present code passes that test.

Implementing CPU affinity is a separate issue for after these patches IMHO. The current
problems have to be fixed anyway. Otherwise you're just compounding (potential) issues,
only making further development harder.

FWIW, the driver with these (reworked) patches runs fine on my RTL839x (Zyxel GS1900-48)
with SMP enabled. That's without implementing CPU affinity support on this driver, so all
SoC interrupts just go to CPU0. If any issues with lock-ups show up later, we can fix them
when they appear.

Best,
Sander
