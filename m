Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C28854AE42
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355083AbiFNK0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237318AbiFNK0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:26:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5844B47AD9;
        Tue, 14 Jun 2022 03:26:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B4F4B817BF;
        Tue, 14 Jun 2022 10:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5356C3411E;
        Tue, 14 Jun 2022 10:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655202370;
        bh=d9pj+TFmwR5Vnt8hJs52y0k4GjIE3TN13/qiSXbl1XE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mnQZsX59shkhsiP9hmtj9/OkA6vwcL2NKvGKYuoLyXAqU1aGBym3q+VRSqyqrYgPA
         570ohQcib4C0xitUZXhps8BjBpIrutd728BKLHgOPPjb6IvBMdQLyDbK9N3J2Sv/Ub
         d9B83/m7xs14F+GPUPxIObu+HHyGEVDZ2hf1hbeQvYBCFzYuRmqVwW7SAEMFVS6GfU
         D6wdSwvAt6ktMohBxo7FcO3TAt/Os0huX0JwhOOxkxfGeEkIypjyJmY5rgEWqQh6FR
         gBRKQIKcArfCbWI41himbegRecw34GqveeMbxBcMU5DL2UNPs6EHZAj1iFXyDr2TCk
         vZDhT4YU8Hd/w==
Date:   Tue, 14 Jun 2022 11:35:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Joe Simmons-Talbott <joetalbott@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3] iio: Use octal permissions and DEVICE_ATTR_{RO,RW}.
Message-ID: <20220614113522.432ebca8@jic23-huawei>
In-Reply-To: <CAHp75Vd79=x93KgqcR3coYHUbHiHwyYTagOuKki54omEPx64jA@mail.gmail.com>
References: <20220601185414.251571-1-joetalbott@gmail.com>
        <CAHp75Vd79=x93KgqcR3coYHUbHiHwyYTagOuKki54omEPx64jA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2022 21:02:52 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Jun 1, 2022 at 8:54 PM Joe Simmons-Talbott <joetalbott@gmail.com> wrote:
> >
> > As reported by checkpatch.pl.  Where possible use DEVICE_ATTR_RO(),
> > DEVICE_ATTR_RW(), and __ATTR_RO().  Change function names to be
> > <var>_show() for read and <var>_store() for write.  
> 
> Thank you for an update!
> I have a few nit-picks, but no need to resend, I believe Jonathan may
> (or may not :) modify when applying.
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> > Suggested-by: Joe Perches <joe@perches.com>
> > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Joe Simmons-Talbott <joetalbott@gmail.com>
> > +static ssize_t watermark_store(struct device *dev,
> > +                              struct device_attribute *attr,  
> 
> Ditto.

Nope. 81 chars ;)

> 
> > +                              const char *buf,
> > +                              size_t len)  
> 
> Ditto.
> 
> >  {
> >         struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >         struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
> > @@ -1366,9 +1366,9 @@ static ssize_t iio_buffer_store_watermark(struct device *dev,
> >         return ret ? ret : len;
> >  }
> >
> > -static ssize_t iio_dma_show_data_available(struct device *dev,
> > -                                               struct device_attribute *attr,
> > -                                               char *buf)
> > +static ssize_t data_available_show(struct device *dev,
> > +                                  struct device_attribute *attr,  
> 
> Ditto.
Nope, well over 80, but pulling char *buf up to previous line fits nicely.

> 
> > +                                  char *buf)

...

> > diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> > index f504ed351b3e..21f113c0ee96 100644
> > --- a/drivers/iio/industrialio-trigger.c
> > +++ b/drivers/iio/industrialio-trigger.c
> > @@ -37,7 +37,7 @@ static LIST_HEAD(iio_trigger_list);

> >  static struct attribute *iio_trig_dev_attrs[] = {
> >         &dev_attr_name.attr,
> > @@ -395,7 +395,7 @@ void iio_dealloc_pollfunc(struct iio_poll_func *pf)
> >  EXPORT_SYMBOL_GPL(iio_dealloc_pollfunc);
> >
> >  /**
> > - * iio_trigger_read_current() - trigger consumer sysfs query current trigger
> > + * current_trigger_show() - trigger consumer sysfs query current trigger
> >   * @dev:       device associated with an industrial I/O device
> >   * @attr:      pointer to the device_attribute structure that
> >   *             is being processed
> > @@ -407,9 +407,9 @@ EXPORT_SYMBOL_GPL(iio_dealloc_pollfunc);
> >   * Return: a negative number on failure, the number of characters written
> >   *        on success or 0 if no trigger is available
> >   */
> > -static ssize_t iio_trigger_read_current(struct device *dev,
> > -                                       struct device_attribute *attr,
> > -                                       char *buf)
> > +static ssize_t current_trigger_show(struct device *dev,
> > +                                   struct device_attribute *attr,  
> 
> Ditto.

Nope, but dragging char *buf up to previous line is good.

> 
> > +                                   char *buf)
> >  {
> >         struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >
> > @@ -419,7 +419,7 @@ static ssize_t iio_trigger_read_current(struct device *dev,
> >  }
> >
> >  /**
> > - * iio_trigger_write_current() - trigger consumer sysfs set current trigger
> > + * current_trigger_store() - trigger consumer sysfs set current trigger
> >   * @dev:       device associated with an industrial I/O device
> >   * @attr:      device attribute that is being processed
> >   * @buf:       string buffer that holds the name of the trigger
> > @@ -432,10 +432,10 @@ static ssize_t iio_trigger_read_current(struct device *dev,
> >   * Return: negative error code on failure or length of the buffer
> >   *        on success
> >   */
> > -static ssize_t iio_trigger_write_current(struct device *dev,
> > -                                        struct device_attribute *attr,
> > -                                        const char *buf,
> > -                                        size_t len)
> > +static ssize_t current_trigger_store(struct device *dev,
> > +                                    struct device_attribute *attr,  
> 
> Ditto.
> 
No


All others tweaked as suggested.

Patch applied to the togreg branch of iio.git and if the train wifi
remains stable (far too many tunnels), shortly pushed out as testing
for 0-day to see if we missed anything (or I messed up the tweaks).

Thanks,

Jonathan

