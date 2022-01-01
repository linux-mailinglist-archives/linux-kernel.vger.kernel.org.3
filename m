Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8362482667
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 04:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiAADdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 22:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiAADdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 22:33:38 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EB3C061574;
        Fri, 31 Dec 2021 19:33:37 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id bp39so25212345qtb.6;
        Fri, 31 Dec 2021 19:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=59el7tfqb2LQiBE3iPN7Zj8N7PRSTRdL/Hbwi0H89bQ=;
        b=W3qwvSL1oLtV7uBO4PLOd5WvYHQu2PKCrIK8s0dcmV7LZZAS5IKIKgPJRJEGHAWa72
         kDsKAwbiIKf9GpLKIrnliuSd2ArXBfsumlihVakAhOAllWXZqWg5EvL1bP5PVmbbEB3D
         xQ+kBTcfG2VAtGixIMa7BrPMnbC7KPNuiIbX1hFQeB7wo4ydjhwVQ2GaHt4R1EREZmxS
         3YMO6p5zHyQm0fB0EgBz8uuzAH8SEukt7ORcazQNiQu6pibeAROJNKjyYGEzf6k9b2Tm
         +gAHe5tSbxOa4Zk2dbN3aqyxWCL3YvzrBStYLlkaa9qYi1QYCyvKQjA8cE2bSkKsLr7Q
         kXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=59el7tfqb2LQiBE3iPN7Zj8N7PRSTRdL/Hbwi0H89bQ=;
        b=Uo6ce18+krPYY0ZYyS60QM7faVoOOrPs5xRrCJXILHEz+Vxm5E2fb5naHNepn0rUTU
         1aHDIqbjCOXoEpoANGt8pD8hYwqMRmQ4OVheS+Yc615FdlDomvMQmcDsqlxCk7Eq8yaw
         owgikCCiy1hZhRL3FcBCyERCO7soIWh1O2a/4Z9ypLNgzUyYdYykVnhBIYqGjajKTiXc
         5Gfgws7HnrA371CzTXrfRf/Z15kkLuFJvyYAfU7gbJ8VxNUtg0hnkY/xN16gvrteVvoR
         T+IyTRs4PH1kSdVLtdBgJkb2NuPP31XK30dtji8QpUoxSQj1fYKaJZazs/fZKAa8UxHd
         zI9A==
X-Gm-Message-State: AOAM533EMgn20zas8XpIfJgKjq2eqUieK2wFdruZmEi2eQRnTa6eR9+c
        1z7ekx1px1Lun/bv5pcbMMzo9N7LMAE=
X-Google-Smtp-Source: ABdhPJxZ4Nybx1M9rtCcMt1GT7JG5U/JBR85ZwYW9LzR4cONWzwbEP+d0+oseFmPtrFvdmBb6mHIAQ==
X-Received: by 2002:a05:622a:1743:: with SMTP id l3mr29832790qtk.98.1641008017088;
        Fri, 31 Dec 2021 19:33:37 -0800 (PST)
Received: from localhost.localdomain (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id x4sm24132867qtw.44.2021.12.31.19.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 19:33:36 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, erhard_f@mailbox.org,
        yinxiujiang@kylinos.cn
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] of: unittest: re-implement overlay tracking
Date:   Fri, 31 Dec 2021 21:33:27 -0600
Message-Id: <20220101033329.1277779-1-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Some overlays are tracked when they are applied.  The tracked overlays
are later removed after the overlay tests are completed.  The old
implementation makes assumptions about the expected values for
overlay changeset id created by the overlay apply which result
in fragile code.  The new code removes the assumptions.

A symptom that exposes a problem with the tracking code is a
warning "UBSAN: shift-out-of-bounds in drivers/of/unittest.c:1933:36",
Kernel Version: 5.15-rc7, PPC-64, Talos II.  This results from variable
"id" value of -1 in the final line of of_unittest_untrack_overlay().

The first patch in the series cleans up the inconsistent use of overlay
changeset id and the obsolete overlay id.  The id is a core concept in
the overlay tracking that is re-implemented in the second patch in
the series.

Frank Rowand (2):
  of: unittest: change references to obsolete overlay id
  of: unittest: re-implement overlay tracking

 drivers/of/unittest.c | 154 +++++++++++++++++++-----------------------
 1 file changed, 71 insertions(+), 83 deletions(-)

-- 
Frank Rowand <frank.rowand@sony.com>

