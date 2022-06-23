Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30DA558BB7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 01:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiFWX3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 19:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiFWX3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 19:29:36 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B54C35AB3;
        Thu, 23 Jun 2022 16:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656026976; x=1687562976;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=heSJ8jzY3pZhIPVQZKO6qwVJfpfmlxuwEG6zr2DoHY4=;
  b=tjTzGh3NdQ5vuEsazKl7hi6qd+6eMfP//s0JEwPAibeUIx6PuRzBqeGH
   eV7zQIeLkzrmEV47aVjjJIhOhS/li66uBU7ghLeuPSYXJtjN3isjKCwdB
   9ZQP3A07kTc2eN9t7NkwzrJgowZhfd5KWVtskJ2OS3uKA3Rxg1OZFltn6
   4=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Jun 2022 16:29:35 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 16:29:33 -0700
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 23 Jun
 2022 16:29:33 -0700
Date:   Thu, 23 Jun 2022 16:29:31 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
CC:     <broonie@kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <bgoswami@codeaurora.org>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <cw00.choi@samsung.com>,
        <krzysztof.kozlowski@linaro.org>, <b.zolnierkie@samsung.com>,
        <myungjoo.ham@samsung.com>, <michael@walle.cc>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <tglx@linutronix.de>,
        <maz@kernel.org>, <lee.jones@linaro.org>, <mani@kernel.org>,
        <cristian.ciocaltea@gmail.com>, <wens@csie.org>,
        <tharvey@gateworks.com>, <rjones@gateworks.com>,
        <mazziesaccount@gmail.com>, <orsonzhai@gmail.com>,
        <baolin.wang7@gmail.com>, <zhang.lyra@gmail.com>,
        <jernej.skrabec@gmail.com>, <samuel@sholland.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-actions@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 02/49] regmap-irq: Fix offset/index mismatch in
 read_sub_irq_data()
Message-ID: <20220623232931.GA21400@quicinc.com>
References: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
 <20220620200644.1961936-3-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220620200644.1961936-3-aidanmacdonald.0x0@gmail.com>
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

On Mon, Jun 20, 2022 at 09:05:57PM +0100, Aidan MacDonald wrote:
> We need to divide the sub-irq status register offset by register
> stride to get an index for the status buffer to avoid an out of
> bounds write when the register stride is greater than 1.
> 
> Fixes: a2d21848d921 ("regmap: regmap-irq: Add main status register support")
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Reviewed-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
