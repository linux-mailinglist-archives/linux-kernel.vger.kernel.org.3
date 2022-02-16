Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6294B7D4E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 03:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343564AbiBPCM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 21:12:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343616AbiBPCMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 21:12:14 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7AE89301;
        Tue, 15 Feb 2022 18:11:59 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id l73so813802pge.11;
        Tue, 15 Feb 2022 18:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4ze8g2rRwpD8xn/HeLOWitwi8nK0K8VN5d++TBjbm+s=;
        b=RkqOGZu+6yxWNJV9d7Z97eFiyAU8t71o5c2XOPUgJ1LEzNN+VQXO8mMHFsiOKt39XR
         n9pwmp3HGOX8KjAFvoDV42upFWrzXVoYLpmz/vyO0zSfS/7ZBz0BbJBuHdqcWQ+Kisz6
         rtE60Z85QqOZqKs6j52FcOZGE8lkRXFlAYnXKHAFUdlN75BROBPK+4HRFUqjTUxx8WbI
         yhDtwO8GDi/fJK95y9qBk+52cLWSpZFW9ZiHPxVRZu5lV3hVs1AX53bhb5FUEBvdgKIf
         b8Xf+HRwlwK60YTd4nNyP2qBmbihuXL+0pPx/SNzPZWWALnptDYafo7TDJ2GTxfa2Ae1
         Ih7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4ze8g2rRwpD8xn/HeLOWitwi8nK0K8VN5d++TBjbm+s=;
        b=qseOElyr727jEbanz7CkI9pxgAszUrwm5MMrz1WIbk4hUdWGXyHl/ALyI9J/wm/REU
         HqC1m7YiPYKhYcWvm1IR2DkA251pgCv8FcXfq0bA7NSaNjhZFZKOF9ayOxExwH6mh4aK
         /AFYwzLJNP4KXt6w4PpSCbzfYNay8mbir7XcrQ7LUTisf8n+nZPE8bFr7PecWxSQE9P0
         yuv7ke2Ed8EcgBDztwMG6unpXb2yAb4RsnT9NYlW7Z8HA6uZ100PEbQWR9uDwOFT+W5P
         jyAAqoin266+/4qG13wavSPXYlZ0Xhj31iNw/O+5ZqubMi6iTi/bsdl1cp/lx/KJooYJ
         7LFw==
X-Gm-Message-State: AOAM533VepGWbGqr7cB1EcCJxyHPprIynfIgsUc1xh3g2unRiVuT8npc
        6p++A4FYSnPbKJ5njas/P+Q=
X-Google-Smtp-Source: ABdhPJzB9WATXJzselA3rhvOjsOrntAX6g+FsyB/uMCT5bPTZhW/XlU12qEDG2/wye1gl0AxgAIYlg==
X-Received: by 2002:a63:5f0f:0:b0:370:1db0:5766 with SMTP id t15-20020a635f0f000000b003701db05766mr430153pgb.532.1644977518882;
        Tue, 15 Feb 2022 18:11:58 -0800 (PST)
Received: from [172.20.119.15] ([61.16.102.72])
        by smtp.gmail.com with ESMTPSA id mt19sm18298946pjb.32.2022.02.15.18.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 18:11:58 -0800 (PST)
Message-ID: <90486cfb-f3b5-2067-738f-f3fba8f9d09a@gmail.com>
Date:   Wed, 16 Feb 2022 10:11:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [RFC V2 1/6] blk: make blk-rq-qos support pluggable and modular
 policy
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     hch@infradead.org, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220215123705.58968-1-jianchao.wan9@gmail.com>
 <20220215123705.58968-2-jianchao.wan9@gmail.com>
 <517dddb8-efd6-6b1a-fa1b-eba6f2c93119@acm.org>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
In-Reply-To: <517dddb8-efd6-6b1a-fa1b-eba6f2c93119@acm.org>
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



On 2022/2/16 5:23 上午, Bart Van Assche wrote:
> On 2/15/22 04:37, Wang Jianchao (Kuaishou) wrote:
>> @@ -337,6 +338,7 @@ void blk_cleanup_queue(struct request_queue *q)
>>        * it is safe to free requests now.
>>        */
>>       mutex_lock(&q->sysfs_lock);
>> +    rq_qos_exit(q);
>>       if (q->elevator)
>>           blk_mq_sched_free_rqs(q);
>>       mutex_unlock(&q->sysfs_lock);
> 
> I think this change should be a separate patch with tag "Fixes: 8e141f9eb803 ("block: drain file system I/O on del_gendisk")". See also https://lore.kernel.org/linux-block/b64942a1-0f7e-9e9c-0fd4-c35647035eaf@acm.org/
> 
Yes, I will do it in next version

Thanks
Jianchao
