Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEF15A44FA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiH2IYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiH2IYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:24:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D858E550A7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:24:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F56A60E55
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5A7C433D6;
        Mon, 29 Aug 2022 08:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661761442;
        bh=xS+xHKp43eJ8JYjFC7VI8wrHD5W9fUJOHs3BwfjYs3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OrAmrIWvV+DVdnADMcl7DZCfVEGWOqsPdJlgwo17uOSljVw3LQDw3aQnyfquQLhrL
         q+5jRhjzWKsj1rjEh1HwACmrTiLxzAAfH7FHM9OBHt/K4D7mCVTAJHxTeSj1vhO0Au
         zv+UePiMENViAS7Xt6itohgyCPU3rT1uVwxOdpkkzzdeU8W2MlSzAHIbSNNevkHDeW
         6Su4R8a+BD3ilfkUW8cHlmuQxSROcmAn7o5kjtr/KQCZVa6cXse+R0LZ2YUpqJ/JHh
         TiMfR9upny50bCg00b0aT5gx3ngNzX5KlQ0KLOAUtI3SZyzloqF79crxIsa1UHQgp6
         i6ywDZryU1SLA==
Date:   Mon, 29 Aug 2022 11:23:47 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Song Chen <chensong_2000@189.cn>
Cc:     karolinadrobnik@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] tools/libs/slab.c: fix compiling mistakes of
 uatomic_inc/uatomic_dec
Message-ID: <Ywx3k6orcutPs7Lf@kernel.org>
References: <1661755121-3286-1-git-send-email-chensong_2000@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1661755121-3286-1-git-send-email-chensong_2000@189.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 02:38:41PM +0800, Song Chen wrote:
> I tried to build tools/test/memblock and got such message:
> 
> /usr/bin/ld: slab.o: in function `kmalloc':
> slab.c:(.text+0x2b): undefined reference to `uatomic_inc'
> /usr/bin/ld: slab.o: in function `kfree':
> slab.c:(.text+0x97): undefined reference to `uatomic_dec'
> collect2: error: ld returned 1 exit status
> 
> I could find any definition or inplememtation of uatomic_inc/uatomic_dec
> in anywhere of the code base. So I use atomic_inc/atomic_dec_and_test
> to replace like other tests underneath tools/test, it works.

They are defined in liburcu headers, in Debian they are found in
liburcu-dev package.
 
> Signed-off-by: Song Chen <chensong_2000@189.cn>
> ---

-- 
Sincerely yours,
Mike.
