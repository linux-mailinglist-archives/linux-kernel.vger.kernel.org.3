Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFB347E415
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 14:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348642AbhLWN2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 08:28:05 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:43712 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348338AbhLWN2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 08:28:02 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-05 (Coremail) with SMTP id zQCowABXOBVHecRh9Zm0BA--.45572S2;
        Thu, 23 Dec 2021 21:27:35 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     robin.murphy@arm.com, andy.shevchenko@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: Re: [PATCH v3] serial: mps2-uart: Check for error irq
Date:   Thu, 23 Dec 2021 21:27:33 +0800
Message-Id: <20211223132733.1400381-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABXOBVHecRh9Zm0BA--.45572S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XF1kWF13tr4UXFWrCw17ZFb_yoWftFg_CF
        4v9a17G3yrJanxtanrtr4ayrnrAr48AF15t3s3X3ZrKryrJa47WFy7Gas3CF17Gwsagry5
        urykuayIyw1S9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbVAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
        1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
        cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
        ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc2xSY4AK67AK6ry8MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAI
        cVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxh
        VjvjDU0xZFpf9x0JUzmhrUUUUU=
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-23 12:54, Robin Murphy wrote:
>> Because of the possible failure of the platform_get_irq(), it should be
>> better to check it to avoid the use of error irq.
>
> As far as I can see, the only "use" of error values is that they will be 
> passed to request_irq(), which will then return -EINVAL because they are 
> not valid IRQ numbers, and that error will be handled appropriately. I 
> think that's a relatively common pattern, so your commit message should 
> really describe why you think it's a problem and why this addition is a 
> meaningful improvement.

Thanks for your reminder, and I correct my commit message as follow.
If that's ok, I will correct my other patches like this.

For the possible failure of the platform_get_irq(), the returned irq
could be error number and will finally cause the failure of the request_irq().
So it might be better to check just now in order to avoid the waste of
later processes.

Sincerely thanks,
Jiasheng

