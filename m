Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5DD4819EF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 07:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbhL3Gbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 01:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236346AbhL3Gbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 01:31:52 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDCEC061574;
        Wed, 29 Dec 2021 22:31:52 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id kj16so21274193qvb.2;
        Wed, 29 Dec 2021 22:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lPQYBcbN5m0grzdVg1oiL9bCyxWDGksMt+6y2rMrOVQ=;
        b=fUKKdW+SvFcgTg+t+p1gVhRCCigBWsqqzK8awzXbFdqNFJwSCjwcEkjBeNmfxhORJs
         X8mBDcS1eKorG/6rTbYR4lUuJpvQy4LSLr9hChre8AGj0kG67NkmStKNel+TWBy1guNS
         05QTrJVnR5Z6yi80mcTKEEWtXTvWtN8ikLMgoon4pm0DP2QxoA6d8eNLokHHxbNRfeXs
         +Q3COnUtZ/SZXyAbgRr13q5qIRCbcM/D/D2DX7lblOpSbYcH9BwuZgxYkoGUFzKUoeNh
         oXFKhXy9SLCHPoC2wyKL7cOBjF2usZs6KnLU5eH0srzwiQ9JwdnD35EQEY5aVlm349H8
         AMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lPQYBcbN5m0grzdVg1oiL9bCyxWDGksMt+6y2rMrOVQ=;
        b=o53uerW3Hrkib7Sh1CRYGklW3caw1SmAwFH0exsiZcR1N0SXPnSbbxoPZ9stf3T8Gg
         MvvuMDKrPEODp2gggZ93ctknMFPjhqS8Wuhi+x6nVxoajtRv0mJNh911iZNWizVx45Bf
         iRYzM/ypEwjk5D10OXCBAn0WbM90ACJ7QpUXatiT3M+c5npS55nuT9Ch9IrFF0eblCVE
         Ir55k9VA56pQieS6o5gas4C1Uonpt8W/ZmUmubma8blp0DvuB1w1v9jGO9A2RUSnm+tZ
         KFm/sMjPN59MOLnOdUo0ezRaLwTy9gfKfEEcKALR/AQXZpz4t/wYB9k6M+1tvN3BWBku
         J0Xw==
X-Gm-Message-State: AOAM531K3k+wtC4XotgJmXD12zZwBck1s+eIoYVinOENmznDVXp8bj21
        1EeKlUVeqpJlQijazckSu+k=
X-Google-Smtp-Source: ABdhPJwFqLtITatUVGsBEEcp901TqmqMJs5VuDtvlIC4vts00CijsRRysOExL9A+EFqIu+CHb9/zRA==
X-Received: by 2002:a05:6214:2a88:: with SMTP id jr8mr26433604qvb.125.1640845911261;
        Wed, 29 Dec 2021 22:31:51 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id bi9sm18858219qkb.60.2021.12.29.22.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 22:31:50 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: luo.penghao@zte.com.cn
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux] netfilter: Remove unnecessary ret assignment
Date:   Thu, 30 Dec 2021 06:31:43 +0000
Message-Id: <20211230063143.586220-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: luo penghao <luo.penghao@zte.com.cn>

Regardless of whether the subsequent (copy_to_user(user, &info, *len) != 0)
holds, the value of ret will be assigned a new value.

The clang_analyzer complains as follows:

net/ipv6/netfilter/ip6_tables.c:

Value stored to 'ret' is never read

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 net/ipv6/netfilter/ip6_tables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_tables.c
index a579ea1..92b90a2 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -986,7 +986,7 @@ static int get_info(struct net *net, void __user *user, const int *len)
 		struct xt_table_info tmp;
 
 		if (in_compat_syscall()) {
-			ret = compat_table_info(private, &tmp);
+			compat_table_info(private, &tmp);
 			xt_compat_flush_offsets(AF_INET6);
 			private = &tmp;
 		}
-- 
2.15.2


