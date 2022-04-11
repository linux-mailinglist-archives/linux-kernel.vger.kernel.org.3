Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91F34FC26D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 18:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiDKQdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 12:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348647AbiDKQdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:33:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12E6831537
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649694686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9npo1nqXaxbPxEQzLk6Betnt1M5YLmZj/dlQsw0KH3E=;
        b=YiHrMYvHInwGeCN3bYuEPlIoiDiJVFb9MVt+VeLTcktAdCuNMwbMiegis3p6SVGNsPwCAv
        5vUEJREkqLSwoCOFuH/+OayrBJT7163N7tjN4yxJhv6w9fmlvXj/vgIEMDDKAHYsFcwWgA
        4IPkTADn56RN2w6+eOU8j+gb1lcUbXA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-zFXsi7TLM1CDyMt1r-rUQw-1; Mon, 11 Apr 2022 12:31:24 -0400
X-MC-Unique: zFXsi7TLM1CDyMt1r-rUQw-1
Received: by mail-qt1-f198.google.com with SMTP id u29-20020a05622a199d00b002e06ae2f56cso13047566qtc.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9npo1nqXaxbPxEQzLk6Betnt1M5YLmZj/dlQsw0KH3E=;
        b=LLskDzoO3SGB5ig3ZMxAp5bhhaQvZAd5qRvofvhnCuhS56pMQeH2m7arSndXjTaMm/
         gIv0OWnReNYxYQiWuGG12pQ5MzsZ0p/mmvrvvDkmvJd2I4py57qoVyGs/DRjRoGXBr8/
         3Ic/ghohZKW2Hki2tSA+q9yPLUGubG7D2t8tYMsR4hDx5K3TOLljgbd+pp4N8mVxHCEo
         +Swq78u2lnyJtYjvud6aqUidfvKX983H6i07ixxNtHYjy5leJgDkufr4Mrn7y/fcdjC8
         4Z2d5ca1AH52ZqBgFs3egERUWwa5MN3w6Lrz6GgJW6M2sspwL+IfBYhlcLV7dsfd57bt
         KWdA==
X-Gm-Message-State: AOAM532wWkPeFV3h+ZVjMACcLO1pC/Z60DMZ2LglFUXpaxEfudmYlK4r
        iucKSDPLIg2Hb1ozFMNvdlDBrnFKFKvAdx/B7L508skxVR0j75raqIeA61RdylU3l6i8859dPXY
        U7GJYgQxVScjZcLBGegiUW43T
X-Received: by 2002:a05:620a:1024:b0:69c:2e0f:d020 with SMTP id a4-20020a05620a102400b0069c2e0fd020mr160242qkk.108.1649694684320;
        Mon, 11 Apr 2022 09:31:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIBbuzUKRKdpRu1szbFKkqYCYu3AmHHhLAg8TDSWf8+WPdx1Tx8DzyFwTfgzm1rUwE2RhpZg==
X-Received: by 2002:a05:620a:1024:b0:69c:2e0f:d020 with SMTP id a4-20020a05620a102400b0069c2e0fd020mr160226qkk.108.1649694684121;
        Mon, 11 Apr 2022 09:31:24 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id s31-20020a05622a1a9f00b002e1df010316sm26851091qtc.80.2022.04.11.09.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 09:31:23 -0700 (PDT)
Subject: Re: [PATCH] security: do not leak information in ioctl
To:     Christoph Hellwig <hch@infradead.org>
Cc:     tim@cyberelk.net, axboe@kernel.dk, jejb@linux.ibm.com,
        martin.petersen@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        llvm@lists.linux.dev
References: <20220409145137.67592-1-trix@redhat.com>
 <YlREKRb/xgAFsi97@infradead.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <eec2efee-1153-8d8e-77c2-96156733a0c6@redhat.com>
Date:   Mon, 11 Apr 2022 09:31:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YlREKRb/xgAFsi97@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/11/22 8:07 AM, Christoph Hellwig wrote:
> Wrong subject prefix, and this really should be split into one patch for
> pcd and one for sr.
ok i will split
> The sr prt looks sensible to me.  But for pcd why can't you just
> initialize buffer using
>
> 	char buffer[32] = { };
>
> and be done with it?

The failure can happen in the transfer loop, so some of the data will 
not be zero.

And checking status should be done.

zero-ing is because i am paranoid.

Tom

>

