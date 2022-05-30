Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDF1537535
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbiE3HBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbiE3HBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:01:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7A3071A23
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653894060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U31K93Uq+Fvheeupr2NMZcwHmZ55uz0S5WD0bojawpY=;
        b=d7dBPfELaloIskHkM//dUCtrdZ0EzJ0L49dRMnmIgLdAcotq9CoFPj2U4wXlRTyNE0j0/T
        ZR32ujmrkvkS6vTsaoaywQfy2GUGdsKLl56fcgvSWiofFUYFfJqQx8XoRfqM/60a9YnLcD
        TKBKLfsKgjmFDZmdygbpexsUhVZxkng=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-wOHure6VMNqkBE-0xDIlmQ-1; Mon, 30 May 2022 03:00:50 -0400
X-MC-Unique: wOHure6VMNqkBE-0xDIlmQ-1
Received: by mail-wm1-f69.google.com with SMTP id j40-20020a05600c1c2800b003972dbb1066so9239318wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=U31K93Uq+Fvheeupr2NMZcwHmZ55uz0S5WD0bojawpY=;
        b=QqDIyeHJTY4o/+Xx6wsXf3xpHKkhZ59kKNmeUZKxXAn86rvod33+ZAZPOT8XtR0G/n
         9zjqA5x/bOcvR3q3zmQayhpr1PqMZ+S1Gi2Qi3PmGiAPFFTvtugGpRNNmUZ+V3ZWHx/4
         gvifpCM9Js84C8DANzmjtxaEFmnQ/a8acKsDF8QEVeb9k+e2ZaF+aMp6PSPfMg4T1qC4
         GEEsd3y2IiXRWFtxfQq9eO9jVowYIDQdxouipB5B4aVByOlBpInkX9bAq3OlwhhIzDAJ
         AJNIrYxYH5Yr2NcMaJ2CU+hHMVKwBbUqcE3WSksWBEJmDRWuKXTaINOrWYRajbo+cAXr
         o91A==
X-Gm-Message-State: AOAM530yHajPZ5TWv5P5MLovs6KVpdD071gH5UvlKEp9BtRLON02SAwV
        mE1iqhKcdB+iOUtaFXIN9NRSNJApCgK2KoaqQxKkuSLeTFfN1lS5hzMbSBUupV7VmNUIAoq1d91
        HrXKE3o6V1QBiew+jmDizPJVs
X-Received: by 2002:a5d:678d:0:b0:210:2f33:4399 with SMTP id v13-20020a5d678d000000b002102f334399mr4865031wru.599.1653894049325;
        Mon, 30 May 2022 00:00:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWbVjgbHJgDifYnjzVjmFGHKAJhvPFV/7EXQPi3xye3rM5BEYeXuoSqoi7mYy2rbSD+dcKpw==
X-Received: by 2002:a5d:678d:0:b0:210:2f33:4399 with SMTP id v13-20020a5d678d000000b002102f334399mr4865010wru.599.1653894049074;
        Mon, 30 May 2022 00:00:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:7c00:aaa9:2ce5:5aa0:f736? (p200300cbc7047c00aaa92ce55aa0f736.dip0.t-ipconnect.de. [2003:cb:c704:7c00:aaa9:2ce5:5aa0:f736])
        by smtp.gmail.com with ESMTPSA id c18-20020a5d5292000000b0020ff3a2a925sm9714539wrv.63.2022.05.30.00.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 00:00:48 -0700 (PDT)
Message-ID: <8ab86020-8e24-4004-d6b1-c122639e584b@redhat.com>
Date:   Mon, 30 May 2022 09:00:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] virtio_balloon: check virtqueue_add_outbuf() return value
Content-Language: en-US
To:     =?UTF-8?B?Qm8gTGl1ICjliJjms6IpLea1qua9ruS/oeaBrw==?= 
        <liubo03@inspur.com>, "mst@redhat.com" <mst@redhat.com>
Cc:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <7a413652a9a9469f948fbfa2eae5c401@inspur.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <7a413652a9a9469f948fbfa2eae5c401@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.05.22 04:16, Bo Liu (刘波)-浪潮信息 wrote:
> Adding this patch can avoid unnecessary VM exits and reduce the number of VM exits
> 

... in corner cases where virtqueue_add_outbuf() fails? Why do we care
about that corner case?

Looks like unnecessary code churn to me, unless I am missing something
important.

-- 
Thanks,

David / dhildenb

