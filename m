Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101085AFFC3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiIGJAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIGJA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:00:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8ED6D9D1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 02:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662541225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wAp9Zrtj3C+q+e8Cw9C0lVMs/In1/6qMij53jvIUwa8=;
        b=hMRYsSzXhj/N2FO5dJE7jz5qKOimAUjxMJ67Sl5SeBmMcZb3CpLqgAidibxdcWEaqOif5b
        5PHxgAmZv4qtCC56uNa+6caBIpKNzmJep+4Q29SbgBUZwy0bwLYmCdhYtSZeP+c9phrRpS
        ZeZPCiKfH14g5KiVnU5o1QIbC7t97sE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-441-HmNdlo5vMCyBvYmR_VG_XA-1; Wed, 07 Sep 2022 05:00:24 -0400
X-MC-Unique: HmNdlo5vMCyBvYmR_VG_XA-1
Received: by mail-wm1-f70.google.com with SMTP id m22-20020a7bca56000000b003a652939bd1so2355206wml.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 02:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=wAp9Zrtj3C+q+e8Cw9C0lVMs/In1/6qMij53jvIUwa8=;
        b=dwc5f5MpynyXmPZCfZfITaSJWmAhQ9c3tTmIU+3VgKagk7ojNmKbzidjhFrg2gfnP5
         MEgEuk5bjfC/EB/24iyw+cfYOc0zkXEPgKDZqYXvpMJiLM6v7mKIVz8VrtVVADyxpDVw
         Zi5WMnRZ39DTIKd1GNDS0yHcyJoVOUTgIKm3ocwqa2Y59Cs7f0XaTHUqSZi/xtnVOY6Y
         kXCbDrBZrM3V0ahHjKUH0RfsKMr+K4WHXyQYg6NjkJL4peUk8rd9MeHaB88WdUFZaX8U
         FgZ9zERpgtyJSLfCxwnYOseRBPEG5OHNQrW42QxHIOnC7sebmSwT4p5XMnkYak+FX+32
         ZJew==
X-Gm-Message-State: ACgBeo1ggPqNJA4Z0ncFkabv/GGC3b0p0U8dv76kRGAjaxP2j8CndIwK
        YP1JRS77WccOE+uLZRGirMSmiPAnKmLXqUGJ/Byukora7yMPbJo6RRz+Dy3v+SDb1H1XtmmI+1L
        CrntLg6J32AY+ARnIkQNzr1pE
X-Received: by 2002:a05:6000:186f:b0:228:e1ab:673 with SMTP id d15-20020a056000186f00b00228e1ab0673mr1186801wri.324.1662541222913;
        Wed, 07 Sep 2022 02:00:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6dfkdI1JyDQpeuz0ufGUcxELkr0R/MjUIxyjerN/R+v+eB/JC8G8PfsVAjm2diZCZyXKbxPQ==
X-Received: by 2002:a05:6000:186f:b0:228:e1ab:673 with SMTP id d15-20020a056000186f00b00228e1ab0673mr1186785wri.324.1662541222653;
        Wed, 07 Sep 2022 02:00:22 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0? (p200300d82f0dba00c95131d7b2b08ba0.dip0.t-ipconnect.de. [2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c358700b003a8418ee646sm27197500wmq.12.2022.09.07.02.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 02:00:22 -0700 (PDT)
Message-ID: <b365f30b-da58-39c0-08e9-c622cc506afa@redhat.com>
Date:   Wed, 7 Sep 2022 11:00:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lpivarc@redhat.com" <lpivarc@redhat.com>,
        "Liu, Jingqi" <jingqi.liu@intel.com>,
        "Lu, Baolu" <baolu.lu@intel.com>
References: <166182871735.3518559.8884121293045337358.stgit@omen>
 <BN9PR11MB527655973E2603E73F280DF48C7A9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d71160d1-5a41-eae0-6405-898fe0a28696@redhat.com> <YxfX+kpajVY4vWTL@ziepe.ca>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] vfio/type1: Unpin zero pages
In-Reply-To: <YxfX+kpajVY4vWTL@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.09.22 01:30, Jason Gunthorpe wrote:
> On Fri, Sep 02, 2022 at 10:32:01AM +0200, David Hildenbrand wrote:
> 
>>> So I wonder instead of continuing to fix trickiness around the zero
>>> page whether it is a better idea to pursue allocating a normal
>>> page from the beginning for pinned RO mappings?
>>
>> That's precisely what I am working. For example, that's required to get
>> rid of FOLL_FORCE|FOLL_WRITE for taking a R/O pin as done by RDMA:
> 
> And all these issues are exactly why RDMA uses FOLL_FORCE and it is,
> IMHO, a simple bug that VFIO does not.

I consider the BUG that our longterm page pinning behaves the way it 
currently does, not that we're not using the FOLL_FORCE flag here.

But it doesn't matter, I'm working on fixing/cleaning it up.

> 
>> I do wonder if that's a real issue, though. One approach would be to
>> warn the VFIO users and allow for slightly exceeding the MEMLOCK limit
>> for a while. Of course, that only works if we assume that such pinned
>> zeropages are only extremely rarely longterm-pinned for a single VM
>> instance by VFIO.
> 
> I'm confused, doesn't vfio increment the memlock for every page of VA
> it pins? Why would it matter if the page was COW'd or not? It is
> already accounted for today as though it was a unique page.
> 
> IOW if we add FOLL_FORCE it won't change the value of the memlock.

I only briefly skimmed over the code Alex might be able to provide more 
details and correct me if I'm wrong:

vfio_pin_pages_remote() contains a comment:

"Reserved pages aren't counted against the user, externally pinned pages 
are already counted against the user."

is_invalid_reserved_pfn() should return "true" for the shared zeropage 
and prevent us from accounting it via vfio_lock_acct(). Otherwise, 
vfio_find_vpfn() seems to be in place to avoid double-accounting pages.

-- 
Thanks,

David / dhildenb

