Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAF358C622
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 12:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237504AbiHHKO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 06:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbiHHKOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 06:14:25 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFB4DE5;
        Mon,  8 Aug 2022 03:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659953662; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pLRnbpIYZMT8r7ef1+TXX9Dt+MKpUbrZ4QDkqhQSVUU=;
        b=QLDNNb3XMkVqshEBBMrWuqMdxWzaP9gJQLu02EsizAa6USaQ+s9qJFTGfeNgPg8z+VzN69
        NM09/8yoJroPxQr7+L7wj3jBg4OIpCKj2/reTOtG97TQObgFiq1cfCCgGImhKXfX0gIE1t
        duuj0Sw53TvLZWqVeesJea3y8VFhqdk=
Date:   Mon, 08 Aug 2022 12:14:15 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 13/28] mfd: sec: Remove #ifdef guards for PM related
 functions
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Message-Id: <RFKAGR.U6QGSG9SKKVK3@crapouillou.net>
In-Reply-To: <e4dbc605-e998-dbca-b9bc-322783578564@linaro.org>
References: <20220807145247.46107-1-paul@crapouillou.net>
        <20220807145247.46107-14-paul@crapouillou.net>
        <a625a1b4-6ecd-79d9-3d13-f42fd5b8275c@linaro.org>
        <ACIAGR.7NVZ6UO1UX632@crapouillou.net>
        <e4dbc605-e998-dbca-b9bc-322783578564@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[...]

>>>>   ---
>>>>    drivers/mfd/sec-core.c | 7 +++----
>>>>    1 file changed, 3 insertions(+), 4 deletions(-)
>>>> 
>>>>   diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
>>>>   index 1fb29c45f5cf..a467de2b2fea 100644
>>>>   --- a/drivers/mfd/sec-core.c
>>>>   +++ b/drivers/mfd/sec-core.c
>>>>   @@ -455,7 +455,6 @@ static void sec_pmic_shutdown(struct 
>>>> i2c_client
>>>>  *i2c)
>>>>    	regmap_update_bits(sec_pmic->regmap_pmic, reg, mask, 0);
>>>>    }
>>>> 
>>>>   -#ifdef CONFIG_PM_SLEEP
>>>>    static int sec_pmic_suspend(struct device *dev)
>>> 
>>>  Did you test W=1 with !CONFIG_PM_SLEEP? No warnings?
>> 
>>  I tested the PR with !CONFIG_PM_SLEEP, correct. sec-core.o compiles
>>  fine. No warnings with W=1.
> 
> Ah, I see now. _DEFINE_DEV_PM_OPS uses __maybe_unused for such case.

Actually it doesn't :) Since the (dev_pm_ops) structure is always (and 
should always be) referenced through pm_sleep_ptr() or pm_ptr(), the 
symbols are never seen as unused by the compiler, but are automatically 
dropped by the compiler when the related config option is turned off.

Cheers,
-Paul


