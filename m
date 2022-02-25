Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385184C51E4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 00:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239185AbiBYXBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 18:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236702AbiBYXBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 18:01:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D795421DF31
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 15:00:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7301961CCA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 23:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460EAC340E7;
        Fri, 25 Feb 2022 23:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645830038;
        bh=u/Cfc6nA/AuYeqwihPJqtVG9625r5X8t5oWUtwBNIpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O/QYnVXTrRKrECDWepkxzwsz6bBq6tBI7zT54e52938MZ9xyC3OLUal7eY55kTem1
         eLsaugpGNVvPvtfgDOJME+STNObFUmJTULm0Agkj/RKB9xU1x5SW56ioSK+qdMdug7
         T049RwqD1+eh1w019ZCmFnd/vzZ4CYTvTLrwlW+4bfX5RhZdUhsq9aP4SpTvs6To83
         4WHkL/Bo4XrekA2fmStkFEAWUE4X8f9x6VjiOGrblezcNhG7+a8Hpx4u/H8E6hh8iU
         MAdo0FLzJtS0UwdrbS2OWJQ1z2GM7jfdxVRIzkSDKlL8H9FjrB4brVjbDDAgref4se
         PZcAUzUGVtVBA==
Date:   Fri, 25 Feb 2022 16:00:34 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 00/71] Introducing the Maple Tree
Message-ID: <Yhlfkk/gTz6a/hOD@archlinux-ax161>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <YhhRrBpXTFolUAKi@qian>
 <20220225190846.u4fwebimd5ejfdpd@revolver>
 <20220225202334.bsw5t3retcchpn2e@revolver>
 <YhlAPOquxUICyGsR@qian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhlAPOquxUICyGsR@qian>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 03:46:52PM -0500, Qian Cai wrote:
> On Fri, Feb 25, 2022 at 08:23:41PM +0000, Liam Howlett wrote:
> > I just booted an arm64 VM with my build and kasan enabled with no issue.
> > Could you please send me your config file for the build?
> 
> On linux-next, I just do:
> 
> $ make arch=arm64 defconfig debug.config [1]
> 
> Then, I just generate some memory pressume into swapping/OOM Killer to
> trigger it.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/kernel/configs/debug.config

Is the stacktrace [1] related to the conflict that Mark encountered [2]
while merging the maple and folio trees? Booting a next-20220223 kernel
on my Raspberry Pi 3 and 4 shows constant NULL pointer dereferences
(just ARCH=arm and ARCH=arm64 defconfigs) and reverting the folio and
maple tree merges makes everything work properly again.

[1]: https://lore.kernel.org/r/YhhRrBpXTFolUAKi@qian/
[2]: https://lore.kernel.org/r/20220224011653.1380557-1-broonie@kernel.org/

Cheers,
Nathan
