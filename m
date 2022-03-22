Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA364E4418
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238961AbiCVQXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbiCVQXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:23:01 -0400
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAC221E1E;
        Tue, 22 Mar 2022 09:21:31 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id F15AFC800A1;
        Tue, 22 Mar 2022 17:21:29 +0100 (CET)
Authentication-Results: srv6.fidu.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=tuxedocomputers.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        tuxedocomputers.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from; s=
        default; t=1647966089; x=1649780490; bh=UtZBNRgWNS685gHiBC5AYcn3
        7IcwlIiOgwaXZ2OaY2w=; b=LRXelzLDJXNORoYBP6SqoG8OkcI8s01YZtkCrF8u
        rCr5g+r9nMLPbOxAMdhcBo+pGiFVxOwQwrXnStlgn+O7GcYyJQ+doDOU0rBq2avn
        zj7zWZ9CCOUzv1J50TPZ66GPbktv4vIF486B6kDpUMdT/sqJC0oHROydZiTzorZb
        XHc=
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id khTitntSUZQ5; Tue, 22 Mar 2022 17:21:29 +0100 (CET)
Received: from wsembach-tuxedo.fritz.box (unknown [IPv6:2001:a61:6168:d301:4be4:641d:6061:c5dc])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 8C90BC80099;
        Tue, 22 Mar 2022 17:21:29 +0100 (CET)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     dmitry.torokhov@gmail.com, tiwai@suse.de, mpdesouza@suse.com,
        arnd@arndb.de, hdegoede@redhat.com, samuel@cavoj.net,
        wse@tuxedocomputers.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] input/i8042: Rework quirk tables
Date:   Tue, 22 Mar 2022 17:21:21 +0100
Message-Id: <20220322162125.59838-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following a suggestion by Hans de Goede, I reworked the quirk tables in the
i8042 driver. Now all quirks only use a single table. This makes quirks
easier to search by device and reduces code line count and memory usage.

The frist patch is minor housekeeping new to this 4th revision

The 2nd patch merges the tables together.

The 3rd patch add optional debug output to see which quirks get applied.

The 4th patch adds a list of Clevo devices that need multiple quirks.
With the reworked table they don't need to be inserted multiple times now,
which was required in v1 and v2 of this patch.

I also included the extra quirk for the Clevo NS7xMU, which was a separate
patch before.

The added Clevo devices are now only identified by their board name as this
is the only somewhat reliable string that might not be changed by resellers.


