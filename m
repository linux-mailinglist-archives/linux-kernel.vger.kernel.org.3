Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81449543BC2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 20:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbiFHSva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 14:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiFHSv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 14:51:28 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE9E3CD2AC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 11:51:27 -0700 (PDT)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3757F3F11D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 18:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1654714285;
        bh=amIVXY7ikJGtMrtlzCqfcbWeYSbhJ0XADNsYuBoNUxM=;
        h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
         Content-Type:Date:Message-ID;
        b=kUTuUh6u9SQyrKXzxHHn8/dfI72q4G+d3tcI8WG2XBdH5jSzM7ulCQLnCwerZTG64
         AB0ida5WAZqySrHhgazzAwR7bANXg+qXIxTsy8J0Fi4uKSm7mjQvKe+Nq8GQZvxQUG
         IuILTQoBvIu1ijrlLzB1R0QN8Xe4ayzIdrfc+47D/hQFPVM5UTv0P+1+cc7vas4BS4
         YaboS9AfeYomljJazFrXz4+h0DWnkRyxGh0BOGT+xDyjd861WEOX7UotTCQOgbdrsw
         JHwYqEA8yqAWs0Whfo69TNCi0HufTGdu5cac7+9x/1y+y8v3/9CpqUUC6U6Rc7GTjH
         Dk++M8UU2+BNQ==
Received: by mail-pg1-f197.google.com with SMTP id 78-20020a630051000000b003fe25580679so1868681pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 11:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
         :comments:mime-version:content-id:content-transfer-encoding:date
         :message-id;
        bh=amIVXY7ikJGtMrtlzCqfcbWeYSbhJ0XADNsYuBoNUxM=;
        b=BTluUFEdySrvVgQOakb/WeK/DMqouP6clYseSO1yhh0s5jaCloa1gqsQvKcWJxp2iY
         RpUhmA2DocpqUFPGnWJS53hJkO41zLY6rRKB095ZpNnZ2hHANpf+fjE+WVSXSDT2cDR8
         Sb9t2cLWyG1rgtSQpnF8N/6l4NkQfbVtfRkpXiTXMc8q7zqrTHhtELXkNh9OxNhxNqL+
         bFu9neTDL8KJYlQzjcdZ6B/jCu5LlDOKOWbwB9rl82gXE1Oe+noJ7nFRdOASlezWQ3WP
         SVkajj9o7zU1oP6Y0r43beenGizBCR5aygepT9RPqrQTwuMCO+XQ8k7eCml1q9Myf/Ku
         W6fw==
X-Gm-Message-State: AOAM530KK7S0ffuPnxzq77K4o+5hANoPjALypEolJALiQ7JHmzqtA5Sw
        p/GFt9mLVqCpt02a8LMq9FaJRu1x8/kTV/DOAwwD3/5+NQ/rTm8b9Poo3Xh9Lv7Y/m/matm2na0
        xpNtt8sJkgH7G+hAQewfb5dLlnZ5SnE6wa5TN43tzMA==
X-Received: by 2002:a05:6a00:8c5:b0:510:6eae:6fa1 with SMTP id s5-20020a056a0008c500b005106eae6fa1mr35377286pfu.12.1654714283963;
        Wed, 08 Jun 2022 11:51:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVwWJq/PBME8kj71zFKppLqLlW8XEtTEpi5EROmQmm0rAB4Jl/KR7Egz0D8qlmi9LSDHl6LQ==
X-Received: by 2002:a05:6a00:8c5:b0:510:6eae:6fa1 with SMTP id s5-20020a056a0008c500b005106eae6fa1mr35377265pfu.12.1654714283722;
        Wed, 08 Jun 2022 11:51:23 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.157])
        by smtp.gmail.com with ESMTPSA id f70-20020a623849000000b0050dc762817esm15335839pfa.88.2022.06.08.11.51.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jun 2022 11:51:23 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
        id D68C962730; Wed,  8 Jun 2022 11:51:22 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
        by famine.localdomain (Postfix) with ESMTP id CF147A0B36;
        Wed,  8 Jun 2022 11:51:22 -0700 (PDT)
From:   Jay Vosburgh <jay.vosburgh@canonical.com>
To:     Jonathan Toppins <jtoppins@redhat.com>
cc:     netdev@vger.kernel.org, Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [net-next v2 2/2] bonding: cleanup bond_create
In-reply-to: <03db585475d164343991f90b268d2d08fa42afb6.1654711315.git.jtoppins@redhat.com>
References: <cover.1654711315.git.jtoppins@redhat.com> <03db585475d164343991f90b268d2d08fa42afb6.1654711315.git.jtoppins@redhat.com>
Comments: In-reply-to Jonathan Toppins <jtoppins@redhat.com>
   message dated "Wed, 08 Jun 2022 14:14:57 -0400."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12961.1654714282.1@famine>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 08 Jun 2022 11:51:22 -0700
Message-ID: <12962.1654714282@famine>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Toppins <jtoppins@redhat.com> wrote:

>Setting RLB_NULL_INDEX is not needed as this is done in bond_alb_initiali=
ze
>which is called by bond_open.
>
>Also reduce the number of rtnl_unlock calls by just using the standard
>goto cleanup path.
>
>Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>

Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>


>---
> drivers/net/bonding/bond_main.c | 24 ++++++------------------
> 1 file changed, 6 insertions(+), 18 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index f85372adf042..3d427183ec8e 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -6218,45 +6218,33 @@ int bond_create(struct net *net, const char *name=
)
> {
> 	struct net_device *bond_dev;
> 	struct bonding *bond;
>-	struct alb_bond_info *bond_info;
>-	int res;
>+	int res =3D -ENOMEM;
> =

> 	rtnl_lock();
> =

> 	bond_dev =3D alloc_netdev_mq(sizeof(struct bonding),
> 				   name ? name : "bond%d", NET_NAME_UNKNOWN,
> 				   bond_setup, tx_queues);
>-	if (!bond_dev) {
>-		pr_err("%s: eek! can't alloc netdev!\n", name);
>-		rtnl_unlock();
>-		return -ENOMEM;
>-	}
>+	if (!bond_dev)
>+		goto out;
> =

>-	/*
>-	 * Initialize rx_hashtbl_used_head to RLB_NULL_INDEX.
>-	 * It is set to 0 by default which is wrong.
>-	 */
> 	bond =3D netdev_priv(bond_dev);
>-	bond_info =3D &(BOND_ALB_INFO(bond));
>-	bond_info->rx_hashtbl_used_head =3D RLB_NULL_INDEX;
>-
> 	dev_net_set(bond_dev, net);
> 	bond_dev->rtnl_link_ops =3D &bond_link_ops;
> =

> 	res =3D register_netdevice(bond_dev);
> 	if (res < 0) {
> 		free_netdev(bond_dev);
>-		rtnl_unlock();
>-
>-		return res;
>+		goto out;
> 	}
> =

> 	netif_carrier_off(bond_dev);
> =

> 	bond_work_init_all(bond);
> =

>+out:
> 	rtnl_unlock();
>-	return 0;
>+	return res;
> }
> =

> static int __net_init bond_net_init(struct net *net)
>-- =

>2.27.0
>
