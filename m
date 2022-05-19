Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21D752E069
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343489AbiESXPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245021AbiESXPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:15:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CDAF688A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:15:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27535B828B0
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFE8C385B8;
        Thu, 19 May 2022 23:15:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="i9mulbtY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653002112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KFjklCGzQpFE2uhZRKArW2d8XdveAx9kF2S3Fc1MUaE=;
        b=i9mulbtYetLsqmmDHPGf452gUsnb7jkbrx7p1R7Vc36GBg/R1EDYTSiH2QVl1O5Uz1C0fN
        Xw3W7B3/icGzX8h1h/Nyr/zwpP0M1aOmKNouf/CN2mMhQV+PrXxj1/ul9WhPzDc5N61AFE
        At0AkwnRmfs5ezKowQ0fhuca5cn1Va0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fa531706 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 19 May 2022 23:15:12 +0000 (UTC)
Date:   Fri, 20 May 2022 01:15:10 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     tytso@mit.edu, hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET 0/2] Fix splice from random/urandom
Message-ID: <YobPfgkzGrNPDDFI@zx2c4.com>
References: <20220519193133.194138-1-axboe@kernel.dk>
 <YoajCafKmgUbbaY0@zx2c4.com>
 <a6c843ff-a3d7-ce6a-4e99-70968834a02a@kernel.dk>
 <8e6c98d4-03e9-3eb5-3d4e-b9a9faeb677a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e6c98d4-03e9-3eb5-3d4e-b9a9faeb677a@kernel.dk>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Thu, May 19, 2022 at 03:02:28PM -0600, Jens Axboe wrote:
> Rebased patches attached, you can also find them here:
> 
> https://git.kernel.dk/cgit/linux-block/log/?h=random-splice
> 
> Did some basic sanity checking (and with splice too), and seems fine
> rebased as well.

Thanks. I left one comment about patch 1 in that subthread. The general
idea of this patchset seems fine, but: what about write_iter? Can't we
convert both of them? 1/3 - read_iter, 2/3 - write_iter, 3/3 - add the
generic splice helpers. I ask because it seems weird to keep around the
old thing (which sounds like is being gradually removed?) alongside the
new thing.

Jason
