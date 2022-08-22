Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E1359CA4A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbiHVUnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbiHVUnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:43:19 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79B11127
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:43:17 -0700 (PDT)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5A09640AFF
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 20:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1661200994;
        bh=Qts39Mg4jjDHGuttlbfQ5Yrda0JS+j1aF+odznqo+PU=;
        h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
         Content-Type:Date:Message-ID;
        b=NTdn4jJT/QXpmHtqppp404rUTQdsmvO+1Bpm/A+wVL5T6Yje9fhE27a4UySCGHiin
         7MdYbD1W+pz7p/N6B9JGM9JXyi7GitwHqIoVtNjFuPAc5IEwFxjezIxmeVkmwhTjRF
         IeJS+HEn5hVRk4MVNqZZfUTRfVz9Fy7vKRYtn+KnsD1MVUnECFR66VzowCB9RBS7UO
         dS01HjT1GWrUui8EaBnVaIvNjUvlaE/yardnzDmaOwYessaY35oGPHsOEgl0sZEpBy
         /3yhXDyi9ydq2Di42t4tZJiJMg/2GHhEUcLrE+Nw+Onq7jLmxQ+G35Hsno1fwmluA+
         H93A6AAPAB9SQ==
Received: by mail-pg1-f199.google.com with SMTP id j3-20020a634a43000000b00429f2cb4a43so5178807pgl.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=Qts39Mg4jjDHGuttlbfQ5Yrda0JS+j1aF+odznqo+PU=;
        b=HPXnHceMb1ny23cH8vXUSLVt+6mWHYRQw8rNrsuqq6goe59B5kkRWYtnqaanGGsE12
         nim/IM7tKFTdmxcNDSX0l9winmttjFkCHX+63fzH0+aaSW0SvhRe283pfg/J9TNWcvkf
         3Bhry3u2l1EbEOvy4J76cGQ9kwaSjl/uq2WdDWYDdSC7tQz+2HAGXNrvhBCuTxfFjEMU
         aOq6fJsWAHYC/hIq0xuLmkllP9MJ+xxGioT+8J/nmdZ4LpguLK8RA2jU9HJRD2UEVVE2
         5Ho8GurYS5WMIP6sXVeZXa03HCISQlNLB1SB6fYyemIhZyBXdhtqkS9TuPlfbrVEvZNQ
         yULA==
X-Gm-Message-State: ACgBeo2Y+v+gTLbq44PZXZR9VifQdBAezcoMdIkJAgEpYXoNZ/27TmdW
        xewaPHD6nGKJ9eRdWAMmO5YsNsj+XVSwjLrwfzjsXzgAE04XUn4Ugo+YC9jiA4QnFYMyz9t4SkG
        e4qLTElMJ4VNxz+sBXvYCLs0oN+0FWrnI/qvpQoK5bg==
X-Received: by 2002:a17:90b:1c89:b0:1f8:42dd:5ebb with SMTP id oo9-20020a17090b1c8900b001f842dd5ebbmr126549pjb.246.1661200991944;
        Mon, 22 Aug 2022 13:43:11 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7Xc8GhE3ET/KjinL8c28unOQOQ+RkAmMqYBYSlQXPa9/OlFIUA4aTUAsurIzrqikMtKTfQXg==
X-Received: by 2002:a17:90b:1c89:b0:1f8:42dd:5ebb with SMTP id oo9-20020a17090b1c8900b001f842dd5ebbmr126526pjb.246.1661200991616;
        Mon, 22 Aug 2022 13:43:11 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.157])
        by smtp.gmail.com with ESMTPSA id l7-20020a63ba47000000b0040caab35e5bsm4628767pgu.89.2022.08.22.13.43.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Aug 2022 13:43:11 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
        id DD0226118F; Mon, 22 Aug 2022 13:43:10 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
        by famine.localdomain (Postfix) with ESMTP id D6DC49FA79;
        Mon, 22 Aug 2022 13:43:10 -0700 (PDT)
From:   Jay Vosburgh <jay.vosburgh@canonical.com>
To:     Sun Shouxin <sunshouxin@chinatelecom.cn>
cc:     vfalico@gmail.com, andy@greyhouse.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        huyd12@chinatelecom.cn
Subject: Re: [PATCH] bonding: Remove unnecessary check
In-reply-to: <20220822103130.3466-1-sunshouxin@chinatelecom.cn>
References: <20220822103130.3466-1-sunshouxin@chinatelecom.cn>
Comments: In-reply-to Sun Shouxin <sunshouxin@chinatelecom.cn>
   message dated "Mon, 22 Aug 2022 03:31:29 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14666.1661200990.1@famine>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 22 Aug 2022 13:43:10 -0700
Message-ID: <14667.1661200990@famine>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sun Shouxin <sunshouxin@chinatelecom.cn> wrote:

>This check is not necessary since the commit d5410ac7b0ba
>("net:bonding:support balance-alb interface with vlan to bridge").

	Please explain why this assertion is correct in your commit
message.

	Also, I presume this is for net-next; please specify in the
PATCH block of the Subject.

	-J

>Suggested-by: Hu Yadi <huyd12@chinatelecom.cn>
>Signed-off-by: Sun Shouxin <sunshouxin@chinatelecom.cn>
>---
> drivers/net/bonding/bond_main.c | 13 -------------
> 1 file changed, 13 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 50e60843020c..6b0f0ce9b9a1 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -1578,19 +1578,6 @@ static rx_handler_result_t bond_handle_frame(struc=
t sk_buff **pskb)
> =

> 	skb->dev =3D bond->dev;
> =

>-	if (BOND_MODE(bond) =3D=3D BOND_MODE_ALB &&
>-	    netif_is_bridge_port(bond->dev) &&
>-	    skb->pkt_type =3D=3D PACKET_HOST) {
>-
>-		if (unlikely(skb_cow_head(skb,
>-					  skb->data - skb_mac_header(skb)))) {
>-			kfree_skb(skb);
>-			return RX_HANDLER_CONSUMED;
>-		}
>-		bond_hw_addr_copy(eth_hdr(skb)->h_dest, bond->dev->dev_addr,
>-				  bond->dev->addr_len);
>-	}
>-
> 	return ret;
> }
> =

>-- =

>2.27.0
>

---
	-Jay Vosburgh, jay.vosburgh@canonical.com
