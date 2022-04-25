Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD4950D6A9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 03:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240203AbiDYBm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 21:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240190AbiDYBmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 21:42:18 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B5B5FBE;
        Sun, 24 Apr 2022 18:39:15 -0700 (PDT)
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id AE4004C0FE2;
        Mon, 25 Apr 2022 01:39:14 +0000 (UTC)
Received: from pdx1-sub0-mail-a217.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 261FC4C0CA5;
        Mon, 25 Apr 2022 01:39:14 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1650850754; a=rsa-sha256;
        cv=none;
        b=Bq82plS4TDd3g6OAx20e/9V6BrOyX8WOGwGT1AXqmbjxdC68LucFuiMJumFwO+qufdguYV
        CU7DUddGGtmvjXlHAOilGPI79zSqYDHZyMXFoXZAFBW8hvF//RD2rbDxWIs82abzplMlXd
        JLEmJTX8v2GJtZC4w34ci4mj4gFkjHA6rCDdy7widHONc9rawToJvyni6J0q66Kmax9glK
        MH3R/NzneK0BK9lhRu8c/2m0Gz4em0TTty/cdIVV2ztZktagAckMMW4hO5iaQniklffIX1
        6kkkYSIZrp7IzK8YqYeDgsBhFBwBloZnhw3E1wcY5AjsuuEw9Zg53P993GBpLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1650850754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=YJkN6I+2UezSB5AlqbP1q9iQB8jSIsoFmEkivaJPKhk=;
        b=OvOnUF9lQKdt4koa81twpkISpe4V18nF9u6IQJFqs4bx7cwgCjrVJMzJ7kUPGRkm9pwr2T
        hnEHx9zMhw9LuJ4kyO9yD4Q5n0Q2ICEwPSJNHqzEurOHBa/3kUiNbCyfOPB8IVEtY2AIgg
        o+qFJy+/zyEA3mCtdcS27ilkRqOruCwuWb457HDBxM6VswIBeuDOzZtaew344A/EEIrh7A
        acs55LFZyeJTmrYfSi29wNCjktiKD5MWWAK6OLkTcZSYzeiEK75orT35IhdRUJ0TZiRfz5
        YBqyxKVBNhLTJEgeHuPUkDE8wmEQN/lIpY2qRcBH/+voMKDwgsNkK2PeIrJkeA==
ARC-Authentication-Results: i=1;
        rspamd-67b64f579b-wtxf7;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Glossy-Scare: 6bc0bd532b1ae71e_1650850754519_4165476151
X-MC-Loop-Signature: 1650850754519:3356547036
X-MC-Ingress-Time: 1650850754519
Received: from pdx1-sub0-mail-a217.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.96.96.30 (trex/6.7.1);
        Mon, 25 Apr 2022 01:39:14 +0000
Received: from fedora (unknown [69.12.38.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a217.dreamhost.com (Postfix) with ESMTPSA id 4Kmnjs1Tk9z2n;
        Sun, 24 Apr 2022 18:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1650850753;
        bh=YJkN6I+2UezSB5AlqbP1q9iQB8jSIsoFmEkivaJPKhk=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=WnEJFu6/MzbZcl5zbHgIJAQYh4d/mxqDSSgfptotRbtTq0Q7wrdZ3u8jjpSmdFb6w
         fus8ph9nH64ag6PvAbAOBt65GzINQamdRW0UNPkVnYjYmShFgvFyzvpBmXqbvIv+u3
         OR/TvGva5QNeAw4ZAKemtV1wLQLTKdaFEPEVASMHZbIsOJ/qmveNCGlEoXnmFs6vwN
         h6xyRtYN3LUaC5bp52f+7rt3Bn1pA5rdkNvw/C8pwToV04PvVABTuMlLIRtnZjq416
         MwtOyzhkGY4Uut0b6F95xKUZB254NNibBrCzw5gWuhnKgxao5bZRX4ieVuszHYebRY
         Yklne7LTHMTAQ==
Date:   Sun, 24 Apr 2022 21:39:11 -0400
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 2/4] staging: media: zoran: setup videocodec header for
 debugging macros
Message-ID: <YmX7v18bPJ7uJ4Oi@fedora>
References: <20220425012640.440717-1-ian@linux.cowan.aero>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425012640.440717-1-ian@linux.cowan.aero>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds inline functions in the videocodec header file to convert the
videocodec and videocodec_master structs to their respective contained
zoran struct. This will be used to pass the zoran struct to the
zrdev_XXX() macros defined in the zoran header.

In the zoran header, the new include is added to ensure all variables
can be completely defined with the zoran and videocodec includes where
they are located.

> Slight modification made here so the patch will apply properly from
> the modified patch 1 - sorry about that.

Signed-off-by: Ian Cowan <ian@linux.cowan.aero>
---
 drivers/staging/media/zoran/videocodec.h | 15 +++++++++++++++
 drivers/staging/media/zoran/zoran.h      |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/staging/media/zoran/videocodec.h b/drivers/staging/media/zoran/videocodec.h
index 9dea348fee40..5e6057edd339 100644
--- a/drivers/staging/media/zoran/videocodec.h
+++ b/drivers/staging/media/zoran/videocodec.h
@@ -307,4 +307,19 @@ extern int videocodec_unregister(const struct videocodec *);
 
 int videocodec_debugfs_show(struct seq_file *m);
 
+#include "zoran.h"
+static inline struct zoran *videocodec_master_to_zoran(struct videocodec_master *master)
+{
+	struct zoran *zr = master->data;
+
+	return zr;
+}
+
+static inline struct zoran *videocodec_to_zoran(struct videocodec *codec)
+{
+	struct videocodec_master *master = codec->master_data;
+
+	return videocodec_master_to_zoran(master);
+}
+
 #endif				/*ifndef __LINUX_VIDEOCODEC_H */
diff --git a/drivers/staging/media/zoran/zoran.h b/drivers/staging/media/zoran/zoran.h
index 42b86356c022..674658154e88 100644
--- a/drivers/staging/media/zoran/zoran.h
+++ b/drivers/staging/media/zoran/zoran.h
@@ -20,6 +20,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/pci.h>
+#include <linux/i2c-algo-bit.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-ctrls.h>
 #include <media/videobuf2-core.h>
-- 
2.35.1

