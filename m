Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8E04BB04C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 04:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiBRDld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 22:41:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiBRDlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 22:41:32 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16E5B18B6;
        Thu, 17 Feb 2022 19:41:16 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id d16so6732999pgd.9;
        Thu, 17 Feb 2022 19:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IO9s8KzRes95vzfkF7po1cE6U/yprrUy5xOgD2OSUu4=;
        b=ON3tYEw/7+3ccvxhEx90PqtB6dGsTiQOSIRCkXBXa/ykFOEXPWEOQv8iaAsD5MhEk9
         Fi2YzjXH3edf5xlWOYV0pJt2z/hP4ZWwNLLCnKCS+UrAE69Zbvp67rnIeaXiY3pxf9v0
         zZxaXIAZRtKhZ6SQgYTD6kEUR+DEHrdICGGZhmZ7VfvKcc3BVD3D19tzs6qQ8YlpiPln
         sllGf7i61bpMPJ3k5pTHyZjC+bjvFh5K8T91WfA8/MOBl+PQeaQe7Rp489cqRLW9XbN6
         9RjB9ertGPP/I4eWyGGYeLjA1J4rGmjRPtRoCTTXugIwtF53BWYi1kdNgKFHwLVkzjjF
         FJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IO9s8KzRes95vzfkF7po1cE6U/yprrUy5xOgD2OSUu4=;
        b=HJlBdOxUDmHH8fy+hNDY6d3luECPnA7OW9veSnwATQQR/t9RuUSJgZBe/5Uv+9Ekd0
         20p/jV/O+P11ipeFM62S1bZ4F9TBX5S8DMcLTAUs99f7Ma8scxG+T39Do4gO3LDt7RCD
         VBg2DJTBIKjDNKzQXMo4VAa2YFiZuGOH2yFrguzrjZCZaVeyiEEoJiaS+JAjsoOKJWG+
         HnEOe0b5XNRTLkFZld5y1NlHwCo64GDG02vqsLJPN2CG26h8k7Mez+tD7WJpAyWUuonD
         2sWTHNmlN0XH5OeRJKP8vOEbxIqDxSziDsRBZZckwXPUzZD0AxqoTMs2mB/GekfS/IlY
         oetQ==
X-Gm-Message-State: AOAM532hfspP5MuIROyaeNO2hQilmTDXX9wwu/+r9/U8w1VWSECBJrHL
        dPsxI9JBP5xIteBVaiyfFdU=
X-Google-Smtp-Source: ABdhPJwd6cr/xrdWP6jxd0afu7D5RpFS8K7nU2iDuksHf9i7m2G/f7+NEAJQA+nRszt/SY9o9ifWpQ==
X-Received: by 2002:a63:5f0f:0:b0:370:1db0:5766 with SMTP id t15-20020a635f0f000000b003701db05766mr4816692pgb.532.1645155676052;
        Thu, 17 Feb 2022 19:41:16 -0800 (PST)
Received: from [172.20.119.15] ([103.112.79.203])
        by smtp.gmail.com with ESMTPSA id ng16sm3245301pjb.12.2022.02.17.19.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 19:41:15 -0800 (PST)
Message-ID: <6e6df16c-3609-71ef-c147-435920e59e8c@gmail.com>
Date:   Fri, 18 Feb 2022 11:41:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [RFC V4 2/6] blk-wbt: make wbt pluggable
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220217031349.98561-1-jianchao.wan9@gmail.com>
 <20220217031349.98561-3-jianchao.wan9@gmail.com>
 <Yg4MQSUZZu9D+qJu@infradead.org>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
In-Reply-To: <Yg4MQSUZZu9D+qJu@infradead.org>
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



On 2022/2/17 4:50 下午, Christoph Hellwig wrote:
>> +struct rq_qos *wbt_rq_qos(struct request_queue *q);
>>  int wbt_init(struct request_queue *);
> 
> 
> Please move the wb_lat sysfs attribute into blk-wbt.c as well, which
> removes the need to expose these two functions.
> 

Given this patchset:
(1) Do we need to reserve the wb_lat sysfs when we turn off the wbt ?
(2) Do we need to disable wbt automatically when switch io scheduler
    to bfq ? Or just tell the user turn off the wbt by themselves ?

Thanks
Jianchao
