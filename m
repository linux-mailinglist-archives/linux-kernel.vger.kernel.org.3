Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5022959ADAD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 13:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345061AbiHTLwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 07:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241030AbiHTLwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 07:52:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AF49E2C8;
        Sat, 20 Aug 2022 04:52:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CDC3B80B92;
        Sat, 20 Aug 2022 11:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE46C433C1;
        Sat, 20 Aug 2022 11:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660996332;
        bh=EHHFSu4yACtrEkdzmPcb5OuIYaJ/erGqHqabiAFd4n0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Uobzz6hGYwNST4mLp+32zhAK6hBM2uMuPL0tYHoaXf0VUw/lzTlKYbYBEwAIGG5s8
         /vL9/34IUQoabbZ4/veM5PwU3SyN5rbMs0Mz2sefrt+/34t+6ENNsKzv8bhuZenELl
         zUCZUKQdpFGSFl+ppucXaF3Lmn3ZDvxL2yRPzU7SJ2+uy7zHWoC6iiRqL5uN+Y6k1Z
         eimAJsPvYMXo/c7OMoKd4vYV9B/vPYbyt2Y8BzIppm0iAfG3PoWDGT2a6mKurNo//g
         UiqtAHhUizVfXi984+qDb/74ClB7njfQmhdHuH/LNFAEIWHR+0RMklLaEEnhvmTb+f
         9pH+tXiyWvRBw==
Date:   Sat, 20 Aug 2022 13:02:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Eddie James <eajames@linux.ibm.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v5 2/2] iio: pressure: dps310: Reset chip if MEAS_CFG is
 corrupt
Message-ID: <20220820130248.7773a6b3@jic23-huawei>
In-Reply-To: <CAHp75VegQspJJ9YT=2E3YvKh-hp9-AGincp4z0GdQbA0Vq4Zug@mail.gmail.com>
References: <20220815145705.203017-1-eajames@linux.ibm.com>
        <20220815145705.203017-3-eajames@linux.ibm.com>
        <CAHp75VegQspJJ9YT=2E3YvKh-hp9-AGincp4z0GdQbA0Vq4Zug@mail.gmail.com>
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

On Thu, 18 Aug 2022 23:16:55 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Aug 15, 2022 at 5:57 PM Eddie James <eajames@linux.ibm.com> wrote:
> >
> > Corruption of the MEAS_CFG register has been observed soon after
> > system boot. In order to recover this scenario, check MEAS_CFG if
> > measurement isn't ready, and if it's incorrect, reset the DPS310
> > and execute the startup procedure.  
> 
> ...
> 
> > + * Called with lock held. Returns a negative value on error, a positive value
> > + * when the device is not ready, and zero when the device is ready.  
> 
> Can we have
> 
> #define DPS310_DEVICE_NOT_READY  1
> 
> (or anonymous enum) and return it instead of abstract 1 or any other
> positive number?

Perhaps make it even clearer by returning the need to wait via another parameter
rather than this being (probably) the only place in driver with a postive rc.

bool reset_done;

rc = dps310_check_reset_meas_cfg(data, DPS310_TMP_RDY, &reset_done);

if (reset_done) {
}

> 
> ...
> 
> > +       rc = dps310_check_reset_meas_cfg(data, DPS310_TMP_RDY);
> >         if (rc < 0)
> >                 goto done;
> >
> > +       if (rc > 0) {
> > +               rate = dps310_get_temp_samp_freq(data);
> > +               timeout = DPS310_POLL_TIMEOUT_US(rate);
> > +
> > +               /*
> > +                * Poll for sensor readiness; base the timeout upon the sample
> > +                * rate.
> > +                */
> > +               rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG,
> > +                                             ready, ready & DPS310_TMP_RDY,
> > +                                             DPS310_POLL_SLEEP_US(timeout),
> > +                                             timeout);
> > +               if (rc)
> > +                       goto done;
> > +       }  
> 
> But have you tried to make a helper that takes a pointer to the
> respective function?
> 

