Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0D752EB53
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348845AbiETL5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348804AbiETL5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:57:18 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC73B37A36
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:57:17 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2BF3C3F1C8
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653047832;
        bh=N1+eNvpQfsh94g110W5w3rgDQJpkJTHEsdjZCoxmAwY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=kKYOXWiKHyIx3fEpx4pDR4BgJ9d8FZ1jTvmIHlTKPC8o2PtgKUR/Luj8TqoC95FMU
         7f0k8bHEt8UKB8JDq8IN9+qFu4ZmYnklrLjCxdmd7H7xJuh62v6VSWzSn0GJTav0WF
         NbICFFMGy4dZ7PkAfxCOAN58TF2yoZuxkmYBqE4YxNIMImlCprVGZAhRC3XoQjKVAr
         U8xjD//eYSYe/vksuXlvfvxchHcsIhfP4EvkrjYZGQr1XRe/w1mrNsx1n7LZCZxWcr
         nvo4P14v2dwLzLhnFqcfZOt5Ek/uISDJTooByZkkolQxoccANZyZl8/8pqGRN2tBXN
         DAv/UdwkHhnBA==
Received: by mail-ed1-f70.google.com with SMTP id n7-20020a05640206c700b0042aaeb9d702so5459358edy.19
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N1+eNvpQfsh94g110W5w3rgDQJpkJTHEsdjZCoxmAwY=;
        b=RoudG7wHWStDaSzKDXqtbcLH34Ra2WYOszWXIy+PGPtyfOCztZz2Rpfi2MLHju/D/K
         fN+xfmtbjo0cf/vT1rXZ3a0iPNmdGn8BJ91uwsCE0m6+Y0KSqgjy+6p6phzTnghnzB9X
         OIzTanDgUjiRefB+iaeHidE9AXvZqnKqtR16yEq62XxYJHX92EMYViEzNamjZiNDD6mN
         6YG9JJ3LcsJcyxsoqPGSp+RMXJEWG7U8e/PiZuE6uEpYd8pW0snkkPWcys3WT6j4EqvE
         uIduSu4XplzlcnqS4SuS/035He/hqDqc65rdVmomLvr5cdWoCV36fYKlc2VFTOxuQvaO
         sC2Q==
X-Gm-Message-State: AOAM532HXjBfPWkBKT3q5koHZtJuKKJahOo5wgqNogbsMK2gUtnrECHh
        d6XqxBXfSFgn/tERD9cD1M1DOL98Fh+VHO81xtSHqivcLARsaZtgDnNuBhQ7qG6vE0STs9PEBDB
        VLRH+rGXDmyYrLp8P4JRUjtwr6oIg5dd+6/5cIS6wbg==
X-Received: by 2002:a17:907:3f1d:b0:6f4:ce49:52ea with SMTP id hq29-20020a1709073f1d00b006f4ce4952eamr8223127ejc.47.1653047831917;
        Fri, 20 May 2022 04:57:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMmKUQtizOb5gFlIHePlKnRgA+9mCZD5XoL8J9tsroIrLPb9DgtvpydSoPbeA3cToKYHvbUw==
X-Received: by 2002:a17:907:3f1d:b0:6f4:ce49:52ea with SMTP id hq29-20020a1709073f1d00b006f4ce4952eamr8223118ejc.47.1653047831778;
        Fri, 20 May 2022 04:57:11 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id ze16-20020a170906ef9000b006fe88802203sm2946451ejb.46.2022.05.20.04.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 04:57:11 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 0/2] s390: Kconfig: Style cleanups
Date:   Fri, 20 May 2022 13:57:06 +0200
Message-Id: <20220520115708.147841-1-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The majority of the Kconfig files use a single tab for basic indentation
and a single tab followed by two whitespaces for help text indentation.
Fix the lines that don't follow this convention.

While at it:
  - Add trailing comments to endif/endmenu statements for better
    readability.

Juerg Haefliger (2):
  s390: Kconfig: Fix indentation and add comments
  s390: Kconfig.debug: Fix indentation

 arch/s390/Kconfig       | 20 ++++++++++----------
 arch/s390/Kconfig.debug | 12 ++++++------
 2 files changed, 16 insertions(+), 16 deletions(-)

-- 
2.32.0

