Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F60D5A6565
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiH3Nrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiH3Nra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:47:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E8B11F196
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 06:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661867105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4TQ3D3Ecv0JVJq75Mysm7I94dQGdbTCqUokREWAuRr0=;
        b=Y8Qmr3S67X+C9PLGjR+4v2mSjj/N0mZN3QYNGJp6hT8eYQ43ZSY/J/agbSqNNwi4IYcrtF
        q7COhyLZ6SRwgAkWzf2QyynJtMiCO+IYSttgK8yHkTZGa7WtsRW5WDMfxxC1sF/h9BL/Vx
        qDKmCn2TCtBJr/lz3L1v+VhRcNSkQA8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-642-bQCEdZb6My-jrIRxhp9Iog-1; Tue, 30 Aug 2022 09:45:04 -0400
X-MC-Unique: bQCEdZb6My-jrIRxhp9Iog-1
Received: by mail-wr1-f71.google.com with SMTP id c25-20020adfa319000000b00226d3f6d28cso1313328wrb.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 06:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=4TQ3D3Ecv0JVJq75Mysm7I94dQGdbTCqUokREWAuRr0=;
        b=y8bb20CPGR2zIfINipXYirQVCNrly6rv7CmHrJPRcH1K6mSO5LW0XCp39XeO+lBPxq
         1RiOSmTEDOTTO6/cFVod0lybKek/19daNXOGIDJREqSdEd4/ZA9HUoC7Nwt1qbV2f/ck
         TdStm4bpqec/8ViAODQ5ohUjUb9LQUg7bA3kkrJuQABzOLo/P4c3H+O1MoI2Sf34Ab5c
         xhzY1cNNy5hzf14aMPaARiqmSbWwwUpHSW8Qi36UXd00JQOS6SVEBiVoKeLfcN+SEY57
         DBSKRxDPXMsRXQ5OzwSTpXCOFT1wKWoTj3uujfFOrwPyXFJDL5C/PR7phcrn9jGjBEHF
         hQeg==
X-Gm-Message-State: ACgBeo1XYYHTekGheObVISULluqfN33KsB3KXkjYjYp3QjX6qIVUpVnY
        yfHzmglrcA/DWRrujKmFpRl+Qlinr+LtY/MnBP1UzcTk9HZC7wDeKzdmBURsSyOGskhxdZSdR1f
        WNldQe7Wh3Gbmp1wsVRqJExcO
X-Received: by 2002:a05:600c:ace:b0:3a5:b495:854d with SMTP id c14-20020a05600c0ace00b003a5b495854dmr9620571wmr.86.1661867102645;
        Tue, 30 Aug 2022 06:45:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7kE0OkvnuES7vDthBiH8iXuZiew08diUgUfwuPstZZgb2cSBtaApqD4FeCYJF2b3SOm8jHEg==
X-Received: by 2002:a05:600c:ace:b0:3a5:b495:854d with SMTP id c14-20020a05600c0ace00b003a5b495854dmr9620557wmr.86.1661867102326;
        Tue, 30 Aug 2022 06:45:02 -0700 (PDT)
Received: from redhat.com ([2.55.191.225])
        by smtp.gmail.com with ESMTPSA id r8-20020a5d6948000000b00226a5187528sm9535421wrw.48.2022.08.30.06.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 06:45:01 -0700 (PDT)
Date:   Tue, 30 Aug 2022 09:44:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Igor Skalkin <igor.skalkin@opensynergy.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        mgo@opensynergy.com
Subject: Re: [PATCH] virtio_bt: Fix alignment in configuration struct
Message-ID: <20220830094441-mutt-send-email-mst@kernel.org>
References: <20220807221152.38948-1-Igor.Skalkin@opensynergy.com>
 <20220807185846-mutt-send-email-mst@kernel.org>
 <02222fcb-eaba-617a-c51c-f939678e3d74@opensynergy.com>
 <20220808081054-mutt-send-email-mst@kernel.org>
 <20220811035817-mutt-send-email-mst@kernel.org>
 <CABBYNZKZGxbt=jdpBL77x1mCeTPdDE-p-Pt8JjZN+KoRgR3Ohw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABBYNZKZGxbt=jdpBL77x1mCeTPdDE-p-Pt8JjZN+KoRgR3Ohw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 10:02:31AM -0700, Luiz Augusto von Dentz wrote:
> Hi Michael,
> 
> On Thu, Aug 11, 2022 at 1:00 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Aug 08, 2022 at 08:16:11AM -0400, Michael S. Tsirkin wrote:
> > > On Mon, Aug 08, 2022 at 02:04:43PM +0200, Igor Skalkin wrote:
> > > > On 8/8/22 01:00, Michael S. Tsirkin wrote:
> > > >
> > > >     On Mon, Aug 08, 2022 at 12:11:52AM +0200, Igor Skalkin wrote:
> > > >
> > > >         According to specification [1], "For the device-specific configuration
> > > >         space, the driver MUST use 8 bit wide accesses for 8 bit wide fields,
> > > >         16 bit wide and aligned accesses for 16 bit wide fields and 32 bit wide
> > > >         and aligned accesses for 32 and 64 bit wide fields.".
> > > >
> > > >         Current version of the configuration structure:
> > > >
> > > >             struct virtio_bt_config {
> > > >                 __u8  type;
> > > >                 __u16 vendor;
> > > >                 __u16 msft_opcode;
> > > >             } __attribute__((packed));
> > > >
> > > >         has both 16bit fields non-aligned.
> > > >
> > > >         This commit fixes it.
> > > >
> > > >         [1] https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fdocs.oasis%2dopen.org%2fvirtio%2fvirtio%2fv1.1%2fvirtio%2dv1.1.pdf&umid=d1786ace-e8ea-40e8-9665-96c0949174e5&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-39b15885ceebe9fda9357320aec1ccbac416a470
> > > >
> > > >         Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
> > > >
> > > >     This is all true enough, but the problem is
> > > >     1. changing uapi like this can't be done, will break userspace
> > > >     2. the driver has more issues and no one seems to want to
> > > >        maintain it.
> > > >     I posted a patch "Bluetooth: virtio_bt: mark broken" and intend
> > > >     to merge it for this release.
> > > >
> > > > This is very sad. We already use this driver in our projects.
> > >
> > > Really?  Can you step up to maintain it? Then we can fix the issues
> > > and it won't be broken.
> >
> > Just a reminder that I'm waiting for a response on that.
> > I just don't know enough about bluetooth.
> 
> Just a heads up that Marcel is on vacation, he did mention that he had
> done some work to update virtio_bt thus why I didn't apply any of the
> changes yet.

Any update? when does Marcel return?

> > --
> > MST
> >
> 
> 
> -- 
> Luiz Augusto von Dentz

