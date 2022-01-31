Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C614A5052
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377841AbiAaUjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:39:41 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37656 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343999AbiAaUjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:39:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4412614C2;
        Mon, 31 Jan 2022 20:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D95C340E8;
        Mon, 31 Jan 2022 20:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643661576;
        bh=LlCWcmjo9XBLXtkZjmaUu+sQAjNy8t3wD356RhDm6+8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dbIvvaZtUtglyEdPJeUXqJeRCSK+nQ6All4q5LCLeHNekPbJGzAd5HBkBDMUdPyEX
         aLGoz9yVDcpb77joBuHGnfcQ20RTksmJJA8Y7SrJ9Rew6tW4rcMIZRXV5cttCSPQ0D
         HkEINXYQFrsUCNmd3iD1ToriUf9adNj2trOKs5EHQpQh2ZgYg2jkD+SsyjO4qmwmJU
         upmD5OlqmrXdrSY7oYrS3dOZxgV98KvJJ3JFZxzIEf0AVbUnMz0iuLBk8UlKNXkBOk
         lpi4tu/p3npuGwGoPD/pO37vgzqDNONpZMMhn8MfAwiO9zjbATlOiIceIevlZ9aNye
         Lvr+4f0EY7Kbg==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nEdSX-004Ugn-LI; Mon, 31 Jan 2022 20:39:33 +0000
MIME-Version: 1.0
Date:   Mon, 31 Jan 2022 20:39:33 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?U?= =?UTF-8?Q?we_Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v16 08/40] gpu: host1x: Add initial runtime PM and OPP
 support
In-Reply-To: <40983f6e-92ee-40d4-861f-06faea0113fc@gmail.com>
References: <20211130232347.950-1-digetx@gmail.com>
 <20211130232347.950-9-digetx@gmail.com>
 <21212ddb-205f-71d6-0199-d75768eaf32c@nvidia.com>
 <41edc53b-5ed1-d524-2546-c3d1ee6cdea4@gmail.com>
 <6652ac84-36f5-0e43-65fa-04786f384f21@nvidia.com>
 <56dce9c7-397d-75b0-b5b8-18ce1084e72b@nvidia.com>
 <6dbc8205-5669-8b08-16b8-fe5e1acdd06f@gmail.com>
 <796eb3f7-80e2-bc55-fd52-43e76220f8c2@nvidia.com>
 <40983f6e-92ee-40d4-861f-06faea0113fc@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <6adda63b4de6b55d11426ecbb08d6c51@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: digetx@gmail.com, jonathanh@nvidia.com, thierry.reding@gmail.com, ulf.hansson@linaro.org, vireshk@kernel.org, sboyd@kernel.org, pdeschrijver@nvidia.com, mperttunen@nvidia.com, lee.jones@linaro.org, u.kleine-koenig@pengutronix.de, nm@ti.com, adrian.hunter@intel.com, mturquette@baylibre.com, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org, linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org, david@ixit.cz
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 2021-12-22 19:31, Dmitry Osipenko wrote:
> 22.12.2021 22:30, Jon Hunter пишет:
>> 
>> On 22/12/2021 19:01, Dmitry Osipenko wrote:
>> 
>> ...
>> 
>>> diff --git a/drivers/gpu/host1x/syncpt.c 
>>> b/drivers/gpu/host1x/syncpt.c
>>> index e08e331e46ae..8194826c9ce3 100644
>>> --- a/drivers/gpu/host1x/syncpt.c
>>> +++ b/drivers/gpu/host1x/syncpt.c
>>> @@ -137,6 +137,15 @@ void host1x_syncpt_restore(struct host1x *host)
>>>       struct host1x_syncpt *sp_base = host->syncpt;
>>>       unsigned int i;
>>> 
>>> +    for (i = 0; i < host->info->nb_pts; i++) {
>>> +        /*
>>> +         * Unassign syncpt from channels for purposes of Tegra186
>>> +         * syncpoint protection. This prevents any channel from
>>> +         * accessing it until it is reassigned.
>>> +         */
>>> +        host1x_hw_syncpt_assign_to_channel(host, sp_base + i, NULL);
>>> +    }
>>> +
>>>       for (i = 0; i < host1x_syncpt_nb_pts(host); i++)
>>>           host1x_hw_syncpt_restore(host, sp_base + i);
>>> 
>>> @@ -352,13 +361,6 @@ int host1x_syncpt_init(struct host1x *host)
>>>       for (i = 0; i < host->info->nb_pts; i++) {
>>>           syncpt[i].id = i;
>>>           syncpt[i].host = host;
>>> -
>>> -        /*
>>> -         * Unassign syncpt from channels for purposes of Tegra186
>>> -         * syncpoint protection. This prevents any channel from
>>> -         * accessing it until it is reassigned.
>>> -         */
>>> -        host1x_hw_syncpt_assign_to_channel(host, &syncpt[i], NULL);
>>>       }
>>> 
>>>       for (i = 0; i < host->info->nb_bases; i++)
>>> 
>> 
>> 
>> Thanks! This fixed it!
> 
> I'll prepare proper patch with yours t-b, thank you.

The fix has been in -next for some time now, but it still hasn't
made it into Linus' tree (at least not in -rc2).

Any hope for this to land -rc3?

Thanks,

      M.
-- 
Jazz is not dead. It just smells funny...
