Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11DC507D68
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 01:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358583AbiDSX5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 19:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358553AbiDSX5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 19:57:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 790991260F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 16:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650412495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/CtOAsqipYaegNyqlf3dMB9JRSjBcThm9Deq+uceP3g=;
        b=bKpYa6VXbpvOvlDgUHO/SLEe2ERStKMqDe4jCKB1TtS/dhHa4qInQBoDmV0fJ0PsG/nI4u
        Jih/gHz4SBsd3CT3SZndf4AXjyd8raRn5REhSkpT2a1uVAwnUi7rsPh3hFEVXlee/+yGxB
        fyCMTk3N+EbIRpE7W3BIdsIwDO2ifHc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-56f2OYh2NnCUB82mzKeUgQ-1; Tue, 19 Apr 2022 19:54:54 -0400
X-MC-Unique: 56f2OYh2NnCUB82mzKeUgQ-1
Received: by mail-qv1-f69.google.com with SMTP id 30-20020a0c80a1000000b00446218e1bcbso176933qvb.23
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 16:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/CtOAsqipYaegNyqlf3dMB9JRSjBcThm9Deq+uceP3g=;
        b=OGQWBWlL0UmjJxzG6OwROLVInyqZ3iEByszUWyWIMuckGg7sfpC1Yt4zVgZAcV+6uW
         1NTG3+YVB+cP9JbueVd9ysawYONwcYrsRIMQLTRPyvcYVDWxcEGglzP9s4DaqHD61Nh5
         LJJPf4mE4+/2KsJCdyOCSDKzmbulZfkiv/MAoAMRAYS90D9EvPDgq4bvYwYxFbZ8QOpD
         mRRqrrDFz2i2h/sR3jMt/vaJiwBPBCtQ5HJtNCVkFRAOsowys6k8//YNSTxJHy+kYvIE
         U3qElcvlH8NiZuC7ZiVIBLo9CU0n+Cgp7IzJ3xlllM0nfumZWQxBK2TPP3p5r2aSAfLE
         YaoQ==
X-Gm-Message-State: AOAM532mgp34fCwc3IzKJ+dI3CbQyizKlMtS4Zs6UKVpgoJAZ8bjHt4i
        iTwNloq8KpnoBT2o+oTugStctlEEBQVMomJOZOsQYo4f4hXzVX8VTiYU2+89rSFncpzfKOzhI+W
        h3RNIZJ60KiomrXCnvyPOklUG
X-Received: by 2002:ac8:5fcb:0:b0:2e1:ebd9:3e29 with SMTP id k11-20020ac85fcb000000b002e1ebd93e29mr12370790qta.147.1650412493889;
        Tue, 19 Apr 2022 16:54:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8+Xtf6UIY4XpCfjOMG4fYln4lyceOvwkt9e587mNGkPBqDDjg/sMiZKacJgzU7+vMgZf0wg==
X-Received: by 2002:ac8:5fcb:0:b0:2e1:ebd9:3e29 with SMTP id k11-20020ac85fcb000000b002e1ebd93e29mr12370780qta.147.1650412493674;
        Tue, 19 Apr 2022 16:54:53 -0700 (PDT)
Received: from [192.168.0.188] ([24.48.139.231])
        by smtp.gmail.com with ESMTPSA id p14-20020a05622a13ce00b002f20a695972sm890439qtk.14.2022.04.19.16.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 16:54:53 -0700 (PDT)
Message-ID: <e495901c-f2f3-cc85-10a6-0d2944255b19@redhat.com>
Date:   Tue, 19 Apr 2022 19:54:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] vm_swappiness=0 should still try to avoid swapping
 anon memory
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, aquini@redhat.com,
        shakeelb@google.com, llong@redhat.com, mhocko@suse.com,
        hakavlad@inbox.lv
References: <20210809223740.59009-1-npache@redhat.com>
 <b5575449-08a2-2901-e7e1-a97150e4878c@redhat.com>
 <Yl8Dk+a1YDwupLMv@cmpxchg.org>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <Yl8Dk+a1YDwupLMv@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/22 14:46, Johannes Weiner wrote:
> Hi Nico,
> 
> On Tue, Apr 19, 2022 at 02:11:53PM -0400, Nico Pache wrote:
>> I think its is important to note the issue we are seeing has greatly improved
>> since the initial posting. However we have noticed that the issue is still
>> present (and significantly worse) when cgroupV1 is set.
>>
>> We were initially testing with CgroupV1 and later found that the issue was not
>> as bad in CgroupV2 (but was still an noticeable issue). This is also resulting
>> in the splitting of THPs in the host kernel.
> 
> When swappiness is 0, cgroup limit reclaim has a fixed SCAN_FILE
> branch, so it shouldn't ever look at anon. I'm assuming you're getting
> global reclaim mixed in. Indeed, I think we can try harder not to swap
> for global reclaim if the user asks for that.
> 
> Can you try the below patch?
Sadly this did not fix the V1 case.

I will have to go back through my notes and over the code again to find what
difference between the two may be causing this issue. Im just starting to focus
on this issue again so my memory needs some refreshing of where I was last at.

The good news is that with the current state of upstream the issue of swap
storms tearing down THPs seems to be minimized to sane amount with V2.

My swappiness=0 solution was a minimal approach to regaining the 'avoid swapping
ANON' behavior that was previously there, but as Shakeel pointed out, there may
be something larger at play.

Cheers,
-- Nico

