Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CBF4FE7CE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 20:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347502AbiDLSW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 14:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236948AbiDLSWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 14:22:53 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0DB4969F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 11:20:35 -0700 (PDT)
Received: from [IPV6:2a00:5f00:102:0:10b3:10ff:fe5d:4ec1] (unknown [IPv6:2a00:5f00:102:0:10b3:10ff:fe5d:4ec1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id AD94E1F44A65;
        Tue, 12 Apr 2022 19:20:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649787633;
        bh=89nEyLETtUj6qse1DGp0rsGFjY9owVYpHqNxsQzbbW4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QDGr51ksXmI4Pez4M+ze9AcF+g/sAdJ+SZL2gaA3ylgszoig0/IJrP9uj05T9dIT0
         MwFBfhb3F5TPRfV3ObzCq+OInxq4oPo5sjvB81gxcIiz0r/5Z0DzndxXHgxu9F7Gew
         5W3k7l7L1GMN4OoJM3a8pnfsfIGdAiK7gY2TZJPObBj6sfPU20AWjRfw+BJHjTY2GA
         GT953VvXgw61UZPXPW2Kp7qmrx49cXR9G6gpk0FDQDQr5AX4nmzJrDcgEd2cGY26TS
         xMT4x+/yxUrqrJ838NWNOVRs4f3B2XFIGaJtPS6tnm4iTn1jjf6rnK2GmtbCFe+Aam
         oy/edFnVBz7tg==
Message-ID: <a04733af-5ff1-a1b4-527d-68b28a037231@collabora.com>
Date:   Tue, 12 Apr 2022 21:20:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1] drm/scheduler: Don't kill jobs in interrupt context
Content-Language: en-US
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Rob Herring <robh@kernel.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>
References: <20220411221536.283312-1-dmitry.osipenko@collabora.com>
 <064d8958-a288-64e1-b2a4-c2302a456d5b@amd.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <064d8958-a288-64e1-b2a4-c2302a456d5b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/22 19:51, Andrey Grodzovsky wrote:
> 
> On 2022-04-11 18:15, Dmitry Osipenko wrote:
>> Interrupt context can't sleep. Drivers like Panfrost and MSM are taking
>> mutex when job is released, and thus, that code can sleep. This results
>> into "BUG: scheduling while atomic" if locks are contented while job is
>> freed. There is no good reason for releasing scheduler's jobs in IRQ
>> context, hence use normal context to fix the trouble.
> 
> 
> I am not sure this is the beast Idea to leave job's sw fence signalling
> to be
> executed in system_wq context which is prone to delays of executing
> various work items from around the system. Seems better to me to leave the
> fence signaling within the IRQ context and offload only the job freeing or,
> maybe handle rescheduling to thread context within drivers implemention
> of .free_job cb. Not really sure which is the better.

We're talking here about killing jobs when driver destroys context,
which doesn't feel like it needs to be a fast path. I could move the
signalling into drm_sched_entity_kill_jobs_cb() and use unbound wq, but
do we really need this for a slow path?
