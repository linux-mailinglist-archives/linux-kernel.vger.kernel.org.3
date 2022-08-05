Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098A758AED3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 19:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241156AbiHER05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 13:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiHER04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:26:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F1F318387
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 10:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659720414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ao0gkuMRfLYr7o7jS1lx9srHmYWP666Jf7PyQa+IiRM=;
        b=UTOEmjyy4wz9LnzMq0WArvoCpIfa2pU3dtBG0KayLX/x99yVn/XvvssnbKpv0G5UzoT2Vq
        BIw39Ov8I8L53VsTASniCaU79jyRtcyb6VIgIM/QTzvLLCi/CtS+uZQFpDlz9UuKHYH9O7
        mKkIpVyp9yyiEgcYg+FtpzIo7puklqM=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-61-moHSVsQlOgqgm1lHGoVWUA-1; Fri, 05 Aug 2022 13:26:53 -0400
X-MC-Unique: moHSVsQlOgqgm1lHGoVWUA-1
Received: by mail-il1-f199.google.com with SMTP id i8-20020a056e020d8800b002d931252904so2050543ilj.23
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 10:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc;
        bh=Ao0gkuMRfLYr7o7jS1lx9srHmYWP666Jf7PyQa+IiRM=;
        b=3CZswTSOR/jPSqHWvhjEi1m9Rky//R7DpH47X1yKJF4RI7kLJU18Hk7BADwbUrRkc7
         HQblG5Sul/hR00Ef9ryWYTBu3KvLhKGtEOmKG2UOaRmQkb+UbGYkX+6MBD0pYzoZMJ3J
         7hL+V5dtiA/h8AvWbwMfoJgizVrCycbGhuCcmGDabCw9gYLRSCXd7CUWaz5vbip80c5t
         qDWM+5p+3IR0QgjOjNBWqQnIJUDdD+u8Jtezod/nRZ+FVfj5Q8S5Pk9yKv7afr6Z1err
         luhybKAATQvxGUBrXztRphovEP5YG/S3P40gHmCbdvGo5/Uo9bFNSiUvCGnQ2t6tGzh+
         sgGA==
X-Gm-Message-State: ACgBeo19zNegrrbUr2MgQQTPc9ez96RcC1z9wxmlm1VUVavSjSikXM4w
        Cm8ll7JXsttkF/mRK0eLWyi5JuokZSWN3cqiZykkiWQdefaowc+FlRlxuzMFzkNkEX7fbGYtE68
        gusDhw0Fwrmk3BhJGy9nbtjo7
X-Received: by 2002:a02:cb11:0:b0:342:9092:f529 with SMTP id j17-20020a02cb11000000b003429092f529mr3468004jap.135.1659720412523;
        Fri, 05 Aug 2022 10:26:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7imir4f1KMO2BHT01KzYt7aLZmkCLQFcKAIujsjO/VpRceEcJxlfKcgWJITRUJJrp3H1EaVA==
X-Received: by 2002:a02:cb11:0:b0:342:9092:f529 with SMTP id j17-20020a02cb11000000b003429092f529mr3467988jap.135.1659720412277;
        Fri, 05 Aug 2022 10:26:52 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id y14-20020a056602164e00b0067bb431f360sm2063532iow.48.2022.08.05.10.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:26:51 -0700 (PDT)
Date:   Fri, 5 Aug 2022 11:26:50 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Arinzon, David" <darinzon@amazon.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Dagan, Noam" <ndagan@amazon.com>,
        "Agroskin, Shay" <shayagr@amazon.com>,
        "Brandes, Shai" <shaibran@amazon.com>,
        "Kiyanovski, Arthur" <akiyano@amazon.com>,
        "mk@semihalf.com" <mk@semihalf.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: vfio/pci - uAPI for WC
Message-ID: <20220805112650.5c13f9a3.alex.williamson@redhat.com>
In-Reply-To: <20220805160545.GA1020364@bhelgaas>
References: <d42f195bffa444719065f4e84098fe0c@EX13D47EUB004.ant.amazon.com>
        <20220805160545.GA1020364@bhelgaas>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2022 11:05:45 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Alex, Cornelia, kvm, lkml (from "get_maintainer.pl drivers/vfio")
> and rewrapped for plain-text readability]
> On Thu, Aug 04, 2022 at 09:47:36AM +0000, Arinzon, David wrote:
> > Hi,
> > 
> > There's currently no mechanism for vfio that exposes WC-related
> > operations (check if memory is WC capable, ask to WC memory) to user
> > space module entities, such as DPDK, for example.
> >
> > This topic has been previously discussed in [1], [2] and [3], but
> > there was no follow-up.
> >
> > This capability is very useful for DPDK, specifically to the DPDK
> > ENA driver that uses vfio-pci, which requires memory to be WC on the
> > TX path. Without WC, higher CPU utilization and performance
> > degradation are observed.
> >
> > In the above mentioned discussions, three options were suggested:
> > sysfs, ioctl, mmap extension (extra attributes).
> > 
> > Was there any progress on this area? Is there someone who's looking
> > into this?

IIRC, much of the discussion was related to VM use cases on ARM and
they may have found alternate ways to do things more like x86.  I'm not
aware of any current development towards a uAPI change to enable this.
Thanks,

Alex

