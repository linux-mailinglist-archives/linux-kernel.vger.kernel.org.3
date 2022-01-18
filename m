Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5843493120
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 00:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350035AbiARXDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 18:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238025AbiARXDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 18:03:18 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2544C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 15:03:17 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id s61-20020a17090a69c300b001b4d0427ea2so3944497pjj.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 15:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=rt6/npTiHHjWj3ecoUN0HYwqJoJlmgLKj93DKfKnkfU=;
        b=ThyT2to8lu+EdzoAhImiUkr1hJ4EQoLjTs7z7wPDbjeTuO7s4QWPLbKv5qzKZwTOJV
         w/E6qozGQ8/ntOaQOsLjUT0vIYHezTR0+m8rKsgBQhgge8XtJBbtFfwO0Gte62FBVvyq
         E/5U59VX3nrhzJdTW2ocksnHQQDLl3Ucjt9O8D3N6cx2k3cJnSgJIXykhvROBS1iYwrD
         m9+qT6LJRJMNeQeDHEZLISCBgSzZ4YSJuZTVMn0Ctbcb9vOFZ2QjUA3ae0r77lMX3NFp
         SB5tR/7XsneXOIpvf9aUvlTQJzuMLc6b5LWzGykhNCVKbspDZHEPPUD5SYewmQC2vzcB
         m27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=rt6/npTiHHjWj3ecoUN0HYwqJoJlmgLKj93DKfKnkfU=;
        b=ZubPkSTxMNr71q0VQE5DnDZkZhSFS3M7uUQiinZLoMV+MQAv/waMcjzJVAA+y8nRCn
         PcAkiPAHAH3uApstDcLsz4o7VAr47lKQDQdH/hxyV+uqGJ/QdHXni0EK4AkkWJmvlIkd
         MH9QSxs3zC39ysetIAgr/dmpN8aFSz4kFcvXnMS1k5LxVByatiK9HpzPIGPbHyjxyx1+
         n3kr0DGsvKUyemPl4tKQJYNphwwJeK1pP+MchMn3V9xlNxuVKUGs6G8JNJFDIOf9yyeV
         Jt1w5cRE8Z0ioZmRz8TR06sr+tEfACWBtCMI6gs3Q01O/0ESmGPH5f6BS82cHRnpk9lz
         WFYA==
X-Gm-Message-State: AOAM5335Uf0nmAv7OmomNwdRNSZxExesBlbXheg3NBAdhAPGjYbKkyW5
        AltjpSO8tLBVDhtY4QJFOD0=
X-Google-Smtp-Source: ABdhPJzRz6I2/Y8tLeRhH017WM73iOH13SYJr0Thb8EEaCjKTk85I1yCFtsDK04PML4YqUIYlPJHYQ==
X-Received: by 2002:a17:90b:797:: with SMTP id l23mr280187pjz.30.1642546997427;
        Tue, 18 Jan 2022 15:03:17 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id h63sm6274007pfe.12.2022.01.18.15.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 15:03:17 -0800 (PST)
Date:   Wed, 19 Jan 2022 12:03:12 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] staging: pi433: validate min/max bit rate settings
Message-ID: <20220118230312.GA4826@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118193422.GA3155@mail.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RF69 chip supports different bit rate settings depending on which frequency
modulation is used. Failing to correctly validate bit rate can lead to a 
silent failure and cause packets not to be read/sent.

This series change the order in which the rf69 chip is configured and add
max bit rate validation.

Patch dependency:

This series depend on these patches as they change the same set of files:

- https://lore.kernel.org/lkml/20220108212728.GA7784@mail.google.com/
- https://lore.kernel.org/lkml/20220114221643.GA7843@mail.google.com/

Changelog:

v3: revert bitrate variable data type change. Req: Dan Carpenter
v2: change bitrate variable type to u32 as pointed by kernel test bot
v1: https://lore.kernel.org/lkml/20220116001726.GA22699@mail.google.com/

Paulo Miguel Almeida (3):
  staging: pi433: fix validation for min bit rate supported by the
    device
  staging: pi433: change order in which driver config the rf69 chip
  staging: pi433: validate max bit_rate based on modulation used

 drivers/staging/pi433/TODO       |  2 ++
 drivers/staging/pi433/pi433_if.c |  8 ++++----
 drivers/staging/pi433/rf69.c     | 12 +++++++++---
 3 files changed, 15 insertions(+), 7 deletions(-)

-- 
2.25.4

