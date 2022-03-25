Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E7B4E6FBE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 10:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356160AbiCYJES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 05:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiCYJER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 05:04:17 -0400
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DD8CD339
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 02:02:32 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru D590C20A83DE
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v1] soc: bcm: Check for NULL return of devm_kzalloc()
To:     QintaoShen <unSimple1993@163.com>, <f.fainelli@gmail.com>
CC:     <bcm-kernel-feedback-list@broadcom.com>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1648110940-4684-1-git-send-email-unSimple1993@163.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <0f5e77e9-3c2c-396d-636b-1b7153007fe5@omp.ru>
Date:   Fri, 25 Mar 2022 12:02:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1648110940-4684-1-git-send-email-unSimple1993@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   s/return/result/ in the subject.

On 3/24/22 11:35 AM, QintaoShen wrote:

> As the potential failuer of allocation, devm_kzalloc() may return NULL.
> Then the 'pd->pmb' and the follow lines of code may bring null pointer dereference.

   Following.

> Therefore, it is better to check the return value of devm_kzalloc() to avoid this confusion.
> 
> Signed-off-by: QintaoShen <unSimple1993@163.com>
> ---
>  drivers/soc/bcm/bcm63xx/bcm-pmb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/soc/bcm/bcm63xx/bcm-pmb.c b/drivers/soc/bcm/bcm63xx/bcm-pmb.c
> index 7bbe46e..55bf389 100644
> --- a/drivers/soc/bcm/bcm63xx/bcm-pmb.c
> +++ b/drivers/soc/bcm/bcm63xx/bcm-pmb.c
> @@ -311,6 +311,8 @@ static int bcm_pmb_probe(struct platform_device *pdev)
>  
>  	for (e = table; e->name; e++) {
>  		struct bcm_pmb_pm_domain *pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);

   Please keep an empty line after declaration.

> +		if (!pd)
> +			return -ENOMEM;
>  
>  		pd->pmb = pmb;
>  		pd->data = e;

MBR, Sergey
