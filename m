Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A797533D9B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244428AbiEYNSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244237AbiEYNRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:17:46 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C837810FED;
        Wed, 25 May 2022 06:17:45 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24P4sXDH020480;
        Wed, 25 May 2022 06:17:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pfpt0220; bh=E/72e8VKOxD+8FBpU5NQwZrQv3lWXiHnBO1xzZCWuwE=;
 b=CiPeEs3udsmWXMvZFvK1OL8xGpOxF+/vE4kL4UOQJpUMTK0z4WKyxQHsC2CuNHmR/7Jd
 0qh5Zy3rRndQf2FdQkACQgHUhIn9ApLkYcaVqRDpCCutj75ylhr8icXeAzZUjgw1xuU1
 s4Q/DW+new9sMa35nHcIuKw3DeDCn+HmXa7qy1rdOtmH5q4ajIqHvDYBbgiOS479Ty9n
 wjy+Brr5p2uAJYTRl0RpfyxqisWwggQhXPsqyD1O1q+TMD/oKMPGP8ExS/TI7w3RcPXJ
 aikmiehqg1WBQp44oU+C2zpP2zfWqFoze8/8jVZrLRLR4Y68Yay+5toHvDa2jvXl0VvG /A== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3g93ty3u3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 06:17:41 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 25 May
 2022 06:17:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 25 May 2022 06:17:39 -0700
Received: from Dell2s-9 (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 4940F3F7061;
        Wed, 25 May 2022 06:17:39 -0700 (PDT)
Date:   Wed, 25 May 2022 06:17:38 -0700
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
CC:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Richter <rric@kernel.org>, <cchavva@marvell.com>,
        <wsadowski@marvell.com>
Subject: Re: [PATCH 1/5] gpio: thunderx: avoid potential deadlock
Message-ID: <20220525131738.GA10532@Dell2s-9>
References: <20220427144620.9105-1-pmalgujar@marvell.com>
 <20220427144620.9105-2-pmalgujar@marvell.com>
 <CAMRc=Mf91eMF7D6CRtA8-HQ7pdtP343WUGhLG4qti_9zJF4ELQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMRc=Mf91eMF7D6CRtA8-HQ7pdtP343WUGhLG4qti_9zJF4ELQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: mew6VYTl9hxbNuCjapYzrNGAGvB4FPny
X-Proofpoint-ORIG-GUID: mew6VYTl9hxbNuCjapYzrNGAGvB4FPny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-25_03,2022-05-25_02,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 01:18:49PM +0200, Bartosz Golaszewski wrote:
> On Wed, Apr 27, 2022 at 4:46 PM Piyush Malgujar <pmalgujar@marvell.com> wrote:
> >
> > Using irqsave/irqrestore locking variants to avoid any deadlock.
> >
> 
> I see you'll be resending this anyway so would you mind providing an
> example of a deadlock that is possible with no-irqsave variants?
> Thanks.
> 
> Bart
>
Hi Bartosz,

Thanks for the review.

Please find below the issue scenario:
In the case when HARDIRQ-safe -> HARDIRQ-unsafe lock order is detected
and interrupt occurs, deadlock could occur.

========================================================
WARNING: possible irq lock inversion dependency detected
5.18.0-rc6 #4 Not tainted
--------------------------------------------------------
swapper/3/0 just changed the state of lock:
ffff000110904cd8 (lock_class){-...}-{2:2}, at: handle_fasteoi_ack_irq+0x2c/0x1b0
but this lock took another, HARDIRQ-unsafe lock in the past:
 (&txgpio->lock){+.+.}-{2:2}


and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&txgpio->lock);
                               local_irq_disable();
                               lock(lock_class);
                               lock(&txgpio->lock);
  <Interrupt>
    lock(lock_class);

 *** DEADLOCK ***

==========================================================

Thanks,
Piyush
> > Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> > ---
