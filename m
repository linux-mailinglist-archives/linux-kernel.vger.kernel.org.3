Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75934C3B7F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 03:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbiBYCMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 21:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbiBYCME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 21:12:04 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A967658;
        Thu, 24 Feb 2022 18:11:32 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d17so3504244pfl.0;
        Thu, 24 Feb 2022 18:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cMIbfsx8xhlhlO0rypyks70MaXjDJamppwKLSs70zXg=;
        b=agWfV/KneIzXmyRrz9MpUkEGgtLQ5KieS3r1T3hSsxxTTjGHJaicT4V4kxEGKONjVE
         Wh9CgIJBTHvaGQ1v7gf9NEIe9gZYcqGNOsHaaSCmxYOJIXCNOGxp76w8CbxJqcO6T134
         qAVaYVuyz3CVRipALOty+jj9f8rTzFIDx+uHOUmgywNiXZHQ2sHCgRoQUqWF2p85L3iO
         xHLYhKcDdQA4d+4B3ipOQwbYvkLjSoAuNv8FHbi7MVmnTNSKXZ+CZUUcknxIhTwIVsgb
         UrlgGSHZX4lw8ZUUmbJ0ZtgJbtse6r5WLZC+Fr83Uo2Us7l75FA76Pzc3QyxQPHsZn8R
         nvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cMIbfsx8xhlhlO0rypyks70MaXjDJamppwKLSs70zXg=;
        b=fkSd/cs//mDToW2GtMB/HWyU3Icz0omhULs9lDCHVdk0f6F0w73AQFmlG2tJ8nPWCZ
         DNjqTYq55GPNWj0JLZZg5K6lkdcVRbZNWaBb0kNZfNwJQblIYmzdlQ/4YqnXvoKF46Yg
         zCqHU4wB8j+ReLAdguqX+AYXIzLDfaYlJstIVwRYGcygUX88HF4Y1RRvucy5qTknpXHM
         6stlTqhF8BeWkNDCvnqB1BczgIivJFxiNzCpi887+mtgO69xxpue+MLRFCVdlcMm1tXW
         xHG/TS3+2y/fB2i88f7ShhWRnqjr+cMEmmodXVpqVXK0ZJMH8NO+Mvq69Nf+9Ma/1vch
         Fv2A==
X-Gm-Message-State: AOAM530V9O/MyT4toVQ0HercQsfocZSGV0ATiAsDx5Jn9G1RfnLgj//V
        zfahBpVAgPA8wLDMdgFEIcP41QALa71Mdg==
X-Google-Smtp-Source: ABdhPJxFcvdnn/j15+geNn7yyDWNYYaTArNomqCKM6Cn4Z8bJTS3viCvPilmLH4a3DbEyOErUhCO7g==
X-Received: by 2002:a63:d201:0:b0:372:c882:210f with SMTP id a1-20020a63d201000000b00372c882210fmr4418862pgg.198.1645755092437;
        Thu, 24 Feb 2022 18:11:32 -0800 (PST)
Received: from [172.20.119.15] ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id f4-20020a63f744000000b00373855b7cf2sm745316pgk.22.2022.02.24.18.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 18:11:32 -0800 (PST)
Message-ID: <99ff40cc-8e56-3dff-ccc5-095844734818@gmail.com>
Date:   Fri, 25 Feb 2022 10:11:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [RFC V5 01/16] blk: make the whole blk_mq_submit_bio under
 q_usage_counter
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220224090654.54671-1-jianchao.wan9@gmail.com>
 <20220224090654.54671-2-jianchao.wan9@gmail.com>
 <YheKOdJdibfxSr5R@infradead.org>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
In-Reply-To: <YheKOdJdibfxSr5R@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/2/24 9:38 下午, Christoph Hellwig wrote:
> On Thu, Feb 24, 2022 at 05:06:39PM +0800, Wang Jianchao (Kuaishou) wrote:
>> This is to protect the rqos list against the rqos open/close. We
>> need to drain all of the caller of blk_mq_submit_bio() before
>> we can operate the rqos list.
> 
> This means ever I/O now has to d an extra refcount roundtrip.

If we want to save cpu cycles for the very fast device, why not introduce
another blk_mq_submit_bio_fast() which can reduce the code drastically.

Thanks
Jianchao 
