Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731CC4E2F00
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351821AbiCURZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345862AbiCURZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:25:37 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95962183805
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:24:11 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mr5-20020a17090b238500b001c67366ae93so12424723pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JfYPzIW2uZzSE1OyzcQN2ZgSvbN8ua2owpED41aqf8k=;
        b=cP0Vw/KU+TayukEqk47ZzWLTyhs9Sb6Nnk/xv2Zusp8ePPannwFsRf9qWpavIy/vUH
         Mthdsilm9/Z2GQOgg2rTFIOzE4gxIiPZDI9q5H0Pq6p7LqWHqxuVfbwYUQoBIhv8Ykdh
         5WLOVxxiHFQrby2H+xNZot7gpXtkaxWzJMEJsl8BlBQ+Qm0Ixfwn5vIaQGSRVJDo80sE
         8+2hEYP/f54KuFdlkzTHxh23nVk2qMy+K8PSfoloz5wfQ1cS9ZGOKp6afCoVdDeB9rg8
         Hz0dVPJunBc92nnCR48bm7Vr+buIVzXEA7aq9fl8K5f+p/nLJmSgLsrDJYOlP6E1tf1F
         KxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=JfYPzIW2uZzSE1OyzcQN2ZgSvbN8ua2owpED41aqf8k=;
        b=QnHAptyifEkf8R29jQ4hzbVGrBGYmvuh+XCd+39YG3xVQgRDX8oe8OHXn/i6qmzUVF
         46mqPab+cV5NkRfssbhhyVS+VlIpo8Th8shi9SAt6tKEzL5ofO3bSJPU1kE6r2av/W2E
         FC3t4AlTjwCXRf9webGZJ88jNQ/8YfsZ6gncgVcgVMcOSuLhh2Zsvv22rKh/kL8W6hWy
         6XJMwPbPK0hRD/0NNFo7hS5iWKAQHJBkgGgjhdiAels4pAHqLz2XSQh1Ppqg0SOIMEE3
         qHOMkPV0H35HMBNFG1/Sf22CzxSWkFAPGyANE8VF+bsiU3KiWEW97kj3EXHgK2qXh3az
         NidA==
X-Gm-Message-State: AOAM532VrZ/iWyNj8TI0j8H1kTLm50PAByuLyRCCkSfHgWV90lWM2wHT
        9DbFbFu2zaWm/4N6/mtZAkQ=
X-Google-Smtp-Source: ABdhPJxktdHHIsTKejTvZ1f+liEbHlXdjGAcmQRLIAdUUovCXnZu4jp649ZCQ4dW1JCBky15mgB7fg==
X-Received: by 2002:a17:903:246:b0:153:857c:a1f6 with SMTP id j6-20020a170903024600b00153857ca1f6mr13788157plh.153.1647883450916;
        Mon, 21 Mar 2022 10:24:10 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id y14-20020a62f24e000000b004f7d604f5ddsm19745878pfl.181.2022.03.21.10.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 10:24:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 21 Mar 2022 07:24:07 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        pkondeti@codeaurora.org, valentin.schneider@arm.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, dhaval.giani@oracle.com,
        qperret@google.com, tim.c.chen@linux.intel.com
Subject: Re: [RFC 6/6] sched/fair: Add sched group latency support
Message-ID: <Yji0twS4N+0b/Rs9@slm.duckdns.org>
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
 <20220311161406.23497-7-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311161406.23497-7-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Mar 11, 2022 at 05:14:06PM +0100, Vincent Guittot wrote:
> Tasks can set its latency priority which is then used to decide to preempt
> the current running entity of the cfs but sched group entities still have
> the default latency priority.
> 
> Add a latency field in task group to set the latency priority of the group
> which will be used against other entity in the parent cfs.

One thing that bothers me about this interface is that the configuration
values aren't well defined. We have the same problems with the nice levels
but at least have them map to well defined weight values, which likely won't
change in any foreseeable future. The fact that we have the
not-too-well-defined nice levels as an interface shouldn't be a reason we
add another one. Provided that this is something scheduler folks want, it'd
be really great if the interface can be better thought through. What are the
numbers actually encoding?

Thanks.

-- 
tejun
