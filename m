Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E8D595DE8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 16:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbiHPOBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 10:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbiHPOBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 10:01:43 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEB26EF11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 07:01:41 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so9705428pjk.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 07:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=erk4QjfKLI1wqXEF6e5iSvx1UiCDlKAdjqB4/lN4Erk=;
        b=Y0g/2vtkm1HDsEQno8ZsLNKBwZANZXHmx08W3wcN28MC03rqN8MuI64iRs+rHEj/xM
         Mhgh3CWWqwIHvp1zbpwHD9c7qXg8eE0IRMI8lE/Bs7Oc8V/33m9VXiuhskmTBfgxD9NZ
         Mq62JekBPMAcUxs3Ilcqg2rqG1qAlFVad2zD270PHvYGPCENWlJsVUgAAgaml9ycj8+R
         a3jNEi3vDV1kpIpykK09HTqW8zI8WIjy7FGbgBfUo8YJAns9J0U7Fg6u4PI2mpVSLveW
         3onWPrEs8plVxEpuEm8C8LSAqbQuxfh0aI9mUsW5fx9yeIMqQ/EHbVhAWxDUX3eJSAq/
         eMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=erk4QjfKLI1wqXEF6e5iSvx1UiCDlKAdjqB4/lN4Erk=;
        b=xNqR4JZrNv+uy3Bi8huh1nepNf0DQbHi/8rh/opkVeex9gsZCK7/l1CDsEs+qZBaiM
         284n867IALYUsVNBUJOoCS90E/aKtioDbjnh1h3s4HvrwBACCIFWHyj15yvRjEXfdXXp
         ftoh7mcTGKhP8MeyLuIG2AyahP6sSmgm1oHwTV9yWIxKUVK0/gpTDpmhdX7q/U4SV58b
         hnS6/xK5hSW7e9i4QfNRYADcYAxo/mkZK2LEZmaUzzFvONCFJCjHS/TsBO3xiN61AJ8n
         UURaVZBKm3iKiMoI8B6Cdevh0Sih7i4dvPoesF+nn17iybhk1Tt4zsty82vlUbWoMYyi
         325w==
X-Gm-Message-State: ACgBeo1h8S+Yb1bkbHQjV3E0/FB9U0xHPTg2bOxt6pcEki8b9fLu+Ei7
        PxSex4dPiHmqWPtgBwOqkjUxyrk8BQNtsA==
X-Google-Smtp-Source: AA6agR5Vh5FoZEV/vDsCM3Tgms3lMElLgMMSYRP2EDYbKRNWdE3cxEILRzOEG90g4VS6xpelMOT0Tw==
X-Received: by 2002:a17:903:2291:b0:16e:cf55:5c72 with SMTP id b17-20020a170903229100b0016ecf555c72mr22182498plh.121.1660658501401;
        Tue, 16 Aug 2022 07:01:41 -0700 (PDT)
Received: from [10.4.196.37] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id r35-20020a17090a43a600b001f522180d46sm6396363pjg.8.2022.08.16.07.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 07:01:41 -0700 (PDT)
Message-ID: <08ec9c4f-80b2-f731-aa8b-fb4e852ece25@bytedance.com>
Date:   Tue, 16 Aug 2022 22:01:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH v2 00/10] sched/psi: some optimization and extension
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     hannes@cmpxchg.org, tj@kernel.org, corbet@lwn.net,
        surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
References: <20220808110341.15799-1-zhouchengming@bytedance.com>
 <20220815132514.GB22640@blackbody.suse.cz>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220815132514.GB22640@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/15 21:25, Michal Koutný wrote:
> On Mon, Aug 08, 2022 at 07:03:31PM +0800, Chengming Zhou <zhouchengming@bytedance.com> wrote:
>> This patch series are some optimization and extension for PSI,
> 
> BTW do you have some numbers/example how much these modifications save
> when aggregated together?
> 

I lost my test data last time, I will use mmtests/config-scheduler-perfpipe
to get some performance numbers right now.

Thanks.
