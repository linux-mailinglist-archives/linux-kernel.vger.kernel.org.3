Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70E357F80A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 03:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiGYBsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 21:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiGYBsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 21:48:50 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8189ED62;
        Sun, 24 Jul 2022 18:48:47 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so8927875pjl.0;
        Sun, 24 Jul 2022 18:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HT09dBY8vUpXT4pAwp9hU5IYkpA64eMFd2Hf4rtewRU=;
        b=Mm90oEayZG+T3cwxeBYyH+MVmHKkb/cUBKaLRzfnQ+jTnJ/4SVK23muAKkqteOmH1Q
         dJcx4yWdTziLMA6gBTPI1pxS49cCkP4pEfgaO79Y+JsVkDujHYOljhTdd3LlK1K3b9af
         +0g9iWBR8+Zc+3f+dphUjQ7+Iv9sRv8TYi4kt8GqV7E2QQX1Wlasf37HTRZ3VVt/5V2M
         u3nw5wOSLp5Sph9joKwVp+etsU7mA4rjbUrKVzbQwhJ0vANDxx+ka84Jc4AAzSpC8Rib
         42MFnN7jRwOGKIJpLTkof5g/yl2yEmPzbk4ICaZKx7+NA6If8z6Lha6oCsGTrUeDgOIU
         TkZQ==
X-Gm-Message-State: AJIora+7SbW+Jv1MH+ud6vM4zXZ7+M2yhtABbJXLRbizvVRksDhRmgzl
        smd22rY9X89gGGsVZopDUZI=
X-Google-Smtp-Source: AGRyM1uPN9pHcsZNA+/K1raafpFnBCZGJCaCSs0N23TarH3QJ1hL9Ma/JcNJv/aZrIv+78hDd3zv4w==
X-Received: by 2002:a17:902:d48a:b0:16b:f0be:4e15 with SMTP id c10-20020a170902d48a00b0016bf0be4e15mr10344383plg.155.1658713726367;
        Sun, 24 Jul 2022 18:48:46 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902654a00b0016d1e514ec5sm7772608pln.139.2022.07.24.18.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jul 2022 18:48:45 -0700 (PDT)
Message-ID: <57accb2a-828d-c532-d964-130a63faebe5@acm.org>
Date:   Sun, 24 Jul 2022 18:48:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] block/mq-deadline: Prioritize first request
Content-Language: en-US
To:     Wang You <wangyoua@uniontech.com>
Cc:     axboe@kernel.dk, fio@vger.kernel.org, hch@lst.de,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        wangxiaohua@uniontech.com
References: <f798c875-0bb9-add7-d7a3-4ac2a76e85d9@acm.org>
 <20220723105909.440050-1-wangyoua@uniontech.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220723105909.440050-1-wangyoua@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/22 03:59, Wang You wrote:
> Also, can I ask? If using fio or other tools, how should testing be done to get
> more accurate and convincing data? Such as the perfectly sequential and random I/O
> performance you mentioned above (fio's multi-threaded test does result in neither
> perfectly sequential nor perfectly random, but single thread dispatch is too slow,
> and cannot play the merge and sorting ability of elv).

I'm not sure that there is agreement about for which data patterns to 
measure performance to conclude that certain code changes improve 
performance of an I/O scheduler.

Thanks,

Bart.
