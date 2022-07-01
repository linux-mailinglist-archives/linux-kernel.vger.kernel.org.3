Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEA1563079
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbiGAJmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236427AbiGAJmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:42:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AF2B42ED6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 02:42:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88662113E;
        Fri,  1 Jul 2022 02:42:16 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C3113F66F;
        Fri,  1 Jul 2022 02:42:15 -0700 (PDT)
Date:   Fri, 1 Jul 2022 10:42:12 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     huhai <15815827059@163.com>
Cc:     cristian.marussi@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, luriwen@kylinos.cn,
        liuyun01@kylinos.cn, huhai <huhai@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] firmware: arm_scpi: Fix error handle when scpi probe
 failed
Message-ID: <20220701094212.snsnbdjc7hia5oti@bogus>
References: <20220701061606.151366-1-15815827059@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701061606.151366-1-15815827059@163.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 02:16:06PM +0800, huhai wrote:
> From: huhai <huhai@kylinos.cn>
>
> When scpi probe fails, do not just return the error code, but also reset
> the global scpi_info to NULL, otherwise scpi_hwmon_probe() may get a UAF
> and cause panic:
>

Interesting, which platform are you using this on ? SCPI is deprecated for
a while, please switch to SCMI which is well maintained both in terms of
specification and support in the kernel. I also assume this is 64-bit
platform, so I don't want you to get stuck in future because of lack
of some feature in SCPI. Please see if you can migrate to SCMI.

>   scpi_protocol FTSC0001:00: incorrect or no SCP firmware found
>   ... ...
>   Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>   Mem abort info:
>

[...]

I think we don't see to make it complex. Can't it be as simple as:

Regards,
Sudeep

-->8

diff --git i/drivers/firmware/arm_scpi.c w/drivers/firmware/arm_scpi.c
index ddf0b9ff9e15..6fa1a5b193b8 100644
--- i/drivers/firmware/arm_scpi.c
+++ w/drivers/firmware/arm_scpi.c
@@ -799,7 +799,7 @@ static struct scpi_ops scpi_ops = {

 struct scpi_ops *get_scpi_ops(void)
 {
-       return scpi_info ? scpi_info->scpi_ops : NULL;
+       return scpi_info && scpi_info->scpi_ops ? scpi_info->scpi_ops : NULL;
 }
 EXPORT_SYMBOL_GPL(get_scpi_ops);
