Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25E44B7B1B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 00:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244762AbiBOXSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 18:18:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiBOXSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 18:18:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C17FC1C9E;
        Tue, 15 Feb 2022 15:18:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37040B81D51;
        Tue, 15 Feb 2022 23:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4E2C340EB;
        Tue, 15 Feb 2022 23:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644967118;
        bh=QeVPmQZzGvl7DCajPZBM5E4Qcbgt1kD5MfDXO75+qHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m8+AUeNcUDoZs97Qg40DOO5XchTZ4gs3/gyYht8NogHZqbIloXkURTiPVfO/wkjUU
         3K6Es5VOMblyHHNilajuGmt8jsmRTOguJ16fZTqCgtPvDJQyiwKjHK4etM/4IOhnDn
         tQMgdl4TpQUzFNHM4rr71tmrptL6YParxXu4cGAqrQ0QeWgKkhrIGZtQfr3nRutGIh
         uxuKDivncOz/ZMMKTQF9TuJI3ABqpS0xGsVr1A86HJrp3rgTXNT8ZgYEkrjrOaZ0p5
         oKW7EccrvKsOrrwLJ3ppVIM7sQg32LRqZMsL+tIsrevvgPe6+/P7QQkq3t9rylEYc3
         uh0G3tYDDzvFA==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: booting.rst: Clarify EL2 and cover v8-R64
Date:   Tue, 15 Feb 2022 23:18:20 +0000
Message-Id: <164493738020.3934087.8555074967425195921.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220107160056.322141-1-andre.przywara@arm.com>
References: <20220107160056.322141-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2022 16:00:54 +0000, Andre Przywara wrote:
> clarify the wording of the ARM64 boot protocol requirements, to both
> cater for the introduction of secure EL2 in Armv8.4, but also for the
> addition of the Armv8-R64 architecture branch.
> There is an ARM ARM supplement for v8-R64[1], and also a free model[2].
> 
> On top of those clarifications, there are at least two other issues to
> consider for v8-R64 on Linux, I wonder if those should be documented
> somewhere, although I doubt that booting.rst is the right place:
> - Linux clears the NS/NSTable bit in the PTEs. In non-secure world those
>   bits are ignored, but when in secure world this means "secure PA".
>   That luckily matches the design here (secure-only), but we should avoid
>   re-purposing those bits in the future (which would be technically
>   possible when running only non-secure).
> - The GIC needs to be implemented using a "single Security state" for
>   the Linux GIC driver to work. The model mentioned above defaults to
>   a security aware GIC, so needs to be told off using the command line.
>   I wonder if this is should be explicitly mentioned somewhere, to avoid
>   disappointment by implementors later.
> 
> [...]

Applied first patch to arm64 (for-next/docs), thanks!

[1/2] arm64: booting.rst: Clarify on requiring non-secure EL2
      https://git.kernel.org/arm64/c/b8ac4ee08d48

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
