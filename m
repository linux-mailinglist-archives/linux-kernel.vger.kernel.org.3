Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5008E5929A6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiHOGhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiHOGhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 865A71AD8A
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 23:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660545423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jVlZ0reYHNN0XIh/eyo0CSGwsYdeKYABdhUvBkxwMO0=;
        b=Xym2EeSvKL+S9lv2dIoqaKNvHhfSeO6bEQG815qriHXeINvwtbDNnfLLmnuIPAhMOLbJIr
        s31kUYVrvCMbcsDp3X+zOPPSiP/fGaUSaxg1uBKBuvHYnUX3isQfCQ2DnQP3fAgXso70OC
        9aPpMdL1IiHcAkjOyYjhTG95ueF5e7Q=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-221-cgmL5NtNN_aCp4WiZWaSKQ-1; Mon, 15 Aug 2022 02:37:01 -0400
X-MC-Unique: cgmL5NtNN_aCp4WiZWaSKQ-1
Received: by mail-ed1-f69.google.com with SMTP id b6-20020a056402278600b0043e686058feso4207041ede.10
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 23:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=jVlZ0reYHNN0XIh/eyo0CSGwsYdeKYABdhUvBkxwMO0=;
        b=poU3K7A66hCz5mEmUnniatFUIRNchhGblmp+G065rYS64m7iHjeT5zaShJE9V6Sfym
         +pg84zg+cKm853BrE34VvFhMYC/snGGwjmFbHrQlylOmsHUD4R/OvDmOS1ddTOcbh3P/
         1oI2vtEuY8Vbl15yfM5HNMMYYKa81soHAKjTHaKqXv2W/2dfG86+o6FXatSXn1H17BDM
         YjM8b3BXlYkgZ2Lqofwt44tDLct5BWZ9vTq2i4CRoTv1uDHyF3kWx0Ipf3uR1yKLqlb/
         Ci1CubBJndNQL4+7ZDMcIxG1ioUImBb1smXdwZvqkmcpW1E6y1IJ3cg2FqgthNAHsZEO
         U0PQ==
X-Gm-Message-State: ACgBeo0C8Dtt0+YHj1ynbK3DZ54HCcm42n21RXH8m19ZuSqGjVkalAKa
        beuERZJv78lAcl3wqwL8NvY7jCgrSL7RAJq3MbzmyJCnxTODEP+PPR/zbMIifTneObCk+n5/O/u
        /bwoTs1whUxC8CbvRCJaRA+x6
X-Received: by 2002:a17:906:ef8c:b0:730:ebff:9e19 with SMTP id ze12-20020a170906ef8c00b00730ebff9e19mr9590750ejb.300.1660545420631;
        Sun, 14 Aug 2022 23:37:00 -0700 (PDT)
X-Google-Smtp-Source: AA6agR44/VJTgS573LfEMfln/aWhTrhZWbvJbWEBy+nynu8A/VqNyZa6le9/dILqc3//t4be9FmZPQ==
X-Received: by 2002:a17:906:ef8c:b0:730:ebff:9e19 with SMTP id ze12-20020a170906ef8c00b00730ebff9e19mr9590740ejb.300.1660545420379;
        Sun, 14 Aug 2022 23:37:00 -0700 (PDT)
Received: from redhat.com ([2.54.169.49])
        by smtp.gmail.com with ESMTPSA id fd4-20020a1709072a0400b00722f069fd40sm3724940ejc.159.2022.08.14.23.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 23:36:59 -0700 (PDT)
Date:   Mon, 15 Aug 2022 02:36:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Andres Freund <andres@anarazel.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: upstream kernel crashes
Message-ID: <20220815022711-mutt-send-email-mst@kernel.org>
References: <20220814212610.GA3690074@roeck-us.net>
 <CAHk-=wgf2EfLHui6A5NbWoaVBB2f8t-XBUiOMkyjN2NU41t6eA@mail.gmail.com>
 <20220814223743.26ebsbnrvrjien4f@awork3.anarazel.de>
 <CAHk-=wi6raoJE-1cyRU0YxJ+9ReO1eXmOAq0FwKAyZS7nhvk9w@mail.gmail.com>
 <1c057afa-92df-ee3c-5978-3731d3db9345@kernel.dk>
 <20220815013651.mrm7qgklk6sgpkbb@awork3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815013651.mrm7qgklk6sgpkbb@awork3.anarazel.de>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 06:36:51PM -0700, Andres Freund wrote:
> Hi,
> 
> On 2022-08-14 19:04:22 -0600, Jens Axboe wrote:
> > I took a quick look and added more SCSI bits to my vm images, but
> > haven't been able to hit it.
> 
> Didn't immediately hit anything locally in a vm either...
> 
> 
> > Sounds like Andres is already bisecting this, so I guess we'll be wiser
> > soon enough.
> 
> I started bisecting the network issue, as it occurred first, and who knows
> what else it could affect. Will bisect the other range after.
> 
> Due to the serial console issue mentioned upthread it's pretty slow
> going. Each iteration I create a new gcp snapshot and vm. Adds like ~10min.
> Doesn't help if intermediary steps don't boot with different symptoms and
> another doesn't immediately build...

Just so we can stop pestering everyone, could you try

git revert --no-edit 0b6fd46ec5f5..a335b33f4f35 ?

Equivalently I pushed it here:

https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git test

-- 
MST

