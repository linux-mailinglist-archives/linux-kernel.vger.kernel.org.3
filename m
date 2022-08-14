Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A9C592031
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 16:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239503AbiHNOiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 10:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiHNOiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 10:38:03 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B441581B;
        Sun, 14 Aug 2022 07:38:01 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bs25so6414387wrb.2;
        Sun, 14 Aug 2022 07:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=espo5Jw5sWu9O5noOsv3BtZvfu0CnVnvAhoBUKVmfr0=;
        b=PJoPqZAYOVZ0/HM/DD7vPkhRRMoCL663palCKJjlwBO+bepesRU6eX6PEEsFslPnQE
         7anhly6UjGx2p8Mt3BOAjipJ4BpJ4vnRxNp5OuV6tnDSMeP4lTo/wfznkRWd+5skeZYX
         MglyrpMD6tbjzPSD2fxBiokrrneT3re5lJj4V11TrdFelL/GKcRF39z1zsEByxUvZjXD
         IANWUEzy8l17KyMZlyyIgbeti1tSL+d6yz8UaBEHEkkWEHaSR8z+b5VCfBoD5YFbjtB2
         fa0ytVBJaaC526pL4jzIc7oXTZnJ9yzHO8o1VXPbUWoWWc+rMRzSzw7W6Z/T5FSwLlZP
         Q65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=espo5Jw5sWu9O5noOsv3BtZvfu0CnVnvAhoBUKVmfr0=;
        b=QwqsGksw5d+AcS1pnLqG7dvmOXmBcjJH0gC3pfmRVpLrINYe2OLkDFCtpG6zv0DzBJ
         YB4Sikb9rYIm9Gv3J+kdMxHb9+qxAvXXEVVKWUGGWV72f7/C57GR2a0TtGYSRnA+H6RA
         g+EXuwbzGUC10UGPTD+RYqmdXhc7nBNrhTgU4ih79ybc2VZxJsiSGX56Vd4cfBpWyAN4
         g302h7/tc20Gz0vD9xCoXZ5Own17JOv77du86EXKwdpxPWOCIbC4UXUuqSbWKf+lhN/T
         y0joLqsrI/2bDrpsUVEQfnz7TFWYv8HnrxXqZKm6RLmWqQKH1vccQXHKiZ9ZgYXPPqC2
         1WmQ==
X-Gm-Message-State: ACgBeo1juV/IbVc+i3YTzN4kwoJTlyfFOpxJ3bKA+uAFjelVd0yQeTSc
        T6M5XNZVaEiB+1n31uXKze8=
X-Google-Smtp-Source: AA6agR7dxhtvBR7RZSWcvPn39LFFZm1dHGpaIpdtlSL3Uf1PD6Pa3ToS4qQCoim5h3SoH9xmqteo6A==
X-Received: by 2002:a5d:64e9:0:b0:220:7dd7:63eb with SMTP id g9-20020a5d64e9000000b002207dd763ebmr6460123wri.590.1660487880069;
        Sun, 14 Aug 2022 07:38:00 -0700 (PDT)
Received: from [192.168.90.207] (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id h13-20020a5d430d000000b00224f605f39dsm3748037wrq.76.2022.08.14.07.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 07:37:59 -0700 (PDT)
Message-ID: <53b0132936a98943fb4284c4f72e3f4e6faa402d.camel@gmail.com>
Subject: Re: [PATCH v5 3/5] iio: pressure: bmp280: Add support for BMP380
 sensor family
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-kernel@vger.kernel.org
Date:   Sun, 14 Aug 2022 16:37:58 +0200
In-Reply-To: <20220814151512.097c7779@jic23-huawei>
References: <cover.1659872590.git.ang.iglesiasg@gmail.com>
         <462251c4bca30b53f06307043ad52d859eb8d5c1.1659872590.git.ang.iglesiasg@gmail.com>
         <20220814151512.097c7779@jic23-huawei>
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

On Sun, 2022-08-14 at 15:15 +0100, Jonathan Cameron wrote:
> On Sun,  7 Aug 2022 13:55:52 +0200
> Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
> 
> > Adds compatibility with the new generation of this sensor, the BMP380
> > 
> > Includes basic sensor initialization to do pressure and temp
> > measurements and allows tuning oversampling settings for each channel.
> > 
> > The compensation algorithms are adapted from the device datasheet and
> > the repository https://github.com/BoschSensortec/BMP3-Sensor-API
> > 
> > Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> 
> One additional comment from me inline.
> 
> Thanks,
> 
> Jonathan
> 
> 
> >         }
> > @@ -1124,6 +1471,13 @@ int bmp280_common_probe(struct device *dev,
> >                 return -EINVAL;
> >         }
> >  
> > +       /* BMP3xx requires soft-reset as part of initialization */
> > +       if (chip_id == BMP380_CHIP_ID) {
> 
> I'd prefer this to be based on a flag in chip_info so that we can
> trivially add it to future devices by just setting that flag for the
> chip_info added for the new device.

How a new init or preinit callback? For now only BMP380 chip would use it, but I
would like to get my hands on a BMP390 and the new BMP580 and extend the driver
to support for them.

> > +               ret = bmp380_cmd(data, BMP380_CMD_SOFT_RESET);
> > +               if (ret < 0)
> > +                       return ret;
> > +       }
> > +
> >         ret = data->chip_info->chip_config(data);
> >         if (ret < 0)
> >                 return ret;
> 

Kind regards,
Angel
