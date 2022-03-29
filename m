Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475C94EA6B8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 06:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbiC2Ey3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 00:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiC2Ey2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 00:54:28 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C39134B9D;
        Mon, 28 Mar 2022 21:52:46 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id bc27so13860779pgb.4;
        Mon, 28 Mar 2022 21:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PendfA7YHEcMYsdHc2AY4wG6aL+D0ZWLpIYu106xzh4=;
        b=G9sFOv2jF7octFBSSjhV/jTK0MOIcZh1yVUBsgrNdeiw+wy5M2JlTySo4lpQfTkj/u
         4cDsVHSYgw1YXU/GRX3dLRWBSWO99Q9ub1VLS7sbqJM+baDQFZBW8PzxZCOZxvoGby/2
         4t8Sy/jNH/YA9cEZdnrKhx+K1RnRk0a2P4h+/+tbjKU/tJfiWe17S7Y2pKL619ahZ16B
         vlaamNHKJsfP1RI45j/hlP9olMiZ/BWM9ppA/HKltQqPRewUT7mz8oJ8Z8+undYEjjV2
         AHBb/URFYM+BKm/r3Jsa68dZj4Dt2aneKbpSQCqnfB/TpPZBTcRCpMmjlKj0HwbQiCX1
         Hd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PendfA7YHEcMYsdHc2AY4wG6aL+D0ZWLpIYu106xzh4=;
        b=q7OnX3hOo6Aw9Oo5hR82Ox+mIB7goxP533oKnhIZsw9swNmvVKFklZH/CwIA+OKtS2
         FbE4P00OuFfXVbminPHHuWS192WWnYZNqRoVET/CoMR7L19uZw+/vmRmHZjMD4zpVMKA
         M9oHXYIBIfjUF+gLOqZQzt6+dvRic2BjlqC847ejRAJnaQrGAU4wa1abgvksq4xXTN/c
         In8R7k4MseNhVDhYrFt12+N9U3RNMmqwjs94Ri/OHuistKbj4Oh1ZvvMPZvUJ9jV1cPr
         4SQzNaEzm4nwR0Z1+rieQfwS9L6KbvrYfsqhv92LdBNPfQJCwzhIHVMa+VPPXj1lRVZe
         xecw==
X-Gm-Message-State: AOAM533jskk/Vzl+kDnFcbSJtJOjnIpABvTNtVBRgROAmdRYapZVoziS
        6snu4922tN2NenowpRZxGwCzDUJgQBsDneU3
X-Google-Smtp-Source: ABdhPJx1yYZXjQ+lW4d9RgSU6MBVhCzLU5IoRR8phbPepNRxgp8vq9eW/D+rpSObHGSqsX7dSG4/4A==
X-Received: by 2002:a65:6cc3:0:b0:382:9d3c:ff82 with SMTP id g3-20020a656cc3000000b003829d3cff82mr716322pgw.110.1648529565356;
        Mon, 28 Mar 2022 21:52:45 -0700 (PDT)
Received: from ubuntu.mate (subs02-180-214-232-80.three.co.id. [180.214.232.80])
        by smtp.gmail.com with ESMTPSA id f16-20020a056a00229000b004fabe756ba6sm19327282pfe.54.2022.03.28.21.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 21:52:44 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] Documentation: doc-guide: Add missing page titles
Date:   Tue, 29 Mar 2022 11:52:33 +0700
Message-Id: <20220329045235.11879-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel documentation guidelines [1] lists that there should have page
title.

Add missing page title for kernel-doc.rst and sphinx.rst, in accordance
to the guideline.

Changes since v3 [2]:
  - Clarify that there is no output differences except formatting
    semantics in [1/2]
  - Drop Suggested-by trailer from Akira Yokosawa in [1/2] 

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org

[1]: https://docs.kernel.org/doc-guide/sphinx.html#specific-guidelines-for-the-kernel-documentation
[2]:
https://lore.kernel.org/linux-doc/20220328065030.24936-1-bagasdotme@gmail.com/

Bagas Sanjaya (2):
  Documentation: kernel-doc: Promote two chapter headings to page title
  Documentation: sphinx: replace "Introduction" chapter heading with
    page title

 Documentation/doc-guide/kernel-doc.rst | 2 ++
 Documentation/doc-guide/sphinx.rst     | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)


base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
An old man doll... just what I always wanted! - Clara

