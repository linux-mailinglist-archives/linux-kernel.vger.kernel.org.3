Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49FC5A9ABB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbiIAOok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbiIAOoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:44:38 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD0E7C511;
        Thu,  1 Sep 2022 07:44:37 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id q9so16581297pgq.6;
        Thu, 01 Sep 2022 07:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date;
        bh=mxj23L74neh2ZoK33yuGSkXVo+X4WjBndDgd5UgSvOQ=;
        b=cuiLV7qs88qM3S0urFlzvZ+WPiJnpMalRIQmDgMt8Qy9DOsB/1GQ6vo5uY2ZL0hRZw
         K1WuWexF4e2TZJN2doUad1qt31Hi4owH9tFKcOor7Z9od1iE3sAddpWBOiRNBd4XNl21
         +V//QCV3KEgtghl4Gekw7/MIWj5gf5jLYQiWdyDX+7dTo4yS8EeQhzmus9kLJRcuJYIu
         AHRJr4RxSCoLTnmVasHndtdisyBrN4u5/9ajKEOo41G5dToAmyySNl7vkklBGCA9+m2y
         AK4TDIBgliBPtraO8R2t8EdspM+wC5nk1ZIXO51l0r12SNVaXuGIOtKCJ3fr9n3Hgjj8
         724A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mxj23L74neh2ZoK33yuGSkXVo+X4WjBndDgd5UgSvOQ=;
        b=hilHOf+Dn1B3ycLI5yeBoVoS9xeRWqXGqUj9EcuWPy3t+9OaQFvyisqcLg95A7yJ60
         7Tya16zhW5tSSddChdZGRFkeSPGqtAaDNcYj0lZKKB7Rd+tZ2lr4rtC2KOQZtdbntmsx
         bZXnA8Hvu/wKjR6bBQ2dgus4FC1lVAvqfMokEK/dDMMhnrzBPRv6cqabSp7ag6enMnu8
         aaUC/VP6WLAOvfhd93RnREMHbIVWHlIjBfQivv2ut08FtIflilykNSy4umaov6+K+qii
         +SSEuUuZ7qVx2bmbxlPFgYStqQyzn6CcE5jpivBWUKAGhkAFz9hPY8ODIzP7LUVf+w/p
         wLNw==
X-Gm-Message-State: ACgBeo3aVHQ1DvYaGs5j5FPnP1S705wx/VOaMK6FqRRLvNzuXBTFAy85
        Ry8mhq5AKRKe4ApSgMRIE7I=
X-Google-Smtp-Source: AA6agR7Anq4PpHhGnCmO6tFS96G+tFBY779l+Uk+DZRDbyXXRQJJy4/wOj4qoiDDVcPz9uXEAd2NsQ==
X-Received: by 2002:a63:eb54:0:b0:42a:20f7:7d9f with SMTP id b20-20020a63eb54000000b0042a20f77d9fmr26522534pgk.444.1662043476636;
        Thu, 01 Sep 2022 07:44:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j6-20020a170903024600b0016bffc59718sm14125119plh.58.2022.09.01.07.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 07:44:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 1 Sep 2022 07:44:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Farber, Eliav" <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        rtanwar@maxlinear.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        talel@amazon.com, hhhawa@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, ronenk@amazon.com, itamark@amazon.com,
        shellykz@amazon.com, shorer@amazon.com, amitlavi@amazon.com,
        almogbs@amazon.com, dkl@amazon.com, andriy.shevchenko@intel.com
Subject: Re: [PATCH v3 02/19] hwmon: (mr75203) fix VM sensor allocation when
 "intel, vm-map" not defined
Message-ID: <20220901144434.GB3477025@roeck-us.net>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-3-farbere@amazon.com>
 <cddebb5a-3b83-e89d-db00-9a59ddbd6741@roeck-us.net>
 <84a68eff-be64-71ce-1533-1e228d3da2a4@amazon.com>
 <71d6d57c-2165-5fe3-515d-9395022921e2@roeck-us.net>
 <2f5c5828-87b9-f3d2-e3d3-0200adbe830c@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f5c5828-87b9-f3d2-e3d3-0200adbe830c@amazon.com>
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

