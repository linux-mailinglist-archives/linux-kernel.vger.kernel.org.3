Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3237357A128
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238131AbiGSOTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbiGSOS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:18:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADA37F52E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:55:51 -0700 (PDT)
Date:   Tue, 19 Jul 2022 13:55:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658238949;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XCsyc41ZvNp9njn6uqBiyVKAtQUMD4aN+KF64YaG1r0=;
        b=YPdHyUmK5vyVXAw657qq8kazjqN4Yy5XiVlPrYAikcV6WP09ViYoQ0MlYTg6tk9uBMif5P
        sNcX9ZPul80F6/3T7fU5vqmU4TiS4gCSHAANKD+/AiQWgUr37w+1ht0/k9miwu6N9r374l
        0MPVLAnkh8c6Co6FGW5BTp3DdBYGO4/R6JBd2SpdaRlLMLUn1hFUjEBnLPeRF+xMZiymQk
        i5mCYYQjkvQBX2jEUUesk8lQuoKfDbuF0N5oASFfjJOlyAgB4mywXEhFw5DlnqNwQ0NF2X
        uWTxRpa9ICN9mXrMeZHAokExg+8ZA2Y3k927qJYgx88q6Y3qyYgFn2ggasY6XA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658238949;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XCsyc41ZvNp9njn6uqBiyVKAtQUMD4aN+KF64YaG1r0=;
        b=kwqm4ry+CPtz1gxepLFpMbANO/aPy0k/J42CnfLn1bLhhv4R1forz7H0VzqaVgxioR6wWr
        0KI+48rU++5k0tCQ==
From:   "irqchip-bot for Xu Qiang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdomain: Report irq number for NOMAP domains
Cc:     Xu Qiang <xuqiang36@huawei.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20220719063641.56541-2-xuqiang36@huawei.com>
References: <20220719063641.56541-2-xuqiang36@huawei.com>
MIME-Version: 1.0
Message-ID: <165823894877.15455.10845543417521952692.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqc=
hip:

Commit-ID:     6f194c99f466147148cc08452718b46664112548
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfo=
rms/6f194c99f466147148cc08452718b46664112548
Author:        Xu Qiang <xuqiang36@huawei.com>
AuthorDate:    Tue, 19 Jul 2022 06:36:40=20
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 19 Jul 2022 14:51:13 +01:00

irqdomain: Report irq number for NOMAP domains

When using a NOMAP domain, __irq_resolve_mapping() doesn't store
the Linux IRQ number at the address optionally provided by the caller.
While this isn't a huge deal (the returned value is guaranteed
to the hwirq that was passed as a parameter), let's honour the letter
of the API by writing the expected value.

Fixes: d22558dd0a6c (=E2=80=9Cirqdomain: Introduce irq_resolve_mapping()=E2=
=80=9D)
Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
[maz: commit message]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220719063641.56541-2-xuqiang36@huawei.com
---
 kernel/irq/irqdomain.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index d5ce965..481abb8 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -910,6 +910,8 @@ struct irq_desc *__irq_resolve_mapping(struct irq_domain =
*domain,
 			data =3D irq_domain_get_irq_data(domain, hwirq);
 			if (data && data->hwirq =3D=3D hwirq)
 				desc =3D irq_data_to_desc(data);
+			if (irq && desc)
+				*irq =3D hwirq;
 		}
=20
 		return desc;
