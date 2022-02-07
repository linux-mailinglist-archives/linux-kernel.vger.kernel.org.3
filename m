Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E164ABE59
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 13:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391773AbiBGMDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 07:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385880AbiBGLpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:45:01 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB145C0401ED;
        Mon,  7 Feb 2022 03:44:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 258F911B3;
        Mon,  7 Feb 2022 03:44:48 -0800 (PST)
Received: from [10.57.15.201] (unknown [10.57.15.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31D9B3F70D;
        Mon,  7 Feb 2022 03:44:45 -0800 (PST)
Subject: Re: [PATCH 0/2] Ignore Energy Model with abstract scale in IPA and
 DTPM
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     amit.kachhap@gmail.com, viresh.kumar@linaro.org, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, dietmar.eggemann@arm.com,
        Pierre.Gondois@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220207073036.14901-1-lukasz.luba@arm.com>
 <0d2217e0-44f7-8587-3e1f-a73d301ab166@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <616307f7-b419-8e36-6879-6cf6f4e02d5a@arm.com>
Date:   Mon, 7 Feb 2022 11:44:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <0d2217e0-44f7-8587-3e1f-a73d301ab166@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/7/22 10:41 AM, Daniel Lezcano wrote:
> On 07/02/2022 08:30, Lukasz Luba wrote:
>> Hi all,
>>
>> The Energy Model supports abstract scale power values. This might cause
>> issues for some mechanisms like thermal governor IPA or DTPM, which
>> expect that all devices provide sane power values. This patch set 
>> prevents
>> from registering such devices for IPA and DTPM.
> 
> 
> Does it mean for example big and little have both 0-100 ?
> 
> 

Unfortunately, these can be any numbers. I hope at least the CPUs
Big and Little power have sense: Little power is not higher
than Big power. The purpose of EM is to enable EAS, so this power
relation between Big and Little should have sense. Someone
who is not willing to or cannot expose real power values, still
wants the EAS to operate (my assumption and hope). The SCMI FW can
provide abstract power values. It's in the SCMI spec. Thus,
creating these abstract scale power values for big.LITTLE the right
way should result in properly working EAS.

I can also have hope for GPU vs. Big power, but it is a weaker hope.
The second is more tricky to distinguish even if you have a domain
knowledge, but not the real measurements with you. The GPU power
values is also a 'sensitive' knowledge to share. Open source guys can do
that (after measurements), but some vendor's engineers probably can't.
