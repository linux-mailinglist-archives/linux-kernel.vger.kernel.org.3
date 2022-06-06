Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA7D53F20C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 00:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbiFFWTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 18:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbiFFWTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 18:19:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352B86D3A0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 15:19:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 917A5CE1BFB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 22:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A48C385A9;
        Mon,  6 Jun 2022 22:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654553946;
        bh=crUd87HuMbJ9Tw6peVIY2DahR8lA6uffjWd8JyRCXWg=;
        h=Date:From:To:Cc:Subject:From;
        b=TvWtjLCbg354pb4ks1cAkks29KIIr/UwdCRDw4tmuLRkfadXeaY38VBmY8iIEBeJo
         RdAyWDDxblKUwYESa1ikgxRVbJh4i7mwxhJpTlSEGia9n9aLvMH8Ijo83PIV/8rg54
         KvyVC4dnEi4yoaYeLOIzvLTiAqyhrnMwv2Wge1+qvcbJoM7NJlIEjDOo9ZkdoBtWMT
         0F0mp+pWo02VFvTFEOv13o3H3rhlNF+yDObMulnwWtTdXt1sZZHkqdiNbt3DA3r+1z
         LrvFAaR7qHFbIG9UtO1VaJBYklCz1rDUvDADy9gIVQY2/2kSWk18q/t6piEUxFdp9M
         6H7aOlXo2wXNg==
Date:   Mon, 6 Jun 2022 15:19:04 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzkaller@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Auto-invalidating old syzbot reports?
Message-ID: <Yp59WCODvEDbpxOY@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the upstream Linux kernel has 888 open syzbot reports
(https://syzkaller.appspot.com/upstream).  However, nearly two-thirds of them
(577) were reported more than 1 year ago.  Old reports are often for bugs that
were already fixed.  They can also be reports that got overlooked, forgotten
about, not sent to the right place, etc.  Kernel maintainers also change over
time, so the current maintainer(s) might never have received the original report
even if syzbot sent the original report to the correct maintainer(s).

Having these old reports open is preventing syzbot from re-reporting any bugs
with the same crash signature (where a crash signature is something like
"KASAN: null-ptr-deref Read in percpu_ref_exit") if it is still being seen.

syzbot does auto-invalidate some old bugs, but only ones without a reproducer.

Given that humans aren't keeping up with these reports, has it been considered
to auto-invalidate all old syzbot reports -- not just ones without a reproducer?

- Eric
