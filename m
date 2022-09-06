Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8798B5AE189
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbiIFHrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239021AbiIFHqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:46:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5384E74CE0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 00:46:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAC6361155
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFACC433C1;
        Tue,  6 Sep 2022 07:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662450395;
        bh=L1N7WtoHUPgAdoMCUsE4RYeHoy6kXFKLrw1Sb9QARtQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FbmWYdNHmnme3dfvJ/DeZaDIs1xu3SBifDzSwwbz6IF8phNHOQdJG5zR4LAKXWoQn
         QaqoDVyAPmEX5LGLDOoq+CZFmi3PZYPVsNXBJ37uuHm3oCLhzqlN8/EKl0vS0TKJwt
         4Mzq0F2JL50fKWabJwPCa5EkGL8lEHE9zN4t7Jz9/BUssgmuaTWGYwmgX8xF4iCZVU
         zlWhAicyCM/kCAFYKmVFrEzXwK4cXH4nSEt78xjxqsZWlzNQvRnMN+m8aZqeIlY43j
         BBaN6NwzcFTg+U088wfS0NMc2JkFg4gN5ZsExTAcV8/WgQ59Hf3G+PafI7MLWRfO8V
         +LTEhbknRxEtw==
Date:   Tue, 6 Sep 2022 09:46:31 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Oleksandr Tymoshenko <ovt@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] seccomp: fix refcounter leak if fork/clone is terminated
Message-ID: <20220906074631.52jgqa7qz3sjmdie@wittgenstein>
References: <20220902034135.2853973-1-ovt@google.com>
 <20220905083914.msdgd575tblq4syj@wittgenstein>
 <CACGj0CgTVVAhBrL7DsP_fL7R9EhZUwu+MkQ1_GpPEtHQW4ojOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACGj0CgTVVAhBrL7DsP_fL7R9EhZUwu+MkQ1_GpPEtHQW4ojOQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 03:53:54PM -0700, Oleksandr Tymoshenko wrote:
> Hi Christian,
> 
> The patch in the seccomp tree, adapted to 5.10 branch, fixed the
> memory leak in my reproducer.
> Thanks for working on this, I should have checked the seccomp tree first :)
> Please disregard the patch in my submission.

Oh, it wasn't my patch it was someone else's. :) I just acked it! Thanks
for working on this we need things like these spotted and fixed!
