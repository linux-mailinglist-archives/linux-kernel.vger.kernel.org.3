Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF7955FE7B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbiF2L1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiF2L1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:27:36 -0400
X-Greylist: delayed 76328 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Jun 2022 04:27:34 PDT
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CEB36B5E;
        Wed, 29 Jun 2022 04:27:34 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 0B0E8C8012A;
        Wed, 29 Jun 2022 13:27:32 +0200 (CEST)
Authentication-Results: srv6.fidu.org (amavisd-new); dkim=pass (1024-bit key)
        reason="pass (just generated, assumed good)"
        header.d=tuxedocomputers.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        tuxedocomputers.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from; s=
        default; t=1656502051; x=1658316452; bh=RpK7AUNpZP7LklmTBq9g+F70
        EFG+ja+byQJZluJ6nTw=; b=nAjslK0HBIfU/NXZiz1UnuB1KrXl+KR9aFPJaszz
        MKjPldU+ZhmK03l10P4e8wurXcwPqh4R8u93mzadlzboWS4Zj04TM0EYOdXfrqA8
        R0Z8Cbj9BNpRKhpyfEVds+vFajUB88n4yVqfiHGvrSX1vb0w0GSAl6cV39YP/4q0
        T18=
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id KRPXwq5UTpHs; Wed, 29 Jun 2022 13:27:31 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 7CCA2C80128;
        Wed, 29 Jun 2022 13:27:31 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     dmitry.torokhov@gmail.com, tiwai@suse.de, samuel@cavoj.net,
        wse@tuxedocomputers.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6] input/i8042: Rework quirk tables
Date:   Wed, 29 Jun 2022 13:27:21 +0200
Message-Id: <20220629112725.12922-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revision 6 fixes some spelling mistakes and a copy and past error causing
two .drive_data fields missing.

The 1st patch is minor housekeeping.

The 2nd patch merges the tables together. Minor fixes in 5th revision and
no more duplication of ASUS devices

The 3rd patch add optional debug output to see which quirks get applied. In
5th revision this no longer breaks compilation on non x86 platforms.

The 4th patch adds a list of Clevo devices that need multiple quirks.
With the reworked table they don't need to be inserted multiple times now,
which was required in v1 and v2 of this patch.

I also included the extra quirk for the Clevo NS7xMU, which was a separate
patch before.

The added Clevo devices are now only identified by their board name as this
is the only somewhat reliable string that might not be changed by resellers.


