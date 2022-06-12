Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A44B54799F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 11:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbiFLJ3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 05:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbiFLJ25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 05:28:57 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84FE193D1;
        Sun, 12 Jun 2022 02:28:55 -0700 (PDT)
Received: from g550jk.localnet (31-151-115-246.dynamic.upc.nl [31.151.115.246])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 632BCCD3B7;
        Sun, 12 Jun 2022 09:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1655026104; bh=+nsIAL6xFL6a1cABzXHA/MS1lpXQhXPaEkKDhejuBR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Rl4X0ZLpfjg4wS+aLRdSneRvN2IXBUuaaV9ns0bXAsb6REqNrsWuqsKntPSQWGDeC
         vbUYr2qRa+5pbYZ5cAwgFrgZR3ocnRpQr/3BomaWOB9uhIUR8wpop1MCdLL8kNRxE8
         7nsa0WaORfV4F9OfnihiAZFTbcRFtMakjwxLv3JM=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Luca Weiss <luca.weiss@fairphone.com>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Song Qiang <songqiang1304521@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 3/5] proximity: vl53l0x: Handle the VDD regulator
Date:   Sun, 12 Jun 2022 11:28:22 +0200
Message-ID: <13033502.uLZWGnKmhe@g550jk>
In-Reply-To: <20220612095333.1479464c@jic23-huawei>
References: <20220523175344.5845-1-markuss.broks@gmail.com> <CKKOCWP2NYO5.GH08U776B1KU@otso> <20220612095333.1479464c@jic23-huawei>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sonntag, 12. Juni 2022 10:53:33 CEST Jonathan Cameron wrote:
> On Wed, 08 Jun 2022 12:18:52 +0200
> 
> "Luca Weiss" <luca.weiss@fairphone.com> wrote:
> > Hi Markuss,
> > 
> > On Mon May 23, 2022 at 7:53 PM CEST, Markuss Broks wrote:
> > > Handle the regulator supplying the VDD pin of VL53L0X.
> > > 
> > > Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> > > ---
> > > 
> > >  drivers/iio/proximity/vl53l0x-i2c.c | 37 +++++++++++++++++++++++++++++
> > >  1 file changed, 37 insertions(+)
> > > 
> > > diff --git a/drivers/iio/proximity/vl53l0x-i2c.c
> > > b/drivers/iio/proximity/vl53l0x-i2c.c index 12a3e2eff464..8581a873919f
> > > 100644
> > > --- a/drivers/iio/proximity/vl53l0x-i2c.c
> > > +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> > > @@ -43,6 +43,7 @@
> > > 
> > >  struct vl53l0x_data {
> > >  
> > >  	struct i2c_client *client;
> > >  	struct completion completion;
> > > 
> > > +	struct regulator *vdd_supply;
> > > 
> > >  };
> > >  
> > >  static irqreturn_t vl53l0x_handle_irq(int irq, void *priv)
> > > 
> > > @@ -192,10 +193,31 @@ static const struct iio_info vl53l0x_info = {
> > > 
> > >  	.read_raw = vl53l0x_read_raw,
> > >  
> > >  };
> > > 
> > > +static void vl53l0x_power_off(void *_data)
> > > +{
> > > +	struct vl53l0x_data *data = _data;
> > > +
> > > +	regulator_disable(data->vdd_supply);
> > > +}
> > > +
> > > +static int vl53l0x_power_on(struct vl53l0x_data *data)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = regulator_enable(data->vdd_supply);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	usleep_range(3200, 5000);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > 
> > >  static int vl53l0x_probe(struct i2c_client *client)
> > >  {
> > >  
> > >  	struct vl53l0x_data *data;
> > >  	struct iio_dev *indio_dev;
> > > 
> > > +	int error;
> > > 
> > >  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > >  	if (!indio_dev)
> > > 
> > > @@ -210,6 +232,21 @@ static int vl53l0x_probe(struct i2c_client *client)
> > > 
> > >  				     I2C_FUNC_SMBUS_BYTE_DATA))
> > >  		
> > >  		return -EOPNOTSUPP;
> > > 
> > > +	data->vdd_supply = devm_regulator_get_optional(&client->dev, 
"vdd");
> > > +	if (IS_ERR(data->vdd_supply))
> > > +		return dev_err_probe(&client->dev, PTR_ERR(data-
>vdd_supply),
> > > +				     "Unable to get VDD 
regulator\n");
> > 
> > It looks like this optional regulator is not actually optional.
> > 
> > [    1.919995] vl53l0x-i2c 1-0029: error -ENODEV: Unable to get VDD
> > regulator
> > 
> > When using devm_regulator_get instead, a dummy regulator gets returned
> > which I think is what we want here:
> > 
> > [    1.905518] vl53l0x-i2c 1-0029: supply vdd not found, using dummy
> > regulator
> > 
> > Can you fix this up or should I send a patch?
> 
> Hi Luca,
> 
> Please send a patch.

Which commit sha can I use for Fixes: here?
Based your togreg[0] branch currently shows "Age: 20 hours" I guess it was 
rebased recently?

Regards
Luca

[0]https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=togreg

> 
> Jonathan
> 
> > Regards
> > Luca
> > 
> > > +
> > > +	error = vl53l0x_power_on(data);
> > > +	if (error)
> > > +		return dev_err_probe(&client->dev, error,
> > > +				     "Failed to power on the 
chip\n");
> > > +
> > > +	error = devm_add_action_or_reset(&client->dev, vl53l0x_power_off,
> > > data);
> > > +	if (error)
> > > +		return dev_err_probe(&client->dev, error,
> > > +				     "Failed to install poweroff 
action\n");
> > > +
> > > 
> > >  	indio_dev->name = "vl53l0x";
> > >  	indio_dev->info = &vl53l0x_info;
> > >  	indio_dev->channels = vl53l0x_channels;




