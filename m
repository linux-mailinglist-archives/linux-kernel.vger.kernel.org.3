Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDE1584DC1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 11:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbiG2JDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 05:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiG2JDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 05:03:22 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322A81FCC7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 02:03:21 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id w17-20020a17090a8a1100b001f326c73df6so3014353pjn.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 02:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0F6WjsWKz9KObz/7ifzY4OgIObfiPVIJwTipmY0aiBw=;
        b=qmwdmJu0l8LfCg+XkzBuR7nx6MbzD26HflPamW2qkwNLU7BYiC6T5XjBDiEy8cejfM
         xuaMQNAcGU15/ccma9ZQx7GT94YcpBcuRD7h9V4qL11ZFIj84Ks9O0+3sl3nS1RzoOY8
         gbHoPomjbTRpJWHSRu2OVb6f3pGiPr9yzVeaJ5h9YxNwPzxFvyX2H7ZcNTCjXlCj1t52
         +w5vJ2bZP9cGkWFz+Oe+3R2I+jYPNl2koSj33AQwZGLLOjHher4xTpfK7oBNwU2mzsQ3
         FONb6LxZf64oYDzOeEfMXpIH0TYEFm5L7cRJkXQwIcfPww1fgHZ7iDDC7PEyLfafAMr4
         fa7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=0F6WjsWKz9KObz/7ifzY4OgIObfiPVIJwTipmY0aiBw=;
        b=B+79M5VntO7ZlBCS0Sv5YhsVJMOoJFIHFBiDVMkSoaI22hT5AWJ030CTZW3j9CnO/w
         sOZ1hFdL8YOIi574eSkpzlLUTkX3OCvpl/3qYx0WtrTJhWmK7ejbXHen9rk6m0DH6Xhq
         X9VX1aAUsGS+VkeUZNsE3hPAanUll2Lbl0VB/zxvKnD3uvJ0g44VwV9onhLSnGg1TlOq
         uBa/6LXQarhFtQgHNrMH9Dj5Ofqa4pWWk/vcQoCvy9rhf6wF6NTB68F03Ae8GZclh05v
         +fpxvWS0CMBVkc/svzw7/SwUCoAQzaS8StWOr2XPKP0/DKj4Y8MgG5KSy5oFrjlxN0dB
         n25A==
X-Gm-Message-State: ACgBeo1ONtDxvFigE/3RdnVom1kv9PsBcRb/LXhmlpUgjznqV1ML5fl3
        JenbaPKS2hVzEw74l53aHdCs4PKcQlETfw==
X-Google-Smtp-Source: AA6agR6I1/hV9CG/nx+NnCYEp8NT8GLsj11UQ5RFHqDjOKi3j8In55xP/LZtfuOZ02whpTIVY5Rxtw==
X-Received: by 2002:a17:902:ab90:b0:16d:c280:3c27 with SMTP id f16-20020a170902ab9000b0016dc2803c27mr2871998plr.58.1659085400632;
        Fri, 29 Jul 2022 02:03:20 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id x66-20020a628645000000b0052ab3039c4esm2319740pfd.8.2022.07.29.02.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 02:03:20 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH] irqdomain: do not shadow nr_irqs global definition
Date:   Fri, 29 Jul 2022 18:03:07 +0900
Message-Id: <20220729090307.57905-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/irqnr.h declares a global variable named `nr_irqs'.

The inline function irq_domain_alloc_irqs() from
include/linux/irqdomain.h also uses the same name and thus shadow the
global declaration. Rename the function argument from `nr_irqs' to
`nbr_irqs'.

This patch silences below -Wshadow warning:

| In file included from ./arch/x86/include/asm/irqdomain.h:5,
|                  from ./arch/x86/include/asm/msi.h:5,
|                  from ./include/linux/msi.h:23,
|                  from ./include/linux/kvm_host.h:19,
|                  from arch/x86/kernel/../kvm/vmx/vmx.h:5,
|                  from arch/x86/kernel/asm-offsets.c:22:
| ./include/linux/irqdomain.h: In function 'irq_domain_alloc_irqs':
| ./include/linux/irqdomain.h:514:38: warning: declaration of 'nr_irqs' shadows a global declaration [-Wshadow]
|   514 |                         unsigned int nr_irqs, int node, void *arg)
|       |                         ~~~~~~~~~~~~~^~~~~~~
| In file included from ./include/linux/interrupt.h:10,
|                  from ./include/linux/kernel_stat.h:9,
|                  from ./include/linux/cgroup.h:26,
|                  from ./include/linux/memcontrol.h:13,
|                  from ./include/linux/swap.h:9,
|                  from ./include/linux/suspend.h:5,
|                  from arch/x86/kernel/asm-offsets.c:13:
| ./include/linux/irqnr.h:8:12: note: shadowed declaration is here
|     8 | extern int nr_irqs;
|       |            ^~~~~~~

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 include/linux/irqdomain.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 00d577f90883..76949bb029b0 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -511,9 +511,9 @@ extern int irq_domain_activate_irq(struct irq_data *irq_data, bool early);
 extern void irq_domain_deactivate_irq(struct irq_data *irq_data);
 
 static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
-			unsigned int nr_irqs, int node, void *arg)
+					unsigned int nbr_irqs, int node, void *arg)
 {
-	return __irq_domain_alloc_irqs(domain, -1, nr_irqs, node, arg, false,
+	return __irq_domain_alloc_irqs(domain, -1, nbr_irqs, node, arg, false,
 				       NULL);
 }
 
-- 
2.35.1

