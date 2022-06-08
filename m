Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68628542B60
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbiFHJVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbiFHJTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:19:18 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE34E2504E3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:42:04 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id p8so17765292pfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 01:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oKrDn7j6iEauiUWOiZHjxCbYJ+SMcnBM09Okw3jAyWg=;
        b=hkP12yBv/qdVHlLRTYmfWbnNdUzR7SIEXiNK5tBfZg8wZEqvBbsaYa48xIl9gAun0V
         5goeucy3rfgPiKHksq4o4pjbCT4LnsLg3Um1mnXSUBVU1nfNUE4782N8yG069J9ETuuh
         L0BccRWgphC+21aMuQHWuPdkjFkQrZtC4xyMzLYp7R/koc2WhuOuuT5HzwIPBry0vOkp
         7yvg55NmSxos6hJ5Yz59RfBKzSuv0MuoAPyb9vGEh65FfBJ2kvANH+TeVZniMFmwvs38
         tKX0OCVm4NZEI2fDx7t56RE3qlOXqGro7NYpT3LXuxEIXfv02zkRr7Nqzu5WLdcy8NAD
         P22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oKrDn7j6iEauiUWOiZHjxCbYJ+SMcnBM09Okw3jAyWg=;
        b=qHGW+VxioX6L4LPe20FPsKzv53TicWEU1DmeEmUYadSVUc/ogvMZi7eCe0VdiXc/Kj
         MGMNIq6SbMUlCuUuUrChTWo7RQ9H1roCF51HFu6e+KOotRyLtXKwHWHzfxBkEW02Fe21
         LaOrfMpRPBveG+suEP4S8eTsCLyXR7wbm/t/rWpuhI9nCIrRkuuEg4YgTvqXptMd97Gb
         nVtLzdI+HYkeVY3bwURziS0DNvQZ1f5FgoJ8Eb6duUxdm68bGjSmb+VCQEuqXlZsJXRK
         6zr5SOMBQm01t/thS8ElSdxnnmLQyz6VWAbByDwX2lknm0SJz2XIUJdej5rPoau3Afsa
         Q/Tw==
X-Gm-Message-State: AOAM531s9T4opg0idlcmQKoFm4oNFfdKDTSkvj2QgpBxfmF4H5tVhbUv
        iZvzUECMC+x0Wu5sw0eHQrNzkQ==
X-Google-Smtp-Source: ABdhPJzD1keYHphMNOiKsYQv/uGAH59sWQMWaVZCHRdHyPa3OQHK25sHTNNqEyRTEKJGpDKla7rOBA==
X-Received: by 2002:a63:90c1:0:b0:3fc:7de1:b2b9 with SMTP id a184-20020a6390c1000000b003fc7de1b2b9mr28895736pge.440.1654677724237;
        Wed, 08 Jun 2022 01:42:04 -0700 (PDT)
Received: from always-T480.www.tendawifi.com ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id u30-20020a63b55e000000b003fc136f9a7dsm2180975pgo.38.2022.06.08.01.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 01:42:03 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 0/1] mm/memory-failure: don't allow to unpoison hw corrupted page
Date:   Wed,  8 Jun 2022 16:43:55 +0800
Message-Id: <20220608084356.40894-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2:
- this change gets protected by mf_mutex
- use -EOPNOTSUPP instead of -EPERM 

v1:
- check KPTE to avoid to unpoison hardware corrupted page

zhenwei pi (1):
  mm/memory-failure: don't allow to unpoison hw corrupted page

 mm/memory-failure.c | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.20.1

