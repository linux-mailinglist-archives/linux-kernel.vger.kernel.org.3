Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D743D592FF3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbiHONcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242838AbiHONb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:31:58 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC874193D3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 06:31:56 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p14-20020a17090a74ce00b001f4d04492faso6752641pjl.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 06:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=CWRYKYmUqt8eEOVX3nqSEB+R46yZlA/ZWTwGwK50XRc=;
        b=1JvETOAQmXm37KQowrJ3QDzbrxnjCS1Z37/PrrmPiJq0cAFAC/z8C6bfKCJbjLMhfU
         Wn1lB/C/YxR/jb0C0S0xWHbqFHZ5/Fm6JxZWRL1Bi3Hy0chxGfVHDeg8OWOU+z0yjxWp
         GoP1kl7UZb0r31lXL0ndr1Cs4gOjHU7gCjsYzTxjXQMxbyTLviAtY+w7ICua4DmWDMoJ
         AFKarS3GDw+voIKQmo0nF8GYGr6CTG+TGbBsE74l/9fsvXuHR/MFRPBatdZsraDsvzCd
         JnXQ9xbRsGEGtCo6lINqk2daqFdnCjGkHUjQ1eE3hyfmZZxHELF0zrJL2KWhcNsCdykF
         ne1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=CWRYKYmUqt8eEOVX3nqSEB+R46yZlA/ZWTwGwK50XRc=;
        b=LjlFmZredRrwcM/4+QpFf+s4TSBHT8DCoG2JmgyASjrlLES3gvtlSMS1vTCCGYOGH4
         iQT9+rze7QZcvEmDOj8j08XD5J7nxyc4bAbgwD+yZfWB/1MqN6iiftfyrZjygvsi4i56
         l85R2eJ5cwNJd6ljYkTlgJ0L9AuZlNLjXoHTVqMMxQoduZidgd9M4daBnrZxwtKwBNP/
         DFIjvkavydktz8vYjvjuFMVkwFyUGQxk+pNKu6xyqgI2wbFU+z9+fS3OwBHcKDbnjKeg
         VZM2+j/MJp8X9XI2dJds3QbaVc61h6P92ZVfmfxFIq3YjKJlYzWpwgX8yyvKRsfIGRlO
         YSAA==
X-Gm-Message-State: ACgBeo3b8zufL/ExF1cv+rFLXc1e+gpeo8zosR0lHaHjhyX6jjcFKVaj
        i9ugd+7bqPpzNHIOeCJozD0lug==
X-Google-Smtp-Source: AA6agR45i9MBYCzQk5IilUQ9i5f+P0H1KhnQJj5vU34O1XkKW5Tt41hQDcSIDioHFtGR9o8/zlsaPw==
X-Received: by 2002:a17:902:ea07:b0:16e:daf6:6087 with SMTP id s7-20020a170902ea0700b0016edaf66087mr16882997plg.68.1660570316249;
        Mon, 15 Aug 2022 06:31:56 -0700 (PDT)
Received: from [10.94.58.189] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id d65-20020a621d44000000b0052c7ff2ac74sm6784740pfd.17.2022.08.15.06.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 06:31:55 -0700 (PDT)
Message-ID: <141052b4-35f6-e2d2-1921-0ffa44d4b7ce@bytedance.com>
Date:   Mon, 15 Aug 2022 21:31:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH 0/5] sched/fair: SIS improvements and cleanups
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20220712082036.5130-1-wuyun.abel@bytedance.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20220712082036.5130-1-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, it would be appreciate if you can offer some advice!

Thanks & Best,
Abel

On 7/12/22 4:20 PM, Abel Wu Wrote:
> The first patch ignores the new sched_feat SIS_UTIL when
> there are idle cores available to make full use of cpus
> as possible.
> 
> The other patches come from the SIS filter patchset [1],
> since they are irrelevant to the filter.
> 
> [1] https://lore.kernel.org/lkml/20220619120451.95251-1-wuyun.abel@bytedance.com/
> 
> Abel Wu (5):
>    sched/fair: ignore SIS_UTIL when has idle core
>    sched/fair: default to false in test_idle_cores
>    sched/fair: remove redundant check in select_idle_smt
>    sched/fair: avoid double search on same cpu
>    sched/fair: remove useless check in select_idle_core
> 
>   kernel/sched/fair.c | 45 ++++++++++++++++++++++-----------------------
>   1 file changed, 22 insertions(+), 23 deletions(-)
> 
