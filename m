Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC5F564E7A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbiGDHOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiGDHOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:14:04 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7438025CD;
        Mon,  4 Jul 2022 00:14:03 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e28so12115299wra.0;
        Mon, 04 Jul 2022 00:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=VYvah1KSmtjolNkND7RZi66x9ctJfX63u9hkg35plwo=;
        b=HollKbJ4m/I7jsxHM35DEhRM/mAEzSx7/AYebxzCKGpnlLWSJ9NUp5XBEl19ZGsuKc
         RGmyEH8e5sIB39A35lmXKl8DSmAR76XZjw9UTEWR3sI9CQ/jnWgud3ejmUb0iWrY2sb+
         kn4aGv0a/2MifZtrQZLp0jqfNOSYGGg8r1eafFN6udbJyhFNLqhj2DRAdId8Qxa7uckt
         liQKm5dcbGMpRfAIrXYNSBTU36fRKXjkrRtuqNCrIzpR/qArB9qisBnwGNksal6QeH7a
         gadleQ3QehLM/IeR80TVbVF3Wle/qxH0+MOmTEEyYFXfRNOHNt2czBdP3CMDy7qAdpsn
         qgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=VYvah1KSmtjolNkND7RZi66x9ctJfX63u9hkg35plwo=;
        b=5JWF2PrNM2c7xRhR6F5BOi8Cb0njEW1IkwopWoNjQNC2jpnQy9bELDOTqZRodKY18J
         ubEbSkJjUr2akK3oWRdG8yXhSWyZnof6slnB668YnWWevMbpSL1iSSb5GF8+7hxHalYR
         4iEM0x3b9Na1/51FDxLtEuwAQrwLeI5jU2eZtYyIMK+9KxdOgH3Zdp6cqskz8HXcgCgj
         Bgv60eNaFE74eXaF0neEaZEQ4+9eSyByJ/xYnV30p3+MqRi35h1uOmUfdKRPmL1vS9aL
         nCf5ReocskvZOfjFkdQU9qJPhS6KQWLot9Ctyv7bDk1iRb7OUinWwFozSpmWUcz8qDnM
         XdFQ==
X-Gm-Message-State: AJIora946RyTqF1F26xNknbuj5a7OA1hCawkZH6jdekOoHPxeNSfw+YY
        mj1zXoys5Fr0hhc+u8cUEcU=
X-Google-Smtp-Source: AGRyM1twYDXp3UtzbbdkdR42ULptwVvD7ouRKZBP2hsbFKvP4AcFGEWnQ7om1ay3+tcooW7F5QfO+g==
X-Received: by 2002:a05:6000:993:b0:21b:8f16:5b3f with SMTP id by19-20020a056000099300b0021b8f165b3fmr23891445wrb.628.1656918841905;
        Mon, 04 Jul 2022 00:14:01 -0700 (PDT)
Received: from [10.43.0.73] (68.201.26.77.dynamic.reverse-mundo-r.com. [77.26.201.68])
        by smtp.gmail.com with ESMTPSA id y22-20020a1c4b16000000b003a04a47d9c2sm18215990wma.47.2022.07.04.00.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 00:14:01 -0700 (PDT)
Message-ID: <4fd9fd1afb7b7f2dab029da80e82824f54333a02.camel@gmail.com>
Subject: Re: [PATCH v2 4/5] iio: pressure: bmp280: Add support for BMP380
 sensor family
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 Jul 2022 09:14:00 +0200
In-Reply-To: <20220704045229.GT11460@kadam>
References: <20220704003219.208409-1-ang.iglesiasg@gmail.com>
         <20220704045229.GT11460@kadam>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.module_f35+14217+587aad52) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On lun, 2022-07-04 at 07:52 +0300, Dan Carpenter wrote:
> On Mon, Jul 04, 2022 at 02:32:09AM +0200, Angel Iglesias wrote:
> > +/* Send a command to BMP3XX sensors */
> > +static int bmp380_cmd(struct bmp280_data *data, u8 cmd)
> > +{
> > +       int ret;
> > +       unsigned int reg;
> > +
> > +       /* check if device is ready to process a command */
> > +       ret = regmap_read(data->regmap, BMP380_REG_STATUS, &reg);
> > +       if (ret) {
> > +               dev_err(data->dev, "failed to read error
> > register\n");
> > +               return ret;
> > +       }
> > +       if (!(cmd & BMP380_STATUS_CMD_RDY_MASK)) {
> 
> This looks like it should be "reg" instead of command?

Yes, it should. Thanks for the catch!

> > +               dev_err(data->dev, "device is not ready to accept
> > commands\n");
> > +               return -EBUSY;
> > +       }
> > +
> > +       /* send command to process */
> > +       ret = regmap_write(data->regmap, BMP380_REG_CMD, cmd);
> > +       if (ret) {
> > +               dev_err(data->dev, "failed to send command to
> > device\n");
> > +               return ret;
> > +       }
> > +       /* wait for 2ms for command to be proccessed */
> > +       usleep_range(data->start_up_time, data->start_up_time +
> > 100);
> > +       /* check for command processing error */
> > +       ret = regmap_read(data->regmap, BMP380_REG_ERROR, &reg);
> > +       if (ret) {
> > +               dev_err(data->dev, "error reading ERROR reg\n");
> > +               return ret;
> > +       }
> > +       if (reg & BMP380_ERR_CMD_MASK) {
> > +               dev_err(data->dev, "error processing command
> > 0x%X\n", cmd);
> > +               return -EINVAL;
> > +       }
> > +       dev_dbg(data->dev, "Command 0x%X proccessed
> > successfully\n", cmd);
> > +
> > +       return 0;
> > +}
> 
> regards,
> dan carpenter

