Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D044863F9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 12:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238652AbiAFLyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 06:54:10 -0500
Received: from foss.arm.com ([217.140.110.172]:52440 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238456AbiAFLyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 06:54:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D17C213A1;
        Thu,  6 Jan 2022 03:54:08 -0800 (PST)
Received: from [10.57.11.40] (unknown [10.57.11.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A2AB3F774;
        Thu,  6 Jan 2022 03:54:07 -0800 (PST)
Subject: Re: [PATCH v2][RFC 1/2] Implement Ziegler-Nichols Heuristic
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org, amitk@kernel.org,
        Chetankumar Mistry <chetan.mistry@arm.com>,
        rui.zhang@intel.com, linux-pm@vger.kernel.org
References: <20211217184907.2103677-1-chetan.mistry@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <23c3480a-c46b-f049-5758-d11124367190@arm.com>
Date:   Thu, 6 Jan 2022 11:54:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211217184907.2103677-1-chetan.mistry@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Could you have a look at this, please?


On 12/17/21 6:49 PM, Chetankumar Mistry wrote:
> Implement the Ziegler-Nichols Heuristic algorithm to better
> estimate the PID Coefficients for a running platform.
> The values are tuned to minimuse the amount of overshoot in
> the temperature of the platform and subsequently minimise
> the number of switches for cdev states.
> 
> Signed-off-by: Chetankumar Mistry <chetan.mistry@arm.com>


This is the continuation of the previous idea to have
better k_* values. You might remember this conversation [1].

I've spent some time researching papers how and what can be done
in this field and if possible to plumb in to the kernel.
We had internal discussions (~2017) of one method fuzzy-logic that I
found back then, but died at the begging not fitting into this
IPA kernel specific environment and user-space. Your suggestion with
observing undershooting and overshooting results sparked better idea.
I thought it's worth to invest in it but I didn't have
time. We are lucky, Chetan was designated to help me and
experiment/implement/test these ideas and here is the patch set.

He's chosen the Ziegler-Nichols method, which shows really
good results in benchmarks (Geekbench and GFXbench on hikey960 Android).
The improved performance in Geekbench is ~10% (vs. old IPA).

The main question from our side is the sysfs interface
which we could be used to trigger this algorithm for
better coefficients estimations.
We ask user to echo to some sysfs files in thermal zone
and start his/her workload. This new IPA 'learns' the system
utilization and reaction in temperature. After a few rounds,
we get better fitted coefficients.
If you need more background about the code or mechanisms, or tests,
I'm sure Chetan is happy to provide you those.

If you are interested in those analyses we can find a way to share a
.html file with the results from LISA notebook.

We are waiting for your decision regarding the design and user
interface.

Regards,
Lukasz

[1] 
https://lore.kernel.org/lkml/42360f0f-5d53-085b-536f-33df93b787ca@arm.com/
