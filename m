Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761F556A518
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbiGGOJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbiGGOJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:09:56 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB13C2CC82;
        Thu,  7 Jul 2022 07:09:54 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id bh13so12788350pgb.4;
        Thu, 07 Jul 2022 07:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MCCS6US3zD5b0Ajc53Gw76nSk4SD7L3bqzxTY3rzoro=;
        b=SDBYOeqQUFmy94RKdCbpjxYtfvzjGNXIvCkpu5lhXH1gJ1Nx5ITu0QrLr2FKPQyhXN
         tYLUjEKIc5UvNxpqOHaj/nRSOc1A3sOOOwdMopVSG3Qz8fZfYpzp3ppJzBJetIHUr1Yr
         1mrJeFobWD8lz5AZZF2BdYqTv4vL28ey3dPqaE6lQ2QQkISRuwphr5PQEGEjyJkaZXKf
         Pde6sHngM91cn8+YD1R7JL33AqyJkJTV7AUIOG4/S7e2VVt0He20Ym3fkkAJoZM4zE3o
         SopJG5IJDXcwl6mbFI9kA3XG/hRUjvsrfbDJ1UjTwolKviBpAOQ+mv2bKPEZVjlf9ESq
         iBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=MCCS6US3zD5b0Ajc53Gw76nSk4SD7L3bqzxTY3rzoro=;
        b=hNwGvwvkzUJnT9zsqEb0X4G1b3nYZ8ekwnByk82TfSCIEZkubHbPvr5uoMB8pX0RGA
         SUgpP2bIdo4Umpt0+XhD3kKzC6IEPQ3kZXoVDsAq6i4wvdj/xnQzMjG0A/wVh88/UTD1
         nUaSIOyDXad2Z0iZD39D+myt61Gyg3cvUsQYITox9VSny/8bhnyqdjP5pjF0ZCF7OR+g
         hZnabT0ukPJfaYRa+PnoMV964IHswyVzLH7XzfnaMD3OlWl6jGG155zuXk1BTgsmRa/l
         VQp2L731SjRjOfHies8GpU/Mol29vFmFXav8RcUTqMN8nO1NbrXm+ZPmAT0PUrO+R1db
         jFuQ==
X-Gm-Message-State: AJIora9nitbCpjXnjuXpPdyJwOmTGG6TG13zmj/7GriXeNaJxEvCP21m
        zZ5mAPstJ8PE4iik9l8p+Kg/zj4tGxK5NQ==
X-Google-Smtp-Source: AGRyM1t9oqNI1C2yEgbktiay3UZmUwsY+GrUhx+YjBYvdnXACAtvNCvylpFsPSZJzRwEqySu3DTiaA==
X-Received: by 2002:a17:902:c952:b0:16c:1cdd:9077 with SMTP id i18-20020a170902c95200b0016c1cdd9077mr628160pla.168.1657202994232;
        Thu, 07 Jul 2022 07:09:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v16-20020a170902e8d000b0015e8d4eb24fsm27778327plg.153.2022.07.07.07.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 07:09:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 7 Jul 2022 07:09:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Kallas, Pawel" <pawel.kallas@intel.com>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        iwona.winiarska@intel.com
Subject: Re: [PATCH 0/3] hwmon: (pmbus) add power from energy readings
Message-ID: <20220707140952.GB3492673@roeck-us.net>
References: <20220706104024.3118590-1-pawel.kallas@intel.com>
 <20220706131758.GA652205@roeck-us.net>
 <dc8771ad-b48b-317d-b132-47208ef58710@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc8771ad-b48b-317d-b132-47208ef58710@intel.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 04:01:54PM +0200, Kallas, Pawel wrote:
> On 06-Jul-22 3:17 PM, Guenter Roeck wrote:
> > On Wed, Jul 06, 2022 at 12:40:21PM +0200, Kallas, Pawel wrote:
> > > Add support for reading EIN or EOUT registers and expose power calculated
> > > from energy. This is more accurate than PIN and POUT power readings.
> > > Readings are exposed in new hwmon files power1_average and power2_average.
> > > Also add support for QUERY command that is needed to check availability
> > > of EIN and EOUT reads and its data format. Only direct data format is
> > > supported due to lack of test devices supporting other formats.
> > > 
> > I don't think this is a good idea. EIN/EOUT report energy consumption,
> > not power.
> 
> According to PMBus-Specification-Rev-1-3-1-Part-II-20150313 "READ_EIN and
> READ_EOUT commands provide information that can be used to calculate power
> consumption". That is accumulator summing instantaneous input power
> expressed in "watt-samples" and counter indicating number of samples.
> The only reasonable thing that can be done with those values is calculating
> power.

Yes, but that is not the responsibility of the kernel. Just like we don't add
up power measurements to calculate energy, we don't take energy measurements
and calculate power consumption. Similar, we don't take voltage and current
measurements and report power consumption from it either.

> 
> > The "average" attributes as implemented don't really report
> > a reliable number since the averaging period is not defined.
> 
> Agree, it is calculating average power since last read, which could be
> incorrect with multiple consumers. However, this is the only possibility
> without adding some timer logic.

Another reason for doing it in userspace. Read energy every N seconds, and use
the difference to calculate average power consumption average over that time
period.

> 
> > Also, kernel
> > drivers should not make up such numbers. I don't mind adding energy
> > attribute support, but that should be reported as what it is, energy.
> > What userspace does with it would then be a userspace concern; it can
> > calculate all kinds of averages from it as much as it wants.
> 
> Returning direct value of read registers would also work for our use case,
> but it is not in line with sysfs interface.

I did not suggest that. Just use the "energyX_in" attributes.

Thanks,
Guenter

> 
> > Also, new attributes should not depend on query command support.
> > I don't mind adding support for that, but it would have to be independent
> > of energy attribute support.
> > 
> > Thanks,
> > Guenter
> > 
> > > Kallas, Pawel (3):
> > >    hwmon: (pmbus) add support for QUERY command
> > >    hwmon: (pmbus) refactor sensor initialization
> > >    hwmon: (pmbus) add EIN and EOUT readings
> > > 
> > >   Documentation/hwmon/pmbus-core.rst |   7 +
> > >   drivers/hwmon/pmbus/pmbus.c        |  20 +++
> > >   drivers/hwmon/pmbus/pmbus.h        |  19 +++
> > >   drivers/hwmon/pmbus/pmbus_core.c   | 261 +++++++++++++++++++++++++++--
> > >   4 files changed, 291 insertions(+), 16 deletions(-)
> > > 
> > > 
> > > base-commit: 7c1de25c06f31b04744beae891baf147af9ba0cb
