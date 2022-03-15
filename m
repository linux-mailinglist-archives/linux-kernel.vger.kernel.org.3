Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8784DA2DB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351215AbiCOTDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351187AbiCOTDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:03:49 -0400
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE315A155
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:02:36 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id D16F9C8008E;
        Tue, 15 Mar 2022 20:02:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        tuxedocomputers.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from; s=
        default; t=1647370954; x=1649185355; bh=SDMsvOzENIieUNEp14igHQgf
        Yk6hEsxarU/8u6JCPek=; b=Xmht9Yt31/xX84N3BI4QfPWZFF1qrcABq1GuqNMY
        PZXJ0OKxXwGRvVTpF9YFhwxHZq3a/8jVuUn78cXL/qv4Ao32SgUuxCa5ShFSVSgE
        sw1yK3vXp2dZfS7oXbZNheRB/fasHineS86j8FTXzHx4GXTm2d0nhkjulpMJ05y+
        68M=
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id k9S9ehrr8x_d; Tue, 15 Mar 2022 20:02:34 +0100 (CET)
Received: from wsembach-tuxedo.fritz.box (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 7757BC80086;
        Tue, 15 Mar 2022 20:02:34 +0100 (CET)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI/backlight: Force backlight native for Clevo NL5xRU and
Date:   Tue, 15 Mar 2022 20:02:27 +0100
Message-Id: <20220315190228.1503866-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch works around a bug appearing on at least two Clevo devices.
I also put some effort in finding the root cause for this bug to fix it in
general: https://bugzilla.kernel.org/show_bug.cgi?id=215683
I could pinpoint it down where it happens, but could use some ideas for
cleanly fixing it.


