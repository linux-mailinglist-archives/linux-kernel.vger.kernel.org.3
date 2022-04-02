Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995054F051F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 19:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358629AbiDBRDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 13:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358615AbiDBRDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 13:03:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD651DBD03;
        Sat,  2 Apr 2022 10:01:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A48860C2B;
        Sat,  2 Apr 2022 17:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D4AC340EE;
        Sat,  2 Apr 2022 17:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648918912;
        bh=Q6oVRzXLQUS0n7KhdiXIiMYL80OZfB68gAxTBgZTO6E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VE2FC75UlzplXarW05pzD62WRDzlZ4DJi1PL6Ps8Z8SOVEy9Wc8HYWkmTcirx+MbP
         vK6J616wNRZR/3OLAI7vdAej/AUnxETcs6qzmRvr4UtHVu0tYin3n9abu8sji7FION
         sySnOKUBbrPXGCtidL6ySUV0TClMP5sJ9wbcEKX4J6UNi0SbKBMXgDV1FhKqd1cY4h
         g0dsfgWByTasoR32YMXPnpxLK99yIdzcjmb3O2Wle8YUrTXHtMVsgt5KQFWavJ0ulJ
         JuLY9SqQ9hoTt9odyoHorYwXkoLMJtuNbrSFpgmCaMLk83ZlxgEWQxlIaJHajkUHp2
         pIRM5xQKP3Ccg==
Date:   Sat, 2 Apr 2022 18:09:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
        "=?UTF-8?B?5pyx546J?= =?UTF-8?B?5piO?= (Yuming Zhu/11457) " 
        <yuming.zhu1@unisoc.com>, linux-iio@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 6/7] iio: adc: sc27xx: add support for PMIC ump9620
Message-ID: <20220402180905.4e85bd5c@jic23-huawei>
In-Reply-To: <CAF12kFsWVQin76KvWnfRszo+w033yjoL5DKc7ttXvywBcZPh5A@mail.gmail.com>
References: <20220311164628.378849-1-gengcixi@gmail.com>
        <20220311164628.378849-7-gengcixi@gmail.com>
        <20220320144151.66450e9a@jic23-huawei>
        <CAF12kFsWVQin76KvWnfRszo+w033yjoL5DKc7ttXvywBcZPh5A@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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


> Hi Jonathan:
> It used origin_calib_data in memcpy,and the length of data
> may less than sizeof(u32). we expect the other bits keeps 0;
> So we initialise 0 in here.
Ah. I'd missed that.  Thanks for the explanation.

> >  
> > > +     size_t len = 0;
> > > +
> > > +     if (!data)
> > > +             return -EINVAL;
> > > +
> > > +     cell = nvmem_cell_get(data->dev, cell_name);
> > > +     if (IS_ERR(cell))
> > > +             return PTR_ERR(cell);
> > > +
> > > +     buf = nvmem_cell_read(cell, &len);
> > > +     if (IS_ERR(buf)) {
> > > +             nvmem_cell_put(cell);
> > > +             return PTR_ERR(buf);
> > > +     }
> > > +
> > > +     memcpy(&origin_calib_data, buf, min(len, sizeof(u32)));
> > > +
> > > +     kfree(buf);
> > > +     nvmem_cell_put(cell);
> > > +     return origin_calib_data;
> > > +}

Jonathan
