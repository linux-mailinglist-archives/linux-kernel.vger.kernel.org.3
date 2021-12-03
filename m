Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D394677DC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352029AbhLCNON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244454AbhLCNOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:14:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBD8C06173E;
        Fri,  3 Dec 2021 05:10:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7225862A6C;
        Fri,  3 Dec 2021 13:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1636C53FAD;
        Fri,  3 Dec 2021 13:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638537046;
        bh=2Sim5sCOA4Vjpren5n6lSsplxT5g17QdmKazX6LcTX0=;
        h=Date:From:To:Cc:Subject:From;
        b=qlR167VUksb8O1JjqzrF5em7YCvj5iUoH5pPLebNNBitTog/d04FwcSSUKlw806ep
         tBSq9Fw4gKX/piksOpvRUbijX3ordVFwCQdrViaxzJnP0NKKOqSVxB+q7lAr7dsQKn
         8EBT4q+8bB4DlvCEUfn8+EBjkwRUWuWWCwNuKRaBA7NchE7KViTCZXE940oJPBP0re
         j03kjCnHjMSBX3TFYyGchB3wQF5eRQl0VmM2RKH33Y+/inmbRJ5FZdsv7RkoTIMxrC
         RTyY65d8n/m9GNLVWRFOHxcc9NTlwn8tyX7J7CPeq4ysLixiu6VLPvCISKSUy/Pmt3
         w2yDA6Y7YRg9A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BD01F40002; Fri,  3 Dec 2021 10:10:42 -0300 (-03)
Date:   Fri, 3 Dec 2021 10:10:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Building perf with BUILD_BPF_SKEL=1 by default
Message-ID: <YaoXUrLUZt1scVb0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,

	So I'm changing all my containers to build with BUILD_BPF_SKEL=1
to then make this the default, so far older containers fail either
because the clang available is too old, so I've added a NO_BUILD_BPF_SKEL=1
env var to disable that in those containers and then there is this other
case where clang is recent enough but:

    util/bpf_skel/bperf_leader.bpf.c:13:20: error: use of undeclared identifier 'BPF_F_PRESERVE_ELEMS'
            __uint(map_flags, BPF_F_PRESERVE_ELEMS);

Because the system's /usr/include/linux/bpf.h doesn't have that
BPF_F_PRESERVE_ELEMS enum entry.

These are enums to make them available via BTF, but then I can't use
the:

#ifdef BPF_F_PRESERVE_ELEMS
#define BPF_F_PRESERVE_ELEMS (1U << 11)
#endif

approach.

But then we _have_ it in the tools/include/uapi/linux/bpf.h we ship:

$ grep BPF_F_PRESERVE_ELEMS tools/include/uapi/linux/bpf.h
	BPF_F_PRESERVE_ELEMS	= (1U << 11),
$

so we need to switch to using it somehow, this way we can build in more
systems and make bperf and other BPF enabled features.

From a quick look I couldn't find where to add
$(sourcedir)/tools/include/uapi/ to the include path used to build
util/bpf_skel/bperf_leader.bpf.c, should be easy, can you take a look?

Thanks,

- Arnaldo
