Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F74254CA59
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353235AbiFONwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347726AbiFONwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:52:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEDD2193;
        Wed, 15 Jun 2022 06:52:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB8F161B20;
        Wed, 15 Jun 2022 13:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F514C341C7;
        Wed, 15 Jun 2022 13:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655301151;
        bh=5viv8HZleikUPoCNSja+0kTEacXDXuq29SCfCBxOlZ8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Z68AF1VVS349Qmh14HdS/s/8qqWEXmqWHIc19lmwlSyXl7gWBkMk+LlfODfjVTeMM
         1jnzjHz1M3+gXsQ8eEqoQrvxHQ9KSoDsQzPM7K/OQGVa3g6iMQ9CNIbjuL+/ygTLyO
         IyOhHdk1u7JjmJrpOQhjeGv6tMQAkzUPH+Kp2/rwYpHQBpNLnMYX94Wu+i2S6uNK3s
         walZiZcwKLOBofdHv4urg7KPFMnnv2onorS53HdnyDZQP1qgq5L5kkgC3fkwKquDgl
         WNUdQ6FzlFE0smcWgFbj12C2zUQkhMiEkpcgpbYSRrCOBYcBAlb6iuihL9zI/QEDrl
         mc1DBOteBT41A==
Date:   Wed, 15 Jun 2022 15:52:27 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanberzl@gmail.com, dlatypov@google.com,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH v4 0/4] Add support for XP-PEN Deco L
In-Reply-To: <20220611113914.355577-1-jose.exposito89@gmail.com>
Message-ID: <nycvar.YFH.7.76.2206151552060.14340@cbobk.fhfr.pm>
References: <20220611113914.355577-1-jose.exposito89@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jun 2022, José Expósito wrote:

> Hello everyone,
> 
> This patchset adds support for the UGEE XP-PEN Deco L tablet.
> This device belongs to a family of tablets that must receive a chunk of
> magic data in order to be enabled (named UGEE v2 internally).
> 
> Once the device is enabled, its parameters can be discovered by parsing
> a report descriptor. HUION v1 tablets have a similar report descriptor
> but, in the case of UGEE v2 tablets, the number of buttons are also
> discoverable [1].
> 
> The ability to discover the number of buttons is the reason for the
> first 3 patches. They enable frame templates.
> Because I lack the hardware to fully test this driver, I added some
> KUnit tests to make sure no bugs are introduced.
> I didn't see any other test in the subsystem (and I doubt I'm the first
> person writing one) so please let me know if I need to move the test to
> a different place.
> 
> The last patch enables the tablet.
> 
> Best wishes,
> José Expósito
> 
> [1] I don't own a HUION v1 device, so I'm not sure if the information
>     about the number of buttons is also present and it is not used in
>     the driver for some reason.
> [2] https://lore.kernel.org/linux-input/20220516112159.GA74406@elementary/T/#t
> 
> ---
> 
> v1 - https://lore.kernel.org/linux-input/20220518224702.1409327-1-jose.exposito89@gmail.com/
> 
> v2 - https://lore.kernel.org/linux-input/20220518224702.1409327-1-jose.exposito89@gmail.com/T/
> 
>  - Add MODULE_DESCRIPTION/LICENSE/AUTHOR to hid-uclogic-rdesc-test.c
>  - Remove unused variable in uclogic_params_ugee_v2_init
>  - Add sparse __force anotation in the result of cpu_to_le16
>  - Add DISABLE_STRUCTLEAK_PLUGIN for KUnit tests
> 
> v3 - https://lore.kernel.org/linux-input/nycvar.YFH.7.76.2206081150060.10851@cbobk.fhfr.pm/T/
> 
>  - Improve Kconfig message
>  - Add .kunitconfig. Thanks to Daniel Latypov for suggesting it in an
>    unrelated patch:
>    https://lore.kernel.org/dri-devel/CAGS_qxpV2SsihEdgXZ6+7N0dxLmdRANq+qE4iUZ2aNrf6vuLYg@mail.gmail.com/
> 
> v4:
> 
>  - Group all the test of the subsystem under HID_KUNIT_TEST:
>    HID_UCLOGIC_KUNIT_TEST -> HID_KUNIT_TEST
>  - Remove DISABLE_STRUCTLEAK_PLUGIN:
>    https://lore.kernel.org/dri-devel/CAGS_qxpFO4ixW=08ZcdcD9J1kU=B3mwoBJkPW8AKu0sKs8aKfA@mail.gmail.com/
> 

Now in hid.git#for-5.20/uclogic. Thanks,

-- 
Jiri Kosina
SUSE Labs

