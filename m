Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7AA56D774
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiGKIM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiGKIM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:12:27 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C211CFC9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:12:25 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h17so5986650wrx.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MPFKY/bHlsQhtgUJcy9UK+LhK0GjolHXo8PsK9MTO74=;
        b=3dWItNH/NrG2UXqFVsxOXWN+q2qqBj4vzooK3M0fqc0NW7nFtkiqcvWaIp93vV4X5t
         cvuXswhlr6y8zqUrdIAnLYVuT0/bBNWWTBvXhoMuA9ghuCH4JYnL2Co6bcDvoOC4NyNL
         9bCZmbb8jxOvLj1zTcOoMyjoZjIdOAHWBXpO4ssyke6GlXpC73oLnxfit7nnRfO6iB7i
         256ylzPv5rvMS0FCWr1MXcdyFEWc5plJLs5nVT7L83L2EGX4IHqfxBkkHMgW6NlmQk7h
         zCrXXf4WDBzabyhGC8I3ECzVLJqbg7Zl72pFR5tKA6tbrSzAQECZD2fYwxRbLLd9YFX/
         FFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MPFKY/bHlsQhtgUJcy9UK+LhK0GjolHXo8PsK9MTO74=;
        b=3itZYh+n2M6dT+vca67CUR3AtkozgHxY63upHt4IJOdSKKizi6/KF6oU2na1e5ww3d
         2NRKumkUPzeVA/s7SlxWVu4az1kO88RKvSooUzPyBSLXSEDvlRxoeUMj0FM6TWsji5IZ
         z2pwZg+YgGzlDdoI4iD9haj2vvQpXTdB4FTV0vp6cjFHm6nxmHqilHdO9t2H225Z8CfQ
         txuI0RPSQhvkE5U//4n9OMIq1SRETyf7rcTbCXtQL9l2XrUYgUoRv+rKuvw+qqjyTWoM
         hZyM7zb6s4FtnPB6e2KYaQT0iFL8nUm81sZJqRAhrGxBXzep08OcjeZrBTmDrPFumVF+
         Hmfg==
X-Gm-Message-State: AJIora/mIUL12iBQ23qc6NkNvztRLmAKheB6oezdKYi0Jj2ejLPhtxXu
        BRC8brmqlgD+9rMNyMwj+jJ41Q==
X-Google-Smtp-Source: AGRyM1tyUmKFNUbH8YgWNHHNsuw6XFvycdzRT3nCgIcwAJdtGiyuk4Xct3kq4NBg+aexVIJb1PXCpg==
X-Received: by 2002:adf:e111:0:b0:21d:665e:2fa5 with SMTP id t17-20020adfe111000000b0021d665e2fa5mr16086610wrz.652.1657527144170;
        Mon, 11 Jul 2022 01:12:24 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d6604000000b0021d650e4df4sm5159809wru.87.2022.07.11.01.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 01:12:23 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>
Cc:     mptcp@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2] bpf: Fix 'dubious one-bit signed bitfield' warnings
Date:   Mon, 11 Jul 2022 10:12:00 +0200
Message-Id: <20220711081200.2081262-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our CI[1] reported these warnings when using Sparse:

  $ touch net/mptcp/bpf.c
  $ make C=1 net/mptcp/bpf.o
  net/mptcp/bpf.c: note: in included file:
  include/linux/bpf_verifier.h:348:26: error: dubious one-bit signed bitfield
  include/linux/bpf_verifier.h:349:29: error: dubious one-bit signed bitfield

Set them as 'unsigned' to avoid warnings.

[1] https://github.com/multipath-tcp/mptcp_net-next/actions/runs/2643588487

Fixes: 1ade23711971 ("bpf: Inline calls to bpf_loop when callback is known")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    v2: switch from 'bool' to 'unsigned int' (Yonghong Song)

 include/linux/bpf_verifier.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 81b19669efba..2e3bad8640dc 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -345,10 +345,10 @@ struct bpf_verifier_state_list {
 };
 
 struct bpf_loop_inline_state {
-	int initialized:1; /* set to true upon first entry */
-	int fit_for_inline:1; /* true if callback function is the same
-			       * at each call and flags are always zero
-			       */
+	unsigned int initialized:1; /* set to true upon first entry */
+	unsigned int fit_for_inline:1; /* true if callback function is the same
+					* at each call and flags are always zero
+					*/
 	u32 callback_subprogno; /* valid when fit_for_inline is true */
 };
 
-- 
2.36.1

