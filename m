Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3564BD344
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 02:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245511AbiBUBwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 20:52:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbiBUBwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 20:52:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC37AE2A
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 17:52:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66CD260E9B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FACC340E8;
        Mon, 21 Feb 2022 01:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645408336;
        bh=4lfUSZ8GkQGgALesFEPJ8MtxwuF+eM/2/gYQ99xIzw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lo8m5g0icBpkrOSuhEwn1AF9oUN2RY0Ngdg+nuwo3VZbVxZEbmpy7LBD70QPDHS7Y
         ABS63Mbzgn4IHK9ceQnuu3s7kqhtGOzLo732IUvmJGmy0YF+jvYf7Fa55pCYh93L4B
         2w4q4r2wnplsP/P+1nlBcrsaAKch50KSB/kKKzqKu8LegUM7YZVV1TCZSmMyqmou3S
         AZzTCvgnOMv3YoZ42kE80GG/ZUTxAWaTUzNm6QkjYzJdQF4r+SMo22O9w8RER80xIY
         yVkOmbpuqOrx6FfrsoBwF1huUi/wQMoVpF21YqstGOvUYKdk0ycYAMhnb/r+e1xLEY
         YuEj4Ijxr5odQ==
Date:   Mon, 21 Feb 2022 02:52:56 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Subject: Re: [PATCH v4 08/10] KEYS: trusted: tee: use
 tee_shm_register_kernel_buf()
Message-ID: <YhLweBhnmITyErqG@kernel.org>
References: <20220204093359.359059-1-jens.wiklander@linaro.org>
 <20220204093359.359059-9-jens.wiklander@linaro.org>
 <CAHUa44HkQtstCyUt_J962rzysFnOJOP+e3T2gL7nV+6V5hfa9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHUa44HkQtstCyUt_J962rzysFnOJOP+e3T2gL7nV+6V5hfa9A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 03:08:48PM +0100, Jens Wiklander wrote:
> Hi Jarkko,
> 
> On Fri, Feb 4, 2022 at 10:34 AM Jens Wiklander
> <jens.wiklander@linaro.org> wrote:
> >
> > Uses the new simplified tee_shm_register_kernel_buf() function instead
> > of the old tee_shm_alloc() function which required specific
> > TEE_SHM-flags
> >
> > Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  security/keys/trusted-keys/trusted_tee.c | 23 +++++++++--------------
> >  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> Since this patch depends on other patches in this patch set and vice
> versa is it OK if I take this patch via my tree? I'm aiming for v5.18
> with this.

Yes.

You can also add:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
