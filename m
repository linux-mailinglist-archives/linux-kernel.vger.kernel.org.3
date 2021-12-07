Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C19A46BB78
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236519AbhLGMlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbhLGMlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:41:08 -0500
Received: from lb1-smtp-cloud9.xs4all.net (lb1-smtp-cloud9.xs4all.net [IPv6:2001:888:0:108::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AA5C061574;
        Tue,  7 Dec 2021 04:37:37 -0800 (PST)
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud9.xs4all.net with ESMTPA
        id uZiom8JcOlcdAuZitmm74J; Tue, 07 Dec 2021 13:37:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1638880655; bh=e1nxQHMf3JV3K8iQrlbfQrErzLZwfWaT7Fr5WTmgnOM=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=Mr8/8ewjooFmJ/S61fP1mr6xOU38rw38iZ+j6r+EbaTiUrN+YYQkOGFVW3glXIm7m
         oevRtMt86hWNJIP3wus7QLayB7j5M8tu7ITzWPC44srkw/SsDXC5sNQer9sj9EC6ux
         lR/kCah6/cX/y5IxbK1LHdwnWw0yj7H/08oFu1ca0GZGJYRyp5qb2PPDJ/NTdYoNFg
         5PCq70/SAEw+lx0Ak2eX+MdrI4efFD58QL7F9tqmgbjKguQK0MO+XgleOE1k64HMWv
         JRpZlnU21mxk2BRW+ulFIuiA8SsQH+uuR7b80Z2DWbexeDGyrtYq8OklDuAbqrwgYJ
         K+dQPqlh3B/sw==
Subject: Re: [PATCH v7 2/7] mtk-mdp: add driver to probe mdp components
To:     houlong wei <houlong.wei@mediatek.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Eizan Miyamoto <eizan@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?UTF-8?B?Q0sgSHUgKOiDoeS/ig==?= =?UTF-8?B?5YWJKQ==?= 
        <ck.hu@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <Andrew-CT.Chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?B?TWluZ2hzaXUgVHNhaSAo6JSh5piO5L+uKQ==?= 
        <Minghsiu.Tsai@mediatek.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-media <linux-media@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <20210825063323.3607738-1-eizan@chromium.org>
 <20210825163247.v7.2.Ie6d1e6e39cf9b5d6b2108ae1096af34c3d55880b@changeid>
 <CAAEAJfDNDXdJFfB-bHhFcqnnKZ0TY--d_wLGddKRymQOLQY4TQ@mail.gmail.com>
 <fc309940c9e59f80397b90c8b11424fea344e1b5.camel@mediatek.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <a0b3a10d-9313-7ac5-692c-822aeff50858@xs4all.nl>
Date:   Tue, 7 Dec 2021 13:37:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <fc309940c9e59f80397b90c8b11424fea344e1b5.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFrnF+E4LspJHa9iC0okvk65sbYCc7UmaWwSeF1PKedql/7Kwu+Dco+/KY6CStjjVju+3Z9bt2NnyNbrgIOsecXm9eWl7G4gTxaWJ1DEOLU/6yyIjNJs
 1u0aYHUrRGYEYFQl3Qg8fEdMuXc658dE0kDzfeNC4kQL0cNF6Ryy8SLPKQR9R31foRCM8wXZ2tESy6u05DnPeY6W0SUAq9mFU4LqQR7RanMdcduzBFKO7en2
 R3Ip7HBIqMplDVeM1wIuUDSHBYYO7xy+1OBxq63Jp3Skoq/I8Oj7HU0YWX0Wey4tYGRJSSzr8xUyTyh2LzCXfVSODjorqjdxK+lEhFtIQEIQeqIShNxE6ztm
 bR0Z0iLkj4sc+CAly15ZTCjycEpy8WjK3GW8i4gGT/6YbG7Bp/8XYyP3KmIIEiDd4dDjoeAxKN4yajFi99nRfKBF06iSMjPbYykD/oUDTpfJCZ9McUyPjDCF
 rYCg4UklGLRodTiZIbTHROu2JD+M+Z9mqvgXHVFv9NGXQA3ovX6mODRQoCKFJSAWrJccq/vqCYaqjveQYeNC05ETw0tTcXKrPs5wAZd7nq5mZHVwt+Y1Z6V4
 eyk4uQFEJdtYRe+6VUzsL2C2FWXYNuiq6IVNto8D1nO/SohM/PKkAVlHhzScpUS3YTiUNvgHixr1rzmumDAow0OlUO+dn2aksuadSKbnRP0aVdA8hCWO9v3z
 F5Q5noY403z5sA6K+ibcTply5RPmCMWfqEDQLN5rGE2svPvpQeFo/8sjOlh3HXD3EYaJU10pz60/huqymFVRDBkGFfHQoWf78A5O99zUP9nEopC8hf/E9qDd
 hV2ouCnmQBYyEQN95u3NAA6gk1NF00ttXJ7hdalKnxlqCbL/Ir9GiDZfpm+u6VTNFxZmNRTRMrS4C/QQJ0A=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/21 6:23 PM, houlong wei wrote:
> Hi Ezequiel,
> 
> Thank you for your attention to this series of patches. I answer partial of your questions below.
> Regards,
> Houlong
> 
> On Sat, 2021-09-04 at 20:34 +0800, Ezequiel Garcia wrote:
>> Hi Eizan,
>>
>> Sorry for seeing this series so late.
>>
>> On Wed, 25 Aug 2021 at 03:35, Eizan Miyamoto <eizan@chromium.org>
>> wrote:
>>>
>>> Broadly, this patch (1) adds a driver for various MTK MDP
>>> components to
>>> go alongside the main MTK MDP driver, and (2) hooks them all
>>> together
>>> using the component framework.
>>>
>>> (1) Up until now, the MTK MDP driver controls 8 devices in the
>>> device
>>> tree on its own. When running tests for the hardware video decoder,
>>> we
>>> found that the iommus and LARBs were not being properly configured.
>>
>> Why were not being properly configured? What was the problem?
>> Why not fixing that instead?
>>
>> Does this mean the driver is currently broken and unusable?
> 
> This series of patches are supplements to another series, please refer
> to  
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=515129c
> , which add device link between the mtk-iommu consumer and the mtk-larb 
> devices. Without that series of patches, the mtk-mdp driver can work
> well so far.
> But with that series, it seems the device link only can be established
> for the device which is registered as a platform driver. That's why
> Eizan adds this series of patches to make all mdp components to be
> registered as platform drivers.

Hold on, so this means that if that iommu device-link series is merged,
then the mtk-mdp driver breaks? I posted a PR for that iommu series, but
I've just withdrawn that PR until this issue is clarified.

Is it only mtk-mdp that is affected by this iommu device-link series, or
others as well?

Regards,

	Hans

> 
>>
>>> To
>>> configure them, a driver for each be added to mtk_mdp_comp so that
>>> mtk_iommu_add_device() can (eventually) be called from
>>> dma_configure()
>>> inside really_probe().
>>>
>>> (2) The integration into the component framework allows us to defer
>>> the
>>> registration with the v4l2 subsystem until all the MDP-related
>>> devices
>>> have been probed, so that the relevant device node does not become
>>> available until initialization of all the components is complete.
>>>
>>> Some notes about how the component framework has been integrated:
>>>
>>> - The driver for the rdma0 component serves double duty as the
>>> "master"
>>>   (aggregate) driver as well as a component driver. This is a non-
>>> ideal
>>>   compromise until a better solution is developed. This device is
>>>   differentiated from the rest by checking for a "mediatek,vpu"
>>> property
>>>   in the device node.
>>>
>>
>> As I have stated in Yunfei, I am not convinced you need an async
>> framework
>> at all. It seems all these devices could have been linked together
>> in the device tree, and then have a master device to tie them.
>>
>> I.e. something like
>>
>> mdp {
>>   mdp_rdma0 {
>>   }
>>   mdp_rsz0 {
>>   }
>>   mdp_rsz1 {
>>   }
>> }
>>
> 
> The commit message of the patch below explains that " If the mdp_*
> nodes are under an mdp sub-node, their corresponding platform device
> does not automatically get its iommu assigned properly."
> Please refer to 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/arch/arm64/boot/dts/mediatek/mt8173.dtsi?h=v5.14.1&id=8127881f741dbbf9a1da9e9bc59133820160b217
> 
>> All this async games seem like making the driver really obfuscated,
>> which will mean harder to debug and maintain.
>> I am not sure we want that burden.
>>
>> Even if we are all fully convinced that you absolutely need
>> an async framework, then what's wrong with v4l2-async?
>>
>> I would start by addressing what is wrong with the IOMMUs
>> in the current design.
>>
>> Thanks,
>> Ezequiel
>>
>>> - The list of mdp components remains hard-coded as
>>> mtk_mdp_comp_dt_ids[]
>>>   in mtk_mdp_core.c, and as mtk_mdp_comp_driver_dt_match[] in
>>>   mtk_mdp_comp.c. This unfortunate duplication of information is
>>>   addressed in a following patch in this series.
>>>
>>> - The component driver calls component_add() for each device that
>>> is
>>>   probed.
>>>
>>> - In mtk_mdp_probe (the "master" device), we scan the device tree
>>> for
>>>   any matching nodes against mtk_mdp_comp_dt_ids, and add component
>>>   matches for them. The match criteria is a matching device node
>>>   pointer.
>>>
>>> - When the set of components devices that have been probed
>>> corresponds
>>>   with the list that is generated by the "master", the callback to
>>>   mtk_mdp_master_bind() is made, which then calls the component
>>> bind
>>>   functions.
>>>
>>> - Inside mtk_mdp_master_bind(), once all the component bind
>>> functions
>>>   have been called, we can then register our device to the v4l2
>>>   subsystem.
>>>
>>> - The call to pm_runtime_enable() in the master device is called
>>> after
>>>   all the components have been registered by their bind() functions
>>>   called by mtk_mtp_master_bind(). As a result, the list of
>>> components
>>>   will not change while power management callbacks
>>> mtk_mdp_suspend()/
>>>   resume() are accessing the list of components.
>>>
>>> Signed-off-by: Eizan Miyamoto <eizan@chromium.org>
>>> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> Reviewed-by: Houlong Wei <houlong.wei@mediatek.com>
>>> ---
>>>
> 

