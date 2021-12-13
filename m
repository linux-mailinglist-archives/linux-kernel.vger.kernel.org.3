Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F594729F3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbhLMK2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240510AbhLMK0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:26:37 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBC6C08EB32;
        Mon, 13 Dec 2021 02:00:51 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id y196so11456001wmc.3;
        Mon, 13 Dec 2021 02:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2J3WjUUDZRJctdcJl6/snud+aQbH4TqfkyM0/+9MbGI=;
        b=HypspHRWAWDb0rHyq47aLfBUtix48TRHayaWJOCh5uPH8KKIg8/zhItvVjRNYLc+I4
         5BunMEsQf0ycC1ysUhASXrHP4/P133GjW2h/fInQuMSYelrVChIecqQPvm6mV519REgd
         WhRvkW42MPcdViOtISTuItmGNJimzO6pkaNc4bT9KMb9XAV1PCHkXbHuYFzb7XhnRCWv
         4qOhBC9IJsLoWDPHU9NxivG7Pn+HMr0B4Ly+l0LEZX4R2jYPJDltczSaP7Qp5Bq6JonC
         YRK8u5Luq9pf8kWynRsp2hEJO8zpPRtCSgHZfUhAi4DrL0gza5b6oDNlXIKW2ofRx5k/
         4ntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2J3WjUUDZRJctdcJl6/snud+aQbH4TqfkyM0/+9MbGI=;
        b=TyxYl2BraDM1S1hlZqGQwIKC4tl44B4AZdsPjpZpQLerc1nNcHLdSxui9QsiP8wdXx
         lGNutLDdlVC62h3TwbtIvlnNLjGNihGHe+XLlMasF52SbhSCNj2fnTwAFPWg7bqT93SA
         lGKRKQvVdE5gNn3i9YlRzBD02Sco94PpubRN00ugRcForG2NXZHDWOWD2t3oNMcGMJ39
         7vF09i5t4rBU9PaOYhAkdz9P+JZ67bymltV9hQTUupF5Top7mj5yGR+SlBZMsUQB4qgP
         sA+SvB3CXND0zSIk0p0ZkqdzRRYnzLacM7IKE9MVxfoAGgWXaWAJqzJMAw0uw9sB0j/g
         WJng==
X-Gm-Message-State: AOAM531Hb9zZmASts9u9SJYDchNDvVQzXqaSDH5gqgRg6icaUtFbnN+Y
        r6WkNQVXaoNUjUpkX3U37y0=
X-Google-Smtp-Source: ABdhPJzySgR4gq8pBxNNwNaxt133hwPgUa7GfoJEXYD0w+IgEkrfVZPmO2xDFBxhYc4pkgSGAqUg2w==
X-Received: by 2002:a05:600c:510d:: with SMTP id o13mr35926524wms.104.1639389649930;
        Mon, 13 Dec 2021 02:00:49 -0800 (PST)
Received: from localhost.localdomain ([2a00:a040:197:458f:acc5:ce9c:f048:f197])
        by smtp.googlemail.com with ESMTPSA id s8sm11826590wra.9.2021.12.13.02.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 02:00:49 -0800 (PST)
From:   Ariel Marcovitch <arielmarcovitch@gmail.com>
To:     masahiroy@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ariel Marcovitch <arielmarcovitch@gmail.com>
Subject: [PATCH 0/2] kconfig: Improve comment blocks in the .config file
Date:   Mon, 13 Dec 2021 12:00:41 +0200
Message-Id: <20211213100043.45645-1-arielmarcovitch@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there!

This series attempts to make the .config file format make more sense.
Currently menuconfig blocks look exactly like regular configs while
comment blocks look almost exactly like menu blocks.

The first patch makes menuconfig blocks look the same as menu blocks.

The second makes comment blocks look different than menu blocks.

The format for comment blocks in the second patch is a suggestion. I
realize some people will think the '###' prefix is distasteful. I'm open
to other options as well, I just couldn't think of a better option that
starts with '#', looks different from a menu and can't be confused with
a disabled config.

Ariel Marcovitch (2):
  kconfig: Show menuconfigs as menus in the .config file
  kconfig: Make comments look different than menus in .config

 scripts/kconfig/confdata.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)


base-commit: e06a61a89ccd3edda046c78f9d08aa045b8c4d32
-- 
2.25.1

