Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7104547E0DF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 10:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347428AbhLWJbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 04:31:24 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:47054 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbhLWJbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 04:31:23 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 3E44722F2B43
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <d879552f-3085-91e6-77fa-d391b890fb6b@omp.ru>
Date:   Thu, 23 Dec 2021 12:31:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] ata: libahci_platform: Remove abundant check
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, <hdegoede@redhat.com>,
        <axboe@kernel.dk>, <p.zabel@pengutronix.de>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211222072446.1096168-1-jiasheng@iscas.ac.cn>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20211222072446.1096168-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 22.12.2021 10:24, Jiasheng Jiang wrote:

> It can be found that platform_get_irq() returns nagative code but not
> null when fails.

    s/null/zero/?

> The comment of the platform_get_irq clearly shows that.

    This comment still doesn't correspond to reality -- 0 can be returned 
(although this would cause a WARN() call)...

> Therefore it should be better to remove the useless check.

    This patch is correct but premature. I have a (not yet merged) patch:

https://marc.info/?l=linux-kernel&m=163623041902285

    It actually disables reporting IRQ0. Until it's merged we have to filter 
out IRQ0 in the libata drivers as libata treats 0 as an indication of the 
polling mode...

> Fixes: fd990556f0fa ("ata: move library code from ahci_platform.c to libahci_platform.c")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
[...]

MBR, Sergey
