Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1DE57B31B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 10:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238035AbiGTIlL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 20 Jul 2022 04:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiGTIlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:41:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA6C18E12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:41:09 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oE5GW-0006PX-0H; Wed, 20 Jul 2022 10:41:08 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oE5GU-0024z2-Ul; Wed, 20 Jul 2022 10:41:06 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oE5GT-0003Nh-Ok; Wed, 20 Jul 2022 10:41:05 +0200
Message-ID: <60d4233757f3ba931284b06545a820176443472b.camel@pengutronix.de>
Subject: Re: [PATCH] reset: reset-simple should depends on HAS_IOMEM
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        kernel test robot <lkp@intel.com>
Date:   Wed, 20 Jul 2022 10:41:05 +0200
In-Reply-To: <20220719085200.203688-1-ben.dooks@sifive.com>
References: <202207190150.mf4rb4VG-lkp@intel.com>
         <20220719085200.203688-1-ben.dooks@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

On Di, 2022-07-19 at 09:52 +0100, Ben Dooks wrote:
> The reset-simple driver does not build on all architecuters as it requires
> devm_ioremap_resource() which is only built when CONFIG_HAS_IOMEM is enabled
> in the kenrel. Fix the following error by depending on CONFIG_HAS_IOMEM:
> 
> drivers/reset/reset-simple.o: in function `reset_simple_probe':
>  reset-simple.c:(.text+0x3aa): undefined reference to `devm_ioremap_resource'
> 
> Fixes: e87998582b50 ("reset: allow building of reset simple driver if expert config selected")

Thank you, I changed this to:

Fixes: 18d1909be345 ("reset: allow building of reset simple driver if expert config selected")

and applied to reset/next.

regards
Philipp
