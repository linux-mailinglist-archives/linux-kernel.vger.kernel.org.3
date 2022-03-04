Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1664CD3FD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239688AbiCDMHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239677AbiCDMHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:07:10 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807E01B30A4;
        Fri,  4 Mar 2022 04:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646395583; x=1677931583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gZtyK7pDwLY5lAZrCyJHDcj242KDLDUK8zT8V+IfAjI=;
  b=2kGsGoJqcUzDc0l+/4+cfvp8oJ/tsYBEV/Aq5wUA3fJH4EoAdIRYPMnY
   bEHuYbZpbL8VdJH8ohMbigYceA4wtTEXX+Z8ofgPmit9ecAFsu2W2w2MV
   OYvfHGUk81CuKXMhEtHFcLpME1XaoUqP9Sqo5EJW12rD/h2KDBAHF/3Sm
   v+WhmToKQgVSTgDjHCjSVr1fPl/QzGS4utCSB0UwUO91nwhFikPkzSXAq
   95zGEdpOUXNOq7RdUqRDYn1Nx/41ifAWI/zy1xkuc3E5bFgxSNNHruWv7
   1sOJLKG1omr21flg7WVct/r9WULm6z/gkltNC2ZVIpEnJNqApVoOcz+uM
   A==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="148093200"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 05:06:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 05:06:21 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 4 Mar 2022 05:06:21 -0700
Date:   Fri, 4 Mar 2022 13:09:11 +0100
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Michael Walle <michael@walle.cc>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        <UNGLinuxDriver@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Colin Foster <colin.foster@in-advantage.com>
Subject: Re: [PATCH v1 5/5] pinctrl: microchip-sgpio: wait until output is
 actually set
Message-ID: <20220304120911.i5rngplg5l6gnnyy@soft-dev3-1.localhost>
References: <20220224161021.2197263-1-michael@walle.cc>
 <20220224161021.2197263-6-michael@walle.cc>
 <20220225092427.jjilv3qo52crsmuw@soft-dev3-1.localhost>
 <2f8a215c67269d639290515931d10b78@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <2f8a215c67269d639290515931d10b78@walle.cc>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 02/25/2022 12:29, Michael Walle wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe

Hi Michael,

Sorry for late reply.

> 
> Hi Horatiu,
> 
> Am 2022-02-25 10:24, schrieb Horatiu Vultur:
> > The 02/24/2022 17:10, Michael Walle wrote:
> > > Right now, when a gpio value is set, the actual hardware pin gets set
> > > asynchronously. When linux write the output register, it takes some
> > > time
> > > until it is actually propagated to the output shift registers. If that
> > > output port is connected to an I2C mux for example, the linux driver
> > > assumes the I2C bus is already switched although it is not.
> > > 
> > > Fortunately, there is a single shot mode with a feedback: you can
> > > trigger the single shot and the hardware will clear that bit once it
> > > has
> > > finished the clocking and strobed the load signal of the shift
> > > registers. This can take a considerable amount of time though.
> > > Measuremens have shown that it takes up to a whole burst cycle gap
> > > which
> > > is about 50ms on the largest setting. Therefore, we have to mark the
> > > output bank as sleepable. To avoid unnecessary waiting, just trigger
> > > the
> > > single shot if the value was actually changed.
> > 
> > I have tested this patch series on our lan9668 board and it worked
> > fine. Thanks!
> 
> Thanks for testing!
> 
> > I just have few questions:
> > 1. What about other boards/chips that have this sgpio, do they have
> > also
> >    the same issue? Because from what I recall on sparx5 they don't have
> >    this issue. I have seen it only on lan9668.
> 
> Unfortunatly, I don't have any knowledge what IP core is used in
> which SoC. I assumed the lan9668 used the same as the sparx5. If
> that is not the case, we need a new compatible. Do you know if it
> the same?

From what I see, it is the same IP.

> 
> On the sparx5 are there any peripheral who you would actually
> notice that the timing is off?

There are some SFP connected, similar to lan966x. So I don't understand
why that issue is not seen there.

> 
> That being said, I'd assume all the serial gpio controller has
> this "flaw". Simply because a register write won't block until the
> value is shifted out to the shift register and actualy loaded by
> strobing the load signal. It just depends on your burst setting
> (even with bursts off, and clocking all the time) on how large
> the delay is. So you might or might not notice it on a board.
> 
> Could you also have a look at the other supported sgpio block,
> the ocelot and the luton? I don't have any register description
> of these.
> 
> > 2. I remember that I have tried to fix this issue like this [1], but
> >    unfortunetly that was never accepted. Is this something that is
> > worth
> >    at looking at?
> 
> That fix is at the wrong place. You'd need to fix every gpio user, no?
> Instead this tries to fix the controller.

Yes, you are right.

> 
> > 
> > [1]
> > https://patchwork.ozlabs.org/project/linux-i2c/patch/20211103091839.1665672-3-horatiu.vultur@microchip.com/
> 
> -michael

-- 
/Horatiu
