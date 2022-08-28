Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9845A3F21
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 20:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiH1Sh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 14:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1Sh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 14:37:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171D53206C;
        Sun, 28 Aug 2022 11:37:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A794B60BBB;
        Sun, 28 Aug 2022 18:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C7CC433D6;
        Sun, 28 Aug 2022 18:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661711874;
        bh=jYHVQ0rSstcQBx3vvBMzsqc5C7/5CLyfa/jyYuVEQZM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vk/UR70PdAV6jPHdLFbhzvud7dL99EaRXVPXgmgxYZ3af/F1WFsfsUijDk+CQtG84
         /uJshm4Eukzah7YKWgzCZXD014MPovXcpB8RYK7aC0NM0Zq2s4DwFzaKGv/PAsGnWQ
         yOQjoi9xogfeMnjhMBzOZdD/5M2BpuyA6hhZxi7KubrkU153Oky7s4SV5iOZs1JsmV
         rH6A1m0jpJZ8Gf7zA2sDbVIQedAHJimN+7F+f3/AHQnabkLe34dIXC7ZI3TrY7/QLl
         IqV5f8fXiBNj8KeT7Q4kbHajjadI85W5PjeFCyrnAgg0s2LcnhBwm40ldVKe4Ey9Fo
         EyUmXVZGn0Q8A==
Date:   Sun, 28 Aug 2022 19:03:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: accel: bma400: Add support for single and
 double tap events
Message-ID: <20220828190332.57ee9aa2@jic23-huawei>
In-Reply-To: <CAM+2Eu+a8LM+XBELAm9H51EWVwCDqcYaxfdj4_-Sk9TtJ0gLJA@mail.gmail.com>
References: <20220825194604.15645-1-jagathjog1996@gmail.com>
        <20220825194604.15645-3-jagathjog1996@gmail.com>
        <CAHp75Vc5048aQL5cLy-OfBfnH6tz_7z24sFX2H1oGRz+JUyq9Q@mail.gmail.com>
        <CAM+2Eu+a8LM+XBELAm9H51EWVwCDqcYaxfdj4_-Sk9TtJ0gLJA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Aug 2022 03:36:23 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Hi Andy,
> 
> On Fri, Aug 26, 2022 at 1:53 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Thu, Aug 25, 2022 at 10:46 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:  
> > >
> > > Add support for single and double tap events based on the tap threshold
> > > value, minimum quiet time before and after the tap and minimum time
> > > between the taps in the double tap. The INT1 pin is used to interrupt
> > > and the event is pushed to userspace.  
> >
> > ...
> >  
> > > +static int tap_reset_timeout[] = {
> > > +       300000,
> > > +       400000,
> > > +       500000,
> > > +       600000  
> >
> > + Comma and so on for the rest of the similar cases.  
> 
> This is the terminator case so I have not added a comma in the last.
> All three tap configurations have only 4 value options.
> 
> >  
> > > +};  
> >
> > ...
> >  
> > > +static int usec_to_tapreg_raw(int usec, const int *time_list)
> > > +{
> > > +       int index;
> > > +
> > > +       for (index = 0; index < 4; index++) {  
> >
> > Magic. Shouldn't be defined?  
> 
> All tap configuration value arrays are of size 4, I will define a
> macro for that.
> 
> >
> > Also you may add it to each data structure in question.  
> 
> Do you mean storing these values in the device's private structure?

I suspect Andy means making sure they are all 4 long via
+static int tap_reset_timeout[NEW_LENGTH_DEFINE] = {
etc.


> 
> Tap configuration values are not stored in the device's private
> structure because.
> - I am directly accessing the device registers in _read_event_value()
> and _write_event_value().
> - These configuration values are not used in the other parts of
> the driver.
> - Two of these configurations have a default value so instead of
> reading and storing these values in the device's private structure
> during device init, I am directly accessing the device's register.
> 
> >  
> > > +               if (usec == time_list[index])
> > > +                       return index;
> > > +       }
> > > +       return -EINVAL;
> > > +}  
> >
> > ...
> >  
> > > +       int ret;
> > > +       unsigned int mask, field_value;  
> >
> > Reversed xmas tree order?
> >  
> > > +        * Tap interrupts are operating with the data rate of 200Hz.  
> >
> > a data  
> 
> Sure, I will correct these in the next patch series.
> 
> Thank you
> Jagath
> 
> >  
> > > +        * See section 4.7 "Tap sensing interrupt" in datasheet v1.2.
> > > +        */  
> >
> > --
> > With Best Regards,
> > Andy Shevchenko  

