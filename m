Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9832857F6A2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 21:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbiGXTBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 15:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGXTA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 15:00:59 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3172FE0A3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 12:00:57 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id r14so10859131ljp.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 12:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IHMS+b3mDvwpMK/cDzCHPu0P8GmbIu/+yms/GdH73sw=;
        b=bGoaywtkZGEkQcPy7njuO4/w2RIeQ8rTyMvn/sPnQGQHf7HI2fFosOMJHoe8O/EFZD
         ATJh/+apUsVSQGCZLO76zcRQo3QGvEu7/h8P/ks09vxKIEOwIrK2R5fpR0HjfpJoDLzG
         3mZ30+8eBEup5Qw2rfgqy7o2P3bm52UgwxB3Gy+bDwuEldlGxTrft5rZdkrrFr9kRgjz
         Cx/nKlpK/s8rYsZJPncxqe2DnEw3oUNwl559lLrlA6lVrHMC2ps0Dso+sFCZ/bQ3vXEj
         e/bQ/yG00YkdiGL9PfMzo12zRc4QGeRJfovBfO0t6UoXHE0NbvHNnRK1d93KDZ+hRTYy
         hqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IHMS+b3mDvwpMK/cDzCHPu0P8GmbIu/+yms/GdH73sw=;
        b=xqLsB+jyiYP4vIGOMq1wG35BqpS7LeuTz0AVvH5b/DlCo6H8/mGnoN27IgDnqP+biG
         1tGVcGazuyyE+1MSC8AbwP3fIApwwajCy+2LxI6C9dfdbwubNKbhg0tpXIWStpbcR9WL
         7nXMHxHMnAVNwQht5xSJK/Gy8768v4Bd9KJja47bHwsAHjRYsrZtgD8wdktoeS9czFzr
         V5eF75d3xjeIMzGCrTJ3GTG45/7JmZQaYKzvHQcbZPE+BNjzyxixrE8ykaMFZsMdsNhM
         u6HbL6iQf5NpT6eXG1QPRO6uVel7b1ccvOGT3s+xV9c09Zz0ia8CZoosHtyRXHVPdhgV
         ujlg==
X-Gm-Message-State: AJIora+i7SYuQw0oFLZ0Vc9IiHKYWWSjJ7gYaggASxOtI65/amQHnYN+
        TSsmGXgpGu8FCe7/WyjxUhufEA==
X-Google-Smtp-Source: AGRyM1s3nkMSDXcI+L/mB7ooKMNuJV1ByJdw0mt62IXB8zpkiu3HoHqH2vGvbsiChaGMnLUzrpw2vw==
X-Received: by 2002:a05:651c:1241:b0:25d:5484:75d3 with SMTP id h1-20020a05651c124100b0025d548475d3mr3233113ljh.45.1658689255220;
        Sun, 24 Jul 2022 12:00:55 -0700 (PDT)
Received: from localhost (h-46-59-88-103.A463.priv.bahnhof.se. [46.59.88.103])
        by smtp.gmail.com with ESMTPSA id p13-20020a2ea4cd000000b0025e0396786dsm404345ljm.93.2022.07.24.12.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 12:00:54 -0700 (PDT)
Date:   Sun, 24 Jul 2022 21:00:53 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        khilman@baylibre.com, abailon@baylibre.com, amitk@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "open list:RENESAS R-CAR THERMAL DRIVERS" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v1 17/33] thermal/drivers/rcar: Switch to new of API
Message-ID: <Yt2W5UCXaB3Memzg@oden.dyn.berto.se>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
 <20220710212423.681301-18-daniel.lezcano@linexp.org>
 <YtZ1IExNlsYaJkC9@oden.dyn.berto.se>
 <18ade2d0-ebda-0526-71f3-65a0b2685068@linexp.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18ade2d0-ebda-0526-71f3-65a0b2685068@linexp.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 2022-07-24 20:27:54 +0200, Daniel Lezcano wrote:
> 
> Hi Niklas,
> 
> I tried to reproduce the issue but without success.
> 
> What sensor are you using ?

I was using rcar_gen3_thermal.

I did my tests starting on v5.19-rc7 and then picked '[PATCH v5 00/12] 
thermal OF rework' from [1] and finally applied this full series on-top 
of that. If you have a branch or some specific test you wish me to try 
I'm happy to so.

1. https://lore.kernel.org/lkml/20220710123512.1714714-1-daniel.lezcano@linexp.org/

> 
> 
> On 19/07/2022 11:10, Niklas Söderlund wrote:
> > Hi Daniel,
> > 
> > Thanks for your work.
> > 
> > On 2022-07-10 23:24:07 +0200, Daniel Lezcano wrote:
> > > The thermal OF code has a new API allowing to migrate the OF
> > > initialization to a simpler approach.
> > > 
> > > Use this new API.
> > I tested this together with the series it depends on and while
> > temperature monitoring seems to work fine it breaks the emul_temp
> > interface (/sys/class/thermal/thermal_zone2/emul_temp).
> > 
> > Before this change I can write a temperature to this file and have it
> > trigger actions, in my test-case changing the cooling state, which I
> > observe in /sys/class/thermal/cooling_device0/cur_state.
> > 
> > Likewise before this change I could trip the critical trip-point that
> > would power off the board using the emul_temp interface, this too no
> > longer works,
> > 
> >      echo 120000 > /sys/class/thermal/thermal_zone2/emul_temp
> > 
> > Is this an intention change of the new API?
> 
> 
> 
> 

-- 
Kind Regards,
Niklas Söderlund
