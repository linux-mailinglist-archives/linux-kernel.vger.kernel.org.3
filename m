Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867304CAA0E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241888AbiCBQXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbiCBQXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:23:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 237803CFDE
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646238175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=319HSMClYmc73i4+9cM7jkH73o3HvmVRZnh4aruHeG8=;
        b=I2ura1F29KRUoiJM93nCh993E8yLOe50pnB/9gzZs+ySRrszUpQusBPP0i8qJMPkl4+hIQ
        AF/t5XdxQCs6ptfeYfQaoMRZj08ZiHO3eXEEBUCWc5BiMdzEJMF++HESNXSoRyp41UJUZd
        lYIKedbnAeKimJI5GuiycJd8ry/tVzo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-W0UEoAYLOLepgP4Y6uOKHA-1; Wed, 02 Mar 2022 11:22:53 -0500
X-MC-Unique: W0UEoAYLOLepgP4Y6uOKHA-1
Received: by mail-wm1-f69.google.com with SMTP id n62-20020a1ca441000000b0038124c99ebcso691803wme.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 08:22:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=319HSMClYmc73i4+9cM7jkH73o3HvmVRZnh4aruHeG8=;
        b=X9pF5YSOP0xjPQJRhJ2XpStu93PaCr483nxJv/JCxA8azVNx4m51iIU47ffhGOnpex
         KyZ5/HfAEZX53WlolIlsfck4QaxhZYfBE41JncIN07DcphMPinjDkk2+iT8FsagsTd72
         sJg7Nqae9e9xzdDcY1Ur1UPkSv0CsJ5h9MbgLe2p0HsM/ucwfFUt9yoWd5I+LpeTQAzG
         fp6OIuHzGCsHLfMwACE5KJrXI2IdoEdyQF241R5mASE+9/jnXrNy34w9wXjevHc0G802
         DjD+6pwDpIU7M/JCwMitTQ5GPz6sQ3hCvf9SsItICpYPi6P7/ASgpWTu1szu8k1S6HUU
         qA6w==
X-Gm-Message-State: AOAM532qWYnb+/kBDeptV2BAFQ7jX8umGAfuFsaC5fyPwuRDEjuJiOIt
        6A8+2xNM3PCaXM5tmGUJLfCWdfTWpLRJD1rWXx0iCXsI4XlP3LUZYTPZfnj74OHBb49ugJuft9w
        i20WyTTcc/Ju/wj4AlSQtpvV6
X-Received: by 2002:a05:600c:378b:b0:381:67e7:e20c with SMTP id o11-20020a05600c378b00b0038167e7e20cmr479497wmr.32.1646238171014;
        Wed, 02 Mar 2022 08:22:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzS+hgEnn1ZApPqccdMegoD/Y1rBIvh8rKEfDBm0b4Su6FFtEq0p31uoeFi3LW+QoZEiPhhcg==
X-Received: by 2002:a05:600c:378b:b0:381:67e7:e20c with SMTP id o11-20020a05600c378b00b0038167e7e20cmr479479wmr.32.1646238170768;
        Wed, 02 Mar 2022 08:22:50 -0800 (PST)
Received: from redhat.com ([2a10:8006:355c:0:48d6:b937:2fb9:b7de])
        by smtp.gmail.com with ESMTPSA id t14-20020a5d49ce000000b001f036a29f42sm2040814wrs.116.2022.03.02.08.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 08:22:50 -0800 (PST)
Date:   Wed, 2 Mar 2022 11:22:46 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Laszlo Ersek <lersek@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        linux-hyperv@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        adrian@parity.io,
        Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: propagating vmgenid outward and upward
Message-ID: <20220302111737-mutt-send-email-mst@kernel.org>
References: <20220301121419-mutt-send-email-mst@kernel.org>
 <CAHmME9qieLUDVoPYZPo=N8NCL1T-RzQ4p7kCFv3PKFUkhWZPsw@mail.gmail.com>
 <20220302031738-mutt-send-email-mst@kernel.org>
 <CAHmME9pf-bjnZuweoLqoFEmPy1OK7ogEgGEAva1T8uVTufhCuw@mail.gmail.com>
 <20220302074503-mutt-send-email-mst@kernel.org>
 <Yh93UZMQSYCe2LQ7@zx2c4.com>
 <20220302092149-mutt-send-email-mst@kernel.org>
 <CAHmME9rf7hQP78kReP2diWNeX=obPem=f8R-dC7Wkpic2xmffg@mail.gmail.com>
 <20220302101602-mutt-send-email-mst@kernel.org>
 <Yh+PET49oHNpxn+H@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh+PET49oHNpxn+H@zx2c4.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 04:36:49PM +0100, Jason A. Donenfeld wrote:
> Hi Michael,
> 
> On Wed, Mar 02, 2022 at 10:20:25AM -0500, Michael S. Tsirkin wrote:
> > So writing some code:
> > 
> > 1:
> > 	put plaintext in a buffer
> > 	put a key in a buffer
> > 	put the nonce for that encryption in a buffer
> > 
> > 	if vm gen id != stored vm gen id
> > 		stored vm gen id = vm gen id
> > 		goto 1
> > 
> > I think this is race free, but I don't see why does it matter whether we
> > read gen id atomically or not.
> 
> Because that 16 byte read of vmgenid is not atomic. Let's say you read
> the first 8 bytes, and then the VM is forked.

But at this point when VM was forked plaintext key and nonce are all in
buffer, and you previously indicated a fork at this point is harmless.
You wrote "If it changes _after_ that point of check ... it doesn't
matter:"

> In the forked VM, the next
> 8 bytes are the same as last time, but the first 8 bytes, which you
> already read, have changed. In that case, your != becomes a ==, and the
> test fails.

Yes I'm aware what an atomic read is. If the read is not atomic
a part of value can change ;)

-- 
MST

