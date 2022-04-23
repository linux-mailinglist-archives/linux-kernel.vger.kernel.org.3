Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1484450C92D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 12:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiDWK2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 06:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbiDWK13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 06:27:29 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C022564E6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:24:31 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u17-20020a05600c211100b0038eaf4cdaaeso9512953wml.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hmwzzU+oUsjeOQ4831eC65EcSxjUz8YhjuhTAsVP8U8=;
        b=CTywPRVtNSBTMd0idOhtNLInS25aX2di8NMiKJ27MTuKI1wC3wAHYqqtMgBrz8Uk38
         h2aEDAHeC30IBkOpwZ/KQ1AZ8P1nGF09QL9Wcaz6pUWT8JZe4PCbvW3AuES/GZ/hqdwh
         sMlhO9k9rvzQIs5689LR03VsW1J2lMBR3y7QcQQsmFNkOybMA4OucGR6KhLNEDo5GbF8
         JnWhJAaO114p3KBNsbT5zEMilZ9I///u+DrVidCADR5QS0CwEtJktemFPTBWIcjgm8qD
         HLRvSofPBigx71DWgavXtPg2FtQi+l9kNCWFTDyG7mEZABSWaYGj+it8R9DmjZxeaHTz
         zIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hmwzzU+oUsjeOQ4831eC65EcSxjUz8YhjuhTAsVP8U8=;
        b=ja4+w45Jqdd02UVgSJ6dl8oA0LTprs2orcykkSQcYbi9/KzCCSaMGn+IV7jkOjZBZx
         etATruSf0IcLMhHNh3HJr6Cj6KS58OIeUqhfG8SnFFF6Wpu6t+9Jg4XauQ5yx63OR4h+
         2Ob+pKMbSmNKULBBVFVSG8g9X9gmUv2jRoCvLaCXNsoiy/fQYzOLk1oqB2CVM6NGQCoq
         lFno6HyiG6R3V5SvDFbrqTxHcuIcVHxAXGR6AAoSDYJEW2cLTY4lkPhwCkMg9K+GoYKa
         gDJfiUiQ/laVRaM6o2pr+gibqgc11ATtaEcqKkKppMAhy+sU7N15h1Y/BTcYOttueEvG
         LQ8Q==
X-Gm-Message-State: AOAM530oB78XtYzRQRoboPoGLH+/Xe/a5eYNCunm1Pab/d64A8dLpct/
        kBbK3zrH/Csh87G3ti18008=
X-Google-Smtp-Source: ABdhPJwbDV6RBBsBs4YLiSHH1R3BI3vAH6+s7n1iUCc/tczi8HEpXIcuEVEJVmm3XPrlOPfEROozog==
X-Received: by 2002:a7b:cf05:0:b0:38e:b707:1c3d with SMTP id l5-20020a7bcf05000000b0038eb7071c3dmr7890731wmg.164.1650709470282;
        Sat, 23 Apr 2022 03:24:30 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id t15-20020adfeb8f000000b002060d26c211sm4089057wrn.114.2022.04.23.03.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 03:24:28 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 0/3] binder: Use kmap_local_page() in binder_alloc.c
Date:   Sat, 23 Apr 2022 12:24:18 +0200
Message-Id: <20220423102421.16869-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kmap_local_page() in binder_alloc.c because kmap() and kmap_atomic()
are being deprecated and kmap_local_page is preferred where it is feasible.

With kmap_local_page(), the mapping is per thread, CPU local and not
globally visible. Furthermore, the mapping can be acquired from any
context, including interrupts.

Fabio M. De Francesco (3):
  binder: Use memset_page() in binder_alloc_clear_buf()
  binder: Use kmap_local_page() in binder_alloc_copy_user_to_buffer()
  binder: Use kmap_local_page() in binder_alloc_get_page()

 drivers/android/binder_alloc.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

-- 
2.34.1

