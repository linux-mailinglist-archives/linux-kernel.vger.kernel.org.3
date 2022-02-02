Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BD74A72FD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242506AbiBBO0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:26:37 -0500
Received: from foss.arm.com ([217.140.110.172]:34440 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237320AbiBBO0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:26:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D13A0ED1;
        Wed,  2 Feb 2022 06:26:34 -0800 (PST)
Received: from [10.57.68.47] (unknown [10.57.68.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02D393F718;
        Wed,  2 Feb 2022 06:26:32 -0800 (PST)
Message-ID: <6f0e58dc-4b81-d819-13e3-9e0f79ba279c@arm.com>
Date:   Wed, 2 Feb 2022 14:26:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v10 2/6] dt-bindings: gpio: logicvc: Add a compatible with
 major version only
Content-Language: en-GB
To:     Linus Walleij <linus.walleij@linaro.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
References: <20220120150024.646714-1-paul.kocialkowski@bootlin.com>
 <20220120150024.646714-3-paul.kocialkowski@bootlin.com>
 <CACRpkdbnEKeDNmFCuUCLaySs6AtD9MPtxV+9JDxKuXvTs9iMVQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CACRpkdbnEKeDNmFCuUCLaySs6AtD9MPtxV+9JDxKuXvTs9iMVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-30 00:46, Linus Walleij wrote:
> On Thu, Jan 20, 2022 at 4:00 PM Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> 
>> There are lots of different versions of the logicvc block and it
>> makes little sense to list them all in compatibles since all versions
>> with the same major are found to be register-compatible.
> 
> The reason we try to be precise is because sometime, long after the driver
> has been merged and maintained for a few years, a bug is discovered
> in a specific version of the silicon.
> 
> What happens is that a fix is applied on all silicon whether it is needed
> or not.
> 
> If you have the precise silicon compatible, you can avoid this and target
> only a specific version.

Indeed, the better approach would be something like:

   compatible:
     oneOf:
       - items:
           - enum:
               - foo,bar-v1.0
               - foo,bar,v1.1
           - const: foo,bar-v1
       - items:
           - enum:
               - foo,bar-v2.0
           - const: foo,bar-v2

That way the DTs are future-proof, while drivers can still match on only 
the less-specific strings until a need arises. Plus it avoids the 
problem that if an existing OS that only understands "foo,bar-v1.0" is 
given a new DT with only "foo,bar-v1" for v1.0 hardware it won't be able 
to use the device, even though it's *functionally* capable of doing so.

However, from skimming patch #5, it looks possible that none of these 
changes are needed at all. If LOGICVC_IP_VERSION_REG tells you the exact 
revision, and is always present (as the unconditional reading of it 
implies), then the only reason for adding new compatibles would be if, 
say, v5 has more clocks from v4 and you want the binding to enforce 
that; otherwise, newer versions are literally compatible with the 
currently-defined binding and therefore should continue to bind against 
the existing string(s) to maximise forward- and backward-compatibility. 
Sure, it's not the prettiest thing for a "generic" compatible to be 
based on an oddly-specific version number that doesn't necessarily match 
the actual software-discoverable version, but what's done is done and 
that's the cost of ABI.

Cheers,
Robin.

(also, nitpick for that part of patch #5 since I'm here: please include 
linux/bitfield.h rather than reinventing FIELD_GET() locally)
