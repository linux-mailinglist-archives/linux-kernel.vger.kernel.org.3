Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A635630D9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbiGAKAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbiGAKAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:00:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4F7173918
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 03:00:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF6DC113E;
        Fri,  1 Jul 2022 03:00:12 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F0743F66F;
        Fri,  1 Jul 2022 03:00:11 -0700 (PDT)
Date:   Fri, 1 Jul 2022 11:00:08 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     huhai <huhai@kylinos.cn>
Cc:     cristian.marussi@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, luriwen@kylinos.cn,
        liuyun01@kylinos.cn, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scpi: Fix error handle when scpi probe
 failed
Message-ID: <20220701100008.coh5mymwwxak5pnu@bogus>
References: <20220701061606.151366-1-15815827059@163.com>
 <20220701094212.snsnbdjc7hia5oti@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701094212.snsnbdjc7hia5oti@bogus>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 10:42:12AM +0100, Sudeep Holla wrote:
> diff --git i/drivers/firmware/arm_scpi.c w/drivers/firmware/arm_scpi.c
> index ddf0b9ff9e15..6fa1a5b193b8 100644
> --- i/drivers/firmware/arm_scpi.c
> +++ w/drivers/firmware/arm_scpi.c
> @@ -799,7 +799,7 @@ static struct scpi_ops scpi_ops = {
> 
>  struct scpi_ops *get_scpi_ops(void)
>  {
> -       return scpi_info ? scpi_info->scpi_ops : NULL;
> +       return scpi_info && scpi_info->scpi_ops ? scpi_info->scpi_ops : NULL;

Scratch that, scpi_info->scpi_ops will be NULL and it is fine to return NULL.

Only reason why something can go wrong is if devm_of_platform_populate()
fails and we return error after setting up scpi_info->scpi_ops.

Can you check if the below fixes the issue ? We can continue working as
a driver even if few of the devices were populated which could be the case
but I am still doubtful about that.

Regards,
Sudeep

-->8

diff --git i/drivers/firmware/arm_scpi.c w/drivers/firmware/arm_scpi.c
index ddf0b9ff9e15..bae2e18e24ee 100644
--- i/drivers/firmware/arm_scpi.c
+++ w/drivers/firmware/arm_scpi.c
@@ -1024,7 +1024,9 @@ static int scpi_probe(struct platform_device *pdev)
                                   scpi_info->firmware_version));
        scpi_info->scpi_ops = &scpi_ops;
 
-       return devm_of_platform_populate(dev);
+       devm_of_platform_populate(dev);
+
+       return ret;
 }

