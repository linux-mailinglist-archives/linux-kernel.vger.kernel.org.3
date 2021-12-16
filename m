Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15718476F62
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbhLPLCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:02:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27140 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236431AbhLPLBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:01:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639652515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l7GwdlGfQ5W/g4LmoX5XmlDa+4pC1YAv6UajHqQaEfs=;
        b=HQKbo+sE+fkwjVNjEdLfqBJ9/0C0xUpjQXlBGTYfs5Uaqbw2/73ZtzNFT659dQjfsuHIw6
        tPCuzBjeRFf4Nrr+uS6UEgDJg0oqKOSYO18dc6VeHkKVqnEOmsgLdWQgS0Ca7xXDSetTWf
        O04rsybzsW81IAwEOX8+/GiLXMAhFOw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-542-3keYelc5M06vD06GuUkrGQ-1; Thu, 16 Dec 2021 06:01:53 -0500
X-MC-Unique: 3keYelc5M06vD06GuUkrGQ-1
Received: by mail-wm1-f69.google.com with SMTP id v62-20020a1cac41000000b0033719a1a714so13667571wme.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 03:01:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=l7GwdlGfQ5W/g4LmoX5XmlDa+4pC1YAv6UajHqQaEfs=;
        b=cJrTFgUBsFSWmRolF3Tl811NBwp0hXQZz98XHB6z7GlZdQEUj1ydaTDDAM3Wmg4mtf
         cA7b+L7jmwzezRqlLgzXJf+YzoKdgWNapuRFQibiX6/L0u6FOMn89/6qy2GoxRig67mR
         SfaBi4cZ7A68wAdg4ClKS1NYCyttFSrR4bx/jF3rqhRBuWRWJ4CVS8m56CWUqkoGzJlG
         ugyp/A61T2/01d+T/UiDzt6nKfOdopkzgbOmmgTv0sttAa6boWDMd1kF+HKmDnwOh+V6
         PPp4HhmsjzC9nRzxXGLHgLff69dRXPBzAURtreBbJh/wjOFRGEu0rmffuekN+oDdNADW
         4o9A==
X-Gm-Message-State: AOAM531Ywo/wkU6QntvJ3PR9a0WFjsKiS/JyJDRlVPyESdgZc7RRVbME
        tS+PAvUItEbllstNE5vek/hx+YpmWxoyd5o0xfu0Z3E73jOIQpninjV+ZJID4Umy+gLjC/vU2q3
        HBp0ja/1B4PaR/VxOYDVzKu1K
X-Received: by 2002:a05:600c:19d0:: with SMTP id u16mr4415954wmq.111.1639652512748;
        Thu, 16 Dec 2021 03:01:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyD/x70y7BF15+GIWDr8ovTZVuSOK1BOzDtEe1Mb1/AGPryPtAQp5I5z1oFB0htlfGkpun81w==
X-Received: by 2002:a05:600c:19d0:: with SMTP id u16mr4415919wmq.111.1639652512416;
        Thu, 16 Dec 2021 03:01:52 -0800 (PST)
Received: from [192.168.3.132] (p4ff23dcd.dip0.t-ipconnect.de. [79.242.61.205])
        by smtp.gmail.com with ESMTPSA id z5sm1326474wru.87.2021.12.16.03.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 03:01:52 -0800 (PST)
Message-ID: <f964967d-dd47-f509-33c3-abd6f8593710@redhat.com>
Date:   Thu, 16 Dec 2021 12:01:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] docs/vm: clarify overcommit amount sysctl behavior
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Anssi Hannula <anssi.hannula@iki.fi>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20211211194159.3137362-1-anssi.hannula@iki.fi>
 <YbUkdvFBayRwV6ax@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YbUkdvFBayRwV6ax@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.12.21 23:21, Matthew Wilcox wrote:
> On Sat, Dec 11, 2021 at 09:41:59PM +0200, Anssi Hannula wrote:
>> Documentation/vm/overcommit-accounting.rst says that the overcommit
>> amount can be set via vm.overcommit_ratio and vm.overcommit_kbytes.
>>
>> Add a clarification that those only take effect in overcommit handling
>> mode 2 ("Don't overcommit"), i.e. they do not act as an "additional"
>> limit that is always enforced.
>>
>> Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
>> ---
> 
> Simple and clear improvement, IMO.  Cc'ing linux-mm to get more eyes on
> it.

As I had the same idea to just make this clearer in the context of
advanced documentation for virtio-mem, so I approve :)

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

