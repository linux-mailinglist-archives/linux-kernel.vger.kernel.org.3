Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4918A558C14
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 02:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiFXADe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 20:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiFXADd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 20:03:33 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDE754BFE;
        Thu, 23 Jun 2022 17:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656029012; x=1687565012;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V+hXaNzG1xRg90Us21edRjM0CTBX8UcXbRwupTdVLP4=;
  b=cFYTK54l0Jj3I3KYIToLQgh2MBUdxyveACW4z74SGmzLY78dBMlA2Ces
   gJhBGQNfJIfQhtwa4d7XWjLXs74/YuMT/+UrtWBoFpycfC/5V1zxgfr3O
   kAoWJOq5ve7TsbkEfnJFg0bVzs3rz9UDFIU+ImMNbNX9hVSX2mjXQnvSf
   0=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Jun 2022 17:03:32 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 17:03:31 -0700
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 23 Jun
 2022 17:03:31 -0700
Date:   Thu, 23 Jun 2022 17:03:30 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, <tharvey@gateworks.com>,
        <rjones@gateworks.com>, Matti Vaittinen <mazziesaccount@gmail.com>,
        <orsonzhai@gmail.com>, <baolin.wang7@gmail.com>,
        <zhang.lyra@gmail.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        <linux-actions@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 18/49] mfd: qcom-pm8008: Add broken_mask_unmask irq chip
 flag
Message-ID: <20220624000329.GB21400@quicinc.com>
References: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
 <20220620200644.1961936-19-aidanmacdonald.0x0@gmail.com>
 <CAHp75Vea8F5ogP8kjfdP4SK3aeohoRnkGZ7LtsLuwfXwL+APvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHp75Vea8F5ogP8kjfdP4SK3aeohoRnkGZ7LtsLuwfXwL+APvA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 11:35:09AM +0200, Andy Shevchenko wrote:
> On Mon, Jun 20, 2022 at 10:08 PM Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> wrote:
> >
> > The qcom-pm8008 appears to use "1 to enable" convention for
> > enabling interrupts, with separate set and clear registers.
> > It's relying on masks and unmasks being inverted from their
> 
> It relies
> 
> > intuitive meaning, so it needs the broken_mask_unmask flag.
> 
> How has it worked until now?

It is as Aidan rightly pointed out. When I was writing the pm8008 driver, I
found that the mask and unmask terminology used in the framework was inverted
when it came to the hardware, so I had to make do and swap them.

It works because in regmap_irq_sync_unlock(), the same mask is used to update
mask_reg and unmask_reg, except that it is inverted for updating the unmask
register. So, by just swapping which register gets updated with the plain mask
and which one gets updated with the inverted mask, I could use the framework to
accomplish the setting and clearing of the correct registers.
