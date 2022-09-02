Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22E55AB87D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiIBSna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiIBSn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:43:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C331144D5
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 11:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662144206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Ygx506LgmFK7L1KUAyuf5pe5qs+tRV+yvCiaInsACw=;
        b=JweQv4mpthRJ2JK5IxWu6Q4Bryn/BdJdJ6hqGWAxsCv1dByAzWBiqyoj/i/8wd2gci7cFN
        k932ZiUodqlmlz8pCe0jgoaP/RiTPvHkRrD37MQvUBSQoqupLyaeiz7cXSmERwkwDxZtb2
        4K8e8mblY0PDhcrvjMXs2NzkV8UW1F4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-645-ysAg3YasO1q1Lropbt5w_A-1; Fri, 02 Sep 2022 14:43:25 -0400
X-MC-Unique: ysAg3YasO1q1Lropbt5w_A-1
Received: by mail-qt1-f199.google.com with SMTP id ff27-20020a05622a4d9b00b0034306b77c08so2156139qtb.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 11:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=7Ygx506LgmFK7L1KUAyuf5pe5qs+tRV+yvCiaInsACw=;
        b=63UOlUcyOkqWuvanEeVHG0/PfzUSO3hWinRzk9VEnUUEF80x5IKdpwwYHLm9DR1h4x
         EMQuMGUkoW7JaDQcK9w2tA9kXIiO6loy4gxrjkeT2SvrutRrdRjlc96xCFsvwoGrOmX1
         1skoXZdi+dgHCUJY4bJU1NjUmhzTsYfUvQ6xnnAz8lWxmsw/PK0gElhIm9QqJt9716ID
         XO1/ncs9zdieu4SIOwbAW9zZrq0JSoejMZ5BwtusCzP670pDFOKLGhiwbgtz928v2yYU
         CPhAx4nqQq4OZfQ0L7tG2x11lu/Mx1wwphGBHHA0hTbFLgtSdzVVEjewWHkADCl/64HE
         S/Zw==
X-Gm-Message-State: ACgBeo1tnDxmJ57W6GGm7JiVpd4shgO2e9w2zDF0EhYUg3k6TIIYIezN
        Qpb/6r4zI5OwhEZb5bWL6a/+l71lAfwx7zhSS2sLdJEII6Dy2mBEn3jkE8TWIB7k93JdS2YVdRK
        U2cs+nJQ6vPVrR3fX//HxQyg=
X-Received: by 2002:a05:6214:c8f:b0:499:21eb:ba3b with SMTP id r15-20020a0562140c8f00b0049921ebba3bmr11683328qvr.97.1662144204602;
        Fri, 02 Sep 2022 11:43:24 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7K6nBjFNlybScTP7Kemi+J2G3yUcqV9Mva+4TXiBdaw+VSNZOrU4SppDL6kJQ3vHr68+qN5A==
X-Received: by 2002:a05:6214:c8f:b0:499:21eb:ba3b with SMTP id r15-20020a0562140c8f00b0049921ebba3bmr11683298qvr.97.1662144204338;
        Fri, 02 Sep 2022 11:43:24 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id c4-20020ac84e04000000b00344f936bfc0sm1406919qtw.33.2022.09.02.11.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 11:43:23 -0700 (PDT)
Date:   Fri, 2 Sep 2022 14:43:22 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de, pankydev8@gmail.com,
        Johannes.Thumshirn@wdc.com, linux-block@vger.kernel.org,
        dm-devel@redhat.com, hare@suse.de, jaegeuk@kernel.org,
        linux-kernel@vger.kernel.org, matias.bjorling@wdc.com,
        gost.dev@samsung.com, bvanassche@acm.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v12 12/13] dm: introduce DM_EMULATED_ZONES target type
Message-ID: <YxJOyq8Pf2vIExFf@redhat.com>
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121914eucas1p2f4445066c23cdae4fca80f7b0268815b@eucas1p2.samsung.com>
 <20220823121859.163903-13-p.raghav@samsung.com>
 <YxFOS8fq8AeE5mkf@redhat.com>
 <96f90e1d-aa0f-1c76-bfc9-a87e978ad655@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96f90e1d-aa0f-1c76-bfc9-a87e978ad655@samsung.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02 2022 at  8:02P -0400,
Pankaj Raghav <p.raghav@samsung.com> wrote:

> On 2022-09-02 02:28, Mike Snitzer wrote:
> > On Tue, Aug 23 2022 at  8:18P -0400,
> > Pankaj Raghav <p.raghav@samsung.com> wrote:
> > 
> >> Introduce a new target type DM_EMULATED_ZONES for targets with
> >> a different number of sectors per zone (aka zone size) than the underlying
> >> device zone size.
> >>
> >> This target type is introduced as the existing zoned targets assume
> >> that the target and the underlying device have the same zone size.
> >> The new target: dm-po2zone will use this new target
> >> type as it emulates the zone boundary that is different from the
> >> underlying zoned device.
> >>
> >> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> >> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> > 
> > This patch's use of "target type" jargon isn't valid. 
> > 
> > Please say "target feature flag" and rename DM_EMULATED_ZONES to
> > DM_TARGET_EMULATED_ZONES in the subject and header.
> > Good catch. I will fix it up for the next version.
> > But, with those fixed:
> > 
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > 
> You mean <Reviewed-By> ? :)

Ah, yes Reviewed-By, force of habit ;)

