Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2734CED36
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 19:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbiCFSby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 13:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiCFSbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 13:31:53 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCCA21829
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 10:31:00 -0800 (PST)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1F78D3F222
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 18:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646591454;
        bh=TA8KjR6S17gXFGKtkIb2JMGZEDPFAMBrDvNRC4af/Ko=;
        h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
         Content-Type:Date:Message-ID;
        b=uCQu9DwxFebbTlhXAnenuN23+NppyFNvBQfZ87ZVeRHQSdo59Wcl0W9ocFiMaJ+bl
         ymIY7XrmM+zJVHcx28YwKxtWyKuQl80EN1+z+WoVupt0oxkSHww6CDKfnw8XJ9H1E5
         93Yq/xILuT7vh00BXnUoqQ0dSUmKe5MVSzJnrmUv0Z3nl5E3YhuE8DEc2j8cGSPorD
         R3hnsUQXxAAvnrk7UXLZSXRuydPrgFyud/qwrjrPAgfr9qnkuhu4Apy7ImcDqXt4I5
         y/PyOMcvpwu2hZsI0OoKE6vukn146RWzXMKV8tMFeYCWDTs3/Nfo+4YjysVT+WEh/s
         tRFKiyBVdY3Fg==
Received: by mail-pg1-f197.google.com with SMTP id u4-20020a63b544000000b0037c62d8b0ecso4948103pgo.13
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 10:30:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
         :comments:mime-version:content-id:content-transfer-encoding:date
         :message-id;
        bh=TA8KjR6S17gXFGKtkIb2JMGZEDPFAMBrDvNRC4af/Ko=;
        b=NxAaGDLc0KnusOw7SNY6pfb46pIseDQ4zMg65LcQNFqahqCMs0qrRDF1UiAj+NjkG0
         TXax64AZMsvrNnYCUYFuYjiHYaGyrm59xpUqOyaWXalGH60eVBsdvPMkP97IJlL1Pv1Z
         hhS7bxEDIS1MBrnDcHN7bXzzQ+rKGBsTfZBtGE+0xPwRJ0nAtpwRP40cUt8utHyj/D6R
         4M96ZTXf5uaKBTIFkz4cI490Xp3SnF9Fmk8K3JmnWdDHO0oRa+FoHivHUmhdW3ifX8o3
         fYXmOa4svuHyZMZjy+/TCBtrmQBLYZwBGPH8fn9RxigUZVsFdKk325aLAhu9POGfEOxz
         8UuA==
X-Gm-Message-State: AOAM532hErwAG1IojtJg/mJOtw6jvvkHQHuhTLaNo7MnKOQz2xAqfneK
        SuFozIuWingRcXewPx6dWj4rE7f4yRuFPy3zJ9ST8zVcRR1F2DyibkhljCrgoIOPel1x5q3VPbi
        7lU2SCfJv7eUXQAYpEmKO207xgXbrsyeHKZMrKBC4jA==
X-Received: by 2002:a63:1651:0:b0:342:b566:57c4 with SMTP id 17-20020a631651000000b00342b56657c4mr6944388pgw.258.1646591452551;
        Sun, 06 Mar 2022 10:30:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQi8U+TTTetLTi4EWqCjwCcAlhxeEPHIymhU/wDHDR2O7G9m5BX8Y+01rkdeWUn6VVZa4lUg==
X-Received: by 2002:a63:1651:0:b0:342:b566:57c4 with SMTP id 17-20020a631651000000b00342b56657c4mr6944366pgw.258.1646591452194;
        Sun, 06 Mar 2022 10:30:52 -0800 (PST)
Received: from famine.localdomain ([50.125.80.157])
        by smtp.gmail.com with ESMTPSA id t8-20020a6549c8000000b00372eb3a7fb3sm9566731pgs.92.2022.03.06.10.30.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Mar 2022 10:30:51 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
        id A8A2960DD1; Sun,  6 Mar 2022 10:30:50 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
        by famine.localdomain (Postfix) with ESMTP id A0E109FAC3;
        Sun,  6 Mar 2022 10:30:50 -0800 (PST)
From:   Jay Vosburgh <jay.vosburgh@canonical.com>
To:     Lianjie Zhang <zhanglianjie@uniontech.com>
cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Veaceslav Falico <vfalico@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bonding: helper macro __ATTR_RO to make code more clear
In-reply-to: <20220306082808.85844-1-zhanglianjie@uniontech.com>
References: <20220306082808.85844-1-zhanglianjie@uniontech.com>
Comments: In-reply-to Lianjie Zhang <zhanglianjie@uniontech.com>
   message dated "Sun, 06 Mar 2022 16:28:08 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24907.1646591450.1@famine>
Content-Transfer-Encoding: quoted-printable
Date:   Sun, 06 Mar 2022 10:30:50 -0800
Message-ID: <24908.1646591450@famine>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lianjie Zhang <zhanglianjie@uniontech.com> wrote:

>Signed-off-by: Lianjie Zhang <zhanglianjie@uniontech.com>

	I'm ok with the change, but this needs a sentence or two in the
commit log message to explain what's going on, so that future readers of
the log don't have to read the diff to figure out why this change makes
sense.

	-J

>diff --git a/drivers/net/bonding/bond_sysfs_slave.c b/drivers/net/bonding=
/bond_sysfs_slave.c
>index 6a6cdd0bb258..69b0a3751dff 100644
>--- a/drivers/net/bonding/bond_sysfs_slave.c
>+++ b/drivers/net/bonding/bond_sysfs_slave.c
>@@ -15,14 +15,8 @@ struct slave_attribute {
> 	ssize_t (*show)(struct slave *, char *);
> };
>
>-#define SLAVE_ATTR(_name, _mode, _show)				\
>-const struct slave_attribute slave_attr_##_name =3D {		\
>-	.attr =3D {.name =3D __stringify(_name),			\
>-		 .mode =3D _mode },				\
>-	.show	=3D _show,					\
>-};
> #define SLAVE_ATTR_RO(_name)					\
>-	SLAVE_ATTR(_name, 0444, _name##_show)
>+const struct slave_attribute slave_attr_##_name =3D __ATTR_RO(_name)
>
> static ssize_t state_show(struct slave *slave, char *buf)
> {
>--
>2.20.1

---
	-Jay Vosburgh, jay.vosburgh@canonical.com
