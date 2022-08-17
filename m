Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242515978D3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 23:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241674AbiHQVQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 17:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241842AbiHQVQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 17:16:33 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B184F726AE
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:16:31 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x63-20020a17090a6c4500b001fabbf8debfso2208650pjj.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc;
        bh=Cl0VOxXiBJ9aDBIZ9VHzAPQnD5rzvmvW0CSWEKzvNbQ=;
        b=i0SpMOMtexVlsWU3FXDtYdeZ42T3dV91NmBN/jHzdRZIQDh4ju+X47frFOnT5mJdaD
         J9ZE8jbbgrEQtl0OhtYp3mnGh5YTLuLGXS/xZS9gY8MQkBLgWhoCmMp/9R8ZFq5Enjo1
         EvYBNz5lRGeHx1kVT7OHS9QwU+RMdZzAqmn0fPF1PHDWO41LlrKWf4/CR0BB2Vco+zwB
         tBMsMF9J5b8Oj+6L01c08s0fDdzVL60C4D4X3QVafJ8fTSId9VMJK46bex/K4L4EhYgC
         xvLAeqo6ZXbkRMCMa/+NTMlk722zALy4BG10rwMf5IVY00f80T64TM7wRWxb/hEMMYwk
         bmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Cl0VOxXiBJ9aDBIZ9VHzAPQnD5rzvmvW0CSWEKzvNbQ=;
        b=sF5dJ9x2khrEyeTUuYMNCB50pZ2VqnN37O/vXXwvdXmWAF2qPj8aVIae6ysypXag3U
         DrcqFcKH5hwqyUdAjBDKpeBt2Kqu/uOSZa5x4M0NyP74Mc3W0J+3BNg7NiHJKjiX/Kuf
         Gkq2lUVtJck2Ac4A4Ozd3wXK6SxRL8r+XeIDQmUpofb85J5s/DaEUiW6hgFHNgeedtPj
         +bixgaG550NV/lGnMCLOFhqAf72oP+LD2zIWWO3dTC/irZM/7tNaB0bHvyRDEUZY8i7W
         nLvFy7HwQBAOXul4EG24DvduSZnOfQEarigfACayUSuZVvDrbH6i/oFFPK64J/5MT11A
         cp3w==
X-Gm-Message-State: ACgBeo13PDq60x2suJkIQJqeUVpEW2+5rsDuGADLXVUf+oa84VrBCJ/Y
        jh6K7F0WwnlbmpStAVv6Y97h2g==
X-Google-Smtp-Source: AA6agR6W9+WQjsdk1xu/I0glOknc8/V9nojrJpa0dnc+toT5lIoGgNIjwXXCzDq6+38o2YdCVWlwiA==
X-Received: by 2002:a17:902:f685:b0:16e:ed53:be7b with SMTP id l5-20020a170902f68500b0016eed53be7bmr104386plg.174.1660770991168;
        Wed, 17 Aug 2022 14:16:31 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-67-188-112-16.hsd1.ca.comcast.net. [67.188.112.16])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902c70200b00172951ddb12sm388830plp.42.2022.08.17.14.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 14:16:29 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Zhao Wenhui <zhaowenhui8@huawei.com>
Cc:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
        <shanpeic@linux.alibaba.com>, <changhuaixin@linux.alibaba.com>,
        <tj@kernel.org>, <dtcccc@linux.alibaba.com>,
        <linux-kernel@vger.kernel.org>, <zhaogongyi@huawei.com>
Subject: Re: [PATCH] sched/fair: limit burst to zero when cfs bandwidth is
 toggled off
References: <20220809120320.19496-1-zhaowenhui8@huawei.com>
Date:   Wed, 17 Aug 2022 14:16:26 -0700
In-Reply-To: <20220809120320.19496-1-zhaowenhui8@huawei.com> (Zhao Wenhui's
        message of "Tue, 9 Aug 2022 20:03:20 +0800")
Message-ID: <xm26fshu4llh.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhao Wenhui <zhaowenhui8@huawei.com> writes:

> When the quota value in CFS bandwidth is set to -1, that imples the
> cfs bandwidth is toggled off. So the burst feature is supposed to
> be disable as well.
>
> Currently, when quota is -1, burst will not be check, so that it can be
> set to almost arbitery value. Examples:
>         mkdir /sys/fs/cgroup/cpu/test
>         echo -1 > /sys/fs/cgroup/cpu/test/cpu.cfs_quota_us
>         echo 10000000000000000 > /sys/fs/cgroup/cpu/test/cpu.cfs_burst_us
>
> Moreover, after the burst modified by this way, quota can't be set
> to any value:
>         echo 100000 > cpu.cfs_quota_us
>         -bash: echo: write error: Invalid argument
>
> This patch can ensure the burst value being zero and unalterable,
> when quota is set to -1.
>
> Fixes: f4183717b370 ("sched/fair: Introduce the burstable CFS controller")
> Reported-by: Zhao Gongyi <zhaogongyi@huawei.com>
> Signed-off-by: Zhao Wenhui <zhaowenhui8@huawei.com>

Indeed, good catch.
Reviewed-by: Ben Segall <bsegall@google.com>
