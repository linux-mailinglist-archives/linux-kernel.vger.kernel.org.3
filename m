Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72874A3E34
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 08:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358030AbiAaH0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 02:26:13 -0500
Received: from foss.arm.com ([217.140.110.172]:36498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357985AbiAaHZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 02:25:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14BE7D6E;
        Sun, 30 Jan 2022 23:25:37 -0800 (PST)
Received: from [10.57.9.236] (unknown [10.57.9.236])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B4C03F73B;
        Sun, 30 Jan 2022 23:25:35 -0800 (PST)
Subject: Re: [PATCH v5] drivers: thermal: clear all mitigation when thermal
 zone is disabled
To:     Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
References: <1643307093-22501-1-git-send-email-quic_manafm@quicinc.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <4024218b-7938-e181-f456-bff4b3fb157a@arm.com>
Date:   Mon, 31 Jan 2022 07:25:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1643307093-22501-1-git-send-email-quic_manafm@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manaf,

On 1/27/22 6:11 PM, Manaf Meethalavalappu Pallikunhi wrote:
> Whenever a thermal zone is in trip violated state, there is a chance
> that the same thermal zone mode can be disabled either via
> thermal core API or via thermal zone sysfs. Once it is disabled,
> the framework bails out any re-evaluation of thermal zone. It leads
> to a case where if it is already in mitigation state, it will stay
> the same state forever.
> 
> To avoid above mentioned issue, add support to bind/unbind
> governor from thermal zone during thermal zone mode change request
> and clear all existing throttling in governor unbind_from_tz()
> callback.

I have one use case:
This would be a bit dangerous, e.g. to switch governors while there is a
high temperature. Although, sounds reasonable to left a 'default' state
for a next governor.

> 
> Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
> ---
>   drivers/thermal/gov_power_allocator.c |  3 +++
>   drivers/thermal/gov_step_wise.c       | 26 ++++++++++++++++++++++++++
>   drivers/thermal/thermal_core.c        | 31 +++++++++++++++++++++++++++----
>   3 files changed, 56 insertions(+), 4 deletions(-)

Why only two governors need that change and not all?
Because they don't have 'bind/unbind' callbacks, then maybe we should
change that as well to make it consistent?

Regards,
Lukasz
