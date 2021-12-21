Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0E547C883
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 21:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbhLUU7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 15:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbhLUU7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 15:59:02 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFADFC061574;
        Tue, 21 Dec 2021 12:59:01 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id k21so673113lfu.0;
        Tue, 21 Dec 2021 12:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EMjej9HUtAXOcAMoyZw+nimK8vBoVTGCydufGYxXW3A=;
        b=QBxyUvO5aXbxIR0XthlyHePXA11I979yfrf++6Y0YXUqD3swGqlQJM6N0SK/yeSF+N
         oPD03Rnl39x+aXv/H/sdi+RAKmXkUy/P7qzmBLNwphVzzxjXMF2uhCvotIV9ESDHgQHu
         SF8BPoPlscsudtTMuzetF1bNB+QRvQJzVOxCgUe2mVVbMlcoMvzYfM9GeHQyuEVNdsro
         3u8bS2UuxWFsWIKF9oOCdJgkiptAxYRerVHbNFcYYTuAHFFyttwtE/I9WiYnIpH5Az1N
         kkKHi4GRLrufxZTanpKnTmHxuoB0gY4w/VSml3M4Vauilk8+gRLJHbMrGLiVdQdsDjBh
         QwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EMjej9HUtAXOcAMoyZw+nimK8vBoVTGCydufGYxXW3A=;
        b=frv/BPzhdduZY0cCYvTinDekmVgJFc5K17/JthK+pudbVeYg/HQkIIsh80335+3K+Z
         ciMT5Wgp1VmbCkf1wT3ufTgLHzaxROouVNjg5S/A5NCOk88Ql7jh2wCk1Sr5bUXB2Qzf
         tEqwlMJHDTT/KESFVFiFBmF5lHT+5tryt11Uwf2ggTdxsl3xGZ137Qk2hHEmiNAvGlvW
         vZyXqHfvkveTlVMBwUjipBVqfTdcrr0fuueTysxPueHLtLhXgNiV1EvirWJRDMfRyjS7
         Rr61N+/unlChxYQjjXwI1MiN4ySdLP7jPMm/KFvnEDSBGCgH6ZOy2ZrxPhKe9OwrzEHh
         DAnw==
X-Gm-Message-State: AOAM531/wzcZ2ronBMktNKDU8wYVHVnNfXQfyc2cMHmOn+jpfKNdU5Nv
        ZiQ+OdgfTTAsn2hXIPx2K2o=
X-Google-Smtp-Source: ABdhPJyQqGTd/AQR3V4qGYEJ+lnA9nHyBoOuC+0UYbMfak9DWTHgpUTRFKkjLQB10viCSl/8d/IXNw==
X-Received: by 2002:a05:6512:691:: with SMTP id t17mr125939lfe.55.1640120340186;
        Tue, 21 Dec 2021 12:59:00 -0800 (PST)
Received: from [192.168.2.145] (46-138-43-24.dynamic.spd-mgts.ru. [46.138.43.24])
        by smtp.googlemail.com with ESMTPSA id bj11sm200ljb.62.2021.12.21.12.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 12:58:59 -0800 (PST)
Subject: Re: [PATCH v16 08/40] gpu: host1x: Add initial runtime PM and OPP
 support
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
References: <20211130232347.950-1-digetx@gmail.com>
 <20211130232347.950-9-digetx@gmail.com>
 <21212ddb-205f-71d6-0199-d75768eaf32c@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <41edc53b-5ed1-d524-2546-c3d1ee6cdea4@gmail.com>
Date:   Tue, 21 Dec 2021 23:58:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <21212ddb-205f-71d6-0199-d75768eaf32c@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for testing it all.

21.12.2021 21:55, Jon Hunter пишет:
> Hi Dmitry, Thierry,
> 
> On 30/11/2021 23:23, Dmitry Osipenko wrote:
>> Add runtime PM and OPP support to the Host1x driver. For the starter we
>> will keep host1x always-on because dynamic power management require a
>> major
>> refactoring of the driver code since lot's of code paths are missing the
>> RPM handling and we're going to remove some of these paths in the future.
> 
> 
> Unfortunately, this change is breaking boot on Tegra186. Bisect points
> to this and reverting on top of -next gets the board booting again.
> Sadly, there is no panic or error reported, it is just a hard hang. I
> will not have time to look at this this week and so we may need to
> revert for the moment.

Only T186 broken? What about T194?

Which board model fails to boot? Is it running in hypervisor mode?

Do you use any additional patches?

Could you please test the below diff? I suspect that
host1x_syncpt_save/restore may be entirely broken for T186 since we
never used these funcs before.

--- >8 ---

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index f5b4dcded088..fd5dfb875422 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -580,7 +580,6 @@ static int __maybe_unused
host1x_runtime_suspend(struct device *dev)
 	int err;

 	host1x_intr_stop(host);
-	host1x_syncpt_save(host);

 	err = reset_control_bulk_assert(host->nresets, host->resets);
 	if (err) {
@@ -596,9 +595,8 @@ static int __maybe_unused
host1x_runtime_suspend(struct device *dev)
 	return 0;

 resume_host1x:
-	host1x_setup_sid_table(host);
-	host1x_syncpt_restore(host);
 	host1x_intr_start(host);
+	host1x_setup_sid_table(host);

 	return err;
 }
@@ -626,9 +624,8 @@ static int __maybe_unused
host1x_runtime_resume(struct device *dev)
 		goto disable_clk;
 	}

-	host1x_setup_sid_table(host);
-	host1x_syncpt_restore(host);
 	host1x_intr_start(host);
+	host1x_setup_sid_table(host);

 	return 0;

