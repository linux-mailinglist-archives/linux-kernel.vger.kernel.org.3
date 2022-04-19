Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638A8507A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 21:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347927AbiDSTkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 15:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbiDSTkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 15:40:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 554D14130A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 12:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650397075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pHJ6JYSZrPnS83IlVv7F04EuoAhV9PC6zDA2k04Zvpg=;
        b=dmMVH3TqiFlUFb/wNMWv66jpkRLjsmpvO6GuG3F9oCweeEEjIpZyAkyrTgVUhdnsU+mRF4
        xBMILgM6a68XzLn6jo0zc43OaNkKybItP0U6FxwVvkqSCuDRLMdvzBYzD6e8DqPEmZy7vg
        fwysDW6rCHybr9mtSI1Fg0D4QFcFfm0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-omMCHOSYPJCopkLmhG_pzw-1; Tue, 19 Apr 2022 15:37:54 -0400
X-MC-Unique: omMCHOSYPJCopkLmhG_pzw-1
Received: by mail-qk1-f200.google.com with SMTP id j12-20020ae9c20c000000b0069e8ac6b244so5592831qkg.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 12:37:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pHJ6JYSZrPnS83IlVv7F04EuoAhV9PC6zDA2k04Zvpg=;
        b=0P19gpDQpPp0sQB7QLL+rAUPV7U69437MSn2JtbY43yKJPf7ehV3M0url/NUYUT1bb
         SQk+r8+T7ZRkDGslUiMHhdyz09rI7QvQ0UlD7pifI5R492yQ8oYcoLhU8UMyDTA8zdVb
         TZ8Lbidca6l3/7UoK2PsbVNZPhm3TbKX+CwErMqxoSO1WX9a+hsYYYDnC82ke0VKXSko
         PHULTADTsGtRnhUMU1tNb03yISusnqGH684Lc9fHFWNmeNd+5w5/gZ5he4Pyb1GdGQcR
         DMKPBCjNd3T7FvCT3m11fn3e6Vll2y9KhMQpS3CxHigc4oAAksP26YfS+Jt0KDu5MZfW
         oArA==
X-Gm-Message-State: AOAM532FnGnVzKM2xX8qENqQucyD5rE1QKgI8tOZiXgT+2szHN3uB+pk
        tgkVON0cwNO5u+idyD98vCjPlDafyPeLq+iXTXsnfkBFABsFNUbEnDtemmQuMjgeIo6svghAp/F
        hcRNWp6fmeTU40PNTF63LjjxM
X-Received: by 2002:a05:620a:bc8:b0:67a:fe6a:22ac with SMTP id s8-20020a05620a0bc800b0067afe6a22acmr10464713qki.28.1650397073511;
        Tue, 19 Apr 2022 12:37:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPR/4hMJhEkQZAK8sWQ4QvNqTqWHMQhWrOUoy3NWsF2eMMzhOhOiaFoCcKUdcxu6ZIGFqM4g==
X-Received: by 2002:a05:620a:bc8:b0:67a:fe6a:22ac with SMTP id s8-20020a05620a0bc800b0067afe6a22acmr10464708qki.28.1650397073307;
        Tue, 19 Apr 2022 12:37:53 -0700 (PDT)
Received: from [192.168.0.188] ([24.48.139.231])
        by smtp.gmail.com with ESMTPSA id d126-20020a37b484000000b0067e60283d08sm449538qkf.40.2022.04.19.12.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 12:37:52 -0700 (PDT)
Message-ID: <001bf379-9026-fd7a-3fff-c1b2cea35348@redhat.com>
Date:   Tue, 19 Apr 2022 15:37:51 -0400
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
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

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
We aren't actually utilizing the cgroup mechanism; however, switching between
the two has a noticeable affect on the global reclaim of the system. This is not
a writeback case either-- The reproducer simply reads. So I think we can rule
out the v2 writeback controller being involved. My initial patch was also
targeting swappiness=0 but this also occurs when >0.
> 
> Can you try the below patch?
of course thanks for that :) I'll let you know how it goes!

Cheers,
-- Nico

