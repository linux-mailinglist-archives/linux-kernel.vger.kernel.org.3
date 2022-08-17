Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6D159724D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240764AbiHQPET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240753AbiHQPDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:03:55 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01F99F18B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 08:03:00 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id l21so13834698ljj.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 08:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=9SGSUQ251L49DEW5Gu8QCKtcNKe7pydvuZtzLIVhia0=;
        b=xeNWp2vXm4Z0cRNiYj00l46jraXiPR+4nfVnYkVGI1QJ4UhlDPCZRmQliccyeYiqOf
         nMfzkvngpIP+WYOAxKt2wsME3SvfQ4KueQv9XfFuWRXHGv2Tzqx1aT5i1yCI0B/XTkLm
         JQ6cPDEheS0M1D5dIZNb3w0wSCcvmYjV11qvtcY6vpA5OldQMLlOa5oGbcpPaJyA9B9V
         5vafFBteAkq8jMOcv7JmKAhzomR4oRdXu5awUIGlo9OQIVTOJvpAU+Lpt+ftRIW9gCUj
         2BF+r6tbooSgyj6Ok2sjbqEHh/9/3A1ziCg3uVOJOWkEaUvC9jZvAl5V4XLFNVzKLYrF
         oRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=9SGSUQ251L49DEW5Gu8QCKtcNKe7pydvuZtzLIVhia0=;
        b=3v8WuwVc+JzGsKqtCiQUCrsOdINFoJyIvgLk2G61wl8f7d4y1Wlv2OcvxFxWz03W2z
         5HIjj1m+tDMm3k2bLDg/TL9a30bxwaqeG/xCLTCay+SblIr22sOBTt+te5gZaj3p5Y9S
         Xn8KcMq18ajb0cAKvgtkedL94nlhILueNNi/lM0zmNjJjiwPLuXY+Hezq5fE67mY2CdQ
         enmo18p6mKexTq6OlZSIkpg3nzOg/dVwIleMQI+g/oEMLq4QtOSGmXQlhA6ifkk6CJ37
         M2GUgnk8unBdRKUEnlSlTv6FLAH6SGwWiZFsjSxRapKW6x1zs9sNlyroY8hSejBU5or2
         mkHg==
X-Gm-Message-State: ACgBeo0EQUlbMQ6g7De27P2gaqbGTAKSPqwvUfLm0xMRMvG/793evn9Y
        H7mil1qxARF8R4O/FI4P+q5Yw4DvPwNvuQ==
X-Google-Smtp-Source: AA6agR7ewoevd/SDgyJy2daDnQcW0k0kvHm6uHcwsUmHZP+fcLBI2RXAeToRhLYezvApSWAfqEaJ1A==
X-Received: by 2002:a05:651c:1988:b0:25e:c619:adb3 with SMTP id bx8-20020a05651c198800b0025ec619adb3mr8890843ljb.231.1660748577342;
        Wed, 17 Aug 2022 08:02:57 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.143])
        by smtp.gmail.com with ESMTPSA id u16-20020a05651c131000b0025fdf9eec1dsm2251969lja.111.2022.08.17.08.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 08:02:56 -0700 (PDT)
Message-ID: <b2498436-13dd-43d6-4b7b-d4d650d1d5b9@openvz.org>
Date:   Wed, 17 Aug 2022 18:02:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH] memcg: adjust memcg for new cgroup allocations
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>, tj@kernel.org,
        gregkh@linuxfoundation.org, hannes@cmpxchg.org, kernel@openvz.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com, shakeelb@google.com,
        songmuchun@bytedance.com, viro@zeniv.linux.org.uk
References: <62188f37-f816-08e9-cdd5-8df23131746d@openvz.org>
 <45a04b75-d61b-4c7a-7169-c971995a6049@openvz.org>
 <20220817091728.GA23229@blackbody.suse.cz>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <20220817091728.GA23229@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/22 12:17, Michal Koutný wrote:
>> +static inline struct mem_cgroup *mem_cgroup_from_cgroup(struct cgroup *cgroup)
> [...]
>> +	css = cgroup_get_e_css(cgroup, &memory_cgrp_subsys);
>> +
>> +	if (css)
>> +		memcg = container_of(css, struct mem_cgroup, css);
> Nit: mem_cgroup_from_css

Yes, my fault, you are right.
it was planned initially, but then I lost it somehow.

Thank you very much!
	Vasily Averin
