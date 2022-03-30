Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0EA4EC5F3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346346AbiC3Nvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243622AbiC3Nvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:51:36 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856C2E339F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 06:49:50 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o3-20020a17090a3d4300b001c6bc749227so6257654pjf.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 06:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pTPymMdQgFl+qNBk1dkxT3ma9TeBkKnfldwjxUhrxOk=;
        b=MK5oAgTfTbUi11X1MeAaypUSJynlIL4eda9F8PDqjoTB/C+cg5WtqnYT394Ssh2/1j
         Ca4ZKqK/3bEJSSuWIzOIU3LDc4LVd04RqAIK4ehScUYH4PnwiInhTx9gBbXxxWe8RiUd
         hkQ9x8wZtIVR9KgQJ+hjBAwOKtqGW5v6c6MqnaoMBZp9bRo1n7SGmg+XUNapHbg3MYNA
         EmXxEir+x34H6VmkoRMK1W9V11VPzxkk6M5ThGQdRq4j8PXorqe+zcSnUWr28ynu3HtK
         UVeNhqFBF1pUlrTB2XsAedLwRBA0vmx2sgEpBfJlR7CyUOYlN4eNY8zRyXXtMwSxY6an
         FkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pTPymMdQgFl+qNBk1dkxT3ma9TeBkKnfldwjxUhrxOk=;
        b=4PRGgvq/KHwKxHR7YG81A7ouAklBFzpWJL5N6Ori18YDNHgRqMUrahIpbGJOle27hi
         j5Wy1Mdmz14X2RqHFQG1AdfM0+htcpXLQyW+3Qavo22FNfRDXAsNt/AqrCqW+bvhWkBi
         7f9RBTa+VN9rZWBkF7mpotGjeLrFdJNPn+0SsNgBBLnSvGIidUqm59AyW1DSLAwwuWez
         OxOGCd4kvRMO1X8KypdDk9H0w3Uw5UPQucW9Sesmi6/2yqcZw4YLpn9McnWE7PGB+5mt
         k6kl6qwN3jepYyug4Gy1qc7VSKlSJFhtjoLOZckUl7w3SEfnOElCJczbWvPsEajcJqzP
         COBQ==
X-Gm-Message-State: AOAM530jsO7WmBIyMzfY/rZorRDIsosfoKMvJZ5+aeGveAgxVc9rORKt
        USV8Ecx4+M3ksBoasfn/DYkGdg==
X-Google-Smtp-Source: ABdhPJyil2ooSr7lhSFj2wMmQw4oKk0xYR7aRhy/GD4hCEPATCC87hH9099pofRsVbZcfOiXhXlueA==
X-Received: by 2002:a17:902:7781:b0:153:35ef:e3d1 with SMTP id o1-20020a170902778100b0015335efe3d1mr36386212pll.116.1648648189964;
        Wed, 30 Mar 2022 06:49:49 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h12-20020a056a00230c00b004faf2563bcasm23262164pfh.114.2022.03.30.06.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 06:49:49 -0700 (PDT)
Message-ID: <dbb7a09d-2833-240b-15af-4b72c4ea83bb@kernel.dk>
Date:   Wed, 30 Mar 2022 07:49:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] block/psi: make PSI annotations of submit_bio only work
 for file pages
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     CGEL <cgel.zte@gmail.com>, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
References: <20220316063927.2128383-1-yang.yang29@zte.com.cn>
 <YjiMsGoXoDU+FwsS@cmpxchg.org> <623938d1.1c69fb81.52716.030f@mx.google.com>
 <YjnO3p6vvAjeMCFC@cmpxchg.org> <20220323061058.GA2343452@cgel.zte@gmail.com>
 <62441603.1c69fb81.4b06b.5a29@mx.google.com> <YkRUfuT3jGcqSw1Q@cmpxchg.org>
 <YkRVSIG6QKfDK/ES@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YkRVSIG6QKfDK/ES@infradead.org>
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

On 3/30/22 7:04 AM, Christoph Hellwig wrote:
> On Wed, Mar 30, 2022 at 09:00:46AM -0400, Johannes Weiner wrote:
>> If you want type distinction, we should move it all into MM code, like
>> Christoph is saying. Were swap code handles anon refaults and the page
>> cache code handles file refaults. This would be my preferred layering,
>> and my original patch did that: https://lkml.org/lkml/2019/7/22/1070.
> 
> FYI, I started redoing that version and I think with all the cleanups
> to filemap.c and the readahead code this can be done fairly nicely now:
> 
> http://git.infradead.org/users/hch/block.git/commitdiff/666abb29c6db870d3941acc5ac19e83fbc72cfd4

This looks way better than hiding it deep down in the block layer.

-- 
Jens Axboe

