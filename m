Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5976252E081
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343584AbiESX06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiESX0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:26:53 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3AE5DA77
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:26:53 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id q4so6013041plr.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hN1UVFZcHVZe/aX8AZVRuJQjZ0Tbe8mm2XkylAcwM2E=;
        b=Iqx87aOK7wpiNZHttyixFPp5iLKq5cuPG4xod0y/8C60/7OyXuqOQOVuYkLBVMuJDR
         9XZIpYJEgOGxheBl0mxJIn1KZfETUspRD39YlDiCMGSGcWVZRFudDwZF0KAYKVK865ZZ
         HD++V2ZLr7kltRCjK52M94uddECJQe+8XE1/tj/BirgSAKbzU95zOOpHv16cpb6dg228
         3eYV30mtl4ul1sCzkeeW2UGY2gRcWrA9DsCYp5OXn9cqFV3RhtNX/dlq8P2u73tArNPh
         CsvYZVMY8OP3fl8yYklfgyue1OLYRLd4MnHqX3Pzq9uR+atbTDZAXue6x4SlQP1zFU9G
         UuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hN1UVFZcHVZe/aX8AZVRuJQjZ0Tbe8mm2XkylAcwM2E=;
        b=Faxbl86Q4eFJ9SgeZ/IEM8K2aiJaldi2LLz00y4gY4MkfUQ0buFjorZb9S6UAOLcHF
         XWPWXinZdDxZH90S/yqTNBafWd1jjDaoAZXmSXqDGe7VmAX7q3H+wi1f1jma6zcI/maE
         tJf701Pky8bL5wGL3zN3usK6ogkDbgoNtj6k7svQS/zvN3gt1cvtXQzkF3Vte8PRgU7Z
         gws6JByoPfNE7OUuzfgMoNSY7ChGqk9iroFhs/C+71TbD5RPcdufTjtXQCzgbgGqBJgZ
         /6Eq32gP6PBjrLpKItqQZxsYs/Klv32W/YlvmCg7QCDZbYFb2rOxSjxRumK6mp/Kk+gh
         eT1w==
X-Gm-Message-State: AOAM532Spimhm7vFpxSPnQ7Q/ez3u4IiMB+jZJF/eT9jZI2Cd/9oa393
        P6Q05isH7WTSeMSK8ivGM7VfhQ==
X-Google-Smtp-Source: ABdhPJxC3sL7IlF6/2bkocTtvRtFPFk31HnOm6sQ7cWChMzqF2T8P3M9K3yVRRgsFfLIzJ+MW3QHiw==
X-Received: by 2002:a17:902:9a4c:b0:156:6735:b438 with SMTP id x12-20020a1709029a4c00b001566735b438mr6756466plv.46.1653002812546;
        Thu, 19 May 2022 16:26:52 -0700 (PDT)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id h8-20020a654688000000b003f60df4a5d5sm3847797pgr.54.2022.05.19.16.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 16:26:52 -0700 (PDT)
Message-ID: <25fb057a-077f-b601-dcb7-130071c733db@linaro.org>
Date:   Thu, 19 May 2022 16:26:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] cgroup: don't queue css_release_work if one already
 pending
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>, Tejun Heo <tj@kernel.org>
Cc:     Michal Koutny <mkoutny@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        syzbot+e42ae441c3b10acf9e9d@syzkaller.appspotmail.com
References: <20220412192459.227740-1-tadeusz.struk@linaro.org>
 <20220414164409.GA5404@blackbody.suse.cz> <YmHwOAdGY2Lwl+M3@slm.duckdns.org>
 <20220422100400.GA29552@blackbody.suse.cz>
 <20220519112319.2455-1-hdanton@sina.com>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
In-Reply-To: <20220519112319.2455-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 04:23, Hillf Danton wrote:
> On Wed, 18 May 2022 09:48:21 -0700 Tadeusz Struk  wrote:
>> On 4/22/22 04:05, Michal Koutny wrote:
>>> On Thu, Apr 21, 2022 at 02:00:56PM -1000, Tejun Heo<tj@kernel.org>  wrote:
>>>> If this is the case, we need to hold an extra reference to be put by the
>>>> css_killed_work_fn(), right?
> That put could trigger INIT_WORK in css_release() and warning [1]
> on init active (active state 0) object OTOH as the same
> css->destroy_work is used in both kill and release pathes.

Will this help if there would be two WQs, one for the css_release path
and one for the rcu_work?

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index adb820e98f24..a4873b33e488 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -124,6 +124,7 @@ DEFINE_PERCPU_RWSEM(cgroup_threadgroup_rwsem);
   * which may lead to deadlock.
   */
  static struct workqueue_struct *cgroup_destroy_wq;
+static struct workqueue_struct *cgroup_destroy_rcu_wq;
  
  /* generate an array of cgroup subsystem pointers */
  #define SUBSYS(_x) [_x ## _cgrp_id] = &_x ## _cgrp_subsys,

-- 
Thanks,
Tadeusz
