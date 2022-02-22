Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194034BF6BA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 11:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbiBVKzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 05:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiBVKzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:55:17 -0500
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95977158DA3;
        Tue, 22 Feb 2022 02:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vCY3PKWG+UyDYeceDiVl2nmf3pfgqjVMkazFF1HRiGE=; b=fp+sOp2QXbG2fhZ5uSWJnQm0Od
        r01zdLCfBd72Th7x54Og+EMBPIKs0Xyj5pPrny6ROjjN8iaBj8BkCw/oz6GOoTGgMT66EKRxdpqHD
        hJVcyt55+nS3lSn7cs/GIDpxA+VVFNUeQ9Low30sxe/XaW70tIc+AK/MRL8OI0GdzOWd6Pa/Y5uyH
        jEhHvlCQ7nFWJ/9KZorN6VPqr69Hkn5k9oq6eYRXK6S0TYPGOBAsrqgKBkzUx7vA3NE1IjNXIQF8J
        /Bw0OtrIyZpf27R0izRIodNVmSjfeAnHLG7ry8gq0D7VTMoKsNfDtcCPlYw6qzh9/1hxpCLOT9Ir/
        DXof/SLA==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=[192.168.1.10])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1nMSod-0000Po-2Q; Tue, 22 Feb 2022 12:54:43 +0200
Message-ID: <b947e0b2-a78d-bacf-0d78-b5d57e821e6e@kapsi.fi>
Date:   Tue, 22 Feb 2022 12:54:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 8/9] drm/tegra: vic: Implement get_streamid_offset
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
        will@kernel.org, robh+dt@kernel.org, robin.murphy@arm.com
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-9-mperttunen@nvidia.com>
 <b1df816b-6838-c435-1a23-5029144e4cfe@gmail.com>
 <7f4e4c47-59f1-1def-36bf-a2ded912f76d@gmail.com>
 <5d1b6e82-2c9d-8388-697f-0d7305a1206f@kapsi.fi>
 <ee648994-b296-2ac4-a676-ddcac463a428@gmail.com>
 <30033f5b-3fd1-22c7-896b-af034a4041df@kapsi.fi>
 <4352fda7-ecb6-4a5e-7d6c-a50537d8eaff@gmail.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <4352fda7-ecb6-4a5e-7d6c-a50537d8eaff@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/22 12:46, Dmitry Osipenko wrote:
> 22.02.2022 11:27, Mikko Perttunen пишет:
>> On 2/21/22 22:10, Dmitry Osipenko wrote:
>>> 21.02.2022 14:44, Mikko Perttunen пишет:
>>>> On 2/19/22 20:54, Dmitry Osipenko wrote:
>>>>> 19.02.2022 21:49, Dmitry Osipenko пишет:
>>>>>> 18.02.2022 14:39, Mikko Perttunen пишет:
>>>>>>> +static int vic_get_streamid_offset(struct tegra_drm_client *client)
>>>>>>> +{
>>>>>>> +    struct vic *vic = to_vic(client);
>>>>>>> +    int err;
>>>>>>> +
>>>>>>> +    err = vic_load_firmware(vic);
>>>>>>
>>>>>> You can't invoke vic_load_firmware() while RPM is suspended. Either
>>>>>> replace this with RPM get/put or do something else.
>>>>
>>>> Why not, I'm not seeing any HW accesses in vic_load_firmware? Although
>>>> it looks like it might race with the vic_load_firmware call in
>>>> vic_runtime_resume which probably needs to be fixed.
>>>
>>> It was not clear from the function's name that h/w is untouched, I read
>>> "load" as "upload" and then looked at vic_runtime_resume(). I'd rename
>>> vic_load_firmware() to vic_prepare_firmware_image().
>>>
>>> And yes, technically lock is needed.
>>
>> Yep, I'll consider renaming it.
> 
> Looking at this all again, I'd suggest to change:
> 
> int get_streamid_offset(client)
> 
> to:
> 
> int get_streamid_offset(client, *offset)
> 
> and bail out if get_streamid_offset() returns error. It's never okay to
> ignore errors.

Sure, seems reasonable. We'll still need some error code to indicate 
that context isolation isn't available for the engine and continue on in 
that case but that's better than just ignoring all of them.

Mikko
