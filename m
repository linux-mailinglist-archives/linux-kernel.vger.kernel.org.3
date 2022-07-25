Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECD357F876
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 05:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbiGYD2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 23:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiGYD2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 23:28:03 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9262FE
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 20:28:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LrlqJ4JqJz4x2c;
        Mon, 25 Jul 2022 13:27:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1658719679;
        bh=A3dlRpormEhO28f6h4590b/Lcp+iomzysnEq+1J3zUI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Qli62PWlLtfkcruNXsG+1tXJVDfSdJ9RoE7TOymCZkkfXrOZ88+xe9q4ltmmke0Bx
         MNoJueQXngwN2gBbxS8Jplqn6WjAn2MMFDWRZvGvdVhTgJeB6G7rHk9KGvlPdFlr+/
         VzJ12EHGgqwXUnmJrXCrTjJUArBz8C8OtU7Lm8IbIchR7cuAnZSFZ/WmAyZLkNoguB
         Qn1HyOWZYQu3PoPolFSVERizYUX7wao9m9UM1/nT590VRpTaI0G2bK5Y4LeYoLS+C/
         MrarpZE3UUxmLOZaHSCMrFsoQRjTi0vokj0qGMbMLsL4wFKSGPzNrP7rv50EzKMznt
         AWlbGlh1tJf4Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Michal =?utf-8?Q?Such?= =?utf-8?Q?=C3=A1nek?= 
        <msuchanek@suse.de>
Cc:     lkp@intel.com, linux-kernel@vger.kernel.org, npiggin@gmail.com,
        Julia.Lawall@inria.fr, paulus@samba.org,
        Jason Wang <wangborong@cdjrlc.com>,
        linuxppc-dev@lists.ozlabs.org, hbathini@linux.ibm.com,
        joel@jms.id.au
Subject: Re: [PATCH] powerpc: Remove the static variable initialisations to 0
In-Reply-To: <20220723192211.GP25951@gate.crashing.org>
References: <20220723092436.7149-1-wangborong@cdjrlc.com>
 <20220723133405.GF17705@kitsune.suse.cz>
 <20220723192211.GP25951@gate.crashing.org>
Date:   Mon, 25 Jul 2022 13:27:52 +1000
Message-ID: <87fsipdg7b.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Sat, Jul 23, 2022 at 03:34:05PM +0200, Michal Such=C3=A1nek wrote:
>> Hello,
>>=20
>> On Sat, Jul 23, 2022 at 05:24:36PM +0800, Jason Wang wrote:
>> > Initialise global and static variable to 0 is always unnecessary.
>> > Remove the unnecessary initialisations.
>>=20
>> Isn't this change also unnecessary?
>>=20
>> Initializing to 0 does not affect correctness, or even any kind of
>> semantics in any way.
>
> It did make a difference when the kernel was still compiled with
> -fcommon (which used to be the GCC default on most configurations, it is
> traditional on Unix).  No explicit initialiser puts an object in .bss if
> you use -fcommon.  This matters a bit for data layout.

The kernel has built with -fno-common since ~2002.

I think the belief is that an explicit initialiser of 0 forces the
variable into .data, but AFAICS that is not true with any compiler we
support.

cheers
