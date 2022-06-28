Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659D655C6C9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343586AbiF1Gox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 02:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244229AbiF1Gou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:44:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3315913DD7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 23:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656398688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hKKhmAVY6ZLU32yFo246MjjcA6QB3q+Asrc/tb9AagA=;
        b=FWCGJqg5msDnwZD0HXb37xFn4rZJnRa1NBrjulXChbQpXZ0+RvnfXDUaROncqdfjI8bReT
        8ePxKVow7na5aCdCDIWjgSqN/n6Gs4um23RAjAjYlztefRXrvcc5k+EE1UQMvfUPuaG4t9
        +SnZukzymjNxBQirLKq8bwd38Ecq2K4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-ldUPbCPaPCaoXFv45YVfig-1; Tue, 28 Jun 2022 02:44:46 -0400
X-MC-Unique: ldUPbCPaPCaoXFv45YVfig-1
Received: by mail-wr1-f71.google.com with SMTP id az28-20020adfe19c000000b0021bc8df3721so825707wrb.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 23:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hKKhmAVY6ZLU32yFo246MjjcA6QB3q+Asrc/tb9AagA=;
        b=RUJGrmIfx/BuOwVwmAX7+PEGPk7WGJgmzRLg9DGtLPhe33pYfsu6vTQcMbsMHLQAgq
         OE+sLD83W+MkPs2snO1HL1dxtONUXERmSxQbjKy4QYGLSHvq1ZZaVKVsaksgxXID9ZQF
         QuKkYoaUgppOheISG3PtJo/aLv/ahGc3ledfJg43zZMpVbWj5oqZsYxXOfUw826DvvZa
         711hZWBLFjbrk0xNdfeg8M8WKYXl4o+Kt2QeXhmYgxVWlMUb13WaS/oDeYrDOR9i3Vte
         zayJnQoiZBZc4KruRQawU7/lfsoHT8c+6JXUOddCZAiuA9bT1hihN/+oBK9oW6Sb1ECA
         ghTg==
X-Gm-Message-State: AJIora/xEGGvoZ+JX1YQUpWHSA6AgqL4MS76Yq4w3qee3qIl/L/G/zMi
        kAHAKFFy/lIvJJWrGZu+HlUhUvWD0cAdJ0mcPoTgMK9dvPc1mOYhyawZDZ5QVN9Fh1VHy9DNCvr
        EVZ3dW5BBAPMPqGdJ9fAdBzk8
X-Received: by 2002:a05:600c:4e90:b0:39c:7ec6:c7d2 with SMTP id f16-20020a05600c4e9000b0039c7ec6c7d2mr19756873wmq.140.1656398685546;
        Mon, 27 Jun 2022 23:44:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uIze8DJsIvzB3CNFTFD7nxCkijrxeoiA7/FaJ3ir6OLO+Z+2vAtNLsCgnTCLoOO1PL/wj22A==
X-Received: by 2002:a05:600c:4e90:b0:39c:7ec6:c7d2 with SMTP id f16-20020a05600c4e9000b0039c7ec6c7d2mr19756849wmq.140.1656398685292;
        Mon, 27 Jun 2022 23:44:45 -0700 (PDT)
Received: from redhat.com ([2.52.23.204])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c1d0f00b003a04962ad3esm9243219wms.31.2022.06.27.23.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 23:44:44 -0700 (PDT)
Date:   Tue, 28 Jun 2022 02:44:40 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        kvm <kvm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V3] virtio: disable notification hardening by default
Message-ID: <20220628023832-mutt-send-email-mst@kernel.org>
References: <20220624022622-mutt-send-email-mst@kernel.org>
 <CACGkMEuurobpUWmDL8zmZ6T6Ygc0OEMx6vx2EDCSoGNnZQ0r-w@mail.gmail.com>
 <20220627024049-mutt-send-email-mst@kernel.org>
 <CACGkMEvrDXDN7FH1vKoYCob2rkxUsctE_=g61kzHSZ8tNNr6vA@mail.gmail.com>
 <20220627053820-mutt-send-email-mst@kernel.org>
 <CACGkMEvcs+9_SHmO1s3nyzgU7oq7jhU2gircVVR3KDsGDikh5Q@mail.gmail.com>
 <20220628004614-mutt-send-email-mst@kernel.org>
 <CACGkMEsC4A+3WejLSOZoH3enXtai=+JyRNbxcpzK4vODYzhaFw@mail.gmail.com>
 <20220628022035-mutt-send-email-mst@kernel.org>
 <CACGkMEt=go5qAH+P0to6yyE2dPhyfFmOQP0jfuj=57PmD7Y3zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEt=go5qAH+P0to6yyE2dPhyfFmOQP0jfuj=57PmD7Y3zg@mail.gmail.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 02:32:19PM +0800, Jason Wang wrote:
> > Question is are there drivers which kick before they are ready
> > to handle callbacks?
> 
> Let me try to have a look at all the drivers to answer this.

One thing to note is that I consider hardening probe and
hardening remove separate features. I think that at this point
for secured guests it is prudent to outright block device
removal - we have been finding races in removal for years.
Note sure there's a flag for that but it's probably not too hard to add
e.g. to pci core.

-- 
MST

