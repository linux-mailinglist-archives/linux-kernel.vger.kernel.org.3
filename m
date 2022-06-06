Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDBE53E84D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239396AbiFFOEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239340AbiFFOD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:03:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E40027411E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654524211;
        bh=1rXejKPjfPobdbqz0N4V2TYitGKaYG2LAs2vjWAHL3A=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=EAxXEQM9A8tBIvVlZgUEqYL2B0H6N0P+yNg6iv+qEy1iYrI6qVy2woDBhO/nvz6DB
         0OF+XNMphKeXch/MdFJdERLDavK22RSFH6MMK5Og2fQjMkN+9jHxLFHh7g/qSkd6aP
         PK4EmNPo+T3wCAtyBprZfT/OEQJX7EQs2HgSKRm0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.151.134] ([217.61.151.134]) by web-mail.gmx.net
 (3c-app-gmx-bs45.server.lan [172.19.170.97]) (via HTTP); Mon, 6 Jun 2022
 16:03:31 +0200
MIME-Version: 1.0
Message-ID: <trinity-aa8df6a5-bba9-4b36-8b0f-591113b5fe71-1654524211277@3c-app-gmx-bs45>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Aw: Re: [PATCH] firmware: arm_scmi: Relax BASE protocol sanity
 checks on protocol list
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 6 Jun 2022 16:03:31 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <45bf11a8-47eb-e088-ba99-30c8788c7143@wolfvision.net>
References: <20220523171559.472112-1-cristian.marussi@arm.com>
 <45bf11a8-47eb-e088-ba99-30c8788c7143@wolfvision.net>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:z+1mX/8+LgSoLE4mwpZunGvi7NBzJPoQLSoQ49Tf5vqoXmRpTJOxQnbemvyiKLa/nrGBs
 LM+O107+QK089vb72msJ1F9l16vPq5HTZWa6ERvZeV8PV2DynEgLcGClj45GPHYeufNokXkF8t/S
 pYXtK0ylpd8s2GpipEgxaFdjz9alLS0KOq2SFM39SJ+0xljWXvSH+PYRY4R/dx6o41LcvKTlpI9n
 UdmdYpV2WY9IecUpjGycaAK5Hh2OB15czJ/lnswOrzwq+4lvYU36l+wBBPRzeI9Iu+O35ySymMAP
 HE=
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Wwq7P8Fq3U=:/jDxrhTWZhDc5/zwtz01m8
 9sXuoH8rNFlnZeGYD5wK+m1kBe3BNi0BBEEdPOO6JisIDTik43OhHFL83uJxrBWfka/5oHaK9
 cJc8EonlHjW/jmaxq3PwXDc9uv9qtQP/RO3WM5q7+ukfEF03CAv2gDlYXG7jdsM/83iQk3l8T
 iR+iBCYvj+jYXhRd1GRdNhe20ityIxIpj218Y6MTqYmu9rrIqEBCLPv4pgXDfJyY2ENtAJ2+n
 9YEnEOxnmQed8CUNaImLifhh71Z3Va+Xc3z4XfoSgxn5+4gbt7rXxYpjY2p+dEmRiuEA6Tupx
 rblEZa3gQhK4++pQpARLMW3VBa0LM7jyH+K02ixI8DGzNaZqgJmcFrdo+AE3CFTh1HXGEWnMm
 pGjGUGCMuYPnuuWCap/LR31TPuOSkQyQ08T0jD1sBnXxKV83PciZgz8NiX/JRcMTBlu7tSbtP
 PBLwolK6PKxcFci5CXvmjPLFh37gfd189MHJeE2H3qqdYWsSQIBw/lQ3E0ao6xYBIjJPZSU48
 vnMRHbTu5ZG5AnL6jUGhBZ6RJCSzdsoaeOETnOi5wbqb1kiieLb1D0/bvyr5sXFNdpQwv96fj
 sMOGR+R1Rf55GfPUatW2F6dR7LijIJCgAvbUmmBurSjjDMVwlQuh3K0XsinQJDv+qiXCQw8Vc
 KtT4fBZfjp/jWj1d9rnywpdG8WaqYAVG+WWAuVs8MtvDoPShgbkfGyR1mjsyYj8O6MmdKPGZ2
 5mw1XidRn5QHzgXY0fVqB90M3Jx21ZuKNE37qFsvV5DrnZqe7Ajqj7Deow69zeekDEdAlDGTI
 YEVpIKp
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Gesendet: Montag, 06. Juni 2022 um 14:59 Uhr
> Von: "Michael Riesch" <michael.riesch@wolfvision.net>

> Thanks a lot, without this fix the Mali G52 GPU won't probe on my RK3568
> EVB1 in vanilla v5.19-rc1.
>
> I guess this patch should have a Fixes: tag, right?
>
> Would be great to have this in v5.19. AFAIC:
>
> Acked-by: Michael Riesch <michael.riesch@wolfvision.net>

Thanks for the Patch, had also this on my rk3568 bpi-r2 pro board:

panfrost fde60000.gpu: get clock failed -517

fixed by this patch

Tested-By: Frank Wunderlich <frank-w@public-files.de>

regards Frank
