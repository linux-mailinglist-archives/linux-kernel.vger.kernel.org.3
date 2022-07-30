Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9836D585B06
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 17:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbiG3P3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 11:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbiG3P3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 11:29:36 -0400
X-Greylist: delayed 1759 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 30 Jul 2022 08:29:35 PDT
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BF813DF7;
        Sat, 30 Jul 2022 08:29:35 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1oHnwf-0004xe-VY; Sat, 30 Jul 2022 17:00:01 +0200
Date:   Sat, 30 Jul 2022 17:00:01 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Kshitiz Varshney <kshitiz.varshney@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Rahul Kumar Yadav <rahulkumar.yadav@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Matt Mackall <mpm@selenic.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-imx@nxp.com, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] Moving init_completion before request_irq
Message-ID: <20220730150001.e2tmrusybyherkra@viti.kaiser.cx>
References: <20220729100211.2204126-1-kshitiz.varshney@nxp.com>
 <e78ff391-3141-bf0b-6fe1-4ff7204414fb@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e78ff391-3141-bf0b-6fe1-4ff7204414fb@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kshitiz & Ahmad,

Thus wrote Ahmad Fatoum (a.fatoum@pengutronix.de):

> > +	init_completion(&rngc->rng_op_done);
> > +
> >  	ret = devm_request_irq(&pdev->dev,
> >  			irq, imx_rngc_irq, 0, pdev->name, (void *)rngc);

> This should probably be moved below imx_rngc_irq_mask_clear(rngc).
> init_completion can stay where it is. That way:

I agree with Ahmad that this is the better approach.

We should clear pending irqs and disable interrupt sources on the
hardware level before we install our irq handler.

Best regards,
Martin

>  - You initialize rngc fully before registering the IRQ handler
>  - You don't handle pending IRQs that you want to dismiss anyway
>  - If the IRQ happens to be because of a SEED_DONE due to a previous
>    boot stage, you don't end up completing the completion prematurely.
