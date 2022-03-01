Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1022C4C8E83
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbiCAPEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbiCAPET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:04:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FA0F41FB8;
        Tue,  1 Mar 2022 07:03:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D19051042;
        Tue,  1 Mar 2022 07:03:36 -0800 (PST)
Received: from [10.57.21.105] (unknown [10.57.21.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B07FD3F70D;
        Tue,  1 Mar 2022 07:03:34 -0800 (PST)
Message-ID: <2fd9c96a-fc86-7247-d13a-a5283bb82494@arm.com>
Date:   Tue, 1 Mar 2022 15:03:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH] coresight: Defer probe when the child dev is not probed
To:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mao Jinlong <jinlmao@qti.qualcomm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
References: <20220228133112.3987-1-quic_jinlmao@quicinc.com>
 <861dd6e1-30dc-626e-3449-72d3b6822e7b@arm.com>
 <a63abe13-793e-323f-e214-1dd9826c8a9a@quicinc.com>
 <CAJ9a7VjShWLeSh0gyna-AUEB+jXO7u8JGLTXm_henn_cJ+E6Zw@mail.gmail.com>
 <edf83cee-d2af-867b-50e4-b065e7fb4b73@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <edf83cee-d2af-867b-50e4-b065e7fb4b73@quicinc.com>
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

Hi

On 01/03/2022 13:30, Jinlong Mao wrote:
> Hi Mike,
> 
> On 3/1/2022 9:15 PM, Mike Leach wrote:
>> Hi,
>>
>> On Tue, 1 Mar 2022 at 11:42, Jinlong Mao <quic_jinlmao@quicinc.com> 
>> wrote:
>>> On 2/28/2022 10:51 PM, Suzuki K Poulose wrote:
>>>

...

>>>
>>> Hi Suzuki,
>>>
>>> This issue happens when race condition happens.
>>> The condition is that the device and its child_device's probe happens 
>>> at the same time.
>>>
>>> For example: device0 and its child device device1.
>>> Both of them are calling coresight_register function. device0 is 
>>> calling coresight_fixup_device_conns.
>>> device1 is waiting for device0 to release the coresight_mutex. 
>>> Because device1's csdev node is allocated,
>>> coresight_make_links will be called for device0. Then in 
>>> coresight_add_sysfs_link, has_conns_grp is true
>>> for device0, but has_conns_grp is false for device1 as has_conns_grp 
>>> is set to true in coresight_create_conns_sysfs_group .
>>> The probe of device0 will fail for at this condition.
>>>
>>>
>>> struct coresight_device *coresight_register(struct coresight_desc *desc)
>>> {
>>>     .........
>>>      mutex_lock(&coresight_mutex);
>>>
>>>      ret = coresight_create_conns_sysfs_group(csdev);
>>>      if (!ret)
>>>          ret = coresight_fixup_device_conns(csdev);
>>>      if (!ret)
>>>          ret = coresight_fixup_orphan_conns(csdev);
>>>      if (!ret && cti_assoc_ops && cti_assoc_ops->add)
>>>          cti_assoc_ops->add(csdev);
>>>
>>>      mutex_unlock(&coresight_mutex);
>>>
>>> .........
>>>
>>> }
>>>
>>> static int coresight_fixup_device_conns(struct coresight_device *csdev)
>>> {
>>>     ..........
>>>          conn->child_dev =
>>>              coresight_find_csdev_by_fwnode(conn->child_fwnode);
>> The issue appears to be a constraint hidden in the lower layers of the 
>> code.
>> Would a better solution not be to alter the code here:
>>
>> if (conn->child_dev && conn->child_dev->has_conns_grp) {
>>     ...
>> } else {
>>        csdev->orphan = true;
>> }
>>
>> which would mean that the connection attempt would drop through to
>> label the connection as an orphan, to be cleaned up by the child
>> itself when it runs coresight_fixup_orphan_conns()
>>

Tnanks Mike, I think that is a good solution. Alternatively, we
could make sure that device_register() and the fixup following
that are atomic.

i.e.

	mutex_lock()

	device_register()
	fixup_connections()
	create_sysfs()

	mutex_unlock();

The fix may be a bit invasive than Mike's proposal, but it makes
sure we don't end up with half baked device on the coresight-bus.

Suzuki
