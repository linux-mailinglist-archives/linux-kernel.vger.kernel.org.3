Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660855A8494
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbiHaRkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbiHaRkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:40:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F5D120AE;
        Wed, 31 Aug 2022 10:40:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FCEF61B18;
        Wed, 31 Aug 2022 17:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C333CC433D7;
        Wed, 31 Aug 2022 17:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661967595;
        bh=bywH8/bPfqvMZICEabxywtFMfQ0jUMtbtk4pXN0z1Ws=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cNryTRuQETBjyI7tmkIc9GOkQtAGXbp3vFbZNqy8SxyXq3HRcCbOaWul8sEth6pKp
         rjpOrdQMgn2miMziBmjiVdNTCFnirIL7HZ4uAZVAAc7LD/KKrAzh/3WzPjmDrt8KHR
         WRJELjx18W+3HItAagGgJZk8B8LcOASDfExn0bHQh5AJK8lZZJ3SuapbggrKKSd87J
         SqfMcx6vfKRm9pRhFsS3TjhFqICZmnVi4RhVD6qPNWN4Oc7F2COhIRwt7T5VNPyE74
         bEoFL3yXyU1KK6gLcckuO7MKEQVPJc91FZGGDkpKexColUkVcFPKzUfN9SJvrdgm6X
         XIFrkvcZpbCfA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1655004286-11493-4-git-send-email-quic_fenglinw@quicinc.com>
References: <1655004286-11493-1-git-send-email-quic_fenglinw@quicinc.com> <1655004286-11493-4-git-send-email-quic_fenglinw@quicinc.com>
Subject: Re: [RESEND PATCH v6 03/10] spmi: pmic-arb: do not ack and clear peripheral interrupts in cleanup_irq
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_fenglinw@quicinc.com, tglx@linutronix.de, maz@kernel.org,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>
To:     Abhijeet Dharmapurikar <adharmap@codeaurora.org>,
        Fenglin Wu <quic_fenglinw@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 31 Aug 2022 10:39:53 -0700
User-Agent: alot/0.10
Message-Id: <20220831173955.C333CC433D7@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Fenglin Wu (2022-06-11 20:24:39)
> From: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
>=20
> Currently, cleanup_irq() is invoked when a peripheral's interrupt
> fires and there is no mapping present in the interrupt domain of
> spmi interrupt controller.
>=20
> The cleanup_irq clears the arbiter bit, clears the pmic interrupt
> and disables it at the pmic in that order. The last disable in
> cleanup_irq races with request_irq() in that it stomps over the
> enable issued by request_irq. Fix this by not writing to the pmic
> in cleanup_irq. The latched bit will be left set in the pmic,
> which will not send us more interrupts even if the enable bit
> stays enabled.
>=20
> When a client wants to request an interrupt, use the activate
> callback on the irq_domain to clear latched bit. This ensures
> that the latched, if set due to the above changes in cleanup_irq
> or when the bootloader leaves it set, gets cleaned up, paving way
> for upcoming interrupts to trigger.
>=20
> With this, there is a possibility of unwanted triggering of
> interrupt right after the latched bit is cleared - the interrupt
> may be left enabled too. To avoid that, clear the enable first
> followed by clearing the latched bit in the activate callback.
>=20
> Fixes: 6bc546e71e50 ("spmi: pmic-arb: cleanup unrequested irqs")
> Fixes: 02abec3616c1 ("spmi: pmic-arb: rename pa_xx to pmic_arb_xx and oth=
er cleanup")
> Signed-off-by: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
> [collinsd@codeaurora.org: fix merge conflict]
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---

Applied to spmi-next
