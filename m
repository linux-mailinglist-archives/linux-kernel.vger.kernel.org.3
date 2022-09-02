Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4D05AB7DD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbiIBSAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbiIBSAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:00:01 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DAD22516
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 10:59:59 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-11f34610d4aso6518883fac.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 10:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Q+oZ55NYjiT65t5Vl1iqL+8XrTwjqiacXY2n398AtS0=;
        b=kkyUuG7am/novr7UV11HsU6OouGiWBJkrJ1dE9kZZEvo5Z8XdtN0315MssKWtF41Sw
         SHKIJef8pwNmufB5/bSZ75YWF5UNFDYoqtExjJSgmGCugpZ9NcPalBoeq80y/l80fkPh
         tIqZa9O5fEcn84B73PTGl1R5G98tzbJdDmB3uNNish2A/9gjwJv4BLPmFGLE8peCX0Hl
         +xeU0Y9SY8tOH32P+Z2Ve38/ckpZc9ECe8+kEHQO3wSkShRjSnWuHIqMncXUniB8pfRE
         PBZgWNcJ8WtRbU4Czkxqdf+1L7lTDEmRaoXHVuz1h+kOWV6+ptZlxHVW8CPipt9gzYYf
         K9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Q+oZ55NYjiT65t5Vl1iqL+8XrTwjqiacXY2n398AtS0=;
        b=ZEIZsBj+Hf/hCs/gZ1ok1q6ASxVByBAbkOpZ3xeUagSSxTy0lCPsNwfppp++s9wROB
         U/Ru9XQWhkSEjaOUx1fh57/E8wweo0EIKRAXeEeMBuHMnV973Ftg1qZUpEoCSm2/PDuB
         8nQLf/vs1FFI8depX41FGIx9L3q3RFQGRikWFzdMwocU8M4u+htHUeKlTVizLDD0O8rh
         SU9HRinxMrpoTGXv6+7bQg/3n5ggdGrR/4520hgR6Q+1LEI1b5gCl1nRoRkXjudZ4r2L
         XfdItZoiCMLMSfAf140lVGoeW6buxLFx4Fk4RgR4Fbb3mWVWtmJLbgxKU16S8pijjrJK
         j+Rg==
X-Gm-Message-State: ACgBeo18KdhnGwIqgKgugJu6LtHki2jZzV+7zSTW4f58kel7ieCw5/oh
        Nd/2mp35pzrbG46W8+5pQyC+46rC+D15xXK3gsmolQ==
X-Google-Smtp-Source: AA6agR4lc8YAHJwrA0snISWdcfeetYmnSJAYib5dTyVyJGE8y6gfVmBogbZ5PvjlQreCbkMykat1Av6txRevneDW3dk=
X-Received: by 2002:a05:6808:e90:b0:345:49f2:a112 with SMTP id
 k16-20020a0568080e9000b0034549f2a112mr2503259oil.7.1662141598208; Fri, 02 Sep
 2022 10:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220902131258.3316367-1-cmo@melexis.com> <CAHp75VdOHDHUVhVXj4L-6ZV25mTWTeO3s3EJQVgLxknXHKRUMg@mail.gmail.com>
In-Reply-To: <CAHp75VdOHDHUVhVXj4L-6ZV25mTWTeO3s3EJQVgLxknXHKRUMg@mail.gmail.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Fri, 2 Sep 2022 19:59:21 +0200
Message-ID: <CAKv63ut0rtTFh3XdF3oR6fxQSLzNkFRS+HPPOY8Xp4LX0OY4Tg@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,
Thanks for the review. I have few questions about your remarks below.

On Fri, 2 Sept 2022 at 17:28, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Fri, Sep 2, 2022 at 4:13 PM <cmo@melexis.com> wrote:
> >
> > From: Crt Mori <cmo@melexis.com>
> >
> > Sensor can operate in lower power modes and even make measurements when
>
> The sensor
> ...or..
> Sensors
>
> > in those lower powered modes. The decision was taken that if measurement
> > is not requested within 2 seconds the sensor will remain in SLEEP_STEP
> > power mode, where measurements are triggered on request with setting the
> > start of measurement bit (SOB). In this mode the measurements are taking
> > a bit longer because we need to start it and complete it. Currently, in
> > continuous mode we read ready data and this mode is activated if sensor
> > measurement is requested within 2 seconds. The suspend timeout is
> > increased to 6 seconds (instead of 3 before), because that enables more
> > measurements in lower power mode (SLEEP_STEP), with the lowest refresh
> > rate (2 seconds).
>
> ...
>
> >  #define MLX90632_PWR_STATUS_CONTINUOUS MLX90632_PWR_STATUS(3) /* continuous*/
> >
> > +#define MLX90632_EE_RR(ee_val) (ee_val & GENMASK(10, 8)) /* Only Refresh Rate bits*/
>
> Missed space. Seems like a copy'n'paste from previous comments that
> lacks the space as well.
>
> ...
>
> > +       unsigned long interraction_timestamp; /* in jiffies */
>
> _ts for timestamp is a fine abbreviation. Also move comment to the kernel doc.
>
> ...
>
> > +static int mlx90632_wakeup(struct mlx90632_data *data);
>
> Can we avoid forward declaration? (I don't even see how it is used
> among dozens of lines of below code in the patch)
>
This is existing function that I did not want to move upwards. Should
I have just moved it rather?

