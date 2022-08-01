Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B5D586D77
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbiHAPN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiHAPNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:13:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 245022A400
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659366802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nsD/rgTzse5a0ywH6Izn9rMfo/95Q7JbCqp8jKzGMjM=;
        b=Z2MRSpMtJ7EooOFl/w/Z8argW0SDP9SNMMgtwaP/qyuhe+7+ZJDD2PiK7g9+XknhDEpt3U
        O/Aqxl+ywrWp/bnUsg/kjWLi1c1/VVAkyss9ZXY2rEPrdiQc5ckX57Pl3z+kXUvT84sXGu
        pubr9VFEg5qoCwz0s5Jlt2qNSKWTkks=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-IHqgHv2tMjKnnn8FzqIwuw-1; Mon, 01 Aug 2022 11:13:20 -0400
X-MC-Unique: IHqgHv2tMjKnnn8FzqIwuw-1
Received: by mail-wm1-f70.google.com with SMTP id v64-20020a1cac43000000b003a4bea31b4dso3345919wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 08:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=nsD/rgTzse5a0ywH6Izn9rMfo/95Q7JbCqp8jKzGMjM=;
        b=7TnFevGeijhibSBkqDI4O4uRkv3zs6CZynD0nGQl6gfEWjRPa//ZVOoSC+Q16CB0O+
         IViW1tYtiyrZBzDEkKvXgG5MbvGsu03a6tQAhnJehkexY7BluNqw6ak3fJ47iMNwBIze
         9dsVqdLH77k6ENmJTiu5M3k0fj21yXkGjvlltcgngiE0q+HwkGYrAkVHoWAZjBfr1M3j
         XyKRVzrh7uWWcUkLBJaaDzm1bxFXsGMoRgzsC9e89kBGf9QsWwC8y1MncmTLf/0hO378
         MaY4AXgNnF6JXmMaHSpRqYlVN0J27mlwtG7ufCWcIacAxh6SrhA5ziaGMfqsnMKxqvgZ
         yXyA==
X-Gm-Message-State: ACgBeo3FPqLNa7gqE9Okmf+H2K/jMwMx1wz/uA3bImHPGSqaag+1NoBW
        xYsgDdkyx8CxBYo8pnZfL2dZGm0FmFtlfwef28GRBagnZYzR9V1vfp1n4l1uFEYmdzRhmXP8VCc
        XKPg0UGl6PBuhv8hJOFmF2kNG
X-Received: by 2002:a5d:6b50:0:b0:21e:298c:caad with SMTP id x16-20020a5d6b50000000b0021e298ccaadmr10078132wrw.509.1659366799349;
        Mon, 01 Aug 2022 08:13:19 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6SFeifuzPYHVAqFr8/wF0WF/GYI/razjAjzF4+8/U33L470f+d6kBv248bmE1Rqf3OzIa40Q==
X-Received: by 2002:a5d:6b50:0:b0:21e:298c:caad with SMTP id x16-20020a5d6b50000000b0021e298ccaadmr10078114wrw.509.1659366799134;
        Mon, 01 Aug 2022 08:13:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6900:6d08:8df1:dd2c:bf00? (p200300cbc70469006d088df1dd2cbf00.dip0.t-ipconnect.de. [2003:cb:c704:6900:6d08:8df1:dd2c:bf00])
        by smtp.gmail.com with ESMTPSA id bs22-20020a056000071600b002206d5fded3sm358369wrb.104.2022.08.01.08.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 08:13:18 -0700 (PDT)
Message-ID: <8ee986d7-0e3e-6b66-8c13-61fc70fa538e@redhat.com>
Date:   Mon, 1 Aug 2022 17:13:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 2/2] Unify how inflated memory is accounted in virtio
 balloon driver
Content-Language: en-US
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     kernel@openvz.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220726140831.72816-1-alexander.atanasov@virtuozzo.com>
 <20220726141047.72913-1-alexander.atanasov@virtuozzo.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220726141047.72913-1-alexander.atanasov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.07.22 16:10, Alexander Atanasov wrote:
> Always account inflated memory as used for both cases - with and
> without deflate on oom. Do not change total ram which can confuse
> userspace and users.

Sorry, but NAK.

This would affect existing users / user space / balloon stats. For example
HV just recently switch to properly using adjust_managed_page_count()


commit d1df458cbfdb0c3384c03c7fbcb1689bc02a746c
Author: Vitaly Kuznetsov <vkuznets@redhat.com>
Date:   Wed Dec 2 17:12:45 2020 +0100

    hv_balloon: do adjust_managed_page_count() when ballooning/un-ballooning
    
    Unlike virtio_balloon/virtio_mem/xen balloon drivers, Hyper-V balloon driver
    does not adjust managed pages count when ballooning/un-ballooning and this leads
    to incorrect stats being reported, e.g. unexpected 'free' output.
    
    Note, the calculation in post_status() seems to remain correct: ballooned out
    pages are never 'available' and we manually add dm->num_pages_ballooned to
    'commited'.


-- 
Thanks,

David / dhildenb

