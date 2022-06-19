Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE460550A95
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 14:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbiFSMW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 08:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiFSMW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 08:22:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2885FB1D9;
        Sun, 19 Jun 2022 05:22:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9A6B61113;
        Sun, 19 Jun 2022 12:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F19C34114;
        Sun, 19 Jun 2022 12:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655641346;
        bh=XexKeqGKbOcIcayyiYj0FU6hI92MPPV90YNRd2iQPio=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E0dKY1kMPBxrCMIV43OjxtbxY1/iMm59gH1HdpLa/+APMQahR8Zd93OCNjhrOjpQn
         RkjmGwZLHRPcjbBKb4p4NxmbaBmx+Gap63q6Jo5JiNYV918lri+ocA1xuz49anLITt
         JO2Dn9UwI1wuqRzhgYWpM0EEBjbmscX/OdrMtRaQdZRfxCn86AnYNtb/qbMj+L3+lm
         ihdavmB/PsDcxx9m9EsiWt8/N8LLktTaH15r1ENi8sRhNCTlQaXuHdJA3vdj84zpOB
         GWBxWeqSFNdhz5PMY11Qw26ekKnxsBMvx7RdXTaXhYavPXUGM9qmVW1a6lR5NjyZcS
         VjLuxmnB6Gehg==
Date:   Sun, 19 Jun 2022 13:31:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Message-ID: <20220619133142.0ca36d2e@jic23-huawei>
In-Reply-To: <20220616170218.dihjli46spimozeg@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220616104211.9257-1-ddrokosov@sberdevices.ru>
        <20220616104211.9257-3-ddrokosov@sberdevices.ru>
        <CAHp75Vc0+ckNnm2tzLMPrjeFRjwoj3zy0C4koNShFRG3kP8b6w@mail.gmail.com>
        <20220616170218.dihjli46spimozeg@CAB-WSD-L081021.sigma.sbrf.ru>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022 17:02:08 +0000
Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:



> > > +       err = -EINVAL;
> > > +       mutex_lock(&msa311->lock);
> > > +       for (odr = 0; odr < ARRAY_SIZE(msa311_odr_table); ++odr)
> > > +               if (val == msa311_odr_table[odr].val &&
> > > +                   val2 == msa311_odr_table[odr].val2) {
> > > +                       err = msa311_set_odr(msa311, odr);  
> >   
> > > +                       if (err) {
> > > +                               dev_err(dev, "cannot update freq (%d)\n", err);
> > > +                               goto failed;
> > > +                       }  
> > 
> > Why is this inside the loop and more important under lock? Also you
> > may cover the initial error code by this message when moving it out of
> > the loop and lock.
> > 
> > Ditto for other code snippets in other function(s) where applicable.
> >   
> 
> Yes, I can move dev_err() outside of loop. But all ODR search loop
> should be under lock fully, because other msa311 operations should not
> be executed when we search proper ODR place.

I don't see why?  The search itself is for a match of the input to const data.
That can occur before taking the lock to do the actual write.

I don't see any additional race beyond the one that is always there of
a thread updating ODR whilst another is accessing the device.  Which order
those events happen in is not controlled by the driver, but the output
will be consistent with one or other order of those two accesses.

Jonathan