> >  static s32 mlx90632_pwr_set_sleep_step(struct regmap *regmap)
> >  {
>
> > +       struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(regmap_get_device(regmap)));
>
> Why ping-ponging here and not using dev_get_drvdata()? Ditto for similar cases.
>
> > +       struct mlx90632_data *data = iio_priv(indio_dev);
> > +       s32 ret = 0;
>
> Assignment is not needed, use 'return 0;' directly. Ditto for all
> cases like this.
>
This is used, because when powerstatus is not equal to sleep_step it
returns, otherwise the ret is changed in the function.

> > +       if (data->powerstatus != MLX90632_PWR_STATUS_SLEEP_STEP) {
> > +               ret = regmap_write_bits(regmap, MLX90632_REG_CONTROL,
> > +                                       MLX90632_CFG_PWR_MASK,
> > +                                       MLX90632_PWR_STATUS_SLEEP_STEP);
> > +               if (ret < 0)
> > +                       return ret;
> > +
> > +               data->powerstatus = MLX90632_PWR_STATUS_SLEEP_STEP;
> > +       }
> > +       return ret;
> >  }
>
> ...
>
> > +       reg = MLX90632_EE_RR(reg) >> 8;
>
> This makes it harder to understand the semantics of reg, can we simply
> unite this line with the below?
>
I find it easier to have it split but I can make one long statement.
> > +       return MLX90632_MEAS_MAX_TIME >> reg;
>
> ...
>
> > +               refresh_time = refresh_time + ret;
>
> += ?
>
> ...
>
> > +               refresh_time = refresh_time + ret;
>
> +=
>
> ...
>
> > +               refresh_time = refresh_time + ret;
>
> Ditto.
>
> ...
>
> > +       unsigned int reg_status;
> >         int ret;
>
> Keep the reversed xmas tree order (like here!) elsewhere for the sake
> of consistency.
>
> ...
>
> > +       ret = regmap_read_poll_timeout(data->regmap, MLX90632_REG_STATUS,
> > +                                      reg_status,
> > +                                      ((reg_status & MLX90632_STAT_BUSY) == 0),
>
> Too many parentheses
>
I like the outer parentheses it shows that it is a break condition. I
have same in another function in this file.

> > +                                      10000, 100 * 10000);
> > +       if (ret < 0) {
> > +               dev_err(&data->client->dev, "data not ready");
> > +               return -ETIMEDOUT;
> > +       }
>
> ...
>
> > +       int current_powerstatus = data->powerstatus;
>
> Please, split the assignment and move it closer to the first user.
>
> ...
>
> > +       data->powerstatus = MLX90632_PWR_STATUS_HALT;
> > +
> > +       if (current_powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP)
> > +               return mlx90632_pwr_set_sleep_step(data->regmap);
>
> > +       else
>
> Redundant.
>
No, the powermode changes among the type.

> > +               return mlx90632_pwr_continuous(data->regmap);
>
> ...
>
> > +               ret = read_poll_timeout(mlx90632_perform_measurement, meas, meas == 19,
> > +                                       50000, 800000, false, data);
> > +               if (ret != 0)
>
> Drop this ' != 0' part. It's useless.
>
> > +                       goto read_unlock;
>
> > +
>
> Seems redundant blank line.
>
> ...
>
> > +       }
> > +
> >
>
> Ditto.
>
> ...
>
> > +       int ret = 0;
>
> Redundant assignment. Use return 0; directly.
>
> ...
>
> > +       if (time_in_range(now, data->interraction_timestamp,
> > +                         data->interraction_timestamp +
>
> > +                         msecs_to_jiffies(MLX90632_MEAS_MAX_TIME + 100))) {
>
> With a local variable you will have better to read code.
>
> > +       }
>
>
> ...
>
> >         struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>
> Maybe a separate patch to drop these here-there dereferences...
>
> ...
>
> > +static int __maybe_unused mlx90632_pm_runtime_suspend(struct device *dev)
>
> No __maybe_unused, use pm_ptr() / pm_sleep_ptr() below.
>
Care to explain a bit more about this? I just followed what other
drivers have...

> > +{
> > +       struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> > +       struct mlx90632_data *data = iio_priv(indio_dev);
> > +
> > +       return mlx90632_pwr_set_sleep_step(data->regmap);
> > +}
> > +
> > +const struct dev_pm_ops mlx90632_pm_ops = {
> > +       SET_SYSTEM_SLEEP_PM_OPS(mlx90632_pm_suspend, mlx90632_pm_resume)
> > +       SET_RUNTIME_PM_OPS(mlx90632_pm_runtime_suspend,
> > +                          NULL, NULL)
>
> Please, use new macros from pm.h / runtime_pm.h
>
> > +};
> > +EXPORT_SYMBOL_GPL(mlx90632_pm_ops);
>
> Can we use special EXPORT macro from pm.h
>
> --
> With Best Regards,
> Andy Shevchenko
