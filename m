Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171AB53A923
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 16:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354806AbiFAO1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 10:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355612AbiFAOZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:25:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2818910F35A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 07:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654092890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rh2kKuq7JT9nDpWOkwBlkZKD7rfR/HcqZJvN8704Ov8=;
        b=XacoGPHNIrh8ciDbRRgBelrWCc13fSlTXKHEUN95B0hr4SAJEKAmhUXda3WlI5N78S1zg6
        dZxeXdRB11XOlKgUlVHSFzXY03h5uXn1lhut4tSZuupnzZHsKxZlfCS+FwPtSeKDWLAQO+
        PFRgc/ybJkn2eUhMZwItLCRWoqmuatg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-dHlZA6qoOE6Ss8FBBHamag-1; Wed, 01 Jun 2022 10:14:49 -0400
X-MC-Unique: dHlZA6qoOE6Ss8FBBHamag-1
Received: by mail-wm1-f69.google.com with SMTP id bg7-20020a05600c3c8700b0039468585269so997419wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 07:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:organization:in-reply-to
         :content-transfer-encoding;
        bh=rh2kKuq7JT9nDpWOkwBlkZKD7rfR/HcqZJvN8704Ov8=;
        b=smA5YjmYpddePolkyEQKQChmlfGxGZaIoEsJp027zn+FY0i37kLrQG2hcRwtYXApJN
         5tGBVqjhxprEjOc1RTTMwwyqDBSb+Bf2H+Avbl2RGNrXO6C8/EtHrVC89UczbtMp3HbN
         m7ePdJtTD+imf733B4pxKbey/jujTcxrTuQKnPoazQMeJ6v635pV6nMeEyl8Jh8Zof3D
         gixiKve+ZlG0JIRWEL5uFlZBjbIQvlpryEI2+9KKHnBSrXgsyHgN7PnkwwhQ4aSb32CO
         JoOTmRr1tT4f7ilhVbhP3paHhMqZj6Z919Ylazt/WU3CUk4Vd3JgAC9j6DDNLtbMGYgm
         K9sg==
X-Gm-Message-State: AOAM533qnPEKPg6l2mplxzrbg5sD7eadFd4mmmbramNn5/M9uVjyDDIu
        lLSBk+WCP9rbiHFwOQPKa3QVlTY15+13mDshi3Ubxcs3xr6jT3jPPbziWJwhkU8LTBeEu3pC5KB
        w+PBg9A7LkTq1ZX1HBZDc5gUn
X-Received: by 2002:a05:6000:1006:b0:210:353e:32b2 with SMTP id a6-20020a056000100600b00210353e32b2mr12507730wrx.303.1654092888647;
        Wed, 01 Jun 2022 07:14:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx06pbtg967o6yanU0JAOXaZhgBCD/uDgV3zu70cIyg/nWCso+q8JR5Wi8x68ONFFSPJwAlVg==
X-Received: by 2002:a05:6000:1006:b0:210:353e:32b2 with SMTP id a6-20020a056000100600b00210353e32b2mr12507708wrx.303.1654092888431;
        Wed, 01 Jun 2022 07:14:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:2600:951d:63df:c091:3b45? (p200300cbc7052600951d63dfc0913b45.dip0.t-ipconnect.de. [2003:cb:c705:2600:951d:63df:c091:3b45])
        by smtp.gmail.com with ESMTPSA id m15-20020a05600c3b0f00b003974ca9fa6dsm7705633wms.2.2022.06.01.07.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 07:14:47 -0700 (PDT)
Message-ID: <e25a6d7b-c93f-c680-5044-c9dac1aa0a2f@redhat.com>
Date:   Wed, 1 Jun 2022 16:14:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/4] mm/shmem: return -EINVAL for addr not PAGE_SIZE
 aligned
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Chen Wandun <chenwandun@huawei.com>, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220601124417.2872001-1-chenwandun@huawei.com>
 <20220601124417.2872001-3-chenwandun@huawei.com>
 <d5f4c444-032d-81f6-c7b8-6e1627aaf7f7@redhat.com>
Organization: Red Hat
In-Reply-To: <d5f4c444-032d-81f6-c7b8-6e1627aaf7f7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.06.22 15:37, David Hildenbrand wrote:
> On 01.06.22 14:44, Chen Wandun wrote:
>> If addr is not PAGE_SIZE aligned, return -EINVAL directly.
> 
> Why is this one to be treated in a special way compared to all of the
> other related checks?

Ah, I see you modify other places in other patches. Maybe just combine
all these return value changes into a single patch? That makes it look
less "special".



-- 
Thanks,

David / dhildenb

