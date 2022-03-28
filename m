Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66404E8EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 09:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238821AbiC1Hb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 03:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbiC1Hby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 03:31:54 -0400
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C55F4833A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 00:30:07 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 61C0720CCE2E
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v2] platform: finally disallow IRQ0 in platform_get_irq()
 and its ilk
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>
References: <025679e1-1f0a-ae4b-4369-01164f691511@omp.ru>
Organization: Open Mobile Platform
Message-ID: <f686dc67-ced2-ecb1-a97a-c73a82fe7f55@omp.ru>
Date:   Mon, 28 Mar 2022 10:30:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <025679e1-1f0a-ae4b-4369-01164f691511@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 3/11/22 10:35 PM, Sergey Shtylyov wrote:

> The commit a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is
> invalid") only calls WARN() when IRQ0 is about to be returned, however
> using IRQ0 is considered invalid (according to Linus) outside the arch/
> code where it's used by the i8253 drivers. Many driver subsystems treat
> 0 specially (e.g. as an indication of the polling mode by libata), so
> the users of platform_get_irq[_byname]() in them would have to filter
> out IRQ0 explicitly and this (quite obviously) doesn't scale...
> Let's finally get this straight and return -EINVAL instead of IRQ0!
> 
> Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Acked-by: Marc Zyngier <maz@kernel.org>
> 
> ---
> The patch is against the 'driver-core-next' branch of Greg Kroah-Hartman's
> 'driver-core.git' repo.
> 
> Changes in version 2:
> - added Marc's ACK.

   Greg, are you going to finally merge this?

MBR, Sergey
