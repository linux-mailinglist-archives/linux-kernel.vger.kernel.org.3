Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9E6506678
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243817AbiDSIFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiDSIFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:05:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A60323BEF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650355357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jLbux2EHSPeAoMYJRPZNPjs6jbsNJeFhQg/FtKIUcjk=;
        b=chFAMNdA7nrHsRz+jWr9Hmi+/fS7gGbPA70OHTWybAPBdjQmtUvW9Qp7jwRb/LvscWpM5P
        YAWqNzFILp9fVxNymDZPf86mDz+cA4hyx0iibrtDdZHK8iD2Y4w0eq9vuWUD7N34k8nHMn
        vYaIAlAQzZnHGwZdHASED13ixNBpZU4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-CVHAmFVVNxm2zUW_cz1Oiw-1; Tue, 19 Apr 2022 04:02:36 -0400
X-MC-Unique: CVHAmFVVNxm2zUW_cz1Oiw-1
Received: by mail-wr1-f71.google.com with SMTP id q4-20020adfc504000000b002079c9cc1bfso1723700wrf.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jLbux2EHSPeAoMYJRPZNPjs6jbsNJeFhQg/FtKIUcjk=;
        b=srXFP0qJaW1P+Sv7b+cWBd242e1RPMfXEH3dCrGWCJq8wGRvQBQfG+0S84COTcz7lf
         MCICGFbLD0yAkJdp8O5a2fXu/OALs+T5Hs1/Hept6zGVwqpUxK41SrcwHCmxsj0kpCTU
         JRSe8hJPw009yPTUkyaI2iQbZZBgWZNFB+geLQ2pZnzKnz4ruj+RokX2M6fZgMMUIgQZ
         VFoEqgMcJ5iRhKFXZV3DWEzw0PTkG2QVBLeAmgsHgBSq3szg6uzQPqcwND55pYREYdgA
         CiTwyhHB4E4cbC3VNOQM/taL3yhIxN7EZ1m3RSpImzvDO7jRnVUFeX2Cx4+Bn5cLsi9A
         viZQ==
X-Gm-Message-State: AOAM532a6SgkuPB/pet5HEfyJJSaVby49TX+hiNcoyCNkO8vbZj7QQIB
        5hESvsGUOLzBC4m97czf2KybEUq4hr3vabEEDdAQdfws4DJlo211OTj2h5k/sUOEASGzS9mROIH
        lMM+wI0lZ1CvgS/h4dX5Nbrbd
X-Received: by 2002:a05:600c:3ca7:b0:38e:50d2:27fe with SMTP id bg39-20020a05600c3ca700b0038e50d227femr18789744wmb.159.1650355354958;
        Tue, 19 Apr 2022 01:02:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoYFbDlizyT41mBRw7KoxJ7TK8LkCRHtUbAAn98T1/ev5GAkMLzD2inzodoQ48+/YZbjyOCg==
X-Received: by 2002:a05:600c:3ca7:b0:38e:50d2:27fe with SMTP id bg39-20020a05600c3ca700b0038e50d227femr18789726wmb.159.1650355354671;
        Tue, 19 Apr 2022 01:02:34 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm17599649wmp.14.2022.04.19.01.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 01:02:34 -0700 (PDT)
Message-ID: <ef51a171-790e-1c13-fc9a-a4c9a2ab5863@redhat.com>
Date:   Tue, 19 Apr 2022 10:02:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 5/5] drm/solomon: Add SSD130x OLED displays SPI support
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Chen-Yu Tsai <wens@kernel.org>, Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime@cerno.tech>,
        YueHaibing <yuehaibing@huawei.com>
References: <20220413162359.325021-1-javierm@redhat.com>
 <20220413162359.325021-6-javierm@redhat.com>
 <CAMuHMdX_myNcA1eG=-qOHhtCEMnnV_eMjQF3dWakd7O6JbXskQ@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdX_myNcA1eG=-qOHhtCEMnnV_eMjQF3dWakd7O6JbXskQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert,

Thanks a lot for your feedback.

On 4/19/22 09:52, Geert Uytterhoeven wrote:

[snip]

>> +static int ssd130x_spi_write(void *context, const void *data, size_t count)
>> +{
>> +       struct ssd130x_spi_transport *t = context;
>> +       struct spi_device *spi = t->spi;
>> +       const u8 *reg = data;
>> +
>> +       if (*reg == SSD130X_COMMAND)
>> +               gpiod_set_value_cansleep(t->dc, 0);
>> +
>> +       if (*reg == SSD130X_DATA)
>> +               gpiod_set_value_cansleep(t->dc, 1);
>> +
>> +       /* Remove the control byte since is not used by the 4-wire SPI */
>> +       return spi_write(spi, ((u8 *)data) + 1, count - 1);
> 
> As I don't like casts, perhaps
> 
>     spi_write(spi, reg + 1, count - 1);
> 
> ? But this is up to you.
>

It's true that is easier to read. I just wanted to make it clear that we
were removing one byte from the data but I believe the comment is enough.

Andy also pointed out an unnecessary blank line in patch 4/5, so I think
these two changes + your R-b warrants a v5. I will post one later today.
 
[snip]

>> +static const struct spi_device_id ssd130x_spi_table[] = {
>> +       { "sh1106",  SH1106_ID },
>> +       { "ssd1305", SSD1305_ID },
>> +       { "ssd1306", SSD1306_ID },
>> +       { "ssd1307", SSD1307_ID },
>> +       { "ssd1309", SSD1309_ID },
>> +       { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(spi, ssd130x_spi_table);
> 
> I'm not sure about the need for this part, but as Mark provided his
> Ac-ed--by, I assume it's correct.
>

Right, I'm quite sure about this. See for example [0] vs [1]. The latter
does of_device_uevent_modalias(dev, env) while the former always does
add_uevent_var(env, "MODALIAS=%s%s", SPI_MODULE_PREFIX, spi->modalias)
even for devices registered through OF.

Also, commits 3ce6c9e2617e ("spi: add of_device_uevent_modalias support")
and 96c8395e2166 ("spi: Revert modalias changes") have some more context.

[0]: https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi.c#L360
[1]: https://elixir.bootlin.com/linux/latest/source/drivers/i2c/i2c-core-base.c#L139
 
> The rest LGTM, so
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>

Thanks!

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

