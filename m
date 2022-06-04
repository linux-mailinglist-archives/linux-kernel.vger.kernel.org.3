Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE0F53D729
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 16:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbiFDOIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 10:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiFDOIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 10:08:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED27633A2C;
        Sat,  4 Jun 2022 07:08:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E94460C2E;
        Sat,  4 Jun 2022 14:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B18C385B8;
        Sat,  4 Jun 2022 14:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654351727;
        bh=N4ugi9zSfdwGsPRh8/YnG85BtXAozOY5znFAX5YFa2I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MX1kcIo5+BGCofSmWwDMT8eFoCP4boBtSeJvnKmQIU2s72X4/UUFGZT4VkrplX23J
         rA4lxbND15H2PY+F5Uk3ORe5KCy1Gq2QPxOwRNTicSD473peQSIhIntf2lHgX6h79S
         jvBWLqaoRzXPoOYuGSoRo6kGVdF2aV3TqmqDcYqBzZmkd9k2BN0iCi7KZGqQc8vYje
         Be4SJrJMX5dmZWVwC+YMZKIYPB+wuAOJjlun5dkguZn0Q3wrbvtBCqs5Hd0lkyXZ5O
         WqkT1zKNQVpuXnLgC5UplXd+6+oCYC+0xpyZhyZLDHtPsSXeaMl9fghhzcckSH9IiS
         NW1jlw4lOsx7g==
Date:   Sat, 4 Jun 2022 15:17:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Joe Simmons-Talbott <joetalbott@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3] iio: Use octal permissions and DEVICE_ATTR_{RO,RW}.
Message-ID: <20220604151749.7da9e75e@jic23-huawei>
In-Reply-To: <CAHp75Vd79=x93KgqcR3coYHUbHiHwyYTagOuKki54omEPx64jA@mail.gmail.com>
References: <20220601185414.251571-1-joetalbott@gmail.com>
        <CAHp75Vd79=x93KgqcR3coYHUbHiHwyYTagOuKki54omEPx64jA@mail.gmail.com>
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

Looks fine to me and I might indeed tidy up the various nit-picks
Andy raised.  I'd like to leave this on the list a little longer though.
Feel free to give me a poke if I haven't picked it up in 2 weeks or so.

Thanks,

Jonathan

