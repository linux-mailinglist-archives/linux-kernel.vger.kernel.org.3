Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635C6545228
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344810AbiFIQj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244751AbiFIQjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:39:25 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF03261808;
        Thu,  9 Jun 2022 09:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654792764; x=1686328764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p8iFJ3QnHLXyV0XBD0xEpbKqckLKd6ENyKoogA15bwk=;
  b=ZE0zH0AwoD051GX3JFHfAyt7gRcGwpbN2F/vf+pEctcvY26kpAKFDfAr
   KE8EVJTygEjxbiYsukuFc/3U1HgYWaxt8adrLpjj+hJZvWmzqJXWwCmXe
   UUnMAukd6BIihnd8aNicpf5kDMU2zgWQPpeQnJYeqd1ma0/tsVuM2uvmg
   s=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Jun 2022 09:39:24 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 09:39:22 -0700
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 9 Jun 2022
 09:39:22 -0700
Date:   Thu, 9 Jun 2022 09:39:20 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
CC:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <wens@csie.org>,
        <jic23@kernel.org>, <lee.jones@linaro.org>, <sre@kernel.org>,
        <broonie@kernel.org>, <gregkh@linuxfoundation.org>,
        <lgirdwood@gmail.com>, <lars@metafoo.de>, <rafael@kernel.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 01/17] regmap-irq: Use sub_irq_reg() to calculate
 unmask register address
Message-ID: <20220609163920.GA7420@quicinc.com>
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
 <20220607155324.118102-2-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220607155324.118102-2-aidanmacdonald.0x0@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 04:53:08PM +0100, Aidan MacDonald wrote:
> Call sub_irq_reg() instead of calculating the offset of the register
> to avoid relying on the fact that sub_irq_reg() is a linear function.

Seems like unmask_reg is the only register whose address is not calculated
using sub_irq_reg(). Switching to using sub_irq_reg() will bring it in line
with the other calculations.

Could you please incorporate this info in your commit message as well? This
should be the rationale for this change; that it allows for the get_irq_reg()
patch should be secondary.

The change seems okay to me, but I'd ideally like someone to pick this up and
test it out just to make sure it doesn't break existing behaviour for them.

Thank you.

Guru Das.
