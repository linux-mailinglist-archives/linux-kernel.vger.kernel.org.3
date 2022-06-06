Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E09353ED23
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiFFRnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 13:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiFFRnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 13:43:25 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1462231E514;
        Mon,  6 Jun 2022 10:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654537404; x=1686073404;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/S6pr49WABi/EsUuj7n0Y6baq3JnjVB8EfNPrmXyCtI=;
  b=Jm4Ht9Iu1f86D+kewB5Z+bywhNrLdaYJW7tv23812OAKJpp8SjEbimz0
   eqmfsu7XQlQ0NDexlqWoqsvmQd2809g4O1uqNUKl1PWefrMzOe+oRRazT
   md2VvZj/gHEOhw/7t5CS55TtOyOD8WDbl5+SIR1gQVn5os6g7x+VoWmpu
   0=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 06 Jun 2022 10:43:23 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 10:43:22 -0700
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 6 Jun 2022
 10:43:22 -0700
Date:   Mon, 6 Jun 2022 10:43:20 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
CC:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <wens@csie.org>,
        <jic23@kernel.org>, <lee.jones@linaro.org>, <sre@kernel.org>,
        <broonie@kernel.org>, <gregkh@linuxfoundation.org>,
        <lgirdwood@gmail.com>, <lars@metafoo.de>, <rafael@kernel.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] regmap-irq: Add get_irq_reg to support unusual
 register layouts
Message-ID: <20220606174320.GA16522@quicinc.com>
References: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
 <20220603135714.12007-2-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220603135714.12007-2-aidanmacdonald.0x0@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 02:57:05PM +0100, Aidan MacDonald wrote:
> Add a new callback, get_irq_reg, for regmap IRQ chips, to support devices
> with unusual register layouts. This is required in the rare cases where
> the offset of an IRQ register is not constant with respect to the base
> register. This is probably best illustrated with an example:
> 
>             mask    status
>     IRQ0    0x40    0x44
>     IRQ1    0x41    0x45
>     IRQ2    0x42    0x46
>     IRQ3    0x43    0x47
>     IRQ4    0x4a    0x4d
> 
> If we set mask_base = 0x40 and status_base = 0x44, the offsets of each
> register relative to the base are:
> 
>             mask    status
>     IRQ0    0       0
>     IRQ1    1       1
>     IRQ2    2       2
>     IRQ3    3       3
>     IRQ4    10      9
> 
> The existing mapping mechanisms can't include IRQ4 in the same irqchip
> as IRQ0-3 because the offset of IRQ4's register depends on which type
> of register we're asking for, ie. which base register is used.
> 
> The get_irq_reg callback allows drivers to specify an arbitrary mapping
> of (base register, register index) pairs to register addresses, instead
> of the default linear mapping "base_register + register_index". This
> allows unusual layouts, like the one above, to be handled using a single
> regmap IRQ chip.
> 
> The drawback is that when get_irq_reg is used, it's impossible to use
> bulk reads for status registers even if some of them are contiguous,
> because the mapping is opaque to regmap-irq. This should be acceptable
> for the case of a few infrequently-polled status registers.

This patch does two things:

1. Add a new callback `get_irq_reg`
2. Replace unmask_offset calculation with call to sub_irq_reg()

Could you please split the patch into two to better reflect this?

Thank you.

Guru Das.
