Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154B657953B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbiGSI3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbiGSI3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:29:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3F0DF5F;
        Tue, 19 Jul 2022 01:29:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDA34B819F0;
        Tue, 19 Jul 2022 08:29:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49D4C341C6;
        Tue, 19 Jul 2022 08:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658219387;
        bh=SKQvH0l9i1NrgVLmaNl8gzEnbJBWUdMAhjKR9bO0AjE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r7knTF7e8LYSjerRRSQ5wWO91YfBEr7Wg7YleO0cV+voVfe/rxXk7bZzOU5okPpcx
         3Ogp0EBJyEMQu5ClGSaUQJgtYgmpcjfZR0BI3Vs7HxR4avdV2TCUyhKNTLmxLUV7G+
         qdyWZG+soz8R12EcpDwdAbL3P7y/aUHjkuj8zFVA0j8mx9dHDSJDet90Ok1/BmdweU
         m0M3ZHgsYzuWqS+b3IKhlgNC+rVoEKbI2CpMqdlF8A98/NF3ZpwlLaIOmVCn1i3Mpr
         MU5u85paiQwWdLfCM3oOF3FDRLlkvmulCR7iQsZ65RU1b5i8jqll7gPqSH5ru2tYoa
         f54vPVMK9Os5A==
Date:   Tue, 19 Jul 2022 09:39:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "tomas.melin@vaisala.com" <tomas.melin@vaisala.com>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        GEO-CHHER-bsp-development 
        <bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH V1 1/1] iio: accel: sca3300: Extend the trigger buffer
 from 16 to 32 bytes
Message-ID: <20220719093944.0c10bae3@jic23-huawei>
In-Reply-To: <AM9PR06MB78447C75482FA9179A601BFDD7BE9@AM9PR06MB7844.eurprd06.prod.outlook.com>
References: <20220701023030.2527019-1-Qing-wu.Li@leica-geosystems.com.cn>
        <20220701023030.2527019-2-Qing-wu.Li@leica-geosystems.com.cn>
        <20220701174602.68b20753@jic23-huawei>
        <AM9PR06MB78447C75482FA9179A601BFDD7BE9@AM9PR06MB7844.eurprd06.prod.outlook.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jul 2022 01:01:46 +0000
