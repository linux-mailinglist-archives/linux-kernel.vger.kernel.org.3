Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF13473AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 03:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244891AbhLNCvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 21:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244831AbhLNCui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 21:50:38 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3769C061748
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 18:50:37 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso16134462pji.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 18:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:cc:references:subject
         :content-language:from:in-reply-to:content-transfer-encoding;
        bh=QWQlvQssHrsTkmhAcYEyHsS+/G2qMiumDXBWc6CQdPo=;
        b=3h0OwKWCGXfI8pNcGzPhZHOkgihKsvKdmRRC2Gqv0AznLP9nxEcI3vAyIa3rjHnq0c
         Ns7W5Yt7y0ycNFkN70oSiEjPUy4z+wcDE+7UVedsF563i/iVbNS4n2LoStcLHCiDItwF
         QquCs6gnpalfdlidWc3DiJ932MrMOK4uhK0xVL01rTH5Ivn87KlomlLKXmjBvn3lAERt
         t9n/k0uVMPChhJBsCSkM7DIJeAJ8X0kt7vuilgVHi9y3Bvo8sXn59VaikU19J9GJwJq3
         DVXSFubI4QtWFikgeEoAqjSBDKC3HgmfUN/OfBCKTTUFlYhTfxNkxE8SXJE72EsDRtnX
         7kvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :references:subject:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=QWQlvQssHrsTkmhAcYEyHsS+/G2qMiumDXBWc6CQdPo=;
        b=fHNhi8ioNmYn67Q++6k14RNMXprwuyg+H0l7t75cH4Awo56imtmfRocjNVGKUi1WmY
         jsnsUJAxGzrQVkjdyDQ2LCf1860Y1Yr3cMaRS44TSDQUXliKa2zPbOjukUtGKNyFIure
         43IQQvMRtPekwYhWn1eMjVdnkxIGc95g5nmiOWWxh5+mlN51ziqZcrEgwkYQA5H6swb7
         6CdEszqBvltENhRti0gsFeqMljyVTuQXDWoRizufxrFxJYWUA48tst3nd/dt9zGy4xYd
         hVbgvORPGHJOuTBbT2wE0WV3pz4j3vVAXp8mdC5cjuYPw8aAaDdevk7zzIKkZBV1hwpQ
         VbYQ==
X-Gm-Message-State: AOAM533qc4pJZIytt7GaYQGnQsJeJCRFEHgLNWe5HB19k9zOrF7K/YVN
        ePx60aEpcLs77NmN1+KqODI5Wg==
X-Google-Smtp-Source: ABdhPJxIc8vigpQDm7p2mih+0Ad94BeKA2H3FSD+oGZxYF+k7+fBqF/V6PVRvu9C0sHUwpPfporoow==
X-Received: by 2002:a17:902:c7c4:b0:141:deb4:1b2f with SMTP id r4-20020a170902c7c400b00141deb41b2fmr2812337pla.44.1639450237360;
        Mon, 13 Dec 2021 18:50:37 -0800 (PST)
Received: from [10.76.43.192] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id g1sm12831489pfu.73.2021.12.13.18.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 18:50:36 -0800 (PST)
Message-ID: <a6aa93b2-cb28-6d79-10ef-7b18bae11231@bytedance.com>
Date:   Tue, 14 Dec 2021 10:50:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
To:     wanghonglei@didichuxing.com, tj@kernel.org
Cc:     bristot@redhat.com, bsegall@google.com, cgroups@vger.kernel.org,
        dietmar.eggemann@arm.com, hannes@cmpxchg.org,
        jameshongleiwang@126.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, lizefan.x@bytedance.com,
        mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, tj@kernel.org, vincent.guittot@linaro.org
References: <20211213150506.61780-1-wanghonglei@didichuxing.com>
Subject: Re: [RESEND PATCH RFC] cgroup: support numabalancing disable in
 cgroup level
Content-Language: en-US
From:   Gang Li <ligang.bdlg@bytedance.com>
In-Reply-To: <20211213150506.61780-1-wanghonglei@didichuxing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
How about my per-process numa balancning patch;)

https://lore.kernel.org/all/20211206024530.11336-1-ligang.bdlg@bytedance.com/
-- 
Thanks
Gang Li

