Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CEB4E9034
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239376AbiC1IfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 04:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbiC1Ie7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:34:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 544FB12AC4;
        Mon, 28 Mar 2022 01:33:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A004DD6E;
        Mon, 28 Mar 2022 01:33:17 -0700 (PDT)
Received: from [192.168.4.86] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E3693F66F;
        Mon, 28 Mar 2022 01:33:15 -0700 (PDT)
Message-ID: <7d571b9d-2066-8217-5485-da0e6ace65eb@arm.com>
Date:   Mon, 28 Mar 2022 09:33:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v4 01/10] Use IDR to maintain all the enabled sources'
 paths.
To:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org
References: <20220324121734.21531-1-quic_jinlmao@quicinc.com>
 <20220324121734.21531-2-quic_jinlmao@quicinc.com>
 <YjxjXnXAXVXfZqr/@kroah.com>
 <e78ff137-fc5e-ff00-0e57-91304288d860@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <e78ff137-fc5e-ff00-0e57-91304288d860@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2022 14:23, Jinlong Mao wrote:
> Hi Greg,
> 
> Thanks for your review.
> 
> On 3/24/2022 8:26 PM, Greg Kroah-Hartman wrote:
>> On Thu, Mar 24, 2022 at 08:17:25PM +0800, Mao Jinlong wrote:
>>> Use hash length of the source's device name to map to the pointer
>>> of the enabled path. Using IDR will be more efficient than using
>>> the list. And there could be other sources except STM and CPU etms
>>> in the new HWs. It is better to maintain all the paths together.
>>>
>>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-core.c | 75 +++++++-------------
>>>   1 file changed, 26 insertions(+), 49 deletions(-)
>> Your subject line is odd.  Please put back the driver subsystem in the
>> subject line so that it makes more sense.
> I will update the subject in next version.
>>
>> And how have you measured "more efficient"?
> 
> Using IDR would be better than doing a sequential search as there will 
> be much more device  in future.

Where do we use sequential search now ? For non-CPU bound sources, yes
we may need something. But CPU case is straight forward, and could be
retained as it is. i.e., per-cpu list of paths.

Cheers
Suzuki


> 
>>
>> thanks,
>>
>> greg k-h
> 
> Thanks
> 
> Jinlong Mao
> 

