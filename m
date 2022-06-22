Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231ED555212
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377124AbiFVRMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236563AbiFVRMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:12:37 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645246458
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:12:36 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id k7so15932451plg.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yCvJ6j6iwtZyRl6d0jNgLD7Pn0GOxUGdw78rUerTkYQ=;
        b=NdN4BCXu8o6umKrHeVvbOYwWPEVpQKSEax8z3H33VWV7QswzIxmX+T5PDstpTniJIA
         rKi6kJ/IRaG60rq7gTRGX//+aC27cSBhAwY6pRR/zwfiVOlNNa0yc03LZiFM+MZSka21
         be6u8q6WxaBojeGcp6t+HRj9G4T4wMp2YEmCxdPeeN7d43dAKj7JuCzxBKixQVRlanov
         n/JX4IvCbf1ViFNjP5DfE8lGWUYdM28RPkwy0C1fKI3GbmqRiatoxSlJ5tN55NmsZTrO
         RgsMA5Aoi2ZQf42N2KrpVU8qNDqLD8T+eW1AE0oJT5vnEeRqk/n7FFjvGka6z+PgxuJY
         BSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yCvJ6j6iwtZyRl6d0jNgLD7Pn0GOxUGdw78rUerTkYQ=;
        b=ucsy1U7JW4+sOx3WbMJJ6ADhIlZlP3PIzrMWSstBofE6Cgw/f82obhTagEseTau2Dk
         giIW+7ezpLbmT+JOid/fdMI5hVFihvp7UUzAgQCuu4NoH1Pm+3ih4Mw7Pxajz+mely3W
         U+cDgfVqFvE4bSi49AxRdqfzjhISU6weFOy/sMa96MgfESrqaiy0a2O4CH9Fak2C6uGA
         enXHkXqOVK5i8NFakec4zDjEaxCq6L1abnOW2+fOP3C2HCkEPKhOaVTLEKF/oOX3QJDN
         +n1OyEUiSRQcOQ2UlrGzN1qOtUO9ePy5A17eaYBzAY/lQvvXsmUMG89WQOUyiv1qAytb
         oyTg==
X-Gm-Message-State: AJIora+QMlEIKgJVDFkbCKiH5dsdZ0ORiFsM6Vf0nlH9TIIWrdO2zJal
        6qHBE/kQMm33747lxKoS5qLf6ZUytb0FQw==
X-Google-Smtp-Source: AGRyM1smrreNKZjFDEyDDY6VS+6kJoOsAn+jBUi1AKP7/9SukHChvTsFm8w9LnLLY0JwXhx6SsQ0tg==
X-Received: by 2002:a17:903:120f:b0:15f:99f:9597 with SMTP id l15-20020a170903120f00b0015f099f9597mr34922215plh.45.1655917955933;
        Wed, 22 Jun 2022 10:12:35 -0700 (PDT)
Received: from smtpclient.apple ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id n18-20020a056a00213200b005251f4596f0sm7592333pfj.107.2022.06.22.10.12.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jun 2022 10:12:35 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [External] [PATCH] node: put_device after failing to
 device_register
From:   Zhi Song <zhi.song@bytedance.com>
In-Reply-To: <YqidROu44rHFaI6w@kroah.com>
Date:   Thu, 23 Jun 2022 01:12:31 +0800
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <2BE06D43-725A-4006-B035-ABCC0B1CEEC3@bytedance.com>
References: <20220614143007.1730171-1-zhi.song@bytedance.com>
 <YqidROu44rHFaI6w@kroah.com>
To:     Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jun 14, 2022, at 22:37, Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> On Tue, Jun 14, 2022 at 10:30:07PM +0800, Zhi Song wrote:
>> device_register() is used to register a device with the system.
>> 
>> We cannot directly free dev after calling this function,
>> even if it returns an error.
> 
> the device is not being freed, why say this?
> 
> And you do have a full 72 columns to use :)
> 
>> 
>> We should use put_device() to give up the reference
>> initialized in this function instead.
> 
> There is no "instead" happening here.  The patch looks correct, but this
> changelog text does not.  Please fix up.
> 
> thanks,
> 
> greg k-h

Hi Greg,

I have submitted this fixed patch here:
https://lore.kernel.org/all/20220621171623.1959231-1-zhi.song@bytedance
.com/
take a look if there's anything wrong. :)

Thanks,

Zhi
