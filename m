Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DD152EF24
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350751AbiETPZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350813AbiETPZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:25:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC92DBA
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:25:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E722B82A57
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 15:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D160C385A9;
        Fri, 20 May 2022 15:25:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aVJvMvr/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653060346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NjzNlNtTF4OIZyOLWpbWo4vMXnxo79Fzre1zqdt4gcY=;
        b=aVJvMvr/IQWbqD92A37qL/p4Q7FDDNWBLU1icDrJqgDSXW1irD/1FV9oNIhvNMnb8MOooO
        X7pIwVdcviLr8r8luFUwftnft8XGp9LngVnooo3fOWSy6PrHUjj14PsssMHcViCBgaPqKb
        +aWrxtEwBwYScy9q0tDXL2TYU44UQkA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e023bd88 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 20 May 2022 15:25:46 +0000 (UTC)
Date:   Fri, 20 May 2022 17:25:44 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jens Axboe <axboe@kernel.dk>, Theodore Ts'o <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 0/3] random: convert to using iters, for Al Viro
Message-ID: <Yoey+FOYO69lS5qP@zx2c4.com>
References: <20220520094459.116240-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220520094459.116240-1-Jason@zx2c4.com>
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

On Fri, May 20, 2022 at 11:44:56AM +0200, Jason A. Donenfeld wrote:
> Jens Axboe (3):
>   random: convert to using fops->read_iter()
>   random: convert to using fops->write_iter()
>   random: wire up fops->splice_{read,write}_iter()

FYI, this series makes reads from /dev/urandom slower, from around 616
MiB/s to 598 MiB/s on my system. That seems rather unfortunate.

Are we sure we really want to do this and need to do this?

Jason
