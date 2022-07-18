Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EA4577D42
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbiGRINB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiGRINA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:13:00 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A98C12767
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:12:59 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r14so15909286wrg.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WQFyWWwhE+sFYfmqiFNY3FVFpk2STK8Gd6DBuc6G+1M=;
        b=psU1SoqZtASiQoWQtOwhQfds8YhtawcPM3L02CnA8lo085AD8Zemy80Nv+bTNWMf8H
         ka7lt6Q64wyzkUsLgRgF9OxXW5nj6/fjzm7JvKgyh9CJQQJVCCGfCu70YCFlJJUAeCE8
         gWgxwmOOvacyQhPO5ZnhGv2kj3Xsk9RRvJ2pxlJJyTj1HHQDuceF6D9p468bqIzAEfYg
         9mFDj9wZYFNiF7Tyd8mhtf/oWd9xHdB2vzsJhSImZEjD4/BKQlPev1Xd9rWJC3hTbGVD
         uJcGRZd7UKP1gYHkDFk2cebnzNGHhQX7YsPK62eQiPQXAsBMoEfmDCkODt3lZYlNZSZQ
         4Z6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WQFyWWwhE+sFYfmqiFNY3FVFpk2STK8Gd6DBuc6G+1M=;
        b=3kehv+IwPkF9qQZKtDSHpxTej7PuQOo6IRK4GTQRVF7GzNMS/W3o7jfE1lR0KOx68x
         2iOqJVQ506kFCbWBKEkBjAw1lDS6TWOOnVf5KC4Vizg1Y9b1MnTRsjTKyUKyL4yorJip
         0m5yDB9J1dBgbl7EehuRW1h3EQvDbWxoqmUwPDhr0FY9fhpdbtCZLVVf5XlZIx9c/o/B
         RS0S445yF4yepW8PBD02pDSxIemTiClsZHBo8mqYZAeIVJZq+MaNrZg1nRxRx587Wee6
         /XgGAOo0P3bOTtKGgUGa6Q2LnuswVIOUtAVFjT8VQSfkBpAqJK+YkXJebiXImHetxleJ
         JO0g==
X-Gm-Message-State: AJIora87BNu9cLNZzVeDmdfVin6RPU6iIS9KIc00jxCeFgqapd3JuekB
        cd9ey+1k73KTM2HTIE94J7TBCA==
X-Google-Smtp-Source: AGRyM1tbmf3fJFTYPPdjJF6kyEfQjLeZliDP/QYBsTuR8F68WPGNcLr6pqg6Tb9D7RdFwn5xCU8EdA==
X-Received: by 2002:a5d:5228:0:b0:21d:93a8:6e64 with SMTP id i8-20020a5d5228000000b0021d93a86e64mr20933000wra.424.1658131977745;
        Mon, 18 Jul 2022 01:12:57 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id m65-20020a1ca344000000b0039c5a765388sm14348741wme.28.2022.07.18.01.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 01:12:57 -0700 (PDT)
Date:   Mon, 18 Jul 2022 09:12:55 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/9] mfd: intel_soc_pmic_crc: Merge Intel PMIC core to
 crc
Message-ID: <YtUWB1ncCr1i3V5x@google.com>
References: <Yrmr175fsQi6ToEY@google.com>
 <YrrO0CQVv6hj1AB0@smile.fi.intel.com>
 <YrxjTD0sJXh8cgVP@google.com>
 <CAHp75VdHpqAxS3jmFi-1Sw6wB1CP3wQVM_+5OP0C_yFFG336LA@mail.gmail.com>
 <Yr1YXHb3GqwZncFK@google.com>
 <CAHp75Vf1UK9Z2P1D9v_j9rsdKoDXWSvb=wJgmkvACYgwofWrxA@mail.gmail.com>
 <35c907e6-6018-d22b-1992-ffc66eb82b0e@redhat.com>
 <Yr1iweMUl+EUY+Q6@google.com>
 <YtHF2giNT1gG1wge@smile.fi.intel.com>
 <YtUV5sE8A3ayQ/Q3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YtUV5sE8A3ayQ/Q3@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022, Lee Jones wrote:

> On Fri, 15 Jul 2022, Andy Shevchenko wrote:
> 
> > On Thu, Jun 30, 2022 at 09:45:53AM +0100, Lee Jones wrote:
> > > On Thu, 30 Jun 2022, Hans de Goede wrote:
> > > > On 6/30/22 10:07, Andy Shevchenko wrote:
> > 
> > ...
> > 
> > > > Note that I already did a manual compare of the moved code blocks
> > > > to check that they were not changed before giving my Reviewed-by.
> > > 
> > > Super, thanks Hans.
> > 
> > Is it okay to be applied?
> 
> Yes, I think so.
> 
> Can you collect all of the Acked-by/Tested-by tags you received
> and submit a [RESEND] please?  Hans' TB which should be applied to all
> patches springs to mind.

To save yourself some pain, leave off my Acks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
