Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82755B0363
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiIGLwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIGLwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:52:32 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C121F959F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 04:52:31 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r17so896577pgr.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 04:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=miuHSxElI7jVpfINfdArls1Vz1pIUMGEpymqisIWKVo=;
        b=Yu/eYgojaSKotZtSS3VsiogfVx2S79dKObXO3mbjPjZdQ7WRi3R7lortLo6MRmMupy
         sjTvth20+3jIH6p1LNlfbEb2CzyS5EPNW9iM8W/VlLz/uhyLYVqDuHPMPkHk6HJvTpJp
         DubI4RI2epOW9g2kIRpvsZJdfRymBz8RkCHQ38TUaPohGBx9VFAc7M6m4XcKkA5BVsLW
         yvpuX5eXwn/GjUsVE0jSa42nd3Rrj4qqicKf8iFg7lNxvITlsXeifwHiHQVoIOCAC8IA
         u7/p3Q03vrGxKYYFsJP4F5XMqPTUIYOXZPxQwsnvTSB4snTS1F1WvvdbOtHud3rAVwfG
         Fs3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=miuHSxElI7jVpfINfdArls1Vz1pIUMGEpymqisIWKVo=;
        b=GZFH2bC/cgRovfC2MicEejv4fgSGI3WjacRHu2L3gMwYh3FVFmaxEhmOw/Za34OuwM
         Tkj/LekhdnUFwhz04CgmYD411/aytmRwmxqbFibgKxqCWYpJgXSw/JLn4t6ntXcImFx6
         CFGdEcM+iGhG/gvmp7YFj6ikW1uMrOIL5/3ddbnmjJv1Rit54JRO9rjREIcpKMwUJ2sU
         6gjdA1TyaEDvtlHKhOv62OnUul3QXN7HFjXNgrg82cWGKt9cgOeVi3k2f7acjO2bWL5c
         uUHlClg9PjKDjSR3TlHqrVwJ9hBRrWUHs2HsSSERai5tBBhrKwfa5G3owYa5y5Xk3wzk
         gCtA==
X-Gm-Message-State: ACgBeo3dy/c52fs5VgC3kp30yDBgMVcGQozQTTosVe0I+BdDOhl1oWoa
        PPbbDnA3mx2DOVcFnGeuWY8=
X-Google-Smtp-Source: AA6agR7NW63A1cj9wEIjhUgB7LiqAqBVStj6zMu4lKgKXJKkWT5qZFBMeT0nNQEpH75am0paER5J1Q==
X-Received: by 2002:a05:6a00:1594:b0:537:b6ab:2dd5 with SMTP id u20-20020a056a00159400b00537b6ab2dd5mr3364385pfk.51.1662551551296;
        Wed, 07 Sep 2022 04:52:31 -0700 (PDT)
Received: from barry-desktop.hub ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id i17-20020a17090332d100b00176d6ad3cd4sm3718888plr.100.2022.09.07.04.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 04:52:30 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
X-Google-Original-From: Barry Song <v-songbaohua@oppo.com>
To:     yangyicong@huawei.com, peterz@infradead.org
Cc:     21cnbao@gmail.com, bristot@redhat.com, bsegall@google.com,
        dietmar.eggemann@arm.com, ego@linux.vnet.ibm.com,
        gautham.shenoy@amd.com, guodong.xu@linaro.org,
        hesham.almatary@huawei.com, john.garry@huawei.com,
        jonathan.cameron@huawei.com, juri.lelli@redhat.com,
        kprateek.nayak@amd.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        mingo@redhat.com, prime.zeng@huawei.com, rostedt@goodmis.org,
        shenyang39@huawei.com, srikar@linux.vnet.ibm.com,
        tim.c.chen@linux.intel.com, vincent.guittot@linaro.org,
        wuyun.abel@bytedance.com, yangyicong@hisilicon.com,
        yu.c.chen@intel.com
Subject: Re: [PATCH v7 0/2] sched/fair: Scan cluster before scanning LLC in wake-up path
Date:   Wed,  7 Sep 2022 23:52:07 +1200
Message-Id: <20220907115207.69058-1-v-songbaohua@oppo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220822073610.27205-1-yangyicong@huawei.com>
References: <20220822073610.27205-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Yicong Yang <yangyicong@hisilicon.com>

> This is the follow-up work to support cluster scheduler. Previously
> we have added cluster level in the scheduler for both ARM64[1] and
> X86[2] to support load balance between clusters to bring more memory
> bandwidth and decrease cache contention. This patchset, on the other
> hand, takes care of wake-up path by giving CPUs within the same cluster
> a try before scanning the whole LLC to benefit those tasks communicating
> with each other.

> Barry Song (2):
>   sched: Add per_cpu cluster domain info and cpus_share_lowest_cache API
>   sched/fair: Scan cluster before scanning LLC in wake-up path

Hi Peter,
I believe this one has been ready. It has also gotten widely reviewed and
tested on platforms w/ and w/o clusters.
Can you please pick up this?

Thanks
Barry
