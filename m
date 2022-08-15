Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9645A5951A8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 07:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiHPFG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 01:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbiHPFFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 01:05:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C86DD345A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660597457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WXAjcjO7a1Xec1M0FgrBvJ/DZYv1/GC3KzW8DO8JMZQ=;
        b=icn7rHQMA3BITS07SDAs22l4THmeLup1KxR7BIcoHwhKm33zObXK6O7NxEfJ2tkR1+pDfg
        gaeRVpGgfB2CWDho1dRZjWGEwrjsEiY4ZuavXpxylKLdkrVQ7ca3VFmXuV4TOCnoB3wGLS
        0/pG035vWPZv/pTOg+g87oqkdpSNKL8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-159-t8yYd9rDNGu8Ku6scnnluA-1; Mon, 15 Aug 2022 17:04:16 -0400
X-MC-Unique: t8yYd9rDNGu8Ku6scnnluA-1
Received: by mail-wm1-f70.google.com with SMTP id v64-20020a1cac43000000b003a4bea31b4dso9186970wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=WXAjcjO7a1Xec1M0FgrBvJ/DZYv1/GC3KzW8DO8JMZQ=;
        b=7b9MHjJITc2sEN7lIHPuZl6fx9+7p3cV8/ICLwW4DCiLcGdEG1lxCO5vxmbbIwZIez
         u/VMwVxOPC6C7RwsB6Jq3X8bcw5TApOZpXPIE14TYTd9jiv4MuMgu5ccci1ZwFYj8P2c
         6N08/+DQBZYxROf9RmS/Y0WFr5g2FUoBfMXpUENMnrI7VCssnLjT8Q30KtieNr9x5vI2
         N3iDB21DZB/NAEnbYOLrgyRFohcZD4ix50g+Vh+LGT/XLOSqxue7V9p5SdBGk5AQrtSn
         J7+c71PGZ2vpAcpAG8Et4ctTXiGPSLjwZ/NOgxW73aKlWIx3hrhbTxpfs/TKNB7kcTHn
         NMTg==
X-Gm-Message-State: ACgBeo2isaFqtLwLCFR9X9zEuNgV4nWah5IbM3zvNTMDZ48VC0BjLNxe
        bgJ1YnyGXz3m2hcfiIIoB/OrIbqDOR4OVTHhRNAy4zWV1dQmjzrKfp2MckNRY+r1sc29XWxL5p4
        eRZEcF4Xn7xXLoIIw6B5fqHDt
X-Received: by 2002:a5d:6b12:0:b0:21f:1568:c7e1 with SMTP id v18-20020a5d6b12000000b0021f1568c7e1mr9679667wrw.532.1660597455258;
        Mon, 15 Aug 2022 14:04:15 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7Gmr8llRM16MIbIkEtv0F723o5Cn9itzZIe2uXIUI1CVZP1QlRvrTBQuLdNU9JyUxOsISU1g==
X-Received: by 2002:a5d:6b12:0:b0:21f:1568:c7e1 with SMTP id v18-20020a5d6b12000000b0021f1568c7e1mr9679646wrw.532.1660597455016;
        Mon, 15 Aug 2022 14:04:15 -0700 (PDT)
Received: from redhat.com ([2.55.43.215])
        by smtp.gmail.com with ESMTPSA id t18-20020a5d42d2000000b0021f15514e7fsm10719060wrr.0.2022.08.15.14.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 14:04:14 -0700 (PDT)
Date:   Mon, 15 Aug 2022 17:04:10 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>, c@redhat.com
Subject: Re: [PATCH] virtio_net: Revert "virtio_net: set the default max ring
 size by find_vqs()"
Message-ID: <20220815165608-mutt-send-email-mst@kernel.org>
References: <20220815090521.127607-1-mst@redhat.com>
 <20220815203426.GA509309@roeck-us.net>
 <20220815164013-mutt-send-email-mst@kernel.org>
 <20220815205053.GD509309@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815205053.GD509309@roeck-us.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 01:50:53PM -0700, Guenter Roeck wrote:
> On Mon, Aug 15, 2022 at 04:42:51PM -0400, Michael S. Tsirkin wrote:
> > On Mon, Aug 15, 2022 at 01:34:26PM -0700, Guenter Roeck wrote:
> > > On Mon, Aug 15, 2022 at 05:16:50AM -0400, Michael S. Tsirkin wrote:
> > > > This reverts commit 762faee5a2678559d3dc09d95f8f2c54cd0466a7.
> > > > 
> > > > This has been reported to trip up guests on GCP (Google Cloud).  Why is
> > > > not yet clear - to be debugged, but the patch itself has several other
> > > > issues:
> > > > 
> > > > - It treats unknown speed as < 10G
> > > > - It leaves userspace no way to find out the ring size set by hypervisor
> > > > - It tests speed when link is down
> > > > - It ignores the virtio spec advice:
> > > >         Both \field{speed} and \field{duplex} can change, thus the driver
> > > >         is expected to re-read these values after receiving a
> > > >         configuration change notification.
> > > > - It is not clear the performance impact has been tested properly
> > > > 
> > > > Revert the patch for now.
> > > > 
> > > > Link: https://lore.kernel.org/r/20220814212610.GA3690074%40roeck-us.net
> > > > Link: https://lore.kernel.org/r/20220815070203.plwjx7b3cyugpdt7%40awork3.anarazel.de
> > > > Link: https://lore.kernel.org/r/3df6bb82-1951-455d-a768-e9e1513eb667%40www.fastmail.com
> > > > Link: https://lore.kernel.org/r/FCDC5DDE-3CDD-4B8A-916F-CA7D87B547CE%40anarazel.de
> > > > Fixes: 762faee5a267 ("virtio_net: set the default max ring size by find_vqs()")
> > > > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > Cc: Jason Wang <jasowang@redhat.com>
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > Tested-by: Andres Freund <andres@anarazel.de>
> > > 
> > > I ran this patch through a total of 14 syskaller tests, 2 test runs each on
> > > 7 different crashes reported by syzkaller (as reported to the linux-kernel
> > > mailing list). No problems were reported. I also ran a single cross-check
> > > with one of the syzkaller runs on top of v6.0-rc1, without this patch.
> > > That test run failed.
> > > 
> > > Overall, I think we can call this fixed.
> > > 
> > > Guenter
> > 
> > It's more of a work around though since we don't yet have the root
> > cause for this. I suspect a GCP hypervisor bug at the moment.
> > This is excercising a path we previously only took on GFP_KERNEL
> > allocation failures during probe, I don't think that happens a lot.
> >
> 
> Even a hypervisor bug should not trigger crashes like this one,
> though, or at least I think so. Any idea what to look for on the
> hypervisor side, and/or what it might be doing wrong ?
> 
> Thanks,
> Guenter

Sure!
So virtio has a queue_size register. When read, it will give you
originally the maximum queue size. Normally we just read it and
use it as queue size.

However, when queue memory allocation fails, and unconditionally with a
network device with the problematic patch, driver is asking the
hypervisor to make the ring smaller by writing a smaller value into this
register.

I suspect that what happens is hypervisor still uses the original value
somewhere. Then it things the ring is bigger than what driver allocated.
If we get lucky and nothing important landed in the several pages
covered by the larger ting, then the only effect is that driver does not
see the data hypervisor writes in the ring, and this is the network
failures observed - most likely DHCP responses get lost and
guest never gets an IP. OTOH if something important lands there then when
hypervisor overwrites that memory it gets corrupted and we get crashes.


-- 
MST

