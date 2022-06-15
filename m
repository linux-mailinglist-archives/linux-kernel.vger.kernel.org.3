Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F2A54D379
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349417AbiFOVQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346840AbiFOVQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:16:38 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E1455375;
        Wed, 15 Jun 2022 14:16:37 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kq6so25639059ejb.11;
        Wed, 15 Jun 2022 14:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5C0iPhxeakDMvXUgfV1iPdhonSoQnQ5rnGQnwwF8N4I=;
        b=ndEHHXW6A4Vo5fTttCudOntgwWpQqS8o5OQw7Dr/ipB9FrgxKbTQttBUOtENB/qPNp
         rjO1hI3ffuijmr74DFbtpwtOcFgHuew8O3dHjpJuFakGh5br8lqKr5Fz7/KrJ7R6li95
         9SNOVLP0lq2/CJddHGRT0M0f3GeL5G+CfLHiQX9ySgAHA87JaNIsfP3N/VnKUAGQhYQL
         RbBbOWDORE0ROq7bjI+pzH5t4QDXBRsTi35wyFmn0DIF5dSQWpvS+TG5aodzBiZqBmPu
         Gl7z4st3AjJMdunku+MOTrxu5WWfGvbdku5LjxyxAVnEhfGWcJdM5OpAm72muWufH+tp
         aFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5C0iPhxeakDMvXUgfV1iPdhonSoQnQ5rnGQnwwF8N4I=;
        b=qavTRL2HTEhiHQMae89O7fI3OGPkOHG5vNuSJ8izcHaAAuguL8PWv5BYYFiFdio1Gu
         6YuogyHsQ18ip5gfKdtuWsBwGeIV6rMceS5aTmxGKmTPbit4bms/aGZTFElVvhMkDe9D
         pyw7PuCU+EfIv7X+FnTIpBL3TkumQwER+cnw974AJGKWCdevL/iswfaGi3AULq6sG7KC
         UuVw/8zXUpZXUEpqkEKIGrCg70TR5swk7VIEHXXVu3N/RNoG584jUtLtfGkhZQ+97kOa
         x7M7Kdixfcxae6B7tzLqOTBgFvcht+2oG31aFVQagO7knQyUQYOKowAX7m6m3PsF5FhP
         QIgw==
X-Gm-Message-State: AJIora991TwUMieXFdEgBLjw8zWJWBLuk+QjG7nwZYTq4eNGxky/bdjX
        QB6m2GgjfkwDFCBX18Ayx60sAhNrv/Ir8cgr8mJDdEST3q4g3A==
X-Google-Smtp-Source: AGRyM1udFiLz4MZe8/DqP44VPEv+E+P3jM2cO+yV+gJZhqYCMCOt8vME4Hd7rMVqtWBzGo5APnL553Y4nTb5XRaIrWg=
X-Received: by 2002:a17:907:9721:b0:70c:65e7:2aa5 with SMTP id
 jg33-20020a170907972100b0070c65e72aa5mr1647531ejc.132.1655327795941; Wed, 15
 Jun 2022 14:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220613120534.36991-13-andrea.merello@iit.it>
 <202206160409.GTDk9b3k-lkp@intel.com> <CAHp75Vd7zF=rC7VYAnqc7cz52HfcLdVWwE6kuifwv3L8JiFBxg@mail.gmail.com>
In-Reply-To: <CAHp75Vd7zF=rC7VYAnqc7cz52HfcLdVWwE6kuifwv3L8JiFBxg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Jun 2022 23:15:58 +0200
Message-ID: <CAHp75VctKV0sbZsjHjPutqo+WDJr5HemWjc50CCqSsScbh5p9A@mail.gmail.com>
Subject: Re: [v6 12/14] iio: imu: add BNO055 serdev driver
To:     kernel test robot <lkp@intel.com>
Cc:     Andrea Merello <andrea.merello@iit.it>,
        Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>, kbuild-all@lists.01.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 11:13 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Jun 15, 2022 at 10:57 PM kernel test robot <lkp@intel.com> wrote:
>
> ...
>
> > >> drivers/iio/imu/bno055/./bno055_ser_trace.h:91:23: warning: format '%d' expects argument of type 'int', but argument 3 has type 'size_t' {aka 'long unsigned int'} [-Wformat=]
>
> >     80              TP_PROTO(size_t len, const unsigned char *buf),
> >     81              TP_ARGS(len, buf),
> >     82              TP_STRUCT__entry(
> >     83                      __field(size_t, len)
> >     84                      __dynamic_array(unsigned char, buf, len)
> >     85              ),
> >     86              TP_fast_assign(
> >     87                      __entry->len = len;
> >     88                      memcpy(__get_dynamic_array(buf),
> >     89                             buf, __entry->len);
> >     90              ),
> >   > 91              TP_printk("len: %d, data: = %*ph",
>
> Obviously it must be %zu
>
> >     92                        __entry->len, __entry->len, __get_dynamic_array(buf)

...and the second len here should be casted to (int) explicitly, since
* in the printf() format specifier means int argument.

> >     93              )

-- 
With Best Regards,
Andy Shevchenko
