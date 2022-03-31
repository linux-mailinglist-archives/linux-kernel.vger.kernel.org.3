Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FE84EDDD5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 17:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239353AbiCaPt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 11:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239893AbiCaPsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:48:32 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA233A9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 08:46:44 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id kl29so20033839qvb.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 08:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mdaverde-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ONl/rjPY44Su63M5PgvxVFFtmWipaKmt8kt7MQsENI=;
        b=mGrwJh3X216JDDAJexHUgbVihbd1M5jxhlvHDrMYkBCOtxLkgPJeLCO5zpWEz8aCPO
         XNmTn/D89/CuONk1ktJRG3sanpLHfp550pJGgbwx+TZIj1A2TsfPVT3FQtFKUsOzJnF2
         QVPHkQshtQdcss9A14aF7LNRAK88E+d1GnDhVAmLTsN4dQzL5y2WN92iKWPy141bwRCr
         K6+dC2e18C7JXVr6lcHLAmfevotBXZbzHTvJoeAFu0prlJ74+WaGdMgntZIIKb0GRBhb
         uaFJ1HTKlnkMLbg7tIODHKj8sUGo5USENlketHsqgOlLejvzbGUOYSLcu6DDQqpBgeW/
         +ikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ONl/rjPY44Su63M5PgvxVFFtmWipaKmt8kt7MQsENI=;
        b=voqwEkQ9lgpKEPTLlp0rYIZmB8zpreMcM7df9EqlCCTspNR+0RRE0gE+qRLMxVZevC
         aQPmZTSxCD48RBbTtTSWu0fCxR1Xbsvz70MK5fcNubOEXyPoysLvF89XOYz7jMAcBmJ8
         bi4FrqGs4Qr+W7Itgy52BUyNnWuCryF9znlNWj+DhooB5syb0c6W9vja4SzRKt2WI5xb
         f1zEqJvOkefj//lmjCvuqkzzFL6ShCsJ0wY9ph+VCtU6XwvlBVVKyPiFJ8qcI8tjE3Ip
         49mttqd6KihpHCZ6JXwIIp7JebsPqq7NFcfP/M8/zCZN57qoEGDJBec6pO+uXy+60e5K
         DyZA==
X-Gm-Message-State: AOAM531WMLQoad0PgkSoDRr31aGgvTFuvOLl9fZUTzQl+QKE17NqVgxC
        34xmhJMQUReUenAfrcgH+1oHZw==
X-Google-Smtp-Source: ABdhPJxa13kl0P1optMF0WTHmFCEXJZd83UC4G9/VHnydUdYRdzj6BS2cS1m2i4Zen8bt/Yjr4R1Pg==
X-Received: by 2002:ad4:5caf:0:b0:441:5879:5e62 with SMTP id q15-20020ad45caf000000b0044158795e62mr4324894qvh.95.1648741603866;
        Thu, 31 Mar 2022 08:46:43 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:1d10:5830:565c:ffc5:fa04:b353])
        by smtp.gmail.com with ESMTPSA id j12-20020ae9c20c000000b0067ec380b320sm13126797qkg.64.2022.03.31.08.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 08:46:43 -0700 (PDT)
From:   Milan Landaverde <milan@mdaverde.com>
To:     bpf@vger.kernel.org
Cc:     milan@mdaverde.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, davemarchevsky@fb.com, sdf@google.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 3/3] bpf/bpftool: handle libbpf_probe_prog_type errors
Date:   Thu, 31 Mar 2022 11:45:55 -0400
Message-Id: <20220331154555.422506-4-milan@mdaverde.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220331154555.422506-1-milan@mdaverde.com>
References: <20220331154555.422506-1-milan@mdaverde.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously [1], we were using bpf_probe_prog_type which returned a
bool, but the new libbpf_probe_bpf_prog_type can return a negative
error code on failure. This change decides for bpftool to declare
a program type is not available on probe failure.

[1] https://lore.kernel.org/bpf/20220202225916.3313522-3-andrii@kernel.org/

Signed-off-by: Milan Landaverde <milan@mdaverde.com>
---
 tools/bpf/bpftool/feature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index c2f43a5d38e0..b2fbaa7a6b15 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -564,7 +564,7 @@ probe_prog_type(enum bpf_prog_type prog_type, bool *supported_types,
 
 		res = probe_prog_type_ifindex(prog_type, ifindex);
 	} else {
-		res = libbpf_probe_bpf_prog_type(prog_type, NULL);
+		res = libbpf_probe_bpf_prog_type(prog_type, NULL) > 0;
 	}
 
 #ifdef USE_LIBCAP
-- 
2.32.0

