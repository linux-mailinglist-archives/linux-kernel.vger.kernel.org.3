Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196D34FE010
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351859AbiDLMLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352553AbiDLMIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:08:23 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1506971A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:08:33 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bv19so13578256ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XFfMi83HyHhMrMz7nwFOvyizW6aspWQXX9TyM36MU7E=;
        b=b7HD5VaNyiC3VzWVe5JREGw3WwW2DOqpJI4Bewo3xtQrIgFagoll75IZ3yOOR+4Ia8
         Hq4uYn4Ma4bitgj6j3950YPwpqiihH2Psdv+JCkyXm+S369Fy8GLOxE06+xJz6+0fQu3
         I8c2Y92E+Yqxiv7F1vQlKYnTlhH4SsP2NwatqTCS/hyQdsHcxHGHuN6Yw/rVQMl8fWCc
         cB4FbbrvDCNASHjiGMm9kAX8yKSeZ9Up1/v5BaVEgKPeYi+tWMZXeD4nlK6jyZYk+LF4
         HHLnI/a0wiIPO3AwudG3TnJWJ8SWv5/83nlmU8h+GscuAUHMufwenXyKP054m1UHd1ZB
         /T9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XFfMi83HyHhMrMz7nwFOvyizW6aspWQXX9TyM36MU7E=;
        b=zTsrDVI4U6UClTNtUtX2gNp9uyQNnvPfTiI4FIx8XSzYf6S1kswLXrSW5lKvOI3zXw
         fQvZUsOo0rDyrl00NZHB/pz5tCyz/YjG0RQlh+S5lK0alWcVMWb6exr8SpnlFJWzTMxN
         7jcODwj6nOtSyCnsnX9cdreCJhCOlo5w4QaRsEP7s8ixBAFtc5Cw8PBcjU4xc93Mz7Hr
         oOzoUy/AnleDsQ4qkRGMGuDZfHlW5WbQtJSHS2ckmE21PmZMBQ7ie4EEZ59w5SNIVA8P
         dQ/TZSWteBU5MXWgXK5QLXIhNppbNgqgTcrFq2C7vMGk/Jqtwe/AGMmpAwIYKJJAtk6H
         V+Dg==
X-Gm-Message-State: AOAM5309rmzrmmYGpsU7YVRYG0XdwEAuW5tI2FKH0J25/O4V00EcWtch
        Ivze2dUwZIqttUcFujSJcdE=
X-Google-Smtp-Source: ABdhPJwLHaReY6LYzG74fFgMURZEJwl58p1XJ+dhTszQwIgB+7Fq69dLJACk10WyGa4/ANaPw78qNQ==
X-Received: by 2002:a17:906:1692:b0:6e8:7641:c620 with SMTP id s18-20020a170906169200b006e87641c620mr12908634ejd.183.1649761711448;
        Tue, 12 Apr 2022 04:08:31 -0700 (PDT)
Received: from leap.localnet (host-82-60-208-254.retail.telecomitalia.it. [82.60.208.254])
        by smtp.gmail.com with ESMTPSA id q11-20020a170906144b00b006cf61dfb03esm13023344ejc.62.2022.04.12.04.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 04:08:30 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Liu Junqi <liujunqi@pku.edu.cn>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        sparmaintainer@unisys.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: Remove D. Kershner from Unisys S-PAR maintainers
Date:   Tue, 12 Apr 2022 13:08:28 +0200
Message-ID: <2976258.CbtlEUcBR6@leap>
In-Reply-To: <YlVXV4J41KBzKHtm@kroah.com>
References: <20220412103629.8029-1-fmdefrancesco@gmail.com> <YlVXV4J41KBzKHtm@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On marted? 12 aprile 2022 12:41:27 CEST Greg Kroah-Hartman wrote:
> On Tue, Apr 12, 2022 at 12:36:29PM +0200, Fabio M. De Francesco wrote:
> > The email address of David Kershner is no more reachable. Remove his
> > entry from the MAINTAINERS file for UNISYS S-PAR DRIVERS and change
> > the status to "Orphan".
> > 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > 
> > v1->v2: Change also the status of the entry to "Orphan" and rework the
> > commit message. (Thanks to Greg Kroah-Hartman).
> > 
> >  MAINTAINERS | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3ed62dcd144e..9283c63565b3 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20184,9 +20184,8 @@ F:	include/linux/cdrom.h
> >  F:	include/uapi/linux/cdrom.h
> >  
> >  UNISYS S-PAR DRIVERS
> > -M:	David Kershner <david.kershner@unisys.com>
> >  L:	sparmaintainer@unisys.com (Unisys internal)
> 
> Again, please drop this "list" as it obviously is not going to anyone.

OK, I'll also drop the "L:" line. I wasn't sure about it because I see 
that there are other entries marked as "Orphan" and the list is still
there. But you are right: although the "sparmaintainer" list address is
not bouncing, it looks like nobody care to read messages there.
  
> And really, this whole code should be removed, no one seems to be using
> it, and if they are, we can easily revert the removal and mark them as
> the maintainer.

1) If I remove the entire drivers/staging/unisys/ I suppose that, in 
MAINTAINERS I should also remove the whole entry called "UNISYS S-PAR 
DRIVERS", not only the "L:" line. 

2) Furthermore, I understand that I should also should change the relevant 
Kbuild files, otherwise all builds of staging would fail. 

I'm sorry for asking but, as you probably recall, I have no prior experience 
with removing drivers from trees and with the Kbuild's infrastructure. I'll 
take some time to read how it works.

Are the two arguments above correct?

Thanks,

Fabio M. De Francesco



