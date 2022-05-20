Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA5E52EF09
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350758AbiETPXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiETPX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:23:27 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF8A13B8E7;
        Fri, 20 May 2022 08:23:26 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so1316920wmz.2;
        Fri, 20 May 2022 08:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y8jCixj/3v6rQoWkQuP8PEbezmpzhkjMJ/xpsL9DATM=;
        b=CvcMmakbrXcQhAC5ZBIn6iVBJ/mlPrcdigP2pWDXVLURmrUXy8rUfDWxE7rCuPbEQU
         R7KAPPgTc42HNc4nQ9UzeXyakfl5fKVBGi5B0ChNqHCDWwDTXS9gSVLyS8ALP0YzuTIN
         QzPlc6DUYdvUZa30MD33+wHeMtUbkth/YjTOlEaag4g+ra/2S59vFkIR4qErStg81HVS
         QtpwVfKZEUMoTJ2pu1mU/ZZD3bsNk7bE9BjHfzRuO6cTGo720JLrIlC+3v4iH5VgBQvm
         xt/mcZXrsqCqbVgVxngEuFtLFYE7ebG1zYxbVRSkChkJDEIENJrgvFGykjw6D9kfynQp
         Xo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y8jCixj/3v6rQoWkQuP8PEbezmpzhkjMJ/xpsL9DATM=;
        b=kQ0RH9xItt0g4Pm/XrcW+BIXICyJP9eFIkSAin7l9aj66dv+anemSJl7D51MKe1oDg
         7Gfl3mwANWHefzF7R67qBp8p7WboAf8bk0mtO7spvcD0GPKatNX1vl+PK/Rdl9SKlmWw
         MGwu2ofdExKlTfX2vr5RlRzS5ZBmfRAz31E8V8sdH6rgXmkGHL8GVlB1ZHZxHDc5eiuN
         JOQc7k4b9pCpqwn1zJZ0aAsBdQ/ejJusbZ4GmtEOtHrYqRRN8rsDvr+qpoSqUQW5vPQ9
         n+Z+LEPq9nc4JHkhmaqni438Yv0Cs04XgFLrXP94DiMF1GH2BjT0oiw1L0RGb5LlS+kU
         QUdQ==
X-Gm-Message-State: AOAM530Wef9RMclsci8Ljx0ToZ0gCpOEScU25H0R5DCwzo2ak5r7AVeT
        NlYg4yQUPdG9iTaigizd2lM=
X-Google-Smtp-Source: ABdhPJzXGgeCQc1J0FMkHZR4RorhL2bFOkNyacqzH+huVj7yLJvr9l9Z3k6yzNni3QpVs2ldufT4Cw==
X-Received: by 2002:a7b:cf33:0:b0:397:347e:88e0 with SMTP id m19-20020a7bcf33000000b00397347e88e0mr5259710wmg.52.1653060204579;
        Fri, 20 May 2022 08:23:24 -0700 (PDT)
Received: from kwango.local (ip-89-102-68-162.net.upcbroadband.cz. [89.102.68.162])
        by smtp.gmail.com with ESMTPSA id b11-20020adfc74b000000b0020e68218048sm2911717wrh.93.2022.05.20.08.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 08:23:23 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fix for 5.18-rc8
Date:   Fri, 20 May 2022 17:23:06 +0200
Message-Id: <20220520152306.10106-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 42226c989789d8da4af1de0c31070c96726d990c:

  Linux 5.18-rc7 (2022-05-15 18:08:58 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.18-rc8

for you to fetch changes up to d0bb883c6355bcb2cc149fb4d5c3b28ccd327a5e:

  libceph: fix misleading ceph_osdc_cancel_request() comment (2022-05-18 21:21:29 +0200)

----------------------------------------------------------------
A fix for a nasty use-after-free, marked for stable.

----------------------------------------------------------------
Ilya Dryomov (2):
      libceph: fix potential use-after-free on linger ping and resends
      libceph: fix misleading ceph_osdc_cancel_request() comment

 include/linux/ceph/osd_client.h |   3 +
 net/ceph/osd_client.c           | 311 ++++++++++++++++------------------------
 2 files changed, 129 insertions(+), 185 deletions(-)
