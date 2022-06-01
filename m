Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA3953AC70
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 20:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356574AbiFASES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 14:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiFASEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 14:04:16 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F3999CF46;
        Wed,  1 Jun 2022 11:04:12 -0700 (PDT)
Received: from kbox (unknown [98.59.227.103])
        by linux.microsoft.com (Postfix) with ESMTPSA id 792F920BE535;
        Wed,  1 Jun 2022 11:04:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 792F920BE535
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1654106651;
        bh=7YDscbLJJjb4AG9U2pBMuOAPQUmbrOZVxwiZ2mIBZz4=;
        h=Date:From:To:Cc:Subject:From;
        b=MY2jATZLODR0l1zwT86H8jY188WQIsc05zFDAbSem7+kWOfG1BHJaMZ1uo4FJSCEK
         s81wl3TXMnzcHoU2HmD/kadwMml1gCTSJob6nTo+TCwdd5p7YmhzKIs/rFf6WGHU7D
         FRs+CAEVOyHKImzyFtlPlkU09ghMftFgD21k+ibU=
Date:   Wed, 1 Jun 2022 11:04:04 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     namhyung@kernel.org, jolsa@kernel.org, acme@kernel.org,
        peterz@infradead.org, mingo@kernel.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Perf MMAP records differ from /proc/[X]/maps when chroot is used
Message-ID: <20220601180404.GA2029@kbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed a related conversation that occurred in the past here:
https://lore.kernel.org/lkml/20220202070828.143303-1-namhyung@kernel.org/

I hit this same issue, however, during debugging I noticed that when
chroot is used the full path including the chroot are in /proc/[X]/maps.
The perf MMAP records only give the relative path within the chroot.

This causes different views of a process when combining mmaps that existed
before perf_event_open() via /proc/[X]/maps and observed mmaps within the
perf_event_open() ring buffer.

I would like to know if this is how mmap records are wanted to be represented
long term via perf? It would be great if these mmap records aligned with how
/proc/[X]/maps are represented so chroot usage becomes (mostly) seamless.

Thanks,
-Beau
