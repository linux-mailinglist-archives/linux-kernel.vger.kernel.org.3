Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91F1478696
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 09:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhLQIzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 03:55:54 -0500
Received: from foss.arm.com ([217.140.110.172]:53586 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhLQIzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 03:55:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BEF41435;
        Fri, 17 Dec 2021 00:55:53 -0800 (PST)
Received: from [10.57.6.245] (unknown [10.57.6.245])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AB503F774;
        Fri, 17 Dec 2021 00:55:52 -0800 (PST)
Subject: Re: [PATCH] drm/panfrost: Avoid user size passed to kvmalloc()
To:     Rob Herring <robh@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20211216161603.983711-1-steven.price@arm.com>
 <CAL_JsqKZBsJxy8h5EQf0wwfioWS-Kx9i=0cQ7p4FHckEXstGiw@mail.gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <4c564c0d-7702-9dfe-910f-969fe130aba8@arm.com>
Date:   Fri, 17 Dec 2021 08:55:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKZBsJxy8h5EQf0wwfioWS-Kx9i=0cQ7p4FHckEXstGiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2021 17:12, Rob Herring wrote:
> On Thu, Dec 16, 2021 at 10:16 AM Steven Price <steven.price@arm.com> wrote:
>>
>> panfrost_copy_in_sync() takes the number of fences from user space
>> (in_sync_count) and used to kvmalloc() an array to hold that number of
>> fences before processing them. This provides an easy method for user
>> space to trigger the OOM killer (by temporarily allocating large amounts
>> of kernel memory) or hit the WARN_ONCE() added by 7661809d493b ("mm:
>> don't allow oversized kvmalloc() calls").
>>
>> Since we don't expect there to be a large number of fences we can
>> instead iterate over the fences one-by-one and avoid the temporary
>> allocation altogether. This also makes the code simpler.
> 
> Doesn't the BO lookup suffer from the same issue?

Ah! Yes it does - I'd looked at this and seen the call to
drm_gem_objects_lookup() and assumed that since it's a DRM function (not
Panfrost specific) it must already handle this gracefully. However
clearly it doesn't, and a quick grep confirms that Panfrost is actually
the only user of the function anyway.

However this one is harder to fix without setting an arbitrary cap on
the number of BOs during a sumbit. I'm not sure how other drivers handle
this - the ones I've looked at so far all have the same issue. There's
obviously the list that Dan already sent, but e.g. msm has the same bug
in msm_gem_submit.c:submit_create() with an amusing bug where the check
for (sz > SIZE_MAX) will never hit, although the call is to kzalloc() so
large allocations are going to fail anyway.

Has anyone got any views on how this should be handled generally? I'm
somewhat wary of setting arbitrary limits, especially as it's
effectively an ABI change.

Steve
