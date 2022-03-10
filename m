Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766554D4330
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbiCJJMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbiCJJL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:11:59 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FAD113776D;
        Thu, 10 Mar 2022 01:10:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFA1A1650;
        Thu, 10 Mar 2022 01:10:58 -0800 (PST)
Received: from [10.57.7.5] (unknown [10.57.7.5])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07ABA3FA20;
        Thu, 10 Mar 2022 01:10:56 -0800 (PST)
Message-ID: <a1790ad9-b5e0-9a00-debc-fc8ef2c757cb@arm.com>
Date:   Thu, 10 Mar 2022 09:10:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v3] coresight: core: Fix coresight device probe failure
 issue
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
References: <20220309142206.15632-1-quic_jinlmao@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220309142206.15632-1-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jinlong


On 09/03/2022 14:22, Mao Jinlong wrote:
> It is possibe that probe failure issue happens when the device
> and its child_device's probe happens at the same time.
> In coresight_make_links, has_conns_grp is true for parent, but
> has_conns_grp is false for child device as has_conns_grp is set
> to true in coresight_create_conns_sysfs_group. The probe of parent
> device will fail at this condition. Add has_conns_grp check for
> child device before make the links and make the process from
> device_register to connection_create be atomic to avoid this
> probe failure issue.
> 
> Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Suggested-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>

Thanks for the rework. The patch looks good to me.

Suzuki
