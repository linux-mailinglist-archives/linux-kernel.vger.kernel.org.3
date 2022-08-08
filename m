Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AFB58D003
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 00:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243749AbiHHWIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 18:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiHHWII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 18:08:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A96841BE96
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 15:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659996485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YQ8C+2+wwMYd+/eKAYReWcvetA2Bfz8WaHNNc7Hh+0s=;
        b=DjCyqooCJNSaq59LMZOLcWv7iYqu10Ngmfp4vTusB4cHVkhNWJGNsESssTr1/kt2W1Eduh
        QvFKhr8qy5O+Rp4cDuXVYQuFaQAVeA73Iv06q7ZJHXiFgTZtKwqD1g+K6ENCq86fSKF6Wz
        jQakLp8DDt/6sFCjQw1gyEaLwF+0OkA=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-2bE1osVrMvGt5R7x94FZxg-1; Mon, 08 Aug 2022 18:08:04 -0400
X-MC-Unique: 2bE1osVrMvGt5R7x94FZxg-1
Received: by mail-io1-f70.google.com with SMTP id u5-20020a6b4905000000b00681e48dbd92so5377367iob.21
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 15:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=YQ8C+2+wwMYd+/eKAYReWcvetA2Bfz8WaHNNc7Hh+0s=;
        b=RbwSXRfinNTTDmu1dx7Er/2Qn6JjJU4+99b32n65EX6Rp0t28C4ah+pl5GgHjUOmy5
         sLFXSklUrrS7e6sO04Bt+QZnEKqegp6M+khJ2om4ywBT6xZF1Mm/3ndFS7RDS3hDPZSv
         7ZYB65by12GUE+l+EzzvlubtCz7Z8j3ZPhKShYad6z/T5bGSlHGJUlGettOV/BwYz3fH
         l2ejzopX5wjyVME6o3H+ahb3UwPj4dLcC7rnV/EoOg8WHWrO1BdENWubp2rvL2Ef+7qx
         4o/vsS5uNUAQYShdwRrADOafw/fGl0BS1HEdeWFrxRsIn/1b9kdZrwN0FJa3AiwVCad2
         T8mQ==
X-Gm-Message-State: ACgBeo3o64v4aS8u5sDuk1QjKxbzwg+rxNLALWnhgmSzlY8Br2Ecylhx
        lmkw7ekd3F8z3sfCUcBLkJbXdZArOAhKkeP2xHdwN7BkLCSOONJWz1tMgA15zkMN4B3tYhcMrjE
        93J+hm/DsQR/3rWv22bhhuI2L
X-Received: by 2002:a05:6e02:1a48:b0:2df:443:fe1a with SMTP id u8-20020a056e021a4800b002df0443fe1amr9574489ilv.264.1659996483557;
        Mon, 08 Aug 2022 15:08:03 -0700 (PDT)
X-Google-Smtp-Source: AA6agR64i2ipjaPkYMQxVPXhZdL8CBTayyhbEDdMwRIlK9Eub6ZsTD+NjpQc4gAj2TlnDMeELRQDdw==
X-Received: by 2002:a05:6e02:1a48:b0:2df:443:fe1a with SMTP id u8-20020a056e021a4800b002df0443fe1amr9574484ilv.264.1659996483371;
        Mon, 08 Aug 2022 15:08:03 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id f17-20020a926a11000000b002df4dccf449sm321285ilc.64.2022.08.08.15.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 15:08:02 -0700 (PDT)
Date:   Mon, 8 Aug 2022 18:08:01 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Feiner <pfeiner@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v1 2/2] mm/hugetlb: support write-faults in shared
 mappings
Message-ID: <YvGJQaYeT9Y8PlDX@xz-m1.local>
References: <20220805110329.80540-1-david@redhat.com>
 <20220805110329.80540-3-david@redhat.com>
 <Yu1dkZeBwv0SUQMq@xz-m1.local>
 <4f644ac5-c40b-32d4-3234-c1dac3d09f83@redhat.com>
 <YvE0OwsyQEL3K5Hm@xz-m1.local>
 <8b317ac7-f80e-4aab-4ad1-4e19a1a0740f@redhat.com>
 <YvFwU4e3WOSRseh6@xz-m1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvFwU4e3WOSRseh6@xz-m1.local>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 04:21:39PM -0400, Peter Xu wrote:
> On Mon, Aug 08, 2022 at 06:25:21PM +0200, David Hildenbrand wrote:
> > >> Relying on VM_SHARED to detect MAP_PRIVATE vs. MAP_SHARED is
> > >> unfortunately wrong.
> > >>
> > >> If you're curious, take a look at f83a275dbc5c ("mm: account for
> > >> MAP_SHARED mappings using VM_MAYSHARE and not VM_SHARED in hugetlbfs")
> > >> and mmap() code.
> > >>
> > >> Long story short: if the file is read-only, we only have VM_MAYSHARE but
> > >> not VM_SHARED (and consequently also not VM_MAYWRITE).
> > > 
> > > To ask in another way: if file is RO but mapped RW (mmap() will have
> > > VM_SHARED cleared but VM_MAYSHARE set), then if we check VM_MAYSHARE here
> > > won't we grant write bit errornously while we shouldn't? As the user
> > > doesn't really have write permission to the file.
> > 
> > Thus the VM_WRITE check. :)
> > 
> > I wonder if we should just do it cleanly and introduce the maybe_mkwrite
> > semantics here as well. Then there is no need for additional VM_WRITE
> > checks and hugetlb will work just like !hugetlb.
> 
> Hmm yeah I think the VM_MAYSHARE check is correct, since we'll need to fail
> the cases where MAYSHARE && !SHARE - we used to silently let it pass.

Sorry I think this is a wrong statement I made..  IIUC we'll fail correctly
with/without the patch on any write to hugetlb RO regions.

Then I just don't see a difference on checking VM_SHARED or VM_MAYSHARE
here, it's just that VM_MAYSHARE check should work too like VM_SHARED so I
don't see a problem.

It also means I can't think of any valid case of having VM_WRITE when
reaching here, then the WARN_ON_ONCE() is okay but maybe also redundant.
Using maybe_mkwrite() seems misleading to me if FOLL_FORCE not ready for
hugetlbfs after all.

-- 
Peter Xu

