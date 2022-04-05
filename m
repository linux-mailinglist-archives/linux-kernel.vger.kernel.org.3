Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1053C4F51B1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450182AbiDFCJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358249AbiDEK2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:28:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72529BF56;
        Tue,  5 Apr 2022 03:17:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E92E6176C;
        Tue,  5 Apr 2022 10:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DA2C385A1;
        Tue,  5 Apr 2022 10:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649153847;
        bh=l99Mt8In48+c+7JJh4arIQJ0SwmWXax74CpxbShDX/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RlH/vpipHZuvw+rMgqeeu05IBGuOMd5eaPdQ4xAFjxV6tETsoZO9nKBd/pTBR13p1
         AlFOgiKk2nRF/Pp1yrcbvfAyysVUGp9+OwFBR6aYx5AU+JEj4l6ORwexaCSt0Xizv4
         y/pDCqn2BfaCPUShwU8HfMNWyBN478jQFP59qwfs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xu Kuohai <xukuohai@huawei.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 330/599] libbpf: Skip forward declaration when counting duplicated type names
Date:   Tue,  5 Apr 2022 09:30:24 +0200
Message-Id: <20220405070308.653121909@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070258.802373272@linuxfoundation.org>
References: <20220405070258.802373272@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Kuohai <xukuohai@huawei.com>

[ Upstream commit 4226961b0019b2e1612029e8950a9e911affc995 ]

Currently if a declaration appears in the BTF before the definition, the
definition is dumped as a conflicting name, e.g.:

    $ bpftool btf dump file vmlinux format raw | grep "'unix_sock'"
    [81287] FWD 'unix_sock' fwd_kind=struct
    [89336] STRUCT 'unix_sock' size=1024 vlen=14

    $ bpftool btf dump file vmlinux format c | grep "struct unix_sock"
    struct unix_sock;
    struct unix_sock___2 {	<--- conflict, the "___2" is unexpected
		    struct unix_sock___2 *unix_sk;

This causes a compilation error if the dump output is used as a header file.

Fix it by skipping declaration when counting duplicated type names.

Fixes: 351131b51c7a ("libbpf: add btf_dump API for BTF-to-C conversion")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Song Liu <songliubraving@fb.com>
Link: https://lore.kernel.org/bpf/20220301053250.1464204-2-xukuohai@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/btf_dump.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 0911aea4cdbe..bd22853be4a6 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1416,6 +1416,11 @@ static const char *btf_dump_resolve_name(struct btf_dump *d, __u32 id,
 	if (s->name_resolved)
 		return *cached_name ? *cached_name : orig_name;
 
+	if (btf_is_fwd(t) || (btf_is_enum(t) && btf_vlen(t) == 0)) {
+		s->name_resolved = 1;
+		return orig_name;
+	}
+
 	dup_cnt = btf_dump_name_dups(d, name_map, orig_name);
 	if (dup_cnt > 1) {
 		const size_t max_len = 256;
-- 
2.34.1



