Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF02525EFA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355257AbiEMJov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 05:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiEMJoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 05:44:46 -0400
X-Greylist: delayed 3611 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 May 2022 02:44:45 PDT
Received: from mail-m17655.qiye.163.com (mail-m17655.qiye.163.com [59.111.176.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBC51E2510
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:44:45 -0700 (PDT)
Received: from [172.16.12.93] (unknown [58.22.7.114])
        by mail-m17655.qiye.163.com (Hmail) with ESMTPA id 2E4D94003D;
        Fri, 13 May 2022 16:44:32 +0800 (CST)
Message-ID: <94bf30a2-9dcf-07b2-ccb6-3c4aa5cf6a00@rock-chips.com>
Date:   Fri, 13 May 2022 16:44:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [BUG] New arm scmi check in linux-next causing rk3568 not to boot
 due to firmware bug
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>, linux-kernel@vger.kernel.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>
References: <1698297.NAKyZzlH2u@archbook> <YnOEwuuyO2/h7c1G@e120937-lin>
 <CAN5uoS_MgBiTVZCRSZyYCH4cnUZD_bHj2+mZu661bFV8TKWScw@mail.gmail.com>
 <6587375.6lpfYT6tjA@archbook> <Yn0a9nSD7Yu6aOkt@bogus>
From:   Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <Yn0a9nSD7Yu6aOkt@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUlKS0tKN1dZLVlBSVdZDwkaFQgSH1lBWRpPQklWGkMfSkhMSx
        5LTExKVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktITUpVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODI6Nzo*ND0*SU8tTigDOQsh
        AzdPCRVVSlVKTU5JT0hKT0xJQ0tPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
        EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIQkNMNwY+
X-HM-Tid: 0a80bc974751da01kuws2e4d94003d
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

     Rockchip has notice this issue, we will check how to fix this issue 
in our ATF release.


Thanks,
- Kever
On 2022/5/12 22:34, Sudeep Holla wrote:
> On Thu, May 12, 2022 at 01:11:22PM +0200, Nicolas Frattaroli wrote:
>> Hello,
>>
>> sorry for the late reply, completely missed that there was a question
>> for me in this mail.
>>
>> On Donnerstag, 5. Mai 2022 11:40:09 CEST Etienne Carriere wrote:
>>> Hello Nicolas, Cristian,
>>> [...]
>>>
>>> Indeed the firmware implementation is wrong in TF-A.
>>> And also in OP-TEE by the way:
>>> https://github.com/OP-TEE/optee_os/blob/3.17.0/core/drivers/scmi-msg/base.c#L163-L166
>>>
>>> @Nicoals, do you want to send a patch to TF-A, or do you want me to do it?
>> I have no experience with TF-A, so I'd prefer if you could do it.
>>
>> In good news, Rockchip has confirmed they're preparing to release RK356x
>> TF-A sources, so I'll be able to port the patch over to their sources once
>> they are released, if they don't already apply it themselves.
>>
> So, there is no way to get a blob release with the patch applied ?
> We know it is a bug in TF-A and if Rockchip is using that codebase, it
> will be the same bug there too causing this issue. Waiting until the
> code is released and the proper TF-A port is done may not be acceptable
> for many developers. So someone from the rockchip doing these tf-a blob
> release must get involved here, understand the situation and get the fixed.
>
> We can workaround, but I want to hear that it will be fixed instead of
> getting ignored until proper port is available.
>
> Etienne, are you not the author for the related TF-A code ? How can we
> get that fixed in the TF-A code base. If you are not, then I will try to
> get my repo login credentials sorted so that I can only push TF-A change.
>
