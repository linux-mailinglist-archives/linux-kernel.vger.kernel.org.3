Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B28572E51
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbiGMGjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbiGMGjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:39:10 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3474ADEB4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:39:08 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id r17so8579256qtx.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gWkpUUzApawwJR2aamV/fgK66eMtR6xDSFbaB2LkNYI=;
        b=elHG3txMqbKZ0Hgz2CXaWzEdKvfGOSI3hHLUWrbJplgeOvYJvVmXhuA1EDE7Aqvpne
         siiKftydQlg1sxEqI99z+DR6ZZbzAHRvFvM/bgpz1nNsqU9tR5Wq1FWJ5rpT5xxayWYn
         eGT0xCVToAtrH03QMjeRTR9+48VER2tukKlgtMt06tbidpbDY+zsHDQ4jWOznP6j4Or6
         4Gdqj4/RVW52sahiHQda/a125HCOEpSHwmFWdPmpV/zfuDqLg12Nw4RyXmb3hpb+myGL
         gu/UU7L2BpPMDVJDUtkC0PFJi3sMz6aYP7beC/bkORNENqzf+gnlWnYP3JPYX5W4bqud
         Yg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gWkpUUzApawwJR2aamV/fgK66eMtR6xDSFbaB2LkNYI=;
        b=scJJgl2lGpOaUkvPlj6IGmO5fgQxYPgB7G9m6n99q4lWHx3s0unS8tdlJR1L7XGDUU
         0p0E+bMxdfr4PDgYYAL0b1JGt4AgC0O/PpBub3JF8F5dydONpsxUr+Rf9AfpfIBYY2HB
         m9/nI6jlrabyC944u+cI3cw1kgyI+pNxa5fOYwETao9x6DMBDKdVloZbxgRqvx3InQof
         kz7PVeyDFi3HQybdKM5pm5IqwYIQKRhMTl+7IJyDsKH8U+Z9So9WJhkD9kleyDIZ41oj
         /NSRA6TEbIc0M4U+phqv8AXZvDNFcAQ/X2pxA2KnOq4zWdxZdSb/i6erGfQ2De7JYqCI
         74EQ==
X-Gm-Message-State: AJIora9GEwCd+mX+GL5KxhBVG/x1x2STuOIq5eb76/DvwTqOI47dSVND
        g0VNJGn/kuCV+UDfhjk29w==
X-Google-Smtp-Source: AGRyM1vipNm0vZXEBhnWy6tqduUht2fjLRfLPlMPVY68w7VsD7/4JYv1Loq0v4itdn2MI9k/4oRdEg==
X-Received: by 2002:a05:622a:1903:b0:31e:b737:a86d with SMTP id w3-20020a05622a190300b0031eb737a86dmr1515986qtc.630.1657694348045;
        Tue, 12 Jul 2022 23:39:08 -0700 (PDT)
Received: from [192.168.1.210] (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id z14-20020ac86b8e000000b0031eb393aa45sm6387375qts.40.2022.07.12.23.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 23:39:07 -0700 (PDT)
Message-ID: <0aa8323d-9461-a861-ac35-6952e7aeaf93@gmail.com>
Date:   Wed, 13 Jul 2022 02:39:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH] 9p: forbid use of mempool for TFLUSH
Content-Language: en-US
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Greg Kurz <groug@kaod.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
References: <12950409.o0bIpVV1Ut@silver>
 <20220713041700.2502404-1-asmadeus@codewreck.org>
From:   Kent Overstreet <kent.overstreet@gmail.com>
In-Reply-To: <20220713041700.2502404-1-asmadeus@codewreck.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/22 00:17, Dominique Martinet wrote:
> TFLUSH is called while the thread still holds memory for the
> request we're trying to flush, so mempool alloc can deadlock
> there. With p9_msg_buf_size() rework the flush allocation is
> small so just make it fail if allocation failed; all that does
> is potentially leak the request we're flushing until its reply
> finally does come.. or if it never does until umount.

Why not just add separate mempools for flushes? We don't have to 
allocate memory for big payloads so they won't cost much, and then the 
IO paths will be fully mempool-ified :)
