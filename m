Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10A25AB5C2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbiIBPxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbiIBPxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:53:22 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485E232EE8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:46:30 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b44so3205398edf.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 08:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=ajoXh4q3PNvCbvJn5Mn8VzhtUwG+56ZVXC4P9Vh7Iio=;
        b=AcFYMnesQZY/pzw/djkTkqEyJAkyM2UZNOGDWb08JKBl77YnKSn4v+kXmuSuHe0+Pv
         X1iBwDBY2EW3PRqyif6AwJL1z3GB8P+AFj0G9FZq4b3po+Rtnbk5iBTwHHPABDfP3VlJ
         KmragM/2oL1dN3/W7VPp0R1NqfwhKVt0vp1QE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=ajoXh4q3PNvCbvJn5Mn8VzhtUwG+56ZVXC4P9Vh7Iio=;
        b=wFtbKlEBpTV3hGr9CkC+QBMUHe6/hCh0fsqyPJLI9Lh/2JZ8IoaTMwcp5mkA3UK1tq
         vwmOn2HRdytkuV0FFTCxCBW6+E79t6V6Ag4TYcWrkvIluSWad4kDrtyhWz7k5HlQVUx+
         2aAkxBiLYbcYSpNkRAdLJgr8Pmw/T+1qXy+uaEC/iC9DSJQe3kj/i/8S0I+I0XsRfXDo
         7DRlT4OOKCW7i/N6gbfWW2b27Tc/pWAJ0Cf9XsnmmJMnKCDbY0IodAo8JK4H6HezBOhM
         oYk6A2jE4S+BuqflpBilLrpCqTFsPd5wX4BROKfFigGhlfkoY1DUUmKG6C+GsMfg0H4C
         TVzg==
X-Gm-Message-State: ACgBeo2B/MLvhOuaJytIJYC+B/+Mk1VewrpdQaCoK52k7OeitwqA+aIA
        Sl0A1YIHPvQT90w6a0jzZTBiUm7OPPPNFdRcrp6zvQ==
X-Google-Smtp-Source: AA6agR7MBoEsTm2riDwZzZu/buGQeydSuaVH4Rx/57NDi177e/XV2qQZIVsLMw0TLGjOe9t5LMKHgJ6gxLI9H11/qZA=
X-Received: by 2002:a05:6402:268d:b0:43d:b9d0:9efc with SMTP id
 w13-20020a056402268d00b0043db9d09efcmr34194052edd.92.1662133588729; Fri, 02
 Sep 2022 08:46:28 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Dao <dqminh@cloudflare.com>
Date:   Fri, 2 Sep 2022 16:46:18 +0100
Message-ID: <CA+wXwBT_fiBrFG-=C=eWGHuJ3XzxDLe-Ba4ybOvuxvu5A1+Tig@mail.gmail.com>
Subject: perf record --kcore does not work when /proc/modules changed during copy
To:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        kernel-team <kernel-team@cloudflare.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, jolsa@redhat.com,
        adrian.hunter@intel.com, namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Perf tools maintainers,

`perf record --kcore` frequently did not work on a somewhat busy system.
For example:

  sudo perf record --kcore -- sleep 1
  ERROR: Failed to copy kcore

Using strace to look at the invocation, the failure looks like:

  ...
  openat(AT_FDCWD, "/proc/modules", O_RDONLY) = 56
  openat(AT_FDCWD, "perf.data/kcore_dir/modules", O_RDONLY) = 57
  read(56, "mpls_gso 16384 0 - Live 0xffffff"..., 4096) = 4070
  read(57, "mpls_gso 16384 0 - Live 0xffffff"..., 4070) = 4070
  read(56, "xt_conntrack 24576 22 - Live 0xf"..., 4096) = 3738
  read(57, "xt_conntrack 24576 22 - Live 0xf"..., 3738) = 3738
  close(57)                               = 0
  close(56)                               = 0
  close(55)                               = 0
  unlink("perf.data/kcore_dir/kcore")     = 0
  close(54)                               = 0
  unlink("perf.data/kcore_dir/modules")   = 0
  unlink("perf.data/kcore_dir/kallsyms")  = 0
  write(2, "ERROR: Failed to copy kcore\n", 28ERROR: Failed to copy kcore
  ...

We can see that the verification of proc/modules failed because /proc/modules
output changed after we copied kcore. When i looked at it, they are caused by
changes of module refcount which seems expected on busy systems, such as

  < tcp_bbr 40960 12644 - Live 0x0000000000000000
  ---
  > tcp_bbr 40960 12678 - Live 0x0000000000000000

Any suggestions on how to make this work is much appreciated.

Cheers,
Daniel.
