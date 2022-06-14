Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF8B54ADD2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242068AbiFNJ50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238421AbiFNJ5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:57:24 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7583EB74;
        Tue, 14 Jun 2022 02:57:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 1D9B1E001A;
        Tue, 14 Jun 2022 02:57:23 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zmYV0_fNanVr; Tue, 14 Jun 2022 02:57:22 -0700 (PDT)
Message-ID: <8024d9e3b885941084740cb0fb2fc9117acdd069.camel@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1655200642; bh=Rey8CK2/AutuqbNI1TttDkE+g6sTkkOOQ0cIeP09/Eg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=m1KyYJfqGSa8yvppfGNN1HVrJe+k1SP09oiNB9b3GxttpaTCVbfZYSTeCOy19LdSh
         JjjjAE1SqtzvoPrrS4P7CPg6ERRkyaNUx9iLaxzIFblEVUYsOxGrpPQkryTkYkFw2x
         ekSi3VQUPNMKR8gwv+Scif1WeJqRUz5LArvWZHK4aBXpKF1Hb7/WKFFxfeEcjdbRk9
         n1bDthsdG98QurGxSue03f5oVEVOZaoVLHqgmKVKg8kB7Vsx2S+Hs8tQbmw6fEn1QN
         0410pLqoTaGzp2NtKZjlVYQDDmI7bcnr4nTjKmfMb2UsgUhwgErQzLF1afg2GKxJrm
         ntd7liWKyvYKQ==
Subject: Re: regulator: BD71837 PMIC resume during noirq phase?
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     Mark Brown <broonie@kernel.org>
Cc:     matti.vaittinen@fi.rohmeurope.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Date:   Tue, 14 Jun 2022 11:57:18 +0200
In-Reply-To: <YqhSXuHMR6kuFu/A@sirena.org.uk>
References: <573166b75e524517782471c2b7f96e03fd93d175.camel@puri.sm>
         <YqhSXuHMR6kuFu/A@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, dem 14.06.2022 um 10:18 +0100 schrieb Mark Brown:
> On Tue, Jun 14, 2022 at 11:06:06AM +0200, Martin Kepplinger wrote:
> 
> > and regulator_enable() in imx-pgc is called from
> > genpd_resume_noirq().
> > 
> > At this point, does any workaround or fix come to your mind I could
> > test? I guess i2c needs to be resumed too...
> > 
> > Why does power domain only implement resume_noirq? How could I
> > untangle
> > this?
> 
> Indeed - if a power domain is controlling regulators then I'd not
> expect
> things to go well if it tries to resume without interrupts, there
> will
> be some things that can be done purely with GPIOs but that's
> depending
> on the hardware having wired things up that way and the operations
> needed by the power domain mapping well onto what can be done with
> GPIOs.

and what's the danger when resuming power domains later?:

--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2062,8 +2062,8 @@ int pm_genpd_init(struct generic_pm_domain
*genpd,
        genpd->domain.ops.runtime_suspend = genpd_runtime_suspend;
        genpd->domain.ops.runtime_resume = genpd_runtime_resume;
        genpd->domain.ops.prepare = genpd_prepare;
-       genpd->domain.ops.suspend_noirq = genpd_suspend_noirq;
-       genpd->domain.ops.resume_noirq = genpd_resume_noirq;
+       genpd->domain.ops.suspend = genpd_suspend_noirq;
+       genpd->domain.ops.resume = genpd_resume_noirq;
        genpd->domain.ops.freeze_noirq = genpd_freeze_noirq;
        genpd->domain.ops.thaw_noirq = genpd_thaw_noirq;
        genpd->domain.ops.poweroff_noirq = genpd_poweroff_noirq;


thanks for taking the time,

                          martin


