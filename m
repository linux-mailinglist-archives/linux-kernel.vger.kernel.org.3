Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB785582869
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 16:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbiG0OR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 10:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiG0OR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:17:56 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A5F1C7;
        Wed, 27 Jul 2022 07:17:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LtG8K5HCJz4x1S;
        Thu, 28 Jul 2022 00:17:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1658931474;
        bh=CaKrmtzmG9/mg5pMzEBvMG4pyIoB46Lu2PBaD5VgPug=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DmQsY0F2PCPeShZnJT1q9UL75KnpBuupYRK73qycnLQEyIbh5njJPLVvsSV1bj3FV
         T308NAznyCjDCg8rXOOdBWghFvwU91SeXYbf9ZzLqsl04SB9HTMN4O+ogFyQQpDEWS
         +r/uLet7X+5jS9J66pOWl9qcRmRRs25cG2MMXTsfQDT6v/1595AypLbMoSkSEHsveV
         UZbyMy+3fcOhX34hXJK79E7D6UjFFEvrOet6ujFs5CBLjepXL2i40NDm8wPxT5wLbZ
         2kXZhfif6TluQSdb7r7lsg5WIRvCdElZd4vptLURTo0jm9mItg3CuEpb3l0flNDy1a
         2REQTrmW6ltcA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alex Deucher <alexdeucher@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the amdgpu and
 powerpc-fixes trees
In-Reply-To: <20220726205458.0b5ca446@canb.auug.org.au>
References: <20220726205458.0b5ca446@canb.auug.org.au>
Date:   Thu, 28 Jul 2022 00:17:49 +1000
Message-ID: <87leseabci.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> Hi all,
>
> After merging the amdgpu tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
>
> ld: drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.o uses hard float, drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.o uses soft float
> ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.o
>
> I have reverted commit
>
>   c653c591789b ("drm/amdgpu: Re-enable DCN for 64-bit powerpc")
>
> for today.

It bisects to:

  40b31e5355ba ("drm/amd/display: Remove FPU flags from DCN30 Makefile")

So I guess there's still some float code in dcn30?

cheers
