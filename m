Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD88528C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 19:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344419AbiEPRlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 13:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344344AbiEPRkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 13:40:55 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156393701F
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 10:40:54 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id r27so16770673iot.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 10:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bkBYbqFw8Uqt2LrlL3b8A2k4CheYeXwKOqf0DAmC3h4=;
        b=n1mNAB+0PSwsAxiakcc+rlhe/EZVDgezWHiyER1cVuh4UPi8Ymz2Syc3w6wYTymETD
         pr2G+uID5qk/YWsWl0tUYPtYQBsBW9gAfcctEIWpNzFxIm/5/SoH/ZugZXxd8dr/9Se4
         DwAg20e8QGCXPzZ0AaTnlCL1hCBAjwXIyhURn+858wfM4tfuL+JPpem6qUf0vDQbC5dl
         Fs4gXpfr0ZH7NCdNV6gDoN2V3k/rejOnfR08RACy0bUvkXOXWwFdyuW1EQIq3kHJxXNv
         OHeH/C6qrx0Okx7gnHjXHm28c6ZlvLzHWsmSyKs9c5g5n9fH85Wz/H147j7CK8XXZD1T
         Ujxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bkBYbqFw8Uqt2LrlL3b8A2k4CheYeXwKOqf0DAmC3h4=;
        b=trvNmNsYinPD3nnXHIbjLYXUnvYhl7sXGuwPib4aRCa+y321ROqHLNu92dKzjFlWuW
         mmObPEBoP0a7pnd0AZXJD3VOgKadLKNn7W8u9zTeklr3QsD46LexYgfSuL9qu/Hdx7RC
         FNeX5ajsuIgStQHZ7lmU8qGUBx9LsuscLyuVAvW7FeS7sumQMFIVZNPLwbWKJWfRr6gf
         kHy/ULQa5n9nzL6/s2vGAaXfRgexQzR/YcZkExU9J/ye+N+uGkHFUCyklZ7V7LT5uzTX
         DCdr5QtEmHCLSaqP0nERbwyNUWGbXyE979+Ffw4RfKUWEpwDZ2TDPr962Vg+VIloX+Uk
         NcLQ==
X-Gm-Message-State: AOAM531M6b1MeWBtSMwyU87sut/LekCwAGSu0/S3MeWbEy38WJebzvHW
        07wNT0h2G5cfk04nEFDt8hQ4XQ==
X-Google-Smtp-Source: ABdhPJwzFS9gS5AVmSDi/Y7kLQ3Xm6tjAaR656Vkq1IYvhBKxr5hb7ksEb4pvoQfzpinz9N7d7RqLQ==
X-Received: by 2002:a05:6638:196:b0:32d:fde1:582d with SMTP id a22-20020a056638019600b0032dfde1582dmr8912456jaq.134.1652722853481;
        Mon, 16 May 2022 10:40:53 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id n11-20020a02714b000000b0032e16c566adsm1757970jaf.109.2022.05.16.10.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 10:40:52 -0700 (PDT)
Message-ID: <83042952-30e9-849a-be31-c31e951e8d70@kernel.dk>
Date:   Mon, 16 May 2022 11:40:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] blk-iocos: fix inuse clamp when iocg deactivate or free
Content-Language: en-US
To:     Chengming Zhou <zhouchengming@bytedance.com>, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
References: <20220516101909.99768-1-zhouchengming@bytedance.com>
 <bbd8744f-d938-c4a5-cb02-145c9875ea53@bytedance.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <bbd8744f-d938-c4a5-cb02-145c9875ea53@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/22 6:18 AM, Chengming Zhou wrote:
> Then this effect is very small, unlikely to have an impact in
> practice. Should I modify the commit message to send v2 or just drop
> it?

Send a v2 please.

-- 
Jens Axboe

