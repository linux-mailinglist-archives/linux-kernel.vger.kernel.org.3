Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763DF4D1E1E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348390AbiCHRGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346685AbiCHRGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:06:35 -0500
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFE452B18;
        Tue,  8 Mar 2022 09:05:36 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id C7773C8008A;
        Tue,  8 Mar 2022 18:05:34 +0100 (CET)
Authentication-Results: srv6.fidu.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=tuxedocomputers.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        tuxedocomputers.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from; s=
        default; t=1646759134; x=1648573535; bh=OA0ZQjt3Q8Ik0rClfyLh5tXC
        L350HchRnX2lr5OmMB4=; b=h+xg8xPczvpohUE02gmTVbQjJ/dw3GfSG0hN7nA2
        IVZpSaZ05TN0GLqeCCXTByU0j6SvojDnTo/+mZi2xp+uGYdS7Z/1tdzpLYPwY6cs
        AV3EAPbObC//DUHY3pf5zdjBXuVGk1uYSgL86jQfbRCRIyFqpb21f7b/mneZHOry
        FBk=
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id Vx7izqSMtrB0; Tue,  8 Mar 2022 18:05:34 +0100 (CET)
Received: from wsembach-tuxedo.fritz.box (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 43C37C80062;
        Tue,  8 Mar 2022 18:05:34 +0100 (CET)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     dmitry.torokhov@gmail.com, tiwai@suse.de, mpdesouza@suse.com,
        arnd@arndb.de, hdegoede@redhat.com, samuel@cavoj.net,
        wse@tuxedocomputers.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] Input/i8042: Merge quirk tables and add Clevo devices
Date:   Tue,  8 Mar 2022 18:05:20 +0100
Message-Id: <20220308170523.783284-1-wse@tuxedocomputers.com>
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

The 2nd patch adds new debug output to make it easy to see if a specific
quirk got applied or not.

The third patch adds a list of Clevo devices that need multiple quirks.
With the reworked table they don't need to be inserted multiple times now,
which was required in v1 and v2 of this patch.

I also included the extra quirk for the Clevo NS7xMU, which was a separate
patch before.


