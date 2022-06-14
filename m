Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A01854ACEC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353808AbiFNJHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353568AbiFNJGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:06:36 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DFE419A8;
        Tue, 14 Jun 2022 02:06:13 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id D96C9E001A;
        Tue, 14 Jun 2022 02:06:12 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id voKW3dmm8_ZE; Tue, 14 Jun 2022 02:06:12 -0700 (PDT)
Message-ID: <573166b75e524517782471c2b7f96e03fd93d175.camel@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1655197572; bh=DRsSqt8gISIlXBvUsIdzvECBw1H0LbI7MkrMo87xlig=;
        h=Subject:From:To:Cc:Date:From;
        b=FN5oqRGvf4gwSqMKw7kQ2uElmFZVNm9+1W2u3luQWBublPhloBzglnhN78w2XWtJI
         yPgVbq4XeIyMAC2iYcKizwDcPiNXQbo2ZCo6MrQ0MjVQuUoc1v7MZQFTY/3ITsjhJN
         ffpoBiDwGCzm+ydufvo02gbOH8MbezzIMnGkeEeoZ9haTyrActyN8rO2kYJh3UH3PE
         pUO4e7iS0GASg6eZn26vjw5pvlSPyD9U3g69Wv3kkK4vY9svcrIhEspjEsiC/SCnh1
         I57qmuziGXIULD3DjOeB45txHRWXvFKykkZ2l86knc377kdymbLGFGzOM6v8vN2zan
         4041KSKo+85iQ==
Subject: regulator: BD71837 PMIC resume during noirq phase?
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     matti.vaittinen@fi.rohmeurope.com, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Date:   Tue, 14 Jun 2022 11:06:06 +0200
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

hi Matti,

I heard you've been helpful in the past - thank for that! Here's a
question I'm currently stuck at: In short, imx8mq can't yet resume from
suspend when using the bd71839 pmic via i2c. The original report here,
just for the background:

https://lore.kernel.org/linux-arm-kernel/2d5d3bbec443742506e39488dbfbf724bb4ca93f.camel@puri.sm/T/#u

But here's what I *think* is going on: When the (buck3) regulator from
bd71839 is the power-supply for a power domain (gpu), the power domain
driver can't resume because buck3 can't be enabled when the pmic isn't
running yet. I'm still a bit uncertain, but here's the logs when simply
printing in the respective suspend/resume callbacks:

[  452.199600] bd718xx-pmic bd71837-pmic.2.auto: bd718xx_resume_noirq
[  452.301450] imx-pgc imx-pgc-domain.5: failed to enable regulator: -
ETIMEDOUT
[  452.320593] imx-i2c 30a20000.i2c: i2c_imx_resume
[  452.322152] bd718xx-pmic bd71837-pmic.2.auto: bd718xx_resume
[  452.323853] imx-i2c 30a30000.i2c: i2c_imx_resume
[  452.324778] imx-i2c 30a40000.i2c: i2c_imx_resume
[  452.325017] imx-i2c 30a50000.i2c: i2c_imx_resume

and regulator_enable() in imx-pgc is called from genpd_resume_noirq().

At this point, does any workaround or fix come to your mind I could
test? I guess i2c needs to be resumed too...

Why does power domain only implement resume_noirq? How could I untangle
this?

thank you very much,

                            martin


