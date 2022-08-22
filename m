Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6207A59B811
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 05:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbiHVDkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 23:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbiHVDk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 23:40:28 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602F5248E5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 20:40:27 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M9ymm08WXz4wgn;
        Mon, 22 Aug 2022 13:40:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1661139625;
        bh=VKTUo2W4RNc2LDslDMcLOnHhdlFBjvbL0BUKEgnwbho=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Je1l+Xpf0IQX7/cqLqeVKhTFzln629PFhZPHnimgYEZfZglpmJOAXo6zZ3qqLhZaf
         pTCMCKJNyh1BWnCZeF0hO5SpcKNefkyzqjvwSQSbB0Q9p4wyY4mxq13vFYf00xpcbr
         xzuVuyPEnHozay6S9HX2w6LkAycpVJvPeR7oLAITkfkdIucCbL9dApvTjnXqw0Xk73
         7cI6LYa6l3ecozrENJFNG4Kt7ornODrTsmYmlmdbec7ns7F8/FpSHkUiBLALBeb+7m
         8ZXm3JZUDtz306E+p2oj6x37piBTa3oKoIdFKPIktfSUup6WZ2toUR+qoAlwz7y2Qs
         AO9ZaxnMzKH8g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, amd-gfx@lists.freedesktop.org,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: Re: [PATCH] powerpc: export cpu_smallcore_map for modules
In-Reply-To: <20220819210112.7924-1-rdunlap@infradead.org>
References: <20220819210112.7924-1-rdunlap@infradead.org>
Date:   Mon, 22 Aug 2022 13:40:23 +1000
Message-ID: <87o7wdkkt4.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:
> Fix build error when CONFIG_DRM_AMDGPU=m:
>
> ERROR: modpost: "cpu_smallcore_map" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>
> by exporting 'cpu_smallcore_map' just as other per_cpu
> symbols are exported.
>
> drivers/gpu/drm/amd/amdkfd/kfd_device.c calls cpu_smt_mask().
> This is an inline function on powerpc which references
> cpu_smallcore_map.
>
> Fixes: 425752c63b6f ("powerpc: Detect the presence of big-cores via "ibm, thread-groups"")
> Fixes: 7bc913085765 ("drm/amdkfd: Try to schedule bottom half on same core")

That 2nd commit is not in mainline, only linux-next.

I don't mind merging this fix preemptively, but is that SHA stable?

cheers
