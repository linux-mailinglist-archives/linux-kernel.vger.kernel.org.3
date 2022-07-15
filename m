Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACA55762F1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 15:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiGONms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 09:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiGONmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:42:46 -0400
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFC77D790;
        Fri, 15 Jul 2022 06:42:45 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTPS id 5D2035202EB;
        Fri, 15 Jul 2022 15:42:43 +0200 (CEST)
Received: from vmlxhi-182.localdomain (10.72.92.119) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Fri, 15 Jul
 2022 15:42:43 +0200
Date:   Fri, 15 Jul 2022 15:42:37 +0200
From:   Michael Rodin <mrodin@de.adit-jv.com>
To:     Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     Michael Rodin <mrodin@de.adit-jv.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <michael@rodin.online>,
        <erosca@de.adit-jv.com>
Subject: Re: [PATCH v2 0/3] Improve error handling in the rcar-vin driver
Message-ID: <20220715134237.GA1114456@vmlxhi-182.localdomain>
References: <YqEO3/KekkZhVjW+@oden.dyn.berto.se>
 <20220628180024.451258-1-mrodin@de.adit-jv.com>
 <YsQIbr9QYGBDoIWT@oden.dyn.berto.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YsQIbr9QYGBDoIWT@oden.dyn.berto.se>
X-Originating-IP: [10.72.92.119]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas, Hans,

On Tue, Jul 05, 2022 at 11:46:22AM +0200, Niklas Söderlund wrote:
> Hi Michael,
> 
> Thanks for your persistent work with this series.

Thank you for the feedback!

> On 2022-06-28 20:00:19 +0200, Michael Rodin wrote:
> > Hello,
> > 
> > this series is a followup to the other series [1] started by Niklas Söderlund
> > where only the first patch has been merged. The overall idea is to be more
> > compliant with the Renesas hardware manual which requires a reset or stop
> > of capture in the VIN module before reset of CSI2. Another goal is to be
> > more resilient with respect to non-critical CSI2 errors so the driver does
> > not end in an endless restart loop. Compared to the previous version [2] of
> > this series the patch 3 is replaced based on the conclusion in [3] so now
> > userspace has to take care of figuring out if a transfer error was harmless
> > or unrecoverable. Other patches are adapted accordingly so no assumptions
> > about criticality of transfer errors are made in the kernel and the
> > decision is left up to userspace.
> 
> I like this solution as it truly pushes the decision to user-space. What 
> bugs me a little bit is that we don't have a way to communicate errors 
> that we know are unrecoverable (it was for this case the work in this 
> area started) and ones that could be recoverable (the use-case added on 
> top).

Yes, it's not nice that V4L2_EVENT_XFER_ERROR does not tell userspace
whether an error is recoverable (i.e. the event can be ignored) or not
(i.e. a restart of streaming is required) but the other possible option
would be (as concluded in [3]) to implement a frame timeout monitoring
thread in v4l2 core. I am not sure if it is possible to implement this
second option cleanly...

> I would also like to hear what Hans thinks as he had good suggestions 
> for how to handle the cases we know can't be recovers in [4].

A a new function vb2_queue_error_with_event() suggested by Hans seems to be
redundant now, since it would not be used by rcar-vin (unless we implement
frame timeout monitoring in the v4l2 core). Or do you have an idea, which
drivers could be the first users of it, e.g. staging/media/imx I mentioned
before?

> > 
> > [1] https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_linux-2Drenesas-2Dsoc_20211108160220.767586-2D1-2Dniklas.soderlund-2Brenesas-40ragnatech.se_&d=DwIDAw&c=euGZstcaTDllvimEN8b7jXrwqOf-v5A_CdpgnVfiiMM&r=sWsgk3pKkv5GeIDM2RZlPY8TjNFU2D0oBeOj6QNBadE&m=ecX7IwfatUO7SNPiyQ6x_8K9t2eWJf3y8GNuNHJ_0W0&s=Cli6jADEgMmCOLVoFekRRXzmty9WBXtoSF9utZJNMXY&e=
> > [2] https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_all_1652983210-2D1194-2D1-2Dgit-2Dsend-2Demail-2Dmrodin-40de.adit-2Djv.com_&d=DwIDAw&c=euGZstcaTDllvimEN8b7jXrwqOf-v5A_CdpgnVfiiMM&r=sWsgk3pKkv5GeIDM2RZlPY8TjNFU2D0oBeOj6QNBadE&m=ecX7IwfatUO7SNPiyQ6x_8K9t2eWJf3y8GNuNHJ_0W0&s=6CysfSY0OoAenEwCzigeyPOb8vyaa4GgzkJSR-ny83U&e=
> > [3] https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_all_YqEO3-252FKekkZhVjW-2B-40oden.dyn.berto.se_&d=DwIDAw&c=euGZstcaTDllvimEN8b7jXrwqOf-v5A_CdpgnVfiiMM&r=sWsgk3pKkv5GeIDM2RZlPY8TjNFU2D0oBeOj6QNBadE&m=ecX7IwfatUO7SNPiyQ6x_8K9t2eWJf3y8GNuNHJ_0W0&s=67JE_QR4x7omrtC7wzbpn2OgW75TAR80-R8WQyE-bVo&e=
> 
> 4. https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_all_1fddc966-2D5a23-2D63b4-2D185e-2Dc17aa6d65b54-40xs4all.nl_&d=DwIDAw&c=euGZstcaTDllvimEN8b7jXrwqOf-v5A_CdpgnVfiiMM&r=sWsgk3pKkv5GeIDM2RZlPY8TjNFU2D0oBeOj6QNBadE&m=ecX7IwfatUO7SNPiyQ6x_8K9t2eWJf3y8GNuNHJ_0W0&s=I18yWgde2UKZY4AiwB5s-Lf12eebHOcHFZFOlTcO2oQ&e=
> 
> -- 
> Kind Regards,
> Niklas Söderlund

-- 
Best Regards,
Michael
