Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A36C4B79DC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244347AbiBOVYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 16:24:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238383AbiBOVYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:24:00 -0500
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64779E61D6;
        Tue, 15 Feb 2022 13:23:49 -0800 (PST)
Received: by mail-pj1-f50.google.com with SMTP id a11-20020a17090a740b00b001b8b506c42fso4396934pjg.0;
        Tue, 15 Feb 2022 13:23:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qLbBvFVC577ibqj3b5u8NA+u/tqGnpQje7r8Bqpw0jQ=;
        b=RP7AYWH+B6sgAmrvH3TeuIJipTlj3rfZnKvgzYEinJ92wPCxGcJHTo+XFWartszUP+
         a1DB3Kfqsjp5Ve7OCw1tWDb7k8YBDiQqk5Bj0buZD5p8SjRiIk/xyWLUrBBj0a8QgfDU
         5H7rP9LTBKtQ5zdQfZccdJYbsFutvJEhYXEyfWqxQ9ti5k8W8SLHInr6mXhipmLPDN+V
         vEZEq1xxcAy7b/Xi8YFtWU/R5NnFsCwGYFDp2ga56n4kxBPy2CpBKUb2H6Bimy/UjUol
         bR8poaW/1HtA4TKwHVHErgbnObKsJrsZn6qywH7VBLw13DdJG9kK8NZop1GuaW6wwDG2
         9HOg==
X-Gm-Message-State: AOAM530YO46fuFJbLr7Gx++uzaYzoAG20VR0faC6JvcjJGX3UOd3JsmA
        QDG2Q1R8zxNmgV8JD/m3hy0=
X-Google-Smtp-Source: ABdhPJyXyPE8wHBIybkMAui490IDkz5GW+uKQmy+kw6bryVQjCpYwAkIB+67yW7npKmMzZJbTESv7w==
X-Received: by 2002:a17:902:e74b:: with SMTP id p11mr642867plf.115.1644960228705;
        Tue, 15 Feb 2022 13:23:48 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id pc18sm7701980pjb.9.2022.02.15.13.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 13:23:47 -0800 (PST)
Message-ID: <517dddb8-efd6-6b1a-fa1b-eba6f2c93119@acm.org>
Date:   Tue, 15 Feb 2022 13:23:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [RFC V2 1/6] blk: make blk-rq-qos support pluggable and modular
 policy
Content-Language: en-US
To:     "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     hch@infradead.org, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220215123705.58968-1-jianchao.wan9@gmail.com>
 <20220215123705.58968-2-jianchao.wan9@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220215123705.58968-2-jianchao.wan9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/22 04:37, Wang Jianchao (Kuaishou) wrote:
> @@ -337,6 +338,7 @@ void blk_cleanup_queue(struct request_queue *q)
>   	 * it is safe to free requests now.
>   	 */
>   	mutex_lock(&q->sysfs_lock);
> +	rq_qos_exit(q);
>   	if (q->elevator)
>   		blk_mq_sched_free_rqs(q);
>   	mutex_unlock(&q->sysfs_lock);

I think this change should be a separate patch with tag "Fixes: 
8e141f9eb803 ("block: drain file system I/O on del_gendisk")". See also 
https://lore.kernel.org/linux-block/b64942a1-0f7e-9e9c-0fd4-c35647035eaf@acm.org/

Thanks,

Bart.
