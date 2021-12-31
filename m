Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04EA482190
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 03:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242313AbhLaCcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 21:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237557AbhLaCcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 21:32:03 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49587C061574;
        Thu, 30 Dec 2021 18:32:03 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id p15so26753943ybk.10;
        Thu, 30 Dec 2021 18:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JVBD5yksZxsGutsYS0eFNfyrQ76f0vg/ibwJcBMTicw=;
        b=L8rpxmDCN1ikw/gmU4P6YK02NrJwmb8vnG7PeeOsHN7BfZpMUKsGISzLrtJwVAFDrB
         mXPmsmSsQ6OqgqeJPpnXnTdBTCqlbVC02OL9jOkGcONd/TkRjRjNKgyxMWIDuKwI3vw/
         bGIhHppSgb6kqnDeCUlxfmOAX7TtQuxrQElxP2wPJhr+OsOh1GmB/BJfjm7xEZw+3lbh
         uY8OP0t5MSXjLBueSZFms3ohCrt7/Uh7T5Pxx7Eb5gIfkg4NMW/M9gsJXYJDwNb8o/7m
         ZK0wc8cuh/GcLRbN9yP+XEZ2MJYwWKUaouO+Kakf9zzfJBsyzCXupNMO26hLtlif0tG2
         shig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JVBD5yksZxsGutsYS0eFNfyrQ76f0vg/ibwJcBMTicw=;
        b=NhwlCQrJ64JSLMlLZYHebZTVj2lAyMub/ZeyT1a92NYWsGrt5aUs/X27UFdiojLKeE
         wOHF0mbpBYCbrQ9R0VP0nFERBT4JApBowH82GfVyPzuoLteK020UdKZyArAXhtOPwnZV
         w4mVjfhw958odYhmqN13P5/fNavsfnHOHmGzk6yQtUbJOhAPVo0wsbhS7rUxvAbIo04D
         U328B21m1bCf763sopC0s479tO6dutWoKijZTol4lO1ys+i1JL5lEvnUksokKZ33idSM
         x6yyAlLCttJ0wdt1eu6A4KCDqqj9NCotbxB8z/LW2cQv2ujy9PD+nd0VT18CPVgJ7KtP
         gkkA==
X-Gm-Message-State: AOAM530WG/CZeyRh7HG9m2IXX1G35EN/Nf9Qof1P7tw7b+QHgdWJx8e0
        QZjmrjHwZ5/gKCMgn0CmdAW3NYz8NgiIi63D39M=
X-Google-Smtp-Source: ABdhPJxHFq4M6ky3lFhl3t+0n++ANc9X8PmONVHU09aZfkknm9NX4lCvnrBEZTEAcGjwpu4G/LmjwmV009rMZWPJ8Sk=
X-Received: by 2002:a25:2e4c:: with SMTP id b12mr26946986ybn.569.1640917922513;
 Thu, 30 Dec 2021 18:32:02 -0800 (PST)
MIME-Version: 1.0
References: <20211230051132.21056-1-hbh25y@gmail.com> <20211230051132.21056-3-hbh25y@gmail.com>
 <Yc4MeIt6JygZ6CrY@rowland.harvard.edu>
In-Reply-To: <Yc4MeIt6JygZ6CrY@rowland.harvard.edu>
From:   Hangyu Hua <hbh25y@gmail.com>
Date:   Fri, 31 Dec 2021 10:31:51 +0800
Message-ID: <CAOo-nLLpNfHzrOyF4P0XvFK1h+J+aZqGL+AqmZP2PG6C=rcFjg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] usb: gadget: clear related members when goto fail
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, axboe@kernel.dk,
        jj251510319013@gmail.com, dan.carpenter@oracle.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/31 =E4=B8=8A=E5=8D=883:46, Alan Stern wrote:
> You must not do this.  I never sent you an Acked-by for this patch; you
> shouldn't claim that I did.

I am sorry about this. I should read the linux kernel community rules
more carefully.

>>      value =3D usb_gadget_probe_driver(&gadgetfs_driver);
>>      if (value !=3D 0) {
>> +            dev->dev =3D NULL;
>> +            dev->hs_config =3D NULL;
>> +            dev->config =3D NULL;
>>              kfree (dev->buf);
>>              dev->buf =3D NULL;
> Why not just grep the lock and goto fail?

You are right. I will modify my patch later.

>>      } else {
>> @@ -1892,7 +1895,12 @@ dev_config (struct file *fd, const char __user *b=
uf, size_t len, loff_t *ptr)
>>      }
>>      return value;
>>
>> +fail2:
>> +    dev->dev =3D NULL;
>> +fail1:
>> +    dev->hs_config =3D NULL;
>
> It is not necessary to have all these different statement labels.  You
> can simply have "fail:" clear all three pointers.
>
>>   fail:
>> +    dev->config =3D NULL;
>>      spin_unlock_irq (&dev->lock);
>>      pr_debug ("%s: %s fail %zd, %p\n", shortname, __func__, value, dev)=
;
>>      kfree (dev->buf);
>
> Alan Stern
>

I don't think so. It is not necessary to clean all three pointers if
some of them aren't kbuf. I think it may be better to keep their own
pointers.

Thanks. Happy new year.
