Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408F75A934C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiIAJh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIAJhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:37:54 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2F5AF487
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:37:53 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id b196so6168349pga.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 02:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=UQO5gUE2TAtCcGUo4A6OHbFofgIzRvtsiFaD0j+8dkw=;
        b=lwFWaIPrtDfo50NdIlYViwVrJ+QNWlvtkXOe7eNzV+SQPRRxePcbSzJv6x76tJEwe0
         ujn1uCmaa6TK7/+3/vguI68iq3HftDNnL8p312EWT7ToPGoFofFkKAEROgEV9797h3/E
         dSJte3IawgkXSJE/H7YJJgh2kCGaqMce+WbrzekEp5bfWI6IXVems7dO9KBAntv54MC9
         JqRCCb/3GzxDRl/rD7mzLzGRzUSfhm7p5aVqVYnEPXWyi0WYUsYkDdVMuqRo5st2LIZT
         fohUX9IZu5q+yz2HxVusUY3PrPFVHhYf1W0hzoFNbYCGfD618swx1q58GRebkvNeZyrA
         nScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=UQO5gUE2TAtCcGUo4A6OHbFofgIzRvtsiFaD0j+8dkw=;
        b=rvH03cIRn8A03RuyiJ9nMHoBI8iO+8Hz6tO9LfcCgH/FeUU9/XdX+2nw4IN4VJJqMT
         xGqu5RaySOVeYMGh6OWUKSxuZtyOwp6L3sx46rJ7t+jesg6d5rWg7WxZNU2mASnTs6o/
         hcJOwPQZLf0lxWgXNbj4xsUQX2oudnx7G888U1anBXoDdBe5oQ4xqeHmlmidnEbTB0ye
         72bQ8Gp+BBV8dWqyQQJMBVcamRD3mSCta5ZhHSNYIlPdBk9ZGWHAiXXSGecDekm12CBE
         r/JKUNl43HM+gnb6orHD1HdpW8gFpjzrjdne7oUZ+JvQHksvs+RGciEdtpGM6fSBYyZ1
         yZPw==
X-Gm-Message-State: ACgBeo3jXVg/+RCq4WzLzbXjFp0V1GmkbKwu/5GxEAYt7+8ba9bhQ3nx
        8W8osAx2AXNU7s46DMhLJfTdZv+393UdPGBxiRbabQ==
X-Google-Smtp-Source: AA6agR7YuO8HGnRmf+rCuolhf+xaWRSn5T36A7DQ4jNeVYnjKEwhlwLH4oTavTCVwXjZr6Wg+HQj++d+tzf0idO5tAk=
X-Received: by 2002:a05:6a00:1a04:b0:52a:d4dc:5653 with SMTP id
 g4-20020a056a001a0400b0052ad4dc5653mr30367339pfv.69.1662025072995; Thu, 01
 Sep 2022 02:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220830100700.344594-1-sudeep.holla@arm.com> <20220830100700.344594-8-sudeep.holla@arm.com>
 <CAHUa44Fmr=vDLbST5qwTDOtSZJq4RYqO+Y4Pij64VeBU-0BgrQ@mail.gmail.com> <20220901085756.ymk3rd7zjqvjpaj6@bogus>
In-Reply-To: <20220901085756.ymk3rd7zjqvjpaj6@bogus>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 1 Sep 2022 11:37:42 +0200
Message-ID: <CAHUa44EswTNmyApBT2jNfkAT2T8Efw0M8NAvimqsT3Vt8oMbNQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] firmware: arm_ffa: Add v1.1 get_partition_info support
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Marc Bonnici <marc.bonnici@arm.com>,
        Achin Gupta <achin.gupta@arm.com>,
        Valentin Laurent <valentin.laurent@trustonic.com>,
        Lukas Hanel <lukas.hanel@trustonic.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 10:58 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Sep 01, 2022 at 10:43:58AM +0200, Jens Wiklander wrote:
> > On Tue, Aug 30, 2022 at 12:07 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > FF-A v1.1 adds support to discovery the UUIDs of the partitions that was
> > > missing in v1.0 and which the driver workarounds by using UUIDs supplied
> > > by the ffa_drivers.
> > >
> > > Add the v1.1 get_partition_info support and disable the workaround if
> > > the detected FF-A version is greater than v1.0.
> > >
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > >  drivers/firmware/arm_ffa/driver.c | 39 ++++++++++++++++++++++++-------
> > >  include/linux/arm_ffa.h           |  1 +
> > >  2 files changed, 32 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> > > index 5c8484b05c50..6822241168d6 100644
> > > --- a/drivers/firmware/arm_ffa/driver.c
> > > +++ b/drivers/firmware/arm_ffa/driver.c
> > > @@ -264,18 +264,24 @@ static int ffa_rxtx_unmap(u16 vm_id)
> > >         return 0;
> > >  }
> > >
> > > +#define PARTITION_INFO_GET_RETURN_COUNT_ONLY   BIT(0)
> > > +
> > >  /* buffer must be sizeof(struct ffa_partition_info) * num_partitions */
> > >  static int
> > >  __ffa_partition_info_get(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
> > >                          struct ffa_partition_info *buffer, int num_partitions)
> > >  {
> > > -       int count;
> > > +       int idx, count, flags = 0, size;
> > >         ffa_value_t partition_info;
> > >
> > > +       if (!buffer || !num_partitions) /* Just get the count for now */
> > > +               flags = PARTITION_INFO_GET_RETURN_COUNT_ONLY;
> > > +
> > >         mutex_lock(&drv_info->rx_lock);
> > >         invoke_ffa_fn((ffa_value_t){
> > >                       .a0 = FFA_PARTITION_INFO_GET,
> > >                       .a1 = uuid0, .a2 = uuid1, .a3 = uuid2, .a4 = uuid3,
> > > +                     .a5 = flags,
> > >                       }, &partition_info);
> > >
> > >         if (partition_info.a0 == FFA_ERROR) {
> > > @@ -285,8 +291,15 @@ __ffa_partition_info_get(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
> > >
> > >         count = partition_info.a2;
> > >
> > > +       if (drv_info->version > FFA_VERSION_1_0)
> > > +               size = partition_info.a3;
> >
> > What happens if this value is larger than sizeof(struct ffa_partition_info)?
> >
>
> Right, I had the check for both 0 size and size > struct size. I removed
> both at once instead of just dropping 0 size. I assume 0 size is non
> compliant or do you prefer to keep that check as well.

The purpose with this size field is to be able to read the known part
of each element in the array.
So I believe that memcpy() below should copy MIN(size, sizeof(struct
ffa_partition_info)), assuming that we update struct
ffa_partition_info if we need to when bumping our reported FF-A
version.

I'm not sure if we need more checks for compliance or not.

Cheers,
Jens

>
> Thanks a lot for the reviews.
>
> --
> Regards,
> Sudeep
