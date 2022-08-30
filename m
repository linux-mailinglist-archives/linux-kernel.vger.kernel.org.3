Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CC65A5E6E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiH3Ioz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiH3Iov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:44:51 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12205FA7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:44:49 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id jm11so10417644plb.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=JbzIXp14whwZiEWpePza0tJks7qqH7QXTLeRE8LUEwk=;
        b=Kaq+VCJSXSeBjOwz4uj10z70wAAkT0EHwpaSfz3KhVomZTfcoywdK0FcqjpLCyLdn/
         JrAoy10e42ty2BQ8VoYEdBUwzcRXXOAPxf6w6A0nk9tBExYbPeir+ETDlY+NIXYQXQ8y
         N18bQMMvTCiarry9ljqF9Sbloi9mB5JjqgqyJxkaWCHDwJggrW5gpUm/3c5MU3Zadqb5
         5c9h4LGhzZB3UHAUisb5ATkRh4Y/xG69nT8hJYfJZljGM9mKwqbYa8rb36QXleTNda9B
         oxWg8YDhKIt19xljiT63DUp4oahJwdMtuO2h/GElwMdDHFDHDqQlOEUXu+4QhJ4O0zTn
         6Grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=JbzIXp14whwZiEWpePza0tJks7qqH7QXTLeRE8LUEwk=;
        b=zH29blmS+I1Ux1k5IXIpnT7SS5ieoS89iMk27du9p/RpoWNkVcFPgV86XR8axrry6P
         e1oA3OXqc5VF77mA/mBe0fEyPJv9fkKS58/YE+ibUdoOp8YlFQWwU5Pp7cC6bi92vCJE
         n9uGcCbG3Xrqu/4Qf6PcWZ9kyxfpdTk10MK+o5zMkmqNNMPiJ1NWueR6NsSdQLv3P2Vg
         2Qi4mlt86AK5wui9tcDt8mp2t2rzQEn5XVQWQmBIvXZcmG+9kADSYjp1OWlw6r581c2x
         ngRbBm1ll2Q3MEEeKpvADckkEJaxNC5FD+VlHrJF1KVQLAWsurWPqwEQlMQwxRowGBbQ
         2Olw==
X-Gm-Message-State: ACgBeo3CNw5MJLnUErUbXCc4/xu5FwuWgSVJFbosZ8BTWQWkZ4OBY3P6
        wD8bfGWM/O+uC49ACOQRvyZM
X-Google-Smtp-Source: AA6agR7OLrfi21l1qp1fuRodigI5L4GFAZFbEKo1JeImXZ+WTHuDDpQCPNW8b9WT1eQHB0qto6zzMA==
X-Received: by 2002:a17:90b:1a88:b0:1fd:6a42:3eb9 with SMTP id ng8-20020a17090b1a8800b001fd6a423eb9mr20749411pjb.154.1661849089311;
        Tue, 30 Aug 2022 01:44:49 -0700 (PDT)
Received: from thinkpad ([117.193.209.245])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f7d100b00174a4bcefc7sm4918735plw.217.2022.08.30.01.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 01:44:48 -0700 (PDT)
Date:   Tue, 30 Aug 2022 14:14:41 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linus.walleij@linaro.org, bjorn.andersson@linaro.org,
        robimarko@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan+linaro@kernel.org, steev@kali.org
Subject: Re: [PATCH v2] pinctrl: qcom: spmi-gpio: Make IRQCHIP immutable
Message-ID: <20220830084441.GB135982@thinkpad>
References: <20220830081212.164709-1-manivannan.sadhasivam@linaro.org>
 <e20dabe02d88f28fc933b596dee8b69d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e20dabe02d88f28fc933b596dee8b69d@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 09:26:51AM +0100, Marc Zyngier wrote:
> On 2022-08-30 09:12, Manivannan Sadhasivam wrote:
> > The IRQCHIP implementation used inside the gpiochips are not supposed to
> 
> lower case
> 
> > be changed during runtime. So let's make the one inside the spmi-gpio
> > gpiochip immutable.
> > 
> > This fixes the below warning during boot:
> > gpio gpiochip0: (c440000.spmi:pmic@0:gpio@c000): not an immutable
> > chip, please consider fixing it!
> > 
> > Separate callbacks need to be provided for irq_{mask/unmask} pointers
> > since
> > the callbacks are supposed to mask/unmask the corresponding parent IRQ
> > in
> > addition to changing the gpio_desc flags.
> 
> This is all part of the existing documentation, so I don't think
> this is really needed.
> 

Yes it is documented, but developers usually refer the commits doing the similar
thing while doing these kind of conversions. For them, this text serves as a
quick documentation.

So I prefer to keep it in the commit message.

Thanks,
Mani

> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> With the above fixed:
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> 
>         M.
> -- 
> Jazz is not dead. It just smells funny...

-- 
மணிவண்ணன் சதாசிவம்
