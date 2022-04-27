Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C854512294
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbiD0T1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiD0T1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:27:40 -0400
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF52EF12;
        Wed, 27 Apr 2022 12:24:27 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru D466720EC9A3
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v3] sh: avoid using IRQ0 on SH3/4
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Rich Felker <dalias@libc.org>, <linux-sh@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <2584ba18-9653-9310-efc1-8b3b3e221eea@omp.ru>
Organization: Open Mobile Platform
Message-ID: <9b29866e-70c1-1b0d-bfd7-1b03ea9e4e89@omp.ru>
Date:   Wed, 27 Apr 2022 22:24:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <2584ba18-9653-9310-efc1-8b3b3e221eea@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/22 9:46 PM, Sergey Shtylyov wrote:

> Using IRQ0 by the platform devices is going to be disallowed soon (see [1])
> and even now, when IRQ0 is about to be returned by platfrom_get_irq(), you

   Oops, it's platform_get_irq(). :-/

> see a big warning.  The code supporting SH3/4 SoCs maps the IRQ #s starting
> at 0 -- modify that code to start the IRQ #s from 16 instead.
> 
> The patch should mostly affect the AP-SH4A-3A/AP-SH4AD-0A boards as they
> indeed use IRQ0 for the SMSC911x compatible Ethernet chip...
> 
> [1] https://lore.kernel.org/all/025679e1-1f0a-ae4b-4369-01164f691511@omp.ru/
> 
> Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

[...]

MBR, Sergey
