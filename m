Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E3547E85F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 20:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349982AbhLWT31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 14:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244849AbhLWT30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 14:29:26 -0500
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C817C061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 11:29:26 -0800 (PST)
Received: from [IPv6:2a02:a03f:eafe:c901:64fb:1efb:3747:a81f] (unknown [IPv6:2a02:a03f:eafe:c901:64fb:1efb:3747:a81f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 4868D2869F5;
        Thu, 23 Dec 2021 20:29:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1640287764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UU7qzXBB8jmiMrCwurtVyc0mmCpjHgy77oyZ+/UkVLs=;
        b=i4cO68vv6Fpae5k6E4IrNog/Vgip5Kt11zwDbsQdwcWFnkTjcpSPe5JTgSMcoD3uq1yecx
        K2Zjm/vGnqhwZLQt+d6MBtoup12ggO/xHR82mf7F4MfYuOgMmmxq8VxwQpqWKwtqKrvNqv
        pZEoyD5/LWK5UXqn9ZMMFCByoj0tayB07qRrZVJtwhm0UqAs2EZtkqME0m08pm9D+aox2r
        54RLA2o6cy5tqDADKVOrfIThd1W7sRW1gkREKUU/OtNlnE1d4iOx7gavMBV952jcvwVYAi
        m2VHlKSGSYrW48uIOABrOvZjTWileRzbJYzRIelYS5H89K/exEJqRQr6iDAwVg==
Message-ID: <add13702d89fdad4ae7a479c0894aaa3be794087.camel@svanheule.net>
Subject: Re: [RFC PATCH v1 3/4] dt-bindings: interrupt-controller:
 realtek,rtl-intc: replace irq mapping
From:   Sander Vanheule <sander@svanheule.net>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org
Date:   Thu, 23 Dec 2021 20:29:23 +0100
In-Reply-To: <87y24byzej.wl-maz@kernel.org>
References: <cover.1640261161.git.sander@svanheule.net>
         <8a5931f18a6f1c92f8c8e4965dc65674d7e5a4c4.1640261161.git.sander@svanheule.net>
         <87y24byzej.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-12-23 at 18:00 +0000, Marc Zyngier wrote:
> On Thu, 23 Dec 2021 12:08:33 +0000,
> Sander Vanheule <sander@svanheule.net> wrote:
> > 
> > The binding incorrectly specified the "interrupt-map" property should be
> > used, although the use is non-standard. A quirk had to be introduced in
> > commit de4adddcbcc2 ("of/irq: Add a quirk for controllers with their own
> > definition of interrupt-map") to allow the driver to function again.
> 
> That's too late. We have released a kernel with this binding, and it
> will live on forever until we totally remove the platform from the
> tree.
> 
> DT is an ABI, and only time travel can fix this blunder.

Taking into account your comments on the previous patch, this change wouldn't even be
required if I correct the mappings for my devices. But that wouldn't get rid of the
assumed mapping between output lines and parent interrupts.

To what extent can the binding be updated to get rid of this assumption? Or would that
require a completely new binding?


Best,
Sander
