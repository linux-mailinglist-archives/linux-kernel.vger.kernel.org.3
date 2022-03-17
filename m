Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831034DC0C6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiCQISh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiCQISf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:18:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3208143C69
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 01:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647505038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kw4dhDpk62g5X51CW7X6oXZ2QF/lhkCUorva+gu7ALk=;
        b=J2I3I5sqmqiiLLKFqj9dQb9ikCJ4Exwe64zYebgBJQs2ay6MYUKsEDQMNN0jRDOu4szYOb
        ct72EKwRErXoQVbsF9E1Uca0h6DtSVg7nw2D8v5c9DCU5ERavxzwi//fdyPOUeqDs+fAuW
        3dx8nCUPGNQt0tinniNK7xJdQp6bJ9Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-uHjX84x9PayrWyslpT1mcw-1; Thu, 17 Mar 2022 04:17:16 -0400
X-MC-Unique: uHjX84x9PayrWyslpT1mcw-1
Received: by mail-wm1-f71.google.com with SMTP id q6-20020a1cf306000000b0038c5726365aso1858263wmq.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 01:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=kw4dhDpk62g5X51CW7X6oXZ2QF/lhkCUorva+gu7ALk=;
        b=WLJwNu3sc84jS4tqxLGb45lS1iVr313BbuN6VSWkDfEQSzL9l6TlthJ5rhv7p9UWE/
         XYy1NzAdfFTXxaz2i6xBQRGQ4cUCRTN6UUpTuRmOA1WYumywGZ6UEhlS/eKsnflnNLRk
         qcs6mpmsH4k1AugBCUfvz0o4ZAU3E7sPq/FOlDBNWUOysdDGllWqw7ov2QNuU0qx/4ue
         EF/OOpk2h8z8PclLmquNc/JbCFgyU34aGi9jOdxLtkg7Ey1/jviJ8RO09xJ+Kl31BGP0
         RUiPbMI+Es9RF7Z6nRGLnsNIQ+LhmlE2s6Rxh4D7jA60A92nrwmSrQRNri7MOlhyT1ux
         9y4w==
X-Gm-Message-State: AOAM530GrnbxuGmu3L4FPqIGm2BJ+2GCw1oHk3hNTXgjES97TgpgFGxS
        PCWlZu02/K4jz9Uus7S9Vug+1viEr+g/TiREKbdgIzClAARwKKXPCGnIWIrs2GphQO2pgmrIc4T
        BQn6AgpnvrcNK/SfargqYMQce
X-Received: by 2002:a1c:7519:0:b0:383:d29b:257 with SMTP id o25-20020a1c7519000000b00383d29b0257mr10225934wmc.172.1647505035340;
        Thu, 17 Mar 2022 01:17:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4l4MIvx+0+J2QEYcBgdVHQKB9D+ntj/JL2mAq5WTj8EmA9P1fZdy2pknRuO2skNx2+G/Xaw==
X-Received: by 2002:a1c:7519:0:b0:383:d29b:257 with SMTP id o25-20020a1c7519000000b00383d29b0257mr10225919wmc.172.1647505035123;
        Thu, 17 Mar 2022 01:17:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:d000:22e9:afb1:c890:7468? (p200300cbc707d00022e9afb1c8907468.dip0.t-ipconnect.de. [2003:cb:c707:d000:22e9:afb1:c890:7468])
        by smtp.gmail.com with ESMTPSA id g1-20020a1c4e01000000b003899c8053e1sm4526132wmh.41.2022.03.17.01.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 01:17:14 -0700 (PDT)
Message-ID: <4e76476b-1da0-09c5-7dc4-0b2db796a549@redhat.com>
Date:   Thu, 17 Mar 2022 09:17:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] delayacct: track delays from ksm cow
Content-Language: en-US
To:     CGEL <cgel.zte@gmail.com>
Cc:     bsingharora@gmail.com, akpm@linux-foundation.org,
        yang.yang29@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20220316133420.2131707-1-yang.yang29@zte.com.cn>
 <412dc01c-8829-eac2-52c7-3f704dbb5a98@redhat.com>
 <6232970f.1c69fb81.4e365.c9f2@mx.google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <6232970f.1c69fb81.4e365.c9f2@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.03.22 03:03, CGEL wrote:
> On Wed, Mar 16, 2022 at 03:56:23PM +0100, David Hildenbrand wrote:
>> On 16.03.22 14:34, cgel.zte@gmail.com wrote:
>>> From: Yang Yang <yang.yang29@zte.com.cn>
>>>
>>> Delay accounting does not track the delay of ksm cow.  When tasks
>>> have many ksm pages, it may spend a amount of time waiting for ksm
>>> cow.
>>>
>>> To get the impact of tasks in ksm cow, measure the delay when ksm
>>> cow happens. This could help users to decide whether to user ksm
>>> or not.
>>>
>>> Also update tools/accounting/getdelays.c:
>>>
>>>     / # ./getdelays -dl -p 231
>>>     print delayacct stats ON
>>>     listen forever
>>>     PID     231
>>>
>>>     CPU             count     real total  virtual total    delay total  delay average
>>>                      6247     1859000000     2154070021     1674255063          0.268ms
>>>     IO              count    delay total  delay average
>>>                         0              0              0ms
>>>     SWAP            count    delay total  delay average
>>>                         0              0              0ms
>>>     RECLAIM         count    delay total  delay average
>>>                         0              0              0ms
>>>     THRASHING       count    delay total  delay average
>>>                         0              0              0ms
>>>     KSM             count    delay total  delay average
>>>                      3635      271567604              0ms
>>>
>>
>> TBH I'm not sure how particularly helpful this is and if we want this.
>>
> Thanks for replying.
> 
> Users may use ksm by calling madvise(, , MADV_MERGEABLE) when they want
> save memory, it's a tradeoff by suffering delay on ksm cow. Users can
> get to know how much memory ksm saved by reading
> /sys/kernel/mm/ksm/pages_sharing, but they don't know what the costs of
> ksm cow delay, and this is important of some delay sensitive tasks. If
> users know both saved memory and ksm cow delay, they could better use
> madvise(, , MADV_MERGEABLE).

But that happens after the effects, no?

IOW a user already called madvise(, , MADV_MERGEABLE) and then gets the
results.

So how is this interface useful except for somebody writing an
application and simply being able to benchmark it with vs. without
MADV_MERGEABLE?

-- 
Thanks,

David / dhildenb