LI Qingwu <qing-wu.li@leica-geosystems.com.cn> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Saturday, July 2, 2022 12:46 AM
> > To: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> > Cc: lars@metafoo.de; tomas.melin@vaisala.com; nuno.sa@analog.com;
> > linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org;
> > GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>
> > Subject: Re: [PATCH V1 1/1] iio: accel: sca3300: Extend the trigger buffer from
> > 16 to 32 bytes
> > 
> > [Some people who received this message don't often get email from
> > jic23@kernel.org. Learn why this is important at
> > https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > This email is not from Hexagon's Office 365 instance. Please be careful while
> > clicking links, opening attachments, or replying to this email.
> > 
> > 
> > On Fri,  1 Jul 2022 02:30:30 +0000
> > LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> wrote:
> >   
> > > After added inclination angle channels, the trigger buffer size is
> > > insufficient. Extend the buffer size from 16 to 32 bytes, and change
> > > the trigger buffer from the struct to a u8 array to adapt the sensor
> > > with/without inclination angles output.
> > > New trigger buffer data:
> > >   - SCA3300: 3 accel channels, temp, and timestamp.
> > >   - SCL3300: 3 accel channels, temp, 3 incli channels, and timestamp.
> > > Readjustment the scan index to make it consistent with the buffer data.
> > >
> > > Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>  
> > 
> > Hi.
> > 
> > Looks good. A trivial suggestion inline to make the code a little more 'self
> > documenting'.  It's a minor change so if you are happy with the suggestion I
> > can tweak that whilst applying.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> 
> Yes, sure, absolutely agree, Thank you!
Looks like I should be able to sneak in a last pull request for this cycle
before the merge window (it was delayed a week).  Hence I've applied this
to the togreg branch of iio.git 

Thanks,

Jonathan

> 
> LI Qingwu
> 
> > > ---
> > >  drivers/iio/accel/sca3300.c | 29 ++++++++++++++++++-----------
> > >  1 file changed, 18 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
> > > index 3c4827bfef53..820dfb635bf1 100644
> > > --- a/drivers/iio/accel/sca3300.c
> > > +++ b/drivers/iio/accel/sca3300.c
> > > @@ -47,12 +47,20 @@
> > >  #define SCL3300_REG_ANG_CTRL 0x0C
> > >  #define SCL3300_ANG_ENABLE   0x1F
> > >
> > > +/*
> > > + * Buffer size max case:
> > > + * Three accel channels, two bytes per channel.
> > > + * Temperature channel, two bytes.
> > > + * Three incli channels, two bytes per channel.
> > > + * Timestamp channel, eight bytes.
> > > + */
> > > +#define SCA3300_MAX_BUFFER_SIZE (ALIGN(2 * 7, sizeof(s64)) +
> > > +sizeof(s64))  
> > 
> > Instead of the 2 use sizeof(s16)
> >  Also now you don't have timestamp in your enum sca3000_scan_indexes you
> > could add a 'tail' element to the enum such as SCA3000_SCAN_MAX then use
> > that instead of the 7 here.  Hopefully that would make this more self
> > documenting.  
> 
> 
> >   
> > > +
> > >  enum sca3300_scan_indexes {
> > >       SCA3300_ACC_X = 0,
> > >       SCA3300_ACC_Y,
> > >       SCA3300_ACC_Z,
> > >       SCA3300_TEMP,
> > > -     SCA3300_TIMESTAMP,
> > >       SCA3300_INCLI_X,
> > >       SCA3300_INCLI_Y,
> > >       SCA3300_INCLI_Z,
> > > @@ -140,10 +148,10 @@ static const struct iio_chan_spec scl3300_channels[]  
> > = {  
> > >       SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Y, 0x2, Y),
> > >       SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Z, 0x3, Z),
> > >       SCA3300_TEMP_CHANNEL(SCA3300_TEMP, 0x05),
> > > -     IIO_CHAN_SOFT_TIMESTAMP(4),
> > >       SCA3300_INCLI_CHANNEL(SCA3300_INCLI_X, 0x09, X),
> > >       SCA3300_INCLI_CHANNEL(SCA3300_INCLI_Y, 0x0A, Y),
> > >       SCA3300_INCLI_CHANNEL(SCA3300_INCLI_Z, 0x0B, Z),
> > > +     IIO_CHAN_SOFT_TIMESTAMP(7),
> > >  };
> > >
> > >  static const unsigned long sca3300_scan_masks[] = { @@ -184,7 +192,9
> > > @@ struct sca3300_chip_info {
> > >   * @spi: SPI device structure
> > >   * @lock: Data buffer lock
> > >   * @chip: Sensor chip specific information
> > > - * @scan: Triggered buffer. Four channel 16-bit data + 64-bit
> > > timestamp
> > > + * @buffer: Triggered buffer:
> > > + *          -SCA3300: 4 channel 16-bit data + 64-bit timestamp
> > > + *          -SCL3300: 7 channel 16-bit data + 64-bit timestamp
> > >   * @txbuf: Transmit buffer
> > >   * @rxbuf: Receive buffer
> > >   */
> > > @@ -192,10 +202,7 @@ struct sca3300_data {
> > >       struct spi_device *spi;
> > >       struct mutex lock;
> > >       const struct sca3300_chip_info *chip;
> > > -     struct {
> > > -             s16 channels[4];
> > > -             s64 ts __aligned(sizeof(s64));
> > > -     } scan;
> > > +     u8 buffer[SCA3300_MAX_BUFFER_SIZE] __aligned(sizeof(s64));
> > >       u8 txbuf[4] __aligned(IIO_DMA_MINALIGN);
> > >       u8 rxbuf[4];
> > >  };
> > > @@ -484,21 +491,21 @@ static irqreturn_t sca3300_trigger_handler(int irq,  
> > void *p)  
> > >       struct iio_dev *indio_dev = pf->indio_dev;
> > >       struct sca3300_data *data = iio_priv(indio_dev);
> > >       int bit, ret, val, i = 0;
> > > +     s16 *channels = (s16 *)data->buffer;
> > >
> > >       for_each_set_bit(bit, indio_dev->active_scan_mask,
> > >                        indio_dev->masklength) {
> > > -             ret = sca3300_read_reg(data,  
> > sca3300_channels[bit].address,  
> > > -                                    &val);
> > > +             ret = sca3300_read_reg(data,
> > > + indio_dev->channels[bit].address, &val);
> > >               if (ret) {
> > >                       dev_err_ratelimited(&data->spi->dev,
> > >                               "failed to read register, error: %d\n",  
> > ret);  
> > >                       /* handled, but bailing out due to errors */
> > >                       goto out;
> > >               }
> > > -             data->scan.channels[i++] = val;
> > > +             channels[i++] = val;
> > >       }
> > >
> > > -     iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
> > > +     iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> > >  
> > iio_get_time_ns(indio_dev));  
> > >  out:
> > >       iio_trigger_notify_done(indio_dev->trig);  
> 

