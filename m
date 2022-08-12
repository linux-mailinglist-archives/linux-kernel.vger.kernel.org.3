Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38073590ABC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 05:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbiHLDaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 23:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHLD34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 23:29:56 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DB3A3D57
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 20:29:55 -0700 (PDT)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4DCB03F13F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1660274993;
        bh=lY1KV5n+d5ZpFbygaAz+OcIJE9BFkKwpGeAuYVt7yJc=;
        h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
         Content-Type:Date:Message-ID;
        b=eVvfFj3129ffd6gqcMhTohCf98/mir1bng2QHFXsFeE2EEa4Bjr+8gJTotn76t2Cn
         nkgCRy8PUv3swS8MBQsMily1StkQAfs1/RIbdyodOIY1wRTr8bo855rGi/jgY5qAPt
         FXeR/socOCnAUtdhUhp9vmlwRystNsAXhLfdb58sPYcExCMQjO2c4wZNCdNf/KvM7H
         SqPnWJ1R2FxrF5RWxs7iLIV1quzYCmjcWWUeE/Kwzg7LFhH8OUG9C2HipKHughHUD9
         KHDhFy7GzYmHJoKEcw0fvemUmor2B67oUtY650/45W1fwOvrh1VGijiOwTeyOULGlg
         sQ9UcFSCYy6Lw==
Received: by mail-pj1-f71.google.com with SMTP id jx17-20020a17090b46d100b001f33b230098so9359697pjb.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 20:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=lY1KV5n+d5ZpFbygaAz+OcIJE9BFkKwpGeAuYVt7yJc=;
        b=1DU/KIKGk712dMmFAkJIHEyCVo9i5ROnSr5rZliPmeq8Iizi1U3nHaMAAl5Ei44noK
         q7TUijylQfO3Gwci2UbquZguO1kKlBkQjQPSCv7mGQ7qhRe3sIfVeGZ2L2rml0t9jGGw
         EiSexm/1pxPgMc7uQR4rfEs3P4+GLOmJ2Tysd9vPI8iciI6xN1AaekaTYJpJJoZ3nftt
         fRUq7ckLscsC1zWtrmwUum4Fs33aZb453CDilMhsTGjfjfoYypEoHuk9r0P8o75KlPhu
         fTbepzyPnYdgU84pWz9z2/9t9KN6AYQBU4SLGKqJuKoOVUP17ynNF2INUQnBCsURUik0
         z2UQ==
X-Gm-Message-State: ACgBeo3Hd9NGPhBG68bvLspLrlYQEK7AnSfFYYEGiF7hX1Ab7WVKxGTw
        PlFngEmRGDOBCwE4f1w0GKAK+8hwa7IReiRdcoiSi1JYH1bghhZeeENAKLP0VgHyd26fNnh1FmR
        J2VeTQGmoJydJkrbABLBdEANxsdcNSWwxXCx/INeoDw==
X-Received: by 2002:a17:902:8b86:b0:170:d739:9a35 with SMTP id ay6-20020a1709028b8600b00170d7399a35mr2118810plb.35.1660274989364;
        Thu, 11 Aug 2022 20:29:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5ZcN5tzJ9ceO68Lj9niDNDPtdHQUSTEps4e4+GC16mdOfmTiQNYrKo2eCELu0bCfYN2VYGmQ==
X-Received: by 2002:a17:902:8b86:b0:170:d739:9a35 with SMTP id ay6-20020a1709028b8600b00170d7399a35mr2118799plb.35.1660274989125;
        Thu, 11 Aug 2022 20:29:49 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.157])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902758400b0016d62ba5665sm434360pll.254.2022.08.11.20.29.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Aug 2022 20:29:48 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
        id 3FFA96119B; Thu, 11 Aug 2022 20:29:48 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
        by famine.localdomain (Postfix) with ESMTP id 391939FA79;
        Thu, 11 Aug 2022 20:29:48 -0700 (PDT)
From:   Jay Vosburgh <jay.vosburgh@canonical.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
cc:     vfalico@gmail.com, andy@greyhouse.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] bonding: return -ENOMEM on rlb_initialize() allocation failure
In-reply-to: <20220812032059.64572-1-jiapeng.chong@linux.alibaba.com>
References: <20220812032059.64572-1-jiapeng.chong@linux.alibaba.com>
Comments: In-reply-to Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
   message dated "Fri, 12 Aug 2022 11:20:59 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1826.1660274988.1@famine>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 11 Aug 2022 20:29:48 -0700
Message-ID: <1827.1660274988@famine>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

>drivers/net/bonding/bond_alb.c:861 rlb_initialize() warn: returning -1 in=
stead of -ENOMEM is sloppy.

	I'll disagree; the return value is only ever tested for being
non-zero.

	-J

>Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D1896
>Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>---
> drivers/net/bonding/bond_alb.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_al=
b.c
>index 60cb9a0225aa..96cb4404b3c7 100644
>--- a/drivers/net/bonding/bond_alb.c
>+++ b/drivers/net/bonding/bond_alb.c
>@@ -858,7 +858,7 @@ static int rlb_initialize(struct bonding *bond)
> =

> 	new_hashtbl =3D kmalloc(size, GFP_KERNEL);
> 	if (!new_hashtbl)
>-		return -1;
>+		return -ENOMEM;
> =

> 	spin_lock_bh(&bond->mode_lock);
> =

>-- =

>2.20.1.7.g153144c
>

---
	-Jay Vosburgh, jay.vosburgh@canonical.com
