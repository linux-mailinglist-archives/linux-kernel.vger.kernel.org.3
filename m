Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB95520E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 08:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237336AbiEJGwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 02:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237316AbiEJGwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 02:52:03 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D178124EA2A
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 23:48:06 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id i17so15926957pla.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 23:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=co2eBHYlJ/8jSI1HX8IuIkIXr/lTF8w1YbWXQnk2TLw=;
        b=fkM8j4GyHljGKWn2LbaZQuIkisiytpq68of+xbM/uFT3nwScwYQGsqaAQIeSE0VjSv
         DrJh5FuYLssyPmI2SE1B4SRvJKYVihDlaLqI++iBX2qBWg450izB3AfQkmnY/bBWLPdc
         aZK56kzzJ5imdE5cFafPTcs9b9EGanCPTTuFXG3oRECooG+/bBU1inYMPY+CGBGJsBO3
         Q54yr2enCbhmxKXqn//QUh1q0kuYkPEShh2a9E4FGe5Lw0KBjhM1Tgtg5VzwS9nD85zv
         mRLrLac9TldMMUgntcKQfKTqM5S6ganSQEyxwxpgmX70ctz5ABvfk2M2grUvI1/CcpPC
         oqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=co2eBHYlJ/8jSI1HX8IuIkIXr/lTF8w1YbWXQnk2TLw=;
        b=n/fzsRu5DuwDGfB5ERajQlVTZbBpcnJv9oStX3XnMJKH6DXehBO2pFMDQojV653ule
         nnpyAAgQRSNrLcXcF5NdTfiakOCD0b7ZdJDQ6yqUBGzrJrqWBuuAAel8Zs2ZyheZqnLt
         XseWK1gXtmLmrM/vZWaGWGc1yv3Fy4pa/XIbeLNraUzZTIVAlITNDJOHipUlLYG8RaIB
         IWPH9ndgz/lCyYKUGhnGcZxCYZsG0yE59FAbGd4Kyp4dtOtShNryDqb+YSUF+k133Q49
         WihpTZ6y0wM27jlYfvbvIMiMJHV6J//3orxdSvcwTx6/Gex38P0evmY6LZ9N79ZeYMC9
         wW1Q==
X-Gm-Message-State: AOAM5318ziHy4jgeQPs2mtbwu+G/Exlismk6YyUC56E6LZSaAdJH+gMS
        IjUIiaYPY/EbOJv8WRqAPK+plQ==
X-Google-Smtp-Source: ABdhPJyon4i99lL4Z56gC2OxIKRnjK+6Jt7ZWreKPWL9YHl9eJQRBDv3XujFVaeiuF61RwtLV/wGbg==
X-Received: by 2002:a17:902:b284:b0:15f:179c:9828 with SMTP id u4-20020a170902b28400b0015f179c9828mr6447989plr.4.1652165286357;
        Mon, 09 May 2022 23:48:06 -0700 (PDT)
Received: from [10.255.89.252] ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id n10-20020a170903110a00b0015e8d4eb20fsm1105863plh.89.2022.05.09.23.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 23:48:05 -0700 (PDT)
Message-ID: <0859381a-5c09-ef54-89bf-e27f79429b97@bytedance.com>
Date:   Tue, 10 May 2022 14:44:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Re: [PATCH 1/3] nvme: introduce bit 5 of smart critical warning
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220507065026.260306-1-pizhenwei@bytedance.com>
 <20220507065026.260306-2-pizhenwei@bytedance.com>
 <20220510054904.GA10460@lst.de>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20220510054904.GA10460@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/22 13:49, Christoph Hellwig wrote:
> On Sat, May 07, 2022 at 02:50:24PM +0800, zhenwei pi wrote:
>> According to NVM Express v1.4, Section 5.14.1.2 ("SMART / Health
>> Information"), introduce bit 5 for "Persistent Memory Region has become
>> read-only or unreliable".
> 
> Given that Linux does not support the PMR, do we really need this?

OK, let's drop this change.

Klaus Jensen corrected me about OAES[7:0]. Sorry, I misunderstand this.

-- 
zhenwei pi
