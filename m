Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C16544CAB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244683AbiFIMx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343641AbiFIMx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:53:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 884867DE33
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:53:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BB7412FC;
        Thu,  9 Jun 2022 05:53:26 -0700 (PDT)
Received: from [10.57.39.144] (unknown [10.57.39.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 070143F73B;
        Thu,  9 Jun 2022 05:53:23 -0700 (PDT)
Message-ID: <6099583c-c986-e1f3-1eee-33b504286757@arm.com>
Date:   Thu, 9 Jun 2022 13:53:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v10 0/7] feec() energy margin removal
Content-Language: en-US
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, tao.zhou@linux.dev, kernel-team@android.com,
        peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
References: <20220607123254.565579-1-vdonnefort@google.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220607123254.565579-1-vdonnefort@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 6/7/22 13:32, Vincent Donnefort wrote:
> Hi,
> 
> Here's a new version of the patch-set to get rid of the energy margin in
> feec(). Many thanks to all for the insightful comments I got.
> 
> find_energy_efficient() (feec()) will migrate a task to save energy only if
> it saves at least 6% of the total energy consumed by the system. This
> conservative approach is a problem on a system where a lot of small tasks
> create a huge load on the overall: very few of them will be allowed to
> migrate to a smaller CPU, wasting a lot of energy. Instead of trying to
> determine yet another margin, let's try to remove it.
> 
> The first elements of this patch-set are various fixes and improvement that
> stabilizes task_util and ensures energy comparison fairness across all CPUs
> of the topology. Only once those fixed, we can completely remove the margin
> and let feec() aggressively place task and save energy.
> 

I've run this patch set on pixel6 (android-mainline) and gathered energy
values from the meter during the PCmark 3.0.

It looks good, with these patches we have ~10% lower energy usage and
only ~3% lower score.

There are no other issues, everything works fine. Feel free to add:

Tested-by: Lukasz Luba <lukasz.luba@arm.com>

to the whole patch set.

Regards,
Lukasz