> > Suggested-by: Joe Perches <joe@perches.com>
> > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Joe Simmons-Talbott <joetalbott@gmail.com>
> > ---
> >
> > Changes in v3:
> >   - Use __ATTR_RO() and add parens to DEVICE_ATTR_{RW,RO} in description
> >     as suggested by Andy Shevchenko <andy.shevchenko@gmail.com>
> >
> > Changes in v2:
> >   - Use DEVICE_ATTR_RO() and DEVICE_ATTR_RW() rather than octal permissions
> >         where applicable.  Rename functions to <var>-show() and
> >         <var>-store().  Based on review by Joe Perches <joe@perches.com>
> >
> >  drivers/iio/industrialio-buffer.c  | 64 ++++++++++++++----------------
> >  drivers/iio/industrialio-core.c    | 35 ++++++++--------
> >  drivers/iio/industrialio-trigger.c | 32 +++++++--------
> >  3 files changed, 61 insertions(+), 70 deletions(-)
> >
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > index b078eb2f3c9d..80121b1ac554 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -630,18 +630,18 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
> >         return ret;
> >  }
> >
> > -static ssize_t iio_buffer_read_length(struct device *dev,
> > -                                     struct device_attribute *attr,
> > -                                     char *buf)
> > +static ssize_t length_show(struct device *dev,
> > +                          struct device_attribute *attr,  
> 
> I think we have enough space to move the attr parameter to the previous line.
> 
> > +                          char *buf)
> >  {
> >         struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
> >
> >         return sysfs_emit(buf, "%d\n", buffer->length);
> >  }
> >
> > -static ssize_t iio_buffer_write_length(struct device *dev,
> > -                                      struct device_attribute *attr,
> > -                                      const char *buf, size_t len)
> > +static ssize_t length_store(struct device *dev,
> > +                           struct device_attribute *attr,  
> 
> Ditto.
> 
> > +                           const char *buf, size_t len)
> >  {
> >         struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >         struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
> > @@ -672,9 +672,9 @@ static ssize_t iio_buffer_write_length(struct device *dev,
> >         return ret ? ret : len;
> >  }
> >
> > -static ssize_t iio_buffer_show_enable(struct device *dev,
> > -                                     struct device_attribute *attr,
> > -                                     char *buf)
> > +static ssize_t enable_show(struct device *dev,
> > +                          struct device_attribute *attr,  
> 
> Ditto.
> 
> > +                          char *buf)
> >  {
> >         struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
> >
> > @@ -1289,10 +1289,10 @@ void iio_disable_all_buffers(struct iio_dev *indio_dev)
> >         iio_buffer_deactivate_all(indio_dev);
> >  }
> >
> > -static ssize_t iio_buffer_store_enable(struct device *dev,
> > -                                      struct device_attribute *attr,
> > -                                      const char *buf,
> > -                                      size_t len)
> > +static ssize_t enable_store(struct device *dev,
> > +                           struct device_attribute *attr,  
> 
> Ditto.
> 
> > +                           const char *buf,
> > +                           size_t len)  
> 
> And these two may be on one line.
> 
> >  {
> >         int ret;
> >         bool requested_state;
> > @@ -1322,19 +1322,19 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
> >         return (ret < 0) ? ret : len;
> >  }
> >
> > -static ssize_t iio_buffer_show_watermark(struct device *dev,
> > -                                        struct device_attribute *attr,
> > -                                        char *buf)
> > +static ssize_t watermark_show(struct device *dev,
> > +                             struct device_attribute *attr,  
> 
> Ditto.
> 
> > +                             char *buf)
> >  {
> >         struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
> >
> >         return sysfs_emit(buf, "%u\n", buffer->watermark);
> >  }
> >
> > -static ssize_t iio_buffer_store_watermark(struct device *dev,
> > -                                         struct device_attribute *attr,
> > -                                         const char *buf,
> > -                                         size_t len)
> > +static ssize_t watermark_store(struct device *dev,
> > +                              struct device_attribute *attr,  
> 
> Ditto.
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
> 
> > +                                  char *buf)
> >  {
> >         struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
> >
> > @@ -1391,18 +1391,12 @@ static ssize_t direction_show(struct device *dev,
> >         }
> >  }
> >
> > -static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
> > -                  iio_buffer_write_length);
> > -static struct device_attribute dev_attr_length_ro = __ATTR(length,
> > -       S_IRUGO, iio_buffer_read_length, NULL);
> > -static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,
> > -                  iio_buffer_show_enable, iio_buffer_store_enable);
> > -static DEVICE_ATTR(watermark, S_IRUGO | S_IWUSR,
> > -                  iio_buffer_show_watermark, iio_buffer_store_watermark);
> > -static struct device_attribute dev_attr_watermark_ro = __ATTR(watermark,
> > -       S_IRUGO, iio_buffer_show_watermark, NULL);
> > -static DEVICE_ATTR(data_available, S_IRUGO,
> > -               iio_dma_show_data_available, NULL);
> > +static DEVICE_ATTR_RW(length);
> > +static struct device_attribute dev_attr_length_ro = __ATTR_RO(length);
> > +static DEVICE_ATTR_RW(enable);
> > +static DEVICE_ATTR_RW(watermark);
> > +static struct device_attribute dev_attr_watermark_ro = __ATTR_RO(watermark);
> > +static DEVICE_ATTR_RO(data_available);
> >  static DEVICE_ATTR_RO(direction);
> >
> >  /*
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index e1ed44dec2ab..bb1dd00b99ac 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -1114,12 +1114,12 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
> >         dev_attr->attr.name = name;
> >
> >         if (readfunc) {
> > -               dev_attr->attr.mode |= S_IRUGO;
> > +               dev_attr->attr.mode |= 0444;
> >                 dev_attr->show = readfunc;
> >         }
> >
> >         if (writefunc) {
> > -               dev_attr->attr.mode |= S_IWUSR;
> > +               dev_attr->attr.mode |= 0200;
> >                 dev_attr->store = writefunc;
> >         }
> >
> > @@ -1393,29 +1393,29 @@ void iio_free_chan_devattr_list(struct list_head *attr_list)
> >         }
> >  }
> >
> > -static ssize_t iio_show_dev_name(struct device *dev,
> > -                                struct device_attribute *attr,
> > -                                char *buf)
> > +static ssize_t name_show(struct device *dev,
> > +                        struct device_attribute *attr,  
> 
> Ditto.
> 
> > +                        char *buf)
> >  {
> >         struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >         return sysfs_emit(buf, "%s\n", indio_dev->name);
> >  }
> >
> > -static DEVICE_ATTR(name, S_IRUGO, iio_show_dev_name, NULL);
> > +static DEVICE_ATTR_RO(name);
> >
> > -static ssize_t iio_show_dev_label(struct device *dev,
> > -                                struct device_attribute *attr,
> > -                                char *buf)
> > +static ssize_t label_show(struct device *dev,
> > +                         struct device_attribute *attr,  
> 
> Ditto.
> 
> > +                         char *buf)
> >  {
> >         struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >         return sysfs_emit(buf, "%s\n", indio_dev->label);
> >  }
> >
> > -static DEVICE_ATTR(label, S_IRUGO, iio_show_dev_label, NULL);
> > +static DEVICE_ATTR_RO(label);
> >
> > -static ssize_t iio_show_timestamp_clock(struct device *dev,
> > -                                       struct device_attribute *attr,
> > -                                       char *buf)
> > +static ssize_t current_timestamp_clock_show(struct device *dev,
> > +                                           struct device_attribute *attr,
> > +                                           char *buf)
> >  {
> >         const struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >         const clockid_t clk = iio_device_get_clock(indio_dev);
> > @@ -1459,9 +1459,9 @@ static ssize_t iio_show_timestamp_clock(struct device *dev,
> >         return sz;
> >  }
> >
> > -static ssize_t iio_store_timestamp_clock(struct device *dev,
> > -                                        struct device_attribute *attr,
> > -                                        const char *buf, size_t len)
> > +static ssize_t current_timestamp_clock_store(struct device *dev,
> > +                                            struct device_attribute *attr,
> > +                                            const char *buf, size_t len)
> >  {
> >         clockid_t clk;
> >         int ret;
> > @@ -1509,8 +1509,7 @@ int iio_device_register_sysfs_group(struct iio_dev *indio_dev,
> >         return 0;
> >  }
> >
> > -static DEVICE_ATTR(current_timestamp_clock, S_IRUGO | S_IWUSR,
> > -                  iio_show_timestamp_clock, iio_store_timestamp_clock);
> > +static DEVICE_ATTR_RW(current_timestamp_clock);
> >
> >  static int iio_device_register_sysfs(struct iio_dev *indio_dev)
> >  {
> > diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> > index f504ed351b3e..21f113c0ee96 100644
> > --- a/drivers/iio/industrialio-trigger.c
> > +++ b/drivers/iio/industrialio-trigger.c
> > @@ -37,7 +37,7 @@ static LIST_HEAD(iio_trigger_list);
> >  static DEFINE_MUTEX(iio_trigger_list_lock);
> >
> >  /**
> > - * iio_trigger_read_name() - retrieve useful identifying name
> > + * name_show() - retrieve useful identifying name
> >   * @dev:       device associated with the iio_trigger
> >   * @attr:      pointer to the device_attribute structure that is
> >   *             being processed
> > @@ -46,15 +46,15 @@ static DEFINE_MUTEX(iio_trigger_list_lock);
> >   * Return: a negative number on failure or the number of written
> >   *        characters on success.
> >   */
> > -static ssize_t iio_trigger_read_name(struct device *dev,
> > -                                    struct device_attribute *attr,
> > -                                    char *buf)
> > +static ssize_t name_show(struct device *dev,
> > +                        struct device_attribute *attr,  
> 
> Ditto.
> 
> > +                        char *buf)
> >  {
> >         struct iio_trigger *trig = to_iio_trigger(dev);
> >         return sysfs_emit(buf, "%s\n", trig->name);
> >  }
> >
> > -static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
> > +static DEVICE_ATTR_RO(name);
> >
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
> > +                                    const char *buf,
> > +                                    size_t len)  
> 
> Ditto.
> 
> >  {
> >         struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >         struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> > @@ -494,9 +494,7 @@ static ssize_t iio_trigger_write_current(struct device *dev,
> >         return ret;
> >  }
> >
> > -static DEVICE_ATTR(current_trigger, S_IRUGO | S_IWUSR,
> > -                  iio_trigger_read_current,
> > -                  iio_trigger_write_current);
> > +static DEVICE_ATTR_RW(current_trigger);
> >
> >  static struct attribute *iio_trigger_consumer_attrs[] = {
> >         &dev_attr_current_trigger.attr,
> > --
> > 2.35.3
> >  
> 
> 

