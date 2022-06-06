Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45A553EA87
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiFFJXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbiFFJXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:23:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34D9E1209E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:23:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FF4011FB;
        Mon,  6 Jun 2022 02:23:06 -0700 (PDT)
Received: from bogus (unknown [10.57.9.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A57AE3F66F;
        Mon,  6 Jun 2022 02:23:04 -0700 (PDT)
Date:   Mon, 6 Jun 2022 10:22:16 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Claudiu.Beznea@microchip.com
Cc:     linmq006@gmail.com, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Mihai.Sain@microchip.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: soc: atmel: Fix refcount leak in
 atmel_soc_device_init
Message-ID: <20220606092216.5s54nzplpsiyj3bv@bogus>
References: <20220605084035.27127-1-linmq006@gmail.com>
 <48c19453-984b-c3ae-b62b-2f0455330084@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48c19453-984b-c3ae-b62b-2f0455330084@microchip.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 09:00:52AM +0000, Claudiu.Beznea@microchip.com wrote:
> On 05.06.2022 11:40, Miaoqian Lin wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > of_find_node_by_path() returns a node pointer with refcount incremented,
> > we should use of_node_put() on it when not need anymore.
> > Add missing of_node_put() to avoid refcount leak.
> > 
> > Fixes: 960ddf70cc11 ("drivers: soc: atmel: Avoid calling at91_soc_init on non AT91 SoCs")
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> > ---
> >  drivers/soc/atmel/soc.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
> > index b2d365ae0282..46dfa24c52fb 100644
> > --- a/drivers/soc/atmel/soc.c
> > +++ b/drivers/soc/atmel/soc.c
> > @@ -369,10 +369,13 @@ static int __init atmel_soc_device_init(void)
> >  {
> >         struct device_node *np = of_find_node_by_path("/");
> > 
> 
> What about having it like this:
> 	const struct of_device_id *of_id;
> 
> 	of_id = of_match_node(at91_soc_allowed_list, np);
> 	of_node_put(np);

+1, I was about to make similar suggestion in couple of other patches making
similar changes.

-- 
Regards,
Sudeep
