Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9158E4FA1A9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 04:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238099AbiDICae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 22:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiDICab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 22:30:31 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CE353A78
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 19:28:24 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ll10so1826315pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 19:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aP/uEaYpsHrJ8Gy8ffXu+nyzx0P9m+j2gLhkvWYNHO8=;
        b=FixpIaCvf2/5FS8G5XpQa4vwIkx44LKaD0JlnAtR18K43rkynRPe2QhPtdq60IfH/v
         SgDblxwh6K4UlulMSOy8Z30ZttqI74PNtO3KfVpdu0RZGoG3DjKj+WHGFzzCHr9cXZC4
         w177gBQfMZ/Y2nVN0DDpnXLbmEm/Y9IpbtEzp/7fEEYwwvDN21iTDhJivZnmt+UJHlIe
         fsFPhSh55OhtbyIHi5ksO7cAluBnD3F1Bje3Ve/Jqcy6TuoX1oVMeXh6v8buefZln/ob
         GTUX86LDkxRSdwvM7q2paH8oy87yW2/mdG8L83UPrFrjV59lAGzWnrCRvvvU9zR5woxC
         Xfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aP/uEaYpsHrJ8Gy8ffXu+nyzx0P9m+j2gLhkvWYNHO8=;
        b=ehE7WjMa4Q7KqKGUQ6AB3Qe4CcObAgdVs4inXE4QzPSgxiaHVIqsndR5fEbdWEEgW7
         Ny5+642QP5wcOYC0N7VDc3pFggwik/Y1YHyFmH4IxpPz27fp8zsCGxkJqciBlQu3wE07
         3sEpSjUHm8d714mWa3ja3+mszLp6O2kNBwEdJgpogV6z66wtkA1HlYn1CLVU/aXbY1U5
         4Z/xgTGAZ/vpkOJulsgz9TkkZrbMKp2W8ZfDhaOGHywCG3MRJ2l6VWYiSW+GixzJ0XZ0
         TUvckifa0yaKhXwrBZXwQel5qt85H5Io+JjydQS5LKxUEZNAOWdSCic0QjbOdrvMPcJM
         0nCQ==
X-Gm-Message-State: AOAM532edQXcs+X+JTUUS67Y5+MEqf4ZL5yCwKf8dY0wMgeN7MsZuIzs
        LYT1yZea96Qu9DYzv9HOjUQBPpAq2fZi9A==
X-Google-Smtp-Source: ABdhPJy+TzZDF9jQhI5qKF0oImy73TjPXXrrcmBng8ALso07xGqsuiiwEtDc9mXlAxmM0sC1q1xdvA==
X-Received: by 2002:a17:902:c643:b0:156:b53e:60e1 with SMTP id s3-20020a170902c64300b00156b53e60e1mr22428468pls.43.1649471304208;
        Fri, 08 Apr 2022 19:28:24 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090a154600b001cb59d912f1sm1255901pja.13.2022.04.08.19.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 19:28:23 -0700 (PDT)
Message-ID: <98d3b9b9-1786-837c-d316-cc991305c8aa@kernel.dk>
Date:   Fri, 8 Apr 2022 20:28:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next RFC v2 0/8] improve tag allocation under heavy load
Content-Language: en-US
To:     "yukuai (C)" <yukuai3@huawei.com>,
        andriy.shevchenko@linux.intel.com, john.garry@huawei.com,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20220408073916.1428590-1-yukuai3@huawei.com>
 <d50a0ee1-c7e2-1b99-8d3f-ce2edeea92cd@kernel.dk>
 <d02f416f-a1de-f7d9-881e-a88c1bdd25c1@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d02f416f-a1de-f7d9-881e-a88c1bdd25c1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/22 8:26 PM, yukuai (C) wrote:
> 在 2022/04/09 3:10, Jens Axboe 写道:
>> For this one, and other patches you send, they send up in spam because
>> the sender can't be verified. I would encourage you to figure out what
>> is going wrong here, because a lot of your patches end up getting
>> dropped or missed because of it.
>>
> 
> Hi,
> 
> Thanks for your notice, however, I have no clue what is going on right
> now. I'll look for some help and hopefully that can be fixed.

The easiest is probably to try and send patches to a gmail account. If
you don't have one, just create one. That will help you see the issue
and verify whatever the fix might be. It might be a company email
server issue, hower.

-- 
Jens Axboe

