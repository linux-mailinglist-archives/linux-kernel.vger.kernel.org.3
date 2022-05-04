Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6601651AF0D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378010AbiEDUbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343665AbiEDUbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:31:52 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712CF4F9F0;
        Wed,  4 May 2022 13:28:15 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-163-222.tukw.qwest.net [174.21.163.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id BEE94368;
        Wed,  4 May 2022 13:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1651696094;
        bh=k1OGqO6yttpA6KvVZQkxzts4/vCE80ZuQxCGo5hhVRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wo4l3g3tbSfivPvsKVzN8JXIHrCdw7VQ8UTGTKDqt9D5vfiFuZJrgX4Iq/+stwnCq
         0eDDymQkC/+HVsKy7fMLvzjQN3Zteirdlt+fFf4ns5C9iwmM1mJKdOmO2FFMlZUyjL
         5NwgO+BtJKIBuMH4kTzRM9i61xpkjAhlErqxi2Ig=
Date:   Wed, 4 May 2022 13:28:11 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH 0/6] regulator: core: Add support for external outputs
Message-ID: <YnLh23QbnO1MHoVL@hatter.bewilderbeest.net>
References: <20220504065041.6718-1-zev@bewilderbeest.net>
 <YnJ37QysSaa+gAps@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YnJ37QysSaa+gAps@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 05:56:13AM PDT, Mark Brown wrote:
>On Tue, May 03, 2022 at 11:50:35PM -0700, Zev Weiss wrote:
>
>> The DT bindings changes (patches 1 and 2) consist of a boolean
>> regulator property to mark it as supplying an external output, and a
>> reg-external-output binding to act as a downstream device representing
>> that output.  The redundancy between the two maybe isn't entirely
>> ideal, but it was the cleanest approach I've been able to come up with
>> so far in terms of working with the regulator subsystem; I'm certainly
>> open to suggestions for better ways of going about this.
>
>Nothing in the series articulates what the purpose of the redundancy is
>- your description of this is a consumer, why would the regulator itself
>care what's connected to it?

Hi Mark, thanks for the review.

To some extent that was an additional (maybe excessive) protective 
measure against regulators ending up userspace-controllable when they 
shouldn't be, since I had previously gotten the impression that there 
was some concern about that possibility.

More functionally though, it was also basically a hack to allow the 
'state' sysfs attribute's mode to get set properly in 
regulator_register(), before the consumer is known.  Though if things 
are rearranged based on what you said in another message about putting 
the enable/disable control in a consumer driver instead of the regulator 
itself, it should be easy to get rid of.


Thanks,
Zev

