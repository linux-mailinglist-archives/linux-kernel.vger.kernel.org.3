Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DDE5387DA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 21:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240931AbiE3TrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 15:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbiE3TrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 15:47:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8A94E39F
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 12:47:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B83160EEC
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 19:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2B5C385B8;
        Mon, 30 May 2022 19:47:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RS52kRgc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653940025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xZhnvCDGgxzqFMhVDr671E9TD2r/XSWLN9a/mjjS6F8=;
        b=RS52kRgccY95o127d3Vabw9vzXJ6O4lS4qQ/b0gWYCAjJJTY3obSimCF+DaPbWe9evP7zP
        kR9MRa2DOKourzZdu8BFJpqciqyjjNbK03FpUimRbQ2ow0fcaVnSJA/WyAMRxHxS0862f8
        wyJ/XOo6BYDlu5O0Cis8AiWwNfZhzIg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id def7c7d5 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 30 May 2022 19:47:05 +0000 (UTC)
Date:   Mon, 30 May 2022 21:47:01 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 5.18.1 has thousands of similar lines in dmesg with
 CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
Message-ID: <YpUfNc9XcdA5KqJ4@zx2c4.com>
References: <83b4b916-1334-e3b0-cb1e-6cd12ae0ddff@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83b4b916-1334-e3b0-cb1e-6cd12ae0ddff@gmx.de>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Toralf,

On Mon, May 30, 2022 at 11:24:55AM +0200, Toralf Förster wrote:
> This deletes the early boot messages in dmesg:
> 
> /var/log # head dmesg
> [    3.114274] random: get_random_u32 called from
> allocate_slab+0x144/0x480 with crng_init=0
> [    3.114286] random: get_random_u32 called from
> allocate_slab+0x144/0x480 with crng_init=0
> [    3.114291] random: get_random_u32 called from
> allocate_slab+0x144/0x480 with crng_init=0
> [    3.114297] random: get_random_u32 called from
> allocate_slab+0x144/0x480 with crng_init=0
> [    3.114304] random: get_random_u32 called from
> allocate_slab+0x144/0x480 with crng_init=0
> [    3.114315] random: get_random_u32 called from
> allocate_slab+0x144/0x480 with crng_init=0
> [    3.114323] random: get_random_u32 called from
> allocate_slab+0x144/0x480 with crng_init=0
> [    3.114329] random: get_random_u32 called from
> allocate_slab+0x144/0x480 with crng_init=0
> [    3.114333] random: get_random_u32 called from
> allocate_slab+0x144/0x480 with crng_init=0
> [    3.114345] random: get_random_u32 called from
> allocate_slab+0x144/0x480 with crng_init=0

This was simplified here:

    https://lore.kernel.org/lkml/20220509172426.612649-1-Jason@zx2c4.com/
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cc1e127bfa95b5fb2f9307e7168bf8b2b45b4c5e

I'm happy to consider other heuristics than the one there if you find
this one problematic. But I think as a debug option, the current
behavior encapsulates well what somebody might want to know when
debugging a kernel. Either way, please let me know if this poses a
problem for you.

Jason
