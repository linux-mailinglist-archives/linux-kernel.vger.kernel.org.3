Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6F1591532
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 20:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239198AbiHLSDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 14:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239051AbiHLSDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 14:03:00 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AB1B286F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 11:02:58 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id e69so1406253iof.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 11:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=YDIeaMayMePbFFEZfRg4KNaQU0N6KJWPDi6PrFqlz2A=;
        b=2oQF0YneF/uXlJTQeXOxbREO2AQNgjBR3gd0r9xztKDHonT7Q6ejaGVKHRr1az8cYx
         J09PYZHWooKMURuarWSMQoP10Pjnn9hzT6oG67j16D25X6paOnCFeSGINThTWrZ66Dqr
         A2POu/qEBo9NEmcaUEFv6qRKXEyXEObuZ4huFVXdBFDVzd+Z987K7wfh8qPpADY8Izob
         FoSal+2wczZjWuNKvx7XiY+YaeEWH4QvkZMsBDQk0jYiWmTmTedkOLhmqKFvDeSGuAZW
         sb06gzRCARFtirfu7F2PMixT3dc/Dn7byxhMZ224kE3n3Vfu9l5qtKzJCgJ9hqJ5EsmL
         MQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=YDIeaMayMePbFFEZfRg4KNaQU0N6KJWPDi6PrFqlz2A=;
        b=TTFXat3RA0k9U1qggy2p+oC/CEJ425txirNos+RZeDyc03tmo9Q11VsX7ZQTOpfTeN
         AqRg2VeVbPjLdVuh8MsDbAEkmEU5NXg0fi5lZrc97EADIz2BpOI2sSEdp9503uJEaXpz
         fP8Rs+hkCybW7Eczj6NXqfoToesgZNNLhpnmSO18vNDIwc/uHqgvnfF+Ouv9z4gHY/d7
         AQLsoJ9HC8i2wQh75JGU2ru61DhbQI5ZUQnYsJKOGS9wxorRPjoRdO/+RKQfBXC5+i/c
         fE+pyLb3+ibDsePclW4jllNUqln+muklEgOKRBgx3mS13BoRORHtVWX6qAYYJBf/3kYj
         NkHw==
X-Gm-Message-State: ACgBeo28y2BxrWdNRjFLwszC4F+yt/xiogF2sjtrt6/EL8rhooY9kKB9
        BBPLbtrSgyRmSDpGj6CH0uf/Nw==
X-Google-Smtp-Source: AA6agR4tFtRMXErWJxk4eoAtCsxNAEGyQVNZEpj4uiYVMhWPJXdGUh/TnUc1Z3h/iTIz1hjzIunhSw==
X-Received: by 2002:a6b:2a46:0:b0:684:5fc3:5f21 with SMTP id q67-20020a6b2a46000000b006845fc35f21mr2185993ioq.154.1660327378094;
        Fri, 12 Aug 2022 11:02:58 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b65-20020a0295c7000000b00339ef592279sm136813jai.127.2022.08.12.11.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 11:02:56 -0700 (PDT)
Message-ID: <d48c7e95-e21e-dcdc-a776-8ae7bed566cb@kernel.dk>
Date:   Fri, 12 Aug 2022 12:02:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: stalling IO regression since linux 5.12, through 5.18
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>,
        Chris Murphy <lists@colorremedies.com>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
References: <e38aa76d-6034-4dde-8624-df1745bb17fc@www.fastmail.com>
 <YvPvghdv6lzVRm/S@localhost.localdomain>
 <2220d403-e443-4e60-b7c3-d149e402c13e@www.fastmail.com>
 <cb1521d5-8b07-48d8-8b88-ca078828cf69@www.fastmail.com>
 <ad78a32c-7790-4e21-be9f-81c5848a4953@www.fastmail.com>
 <e36fe80f-a33b-4750-b593-3108ba169611@www.fastmail.com>
 <CAEzrpqe3rRTvH=s+-aXTtupn-XaCxe0=KUe_iQfEyHWp-pXb5w@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAEzrpqe3rRTvH=s+-aXTtupn-XaCxe0=KUe_iQfEyHWp-pXb5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/22 11:59 AM, Josef Bacik wrote:
> On Fri, Aug 12, 2022 at 12:05 PM Chris Murphy <lists@colorremedies.com> wrote:
>>
>>
>>
>> On Wed, Aug 10, 2022, at 3:34 PM, Chris Murphy wrote:
>>> Booted with cgroup_disable=io, and confirmed cat
>>> /sys/fs/cgroup/cgroup.controllers does not list io.
>>
>> The problem still reproduces with the cgroup IO controller disabled.
>>
>> On a whim, I decided to switch the IO scheduler from Fedora's default bfq for rotating drives to mq-deadline. The problem does not reproduce for 15+ hours, which is not 100% conclusive but probably 99% conclusive. I then switched live while running the workload to bfq on all eight drives, and within 10 minutes the system cratered, all new commands just hang. Load average goes to triple digits, i/o wait increasing, i/o pressure for the workload tasks to 100%, and IO completely stalls to zero. I was able to switch only two of the drive queues back to mq-deadline and then lost responsivness in that shell and had to issue sysrq+b...
>>
>> Before that I was able to extra sysrq+w and sysrq+t.
>> https://drive.google.com/file/d/16hdQjyBnuzzQIhiQT6fQdE0nkRQJj7EI/view?usp=sharing
>>
>> I can't tell if this is a bfq bug, or if there's some negative interaction between bfq and scsi or megaraid_sas. Obviously it's rare because otherwise people would have been falling over this much sooner. But at this point there's strong correlation that it's bfq related and is a kernel regression that's been around since 5.12.0 through 5.18.0, and I suspect also 5.19.0 but it's being partly masked by other improvements.
> 
> This matches observations we've had internally (inside Facebook) as
> well as my continual integration performance testing.  It should
> probably be looked into by the BFQ guys as it was working previously.
> Thanks,

5.12 has a few BFQ changes:

Jan Kara:
      bfq: Avoid false bfq queue merging
      bfq: Use 'ttime' local variable
      bfq: Use only idle IO periods for think time calculations

Jia Cheng Hu
      block, bfq: set next_rq to waker_bfqq->next_rq in waker injection

Paolo Valente
      block, bfq: use half slice_idle as a threshold to check short ttime
      block, bfq: increase time window for waker detection
      block, bfq: do not raise non-default weights
      block, bfq: avoid spurious switches to soft_rt of interactive queues
      block, bfq: do not expire a queue when it is the only busy one
      block, bfq: replace mechanism for evaluating I/O intensity
      block, bfq: re-evaluate convenience of I/O plugging on rq arrivals
      block, bfq: fix switch back from soft-rt weitgh-raising
      block, bfq: save also weight-raised service on queue merging
      block, bfq: save also injection state on queue merging
      block, bfq: make waker-queue detection more robust

Might be worth trying to revert those from 5.12 to see if they are
causing the issue? Jan, Paolo - does this ring any bells?

-- 
Jens Axboe

