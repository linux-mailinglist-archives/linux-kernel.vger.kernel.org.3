Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A91859127A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 16:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbiHLOs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 10:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237826AbiHLOs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 10:48:27 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E497ABD4A
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:48:25 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 24so971909pgr.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=tmJm+SpCPyDqJ1lshIA1ETszu0sVt5hUjFD5g/2kg50=;
        b=aJ+9o9HQcipIlVWgIit02PLYCSWZQby4S9kcexl1KVoRbd5IYGKzIN29a15kXcl3tH
         kQLYYNSlzNAl1v02d7rPkfua47JAO3GOBNKFzUxavCTsZEeK1OYRR3BdVs4jJNmVoAoH
         kNPqKF4KotAOzRhuCPRWLuFYoYVXZBp8OpCvop4KzhGmsXmUsZJNDBb316UO1IPRE2PV
         o9sLm46JHvpK9rCWnkoSbovI/tG5xatcI24KnR2pt8q6nKRhLBxTbVHhauUr4NBYONjI
         LI3kHQ//6JXOfOrrskh9QahS+X8WZUrfsr3TJ76YFK3ff1+5HijxA00HyJ/6XB/wd4ut
         gYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=tmJm+SpCPyDqJ1lshIA1ETszu0sVt5hUjFD5g/2kg50=;
        b=C57lbcjof1KEWJv96yW/jhjPi5edBDW4UqHNc80M7UUZVzsHgi49HJ85AMtWqtj6I9
         sCRElP+4PB9NYSsFeKKD5MGt2dtQrpwH+7hd6AnqTj9A0M7UGTO+MtkNlWOrDD2pOkoh
         pZ223+V+0VXlNo9wBV/XarN8xjAIiQbGLxIrLrN0f6TLI86+kLQ/JkOH1g5froVpP+M8
         k9WVpEpaP63Nrs0yLP/waUIBNTaYdMXoZgezmAey3hZAQlweEMkOSZaOo/4B9rxRBkbI
         m9rXGCZTehG5nfZgz0+KmRNo2nkhunbPJW0F5tgJDUhd7/Bre3nddVWgFVr4FKB6N9S7
         S+Zg==
X-Gm-Message-State: ACgBeo1La6astXdhadeKmJSjoZ2hBKYgRBPM+dVFMIidz3DwD+OWheQQ
        o83f6MNpgRGlD9tyYFaEZJ54NYZWcRJPxg==
X-Google-Smtp-Source: AA6agR6GZCf3r5KmUJM1S3uTXeEKj1oUGGU+qcmom++g7ekrhliqaeUv0A+Xqdt1Ba4yqQaLzwQyZw==
X-Received: by 2002:a63:2dc5:0:b0:423:1abf:d0b3 with SMTP id t188-20020a632dc5000000b004231abfd0b3mr28018pgt.211.1660315704696;
        Fri, 12 Aug 2022 07:48:24 -0700 (PDT)
Received: from [10.4.217.209] ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id u13-20020a170903124d00b0016db6bd77f4sm1898601plh.117.2022.08.12.07.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 07:48:24 -0700 (PDT)
Message-ID: <686b645c-c4e1-357f-7c57-b961a1feeda0@bytedance.com>
Date:   Fri, 12 Aug 2022 22:48:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: [PATCH] blk-mq: move bio merge attempt to blk_mq_submit_bio()
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220812083944.79616-1-zhouchengming@bytedance.com>
 <330468da-a778-6cfc-ce46-a62566d71c8d@kernel.dk>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <330468da-a778-6cfc-ce46-a62566d71c8d@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/12 20:40, Jens Axboe wrote:
> On 8/12/22 2:39 AM, Chengming Zhou wrote:
>> We will try to get request from cache before alloc request, in
>> both cases will first attempt bio merge.
>>
>> This patch move this common part to blk_mq_submit_bio(), which
>> simplify the code and avoid passing in the pointer of bio.
> 
> I don't think this will work. If we get a cached request, then we
> know we have a reference to the queue. If you swap these around,
> then that's no longer the case and we can have a use-after-free if
> the queue goes away.
> 

Sorry, thanks for your reply!
