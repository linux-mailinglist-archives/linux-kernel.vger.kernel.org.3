Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFAA4D9004
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 00:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343567AbiCNXGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 19:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235753AbiCNXGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 19:06:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BBA39BBC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 16:05:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 373E91F41076
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647299101;
        bh=ImDNs5MtGaf4nSstH8zkCM28WFaVLQuyemCzF6ZQYJo=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=PlTxBut6TmpI+QxoNKeujpyLENjWdEye6aX+0N+6F2/DOWqvfg/tBGqHA5BBm8CI4
         X/PEtRzXZbpIxQNXOSP+0W9ebTMWRTU7FAozYDi8ZeHs8Pa3NHe1IO7b5XESYewp/3
         GoZvmtJx24jW14SESqm1+Qc+1KUVLhEtSav5/rG9qCfIWP/ESK2kgphI2niv0mRLUJ
         HjKo+pGO2RWRRyDFe5aGiYvn5ZaPBT9ucMsNDNUw7+Pu9wMG38u3xcjKqRnJ4Cqs6e
         AVsQv0/1Hzo0rUYayD7AR2j34doPgXwjvp0uZwPU3GY7LcDH0SBNkYOtsnhai7Hozz
         jqwDJ8iUNBe1Q==
Message-ID: <64959ce1-15f0-59f5-a6f8-4258019e5a4b@collabora.com>
Date:   Tue, 15 Mar 2022 02:04:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v1 0/5] Add memory shrinker to VirtIO-GPU DRM driver
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Rob Clark <robdclark@chromium.org>
References: <20220308131725.60607-1-dmitry.osipenko@collabora.com>
 <CAF6AEGt=aVJ9nR+Wv+bJEFZrn-cNOSNXG1TaJr=Cx-FTgutwKA@mail.gmail.com>
 <d2290971-ea22-8203-631e-b896c76a994b@collabora.com>
 <CAF6AEGuR8B6z+z=VFQ6y01wbboYS_qpkghD1GYdLES_RZOW1wA@mail.gmail.com>
 <42facae5-8f2c-9c1f-5144-4ebb99c798bd@collabora.com>
 <CAF6AEGtebAbWhkvrxzi4UBLdv2LJPQVPBzH-sXcACs7cxznQ8A@mail.gmail.com>
 <05e1fe61-1c29-152f-414b-cd6a44525af0@collabora.com>
 <CAF6AEGvf81epGOs7Zh4WK-7mkXRApO2p-h4g8dTuk4xtc1HOeg@mail.gmail.com>
 <285bf619-8c05-f2f4-3aeb-e013fba8754a@collabora.com>
In-Reply-To: <285bf619-8c05-f2f4-3aeb-e013fba8754a@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/22 01:43, Dmitry Osipenko wrote:
>> I think that, given virgl uses host storage, guest shrinker should be
>> still useful.. so I think continue with this series.
> Guest shrinker indeed will be useful for virgl today. I was already
> questioning why virgl needs both host and guest storages, maybe it will
> move to a host-only storage approach in the future.
> 
> I think the variant with the timer expiration actually could be
> interesting to try because it should allow host to purge its VM BOs by
> itself, preventing host OOMs.

While I was working on shrinker v2, I noticed that host-side allocation
may take a significant time. So I decided to defer implementation of my
idea of using timer-based expiration for host-only BOs. I'll need to
examine it more.

>> For host shrinker, I'll have to look more at when crosvm triggers
>> balloon inflation.  I could still go the MADV:WILLNEED_REPLACE
>> approach instead, which does have the advantage of host kernel not
>> relying on host userspace or vm having a chance to run in order to
>> release pages.  The downside (perhaps?) is it would be more specific
>> to virtgpu-native-context and less so to virgl or venus (but I guess
>> there doesn't currently exist a way for madvise to be useful for vk
>> drivers).
> I'll also take a look at what CrOS does, maybe it has some interesting
> ideas.

I looked at CrOS kernel and crosvm, and haven't noticed anything special
there in regards to purging GPU's memory of VM on host-side memory
pressure. If you'll find something, then please let me know.

I sent out v2 of the shrinker series, but missed to CC you on it by
accident, please find it here [1].

[1]
https://lore.kernel.org/dri-devel/20220314224253.236359-1-dmitry.osipenko@collabora.com/T/#t