On Thu, Sep 01, 2022 at 11:39:58AM +0300, Farber, Eliav wrote:
> On 8/31/2022 2:48 PM, Guenter Roeck wrote:
> > On 8/30/22 22:49, Farber, Eliav wrote:
> > > On 8/31/2022 8:36 AM, Guenter Roeck wrote:
> > > > On 8/30/22 12:21, Eliav Farber wrote:
> > > > > Bug fix - in case "intel,vm-map" is missing in device-tree
> > > > > ,'num' is set
> > > > > to 0, and no voltage channel infos are allocated.
> > > > > 
> > > > > Signed-off-by: Eliav Farber <farbere@amazon.com>
> > > > > ---
> > > > >   drivers/hwmon/mr75203.c | 28 ++++++++++++----------------
> > > > >   1 file changed, 12 insertions(+), 16 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
> > > > > index 046523d47c29..0e29877a1a9c 100644
> > > > > --- a/drivers/hwmon/mr75203.c
> > > > > +++ b/drivers/hwmon/mr75203.c
> > > > > @@ -580,8 +580,6 @@ static int mr75203_probe(struct
> > > > > platform_device *pdev)
> > > > >       }
> > > > > 
> > > > >       if (vm_num) {
> > > > > -             u32 num = vm_num;
> > > > > -
> > > > >               ret = pvt_get_regmap(pdev, "vm", pvt);
> > > > >               if (ret)
> > > > >                       return ret;
> > > > > @@ -594,30 +592,28 @@ static int mr75203_probe(struct
> > > > > platform_device *pdev)
> > > > >               ret = device_property_read_u8_array(dev, "intel,vm-map",
> > > > > pvt->vm_idx, vm_num);
> > > > >               if (ret) {
> > > > > -                     num = 0;
> > > > > +                     /*
> > > > > +                      * Incase intel,vm-map property is not
> > > > > defined, we
> > > > > +                      * assume incremental channel numbers.
> > > > > +                      */
> > > > > +                     for (i = 0; i < vm_num; i++)
> > > > > +                             pvt->vm_idx[i] = i;
> > > > >               } else {
> > > > >                       for (i = 0; i < vm_num; i++)
> > > > >                               if (pvt->vm_idx[i] >= vm_num ||
> > > > > -                                 pvt->vm_idx[i] == 0xff) {
> > > > > -                                     num = i;
> > > > > +                                 pvt->vm_idx[i] == 0xff)
> > > > >                                       break;
> > > > 
> > > > So all vm_idx values from 0x00 to 0xfe would be acceptable ?
> > > > Does the chip really have that many registers (0x200 + 0x40 +
> > > > 0x200 * 0xfe) ?
> > > > Is that documented somewhere ?
> > > According to the code vm_num is limited to 32 because the mask is
> > > only 5 bits:
> > > 
> > > #define VM_NUM_MSK    GENMASK(20, 16)
> > > #define VM_NUM_SFT    16
> > > vm_num = (val & VM_NUM_MSK) >> VM_NUM_SFT;
> > > 
> > > In practice according to the data sheet I have:
> > > 0 <= VM instances <= 8
> > > 
> > Sorry, my bad. I misread the patch and thought the first part of
> > the if statement was removed.
> > 
> > Anyway, what is the difference between specifying an vm_idx value of
> > 0xff and not specifying anything ? Or, in other words, taking the dt
> > example, the difference between
> >        intel,vm-map = [03 01 04 ff ff];
> > and
> >        intel,vm-map = [03 01 04];
> 
> The actual number of VMs is read from a HW register:
>     ret = regmap_read(pvt->c_map, PVT_IP_CONFIG, &val);
>     ...
>     vm_num = (val & VM_NUM_MSK) >> VM_NUM_SFT;
> 
> Also, using:
>     ret = device_property_read_u8_array(dev, "intel,vm-map", vm_idx,
>                         vm_num);
> in the driver will fail if vm_num > sizeof array in device-tree.
> 
> So, if for example vm_num = 5, but you will want to map only 3 of them
> you most set property to be:
>     intel,vm-map = [03 01 04 ff ff];
> otherwise if you set:
>     intel,vm-map = [03 01 04];
> it will assume the property doesn't, and will continue the flow in code
> as if it doesn’t exist (which is not what the user wanted, and before my
> fix also has a bug).

There should be some error handling to catch this case (ie if the number
of entries does not match the expected count), or if a value in the array
is larger or equal to vm_num. Today the latter is silently handled as end
of entries (similar to 0xff), but that should result in an error.
This would avoid situations like
	intel,vm-map = [01 02 03 04 05];
ie where the person writing the devicetree file accidentally entered
index values starting with 1 instead of 0. A mismatch between vm_num
and the number of entries in the array is silently handled as if there
was no property at all, which is at the very least misleading and
most definitely unexpected and should also result in an error.

Also, what happens if the devicetree content is something like the
following ? Would that be valid ?
	intel,vm-map = [00 01 01 01 01 01];

Thanks,
Guenter
