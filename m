Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B7D592BD6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241553AbiHOI2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbiHOI2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:28:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F9B11F639
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 01:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660552117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lEHWMXFZ2uct4Ktk4KY1ISQiitnDvCq9CZGYvT11o94=;
        b=ToM+WyNED1xHXruOEy9GT37AeCQV7Yme3ZiIbz7dDJ5xgMUQvA7+UkFM1zvDe4Nz8teDGJ
        3YVG5o+R+5boNVTpiNwp/fCQA0ujaPQ+iREOE5dK/mOVISKMYUq58NU9A8K2sRmHXfXFRn
        csAjQLqmpyIZEN2nJIo8TvuuIwtU8MQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-619-zfq21Dw_P-6oy3bysp51dw-1; Mon, 15 Aug 2022 04:28:35 -0400
X-MC-Unique: zfq21Dw_P-6oy3bysp51dw-1
Received: by mail-ej1-f71.google.com with SMTP id ga16-20020a1709070c1000b007331af32d3aso940766ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 01:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=lEHWMXFZ2uct4Ktk4KY1ISQiitnDvCq9CZGYvT11o94=;
        b=SrohP0WFJ7IlQmxaaKYyDhbj1yswBklZjG5etCOZ9Df9NJctaR/hi1GCKrkLgmqrea
         4qbnTyAJqr6TJyTGrmC7xNN97N0TWa14r3T6xttthhyWmCqS05Qwj/hDUA1HO5kqBuld
         QGDUHGHsRtaKZ7SSqX8Mf/HStGm/8YS/Zm9SGgmOBL7HN3ueYXf8knqTVuAgzV1bLAU+
         z5BkAu9oOh3blheOZ6Hn6N5cxUHRbvERbEWOUAwcMf8axdFp1hFtcOGDVb+ttE184mIJ
         /+dTm+5gmnmxlrW2hGuiGeIo2dT3VMBavKZzK8+ifZ5VrjGwGSLl3atNdKJvjaOiCqcj
         c3sw==
X-Gm-Message-State: ACgBeo0XsibVPtQDPBGjFrre03GDZyJMNnR/aBw2fOfXPyxEZhGs3mZF
        cDLktAQiJ876KApPlRaf+V/XMS5rdr71PnkCLfGUh+pRh4YPPFy1NBm2mx4cyBC+bW6nN7AmSyj
        r34Vd4KttcC9BvhEE8ajl5wuS
X-Received: by 2002:a17:906:5a4f:b0:730:825a:d860 with SMTP id my15-20020a1709065a4f00b00730825ad860mr9738655ejc.143.1660552114219;
        Mon, 15 Aug 2022 01:28:34 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4tAIkoXvkWgmRems/JupsfZUMzrxVWgjeYGv5FVIVL7IdG83ARhP2VC6LbArZAKXBv+CG2fg==
X-Received: by 2002:a17:906:5a4f:b0:730:825a:d860 with SMTP id my15-20020a1709065a4f00b00730825ad860mr9738642ejc.143.1660552114023;
        Mon, 15 Aug 2022 01:28:34 -0700 (PDT)
Received: from redhat.com ([2.54.169.49])
        by smtp.gmail.com with ESMTPSA id n18-20020aa7c452000000b0043ba437fe04sm6236573edr.78.2022.08.15.01.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 01:28:33 -0700 (PDT)
Date:   Mon, 15 Aug 2022 04:28:29 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Andres Freund <andres@anarazel.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: upstream kernel crashes
Message-ID: <20220815042623-mutt-send-email-mst@kernel.org>
References: <20220814212610.GA3690074@roeck-us.net>
 <CAHk-=wgf2EfLHui6A5NbWoaVBB2f8t-XBUiOMkyjN2NU41t6eA@mail.gmail.com>
 <20220814223743.26ebsbnrvrjien4f@awork3.anarazel.de>
 <CAHk-=wi6raoJE-1cyRU0YxJ+9ReO1eXmOAq0FwKAyZS7nhvk9w@mail.gmail.com>
 <1c057afa-92df-ee3c-5978-3731d3db9345@kernel.dk>
 <20220815013651.mrm7qgklk6sgpkbb@awork3.anarazel.de>
 <CAHk-=wikzU4402P-FpJRK_QwfVOS+t-3p1Wx5awGHTvr-s_0Ew@mail.gmail.com>
 <20220815071143.n2t5xsmifnigttq2@awork3.anarazel.de>
 <20220815034532-mutt-send-email-mst@kernel.org>
 <20220815081527.soikyi365azh5qpu@awork3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815081527.soikyi365azh5qpu@awork3.anarazel.de>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 01:15:27AM -0700, Andres Freund wrote:
> Hi,
> 
> On 2022-08-15 03:51:34 -0400, Michael S. Tsirkin wrote:
> > It is possible that GCP gets confused if ring size is smaller than the
> > device maximum simply because no one did it in the past.
> > 
> > So I pushed just the revert of 762faee5a267 to the test branch.
> > Could you give it a spin?
> 
> Seems to fix the issue, at least to the extent I can determine at 1am... :)
> 
> Greetings,
> 
> Andres Freund

So you tested this:

commit 13df5a7eaeb22561d39354b576bc98a7e2c389f9 (HEAD, kernel.org/test)
Author: Michael S. Tsirkin <mst@redhat.com>
Date:   Mon Aug 15 03:44:38 2022 -0400

    Revert "virtio_net: set the default max ring size by find_vqs()"
    
    This reverts commit 762faee5a2678559d3dc09d95f8f2c54cd0466a7.
    
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

and it fixes both issues right? No crashes no networking issue?

Just making sure before I send this upstream as a stop-gap.

We need to figure out what is going on since I think there's a GCP
hypervisor bug that we need to find a way to detect and work around but
that can wait.

-- 
MST

