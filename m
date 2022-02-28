Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343914C6D43
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbiB1M6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbiB1M5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:57:55 -0500
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFC67804D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:57:17 -0800 (PST)
Received: from vanadium.ugent.be (vanadium.ugent.be [157.193.99.61])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id F17332A9DB5;
        Mon, 28 Feb 2022 13:57:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1646053035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bapqjhLApcwzDEhybuGVU/3933XunfSW4IVKilZ7qD4=;
        b=pv0ZTcwUvhCAo4vxv2igrSpgiecCPZyuDI4hMokJve/s2Gdp7QcZcXzj5UohqsBwM7ZAAA
        eNzPSkxzaKOjLZv7DGoka7E+VKNpTHHGKC9F7+Hdagu30tmeQ4KgeCkDRLBDWQk5XnYUeI
        Kit+3/QQ8BzKWgnbEP71BU/7x1GRzLGMgb5uWMt2XL7CL0LW15E+ekd/P7P6XJQYLaNFOg
        vekTaj76LdctZmJ60lIbMjl1uhQdUpY+Qm3v2CKx0c6G6gIzcdc7Lei5D+oNAHa9DDqQh7
        IoziqFLAMWxOiUJyyzseWZL1GYr1eH1qszF3viLsY/5vuvOuwXEVdEPD9kf6aA==
Message-ID: <4a8dac0dc296920c6e58584d48d6eaf6644b0322.camel@svanheule.net>
Subject: Re: [PATCH v5 0/4] Per-parent domains for realtek-rtl IRQ driver
From:   Sander Vanheule <sander@svanheule.net>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org
Date:   Mon, 28 Feb 2022 13:57:13 +0100
In-Reply-To: <87czjo49ht.wl-maz@kernel.org>
References: <cover.1644864700.git.sander@svanheule.net>
         <87czjo49ht.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Tue, 2022-02-15 at 12:09 +0000, Marc Zyngier wrote:
> On Mon, 14 Feb 2022 18:56:57 +0000,
> Sander Vanheule <sander@svanheule.net> wrote:
> > 
> > The original implementation for this interrupt controller/router used
> > an interrupt-map parser to determine which parent interrupts were
> > present. However, this controller is not transparent, so a list of
> > parent interrupts seems more appropriate, while also getting rid of the
> > assumed routing to parent interrupts.
> > 
> > Additionally, N real cascaded interrupts are implemented, instead of
> > handling all input interrupts with one cascaded interrupt. Otherwise it
> > is possible that the priority of the parent interrupts is not respected.
> 
> My original question[1] still stands. An old kernel breaks with a new
> DT. I am not convinced that this is an acceptable outcome.
> 
>         M.
> 
> [1] https://lore.kernel.org/all/874k585efy.wl-maz@kernel.org


My apologies for the delay in replying, although I suppose the lack of response
from others perhaps indicates that there is little interest maintaining old
kernel/new DT compatibility for this hardware. John has previously argued in
favour of breaking compatibility [2].

Chances of someone running a vanilla kernel build on this hardware are close to
zero at this moment. The most important part, the internal ethernet switch, is
only supported with out-of-tree patches. If patches can be included on an old
(LTS) kernel to provide networking support, then patches can be included to be
compatible with a new DT specification for the interrupts as well. OpenWrt does
exactly this: use an old (5.10) kernel with new upstream features backported.

The binding could be adjusted to allow (but deprecate) interrupt-map for the new
two-part compatibles. This would require a new DT to both specify two-cell
interrupt specifiers, and an equivalent interrupt-map definition to ensure
perfect two-way compatibility. This duplicated info would need to be maintained
for years however, as LTS kernels stay around for a long time. In my opinion,
breaking compatibility with old kernels would allow us to move forward with a
cleaner driver and binding.

Best,
Sander

[2]
https://lore.kernel.org/all/9c169aad-3c7b-2ffb-90a2-1ca791a3f411@phrozen.org/
