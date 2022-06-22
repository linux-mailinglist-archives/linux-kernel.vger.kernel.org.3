Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794B2554A8B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351980AbiFVNKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348980AbiFVNKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:10:49 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362FC3138B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 06:10:47 -0700 (PDT)
Received: from [62.91.21.7] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1o407q-0001zi-OT; Wed, 22 Jun 2022 15:10:30 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Liang He <windhl@126.com>, linux@armlinux.org.uk,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm: mach-rockchip: (pm) Add missing of_node_put()
Date:   Wed, 22 Jun 2022 15:10:26 +0200
Message-ID: <4377545.PIDvDuAF1L@phil>
In-Reply-To: <1a450b67-1e37-1eac-5906-910cb4deefdf@kernel.org>
References: <20220616021713.3973472-1-windhl@126.com> <1a450b67-1e37-1eac-5906-910cb4deefdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 22. Juni 2022, 11:00:11 CEST schrieb Krzysztof Kozlowski:
> On 16/06/2022 04:17, Liang He wrote:
> > In rockchip_suspend_init(), of_find_matching_node_and_match() will
> > return a node pointer with refcount incremented. We should use
> > of_node_put() in fail path or when it is not used anymore.
> > 
> > Signed-off-by: Liang He <windhl@126.com>
> > ---
> >  changelog:
> > 
> >  v2: (1) use real name for Sob (2) use goto-label patch style
> >  v1: add of_node_put() for each return
> > 
> 
> Before applying the patch please check it carefully. Previous evidence
> [1][2] suggests that not it was not even compiled.

thanks noticing possible issues and for the heads up :-) .

I re-examined the patch and at least in this case the of_node_put addition
looks correct - the original code was missing this and not putting the node
it got in the error case. And the change also compiles :-) .

Heiko

> [1] https://lore.kernel.org/all/202206221602.odN70SHs-lkp@intel.com/
> 
> [2]
> https://lore.kernel.org/all/16f9a971.44e5.1817068ee3c.Coremail.windhl@126.com/
> 
> 
> Best regards,
> Krzysztof
> 




