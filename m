Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA121599DD9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 16:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349481AbiHSOtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 10:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348837AbiHSOta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:49:30 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05583D87F1;
        Fri, 19 Aug 2022 07:49:29 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id c24so3864011pgg.11;
        Fri, 19 Aug 2022 07:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=AEaEgab2mhaMiSkvYoYiW7yx1z+hEFyxx9wlIiPpIa8=;
        b=PZ5svkXPbBwfSmVwVlHXWBmxq3AZJqp1RSsZNV5Oq5Dh1sKLcsDXsaDJP43L1FWZQq
         za3PikWje+XoLxbmk7iVdND4a6hbwkG8/J/It6sJQpAhMZKI11CSTYr/oBsdm+qrKIqR
         j7oIuOlmekZNPKeb+R8M+whb+ocqQKLGEURKHwm5j2FnoBHwJkTFRApU6tSZ8Tg/rbLA
         afLL5UfJymiV9jUWKcWyEconwlHGBeqrHSmqVDjv/FOAXbWHC/rhhfF6BvFX/D8my400
         bBu4iCw0YNHY6pRewxyRO+8i6c/NU59CpaQn/5ycxNs4Vj6PN3TG82q/QUyDhURpochP
         E/kw==
X-Gm-Message-State: ACgBeo1Wv8jjSIQEvvAySHP4iZmvJ/G6BdjNUqkvisRjf1CVEAJWjENQ
        bL2452RhqJ+s76ySQek3n7EwFwZkyiw=
X-Google-Smtp-Source: AA6agR4n7cfXryL/GLcBwpbdaZ8OS1DGI89ou5DCJZPaiWYVxSuSylH84/CiOOS86Tu5616hB6UhkA==
X-Received: by 2002:a63:1925:0:b0:429:f4f4:7d48 with SMTP id z37-20020a631925000000b00429f4f47d48mr6689792pgl.474.1660920568337;
        Fri, 19 Aug 2022 07:49:28 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id e14-20020aa798ce000000b00534a1315a63sm3580495pfm.136.2022.08.19.07.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 07:49:27 -0700 (PDT)
Message-ID: <17ccd5ae-0268-1bee-7822-1352f4c676ba@acm.org>
Date:   Fri, 19 Aug 2022 07:49:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: 6.0-rc1 regression block (blk_mq) / RCU task stuck errors +
 block-io hang
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, rcu@vger.kernel.org
References: <dd6844e7-f338-a4e9-2dad-0960e25b2ca1@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <dd6844e7-f338-a4e9-2dad-0960e25b2ca1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/22 05:01, Hans de Goede wrote:
> I've been dogfooding 6.0-rc1 on my main workstation and I have hit
> this pretty serious bug, serious enough for me to go back to 5.19
> 
> My dmesg is showing various blk_mq (RCU?) related lockdep splats
> followed by some tasks getting stuck on disk-IO. E.g. "sync"
> is guaranteed to hang, but other tasks too.
> 
> This seems to be mainly the case on "sd" disks (both sata
> and USB) where as my main nvme drive seems fine, which has
> probably saved me from worse issues...
> 
> Here are 4 task stuck reports from my last boot, where
> I had to turn off the machine by keeping the power button
> pressed for 4 seconds.
> 
> [ ... ]
 >
> Sorry for not being able to write a better bug-report but I don't have
> the time to dive into this deeper. I hope this report is enough for
> someone to have a clue what is going on.

Thank you for the detailed report. I think this report is detailed 
enough to root-cause this issue, something that was not possible before 
this report.

Please help with verifying whether this patch fixes this issue: "[PATCH] 
scsi: sd: Revert "Rework asynchronous resume support"" 
(https://lore.kernel.org/linux-scsi/20220816172638.538734-1-bvanassche@acm.org/).

Thanks,

Bart.

