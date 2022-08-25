Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDC75A0CB8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240383AbiHYJdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240381AbiHYJdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:33:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2418A1D7B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661419983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f93As8t+AUZuoeXw4IPmjspMtTl9iyRz8DSCXtau4WA=;
        b=TXGsJNu25VAJKv6EpKJ0++AQMCX+LAAmQAMG58HGsajsJ+z7wNDC2ELAhLENMp4i7cSWf+
        KKOYugp/6awE6IAbS1+k0/5CsbjVKFFb+Ad5qf9ObYPsMm1pH1ZMABdf1AdIUHXSKpI8i8
        2Mk3zGqAXJ72SUo5K9CILxqCe7xMOU4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-644-QMc-4VkRMkmXoKB4MvejaA-1; Thu, 25 Aug 2022 05:33:01 -0400
X-MC-Unique: QMc-4VkRMkmXoKB4MvejaA-1
Received: by mail-qv1-f72.google.com with SMTP id dh19-20020ad458d3000000b00496bf7e4a72so10554711qvb.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=f93As8t+AUZuoeXw4IPmjspMtTl9iyRz8DSCXtau4WA=;
        b=x8P2CxUJrRnks20y2pNGTzxTjlgPVRFsnEPHuf083rw0LRMestOAaifLa6+rm1xxX9
         7+S4swtvMpQoq9bN32u0pA6W3My5SY0slXK9TwTfQJla57ZgyFpF93aKGyG6Wi/vgh8h
         ER/3SS8DQADyOpConwk47zpe1l39ylVRM4pa7VOEVuJ9JdQC5BlnToecr64letBctY3W
         f5DdQg1nA5FoSZzS7Qpe0JblxKJC2TMSobfqeyrb+fKmudqZPYCJmdRUlXhvk15MYKkk
         czPMfTQVx3zcxRAD1Z3RkKJNfrsI1KdZIkrjDT9cz2U8WMCkF5z/jiHcAOwgFYuyV3tC
         Zylw==
X-Gm-Message-State: ACgBeo1q0HAEr+tMKcDl08AQdrXcLRD0TanrytRkOHyXsnWbSx4nrdVV
        a3CIUPbSx44EPauztTPkGs5cYYzIbLkE+M0pai9Fk896sLXs6UPVQ+MnM9Q9kcWhlK993mpbcGz
        4McsU3dx/mxgMVIe4obPZ7rFt
X-Received: by 2002:a05:620a:f83:b0:6bb:ac26:e566 with SMTP id b3-20020a05620a0f8300b006bbac26e566mr2204231qkn.779.1661419981137;
        Thu, 25 Aug 2022 02:33:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5CMv5jYuA/JegCZgF/AkLiAH2iQsQFomqiCX+y/Zu+/FOx28tVRoV8HXTM6lhhC0eY1djUvQ==
X-Received: by 2002:a05:620a:f83:b0:6bb:ac26:e566 with SMTP id b3-20020a05620a0f8300b006bbac26e566mr2204217qkn.779.1661419980956;
        Thu, 25 Aug 2022 02:33:00 -0700 (PDT)
Received: from [192.168.1.165] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id k8-20020ac80748000000b0031ee918e9f9sm13368029qth.39.2022.08.25.02.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 02:33:00 -0700 (PDT)
Message-ID: <d53a4672-d068-c394-6ab1-058b2d72701f@redhat.com>
Date:   Thu, 25 Aug 2022 10:32:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [Cluster-devel] [PATCH] gfs2: move from strlcpy with unused
 retval to strscpy
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20220818210144.7915-1-wsa+renesas@sang-engineering.com>
 <bd7275c6-4ebe-de99-75c2-400cfa2e5026@redhat.com> <YwaFRvWw5hi/uWYs@shikoro>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
From:   Andrew Price <anprice@redhat.com>
In-Reply-To: <YwaFRvWw5hi/uWYs@shikoro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2022 21:08, Wolfram Sang wrote:
> Hi Andy.
> 
>>> -	strlcpy(sdp->sd_proto_name, proto, GFS2_FSNAME_LEN);
>>> -	strlcpy(sdp->sd_table_name, table, GFS2_FSNAME_LEN);
>>> +	strscpy(sdp->sd_proto_name, proto, GFS2_FSNAME_LEN);
>>> +	strscpy(sdp->sd_table_name, table, GFS2_FSNAME_LEN);
>>
>> Perhaps the size should be changed to GFS2_LOCKNAME_LEN to match the size of
>> the destination, too.
>>
>> With that addition, this patch fixes this syzkaller report:
>>
>> https://listman.redhat.com/archives/cluster-devel/2022-August/022755.html
> 
> Linus wrote another summary about strlcpy vs. strscpy use[1]. So, the
> size argument should be the size of the smaller buffer if the buffers
> are of different size. GFS2_LOCKNAME_LEN is smaller, so that looks
> suitable. Shall I resend the patch with the suggested change?

Yes, please. I can't speak for the gfs2 maintainers but I think it would 
be a good plan, as the combination of strscpy and the size change fixes 
a bug.

Andy

> 
> All the best,
> 
>     Wolfram
> 
> [1] https://lore.kernel.org/lkml/CAHk-=wi+xbVq++uqW9YgWpHjyBHNB8a-xad+Xp23-B+eodLCEA@mail.gmail.com/
> 

