Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2AC572521
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 21:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235738AbiGLTLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 15:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235896AbiGLTJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:09:53 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1D5E5DC5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 11:52:31 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 650B95C00EE;
        Tue, 12 Jul 2022 14:52:29 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Tue, 12 Jul 2022 14:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1657651949; x=1657738349; bh=IY
        KejSUZ3WZ+rhgYIP1qlUg5GTYFGUfBIb/+FJ5/tLw=; b=dYgW8IM1NBH0bfRVhT
        O72vlCb4L5NtaRaxC3jyVY/1BAu49rbKXMdfsQdoKp0R+L2hl9IClGIu3bU9+OXD
        i2MI5FKhpdt/vOA5FiRwL3FHa4/KaN0HwzBk/HtIoPg25zy3E8RZlf8ZG4wV0Unz
        zoWNFPNxdDyvh1/RInvUL+ZTLU+34LI4XlEDh5gGDpJBtY8v+WIy+qbAG/th+v8c
        QjWedpCLz/gi2VlqmbAMNaLXBzkqsqAuDf7f/HFxThMOybtxbBe7HcLv4DtbM80J
        n9OOfzLSXQWupHMWqZUsVqkzxLpSnSaa6sdFwzgN82BSONP+UqIyLpCDRTAlSzc1
        znuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1657651949; x=1657738349; bh=IYKejSUZ3WZ+rhgYIP1qlUg5GTYF
        GUfBIb/+FJ5/tLw=; b=L+wMMjooU8IqVZuddaMv9tP/7F9+gJbvaHnsKyKz20oo
        1wS6CnNJDTbed8NIyRVo64sRWeetdUJaJTNcv8YZtk7z83FB4q7s0fkFCsDDV9SF
        fMg3iKplzkIcEv/8KBBCVW3+qtfggZ37rYP0IfgHsaxRcYzEYlUcmmTjMxMD7l/O
        Xqxc35BlY7I/fgucIerpwGoiR2UjMeXNToQMkNGgaa0ydfceSWHPDGiM08H+XJIU
        /ouiWTm3Lc9Mb/hsPC9HrmOkdhWfoPKOrsqzeFuz0Ue1mZwWkA103FVukQM7+sTM
        N6N991AEtJkVOo2x+f77Rqs23jRUUi+CaM1RKET75g==
X-ME-Sender: <xms:7cLNYs97A26n4RopurtOpIHYO7-zGfCEewyx6Xa6Sok5v8_KS9fcTg>
    <xme:7cLNYkvNgeUWVpSR9lmbyLuixaEsxPcGmVst9CbH9qeQ9812rSna15V8c6c76Z68y
    CEBPx0VJwFYQ7liwe0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejhedgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfu
    vhgvnhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtf
    frrghtthgvrhhnpeelvefggeffheevtdeivefhkeehfeettdejteduveeiheevveeilefg
    hfeiveeiueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:7cLNYiAjOpmUDItfFMPMQzF2v4b3FotlmQJ-IXd6hizgo_NNaQY3ZA>
    <xmx:7cLNYscgs98_M0NoR9NyKJCgsKrndXRRe1XRsFZ0Mb8KDPOKDCz3ow>
    <xmx:7cLNYhODbzQabRyswE0tHFIH67Bry9p95L0wBng5MTy62BEUw83xGQ>
    <xmx:7cLNYkoB_skrQX5QgXXw4jPQfpdSKaOaMMBPv5ip4iJ2Rj-3QwAjeA>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 09226A6007C; Tue, 12 Jul 2022 14:52:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-755-g3e1da8b93f-fm-20220708.002-g3e1da8b9
Mime-Version: 1.0
Message-Id: <0ad65aa0-862d-4b5b-aa35-0323a19ba17a@www.fastmail.com>
In-Reply-To: <20220712160919.740878-2-konrad.dybcio@somainline.org>
References: <20220712160919.740878-1-konrad.dybcio@somainline.org>
 <20220712160919.740878-2-konrad.dybcio@somainline.org>
Date:   Tue, 12 Jul 2022 20:52:08 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Marc Zyngier" <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] irqchip/apple-aic: Add support for A7-A11 SoCs
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

marcan probably has to review this in detail but two comments from me:

On Tue, Jul 12, 2022, at 18:09, Konrad Dybcio wrote:
> Add support for A7-A11 SoCs by if-ing out some features only present on
> A12 & newer (UNCORE2 registers) or M1 & newer (EL2 registers - the
> older SoCs don't implement EL2).
>
> Also, annotate IPI regs support (A11 and newer*) so that the driver can
> tell whether the SoC supports these (they are written to even if fast
> IPI is disabled, when the registers are there of course).
>
> *A11 is supposed to use this feature, but it is currently not working.
> That said, it is not yet necessary, especially with only one core up,
> and it works a-ok using the same featureset as earlier SoCs.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  drivers/irqchip/irq-apple-aic.c | 54 +++++++++++++++++++++++----------
>  1 file changed, 38 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
> index 12dd48727a15..36f4b52addc2 100644
> --- a/drivers/irqchip/irq-apple-aic.c
> +++ b/drivers/irqchip/irq-apple-aic.c
> @@ -245,7 +245,10 @@ struct aic_info {
>  	u32 die_stride;
> 
>  	/* Features */
> +	bool el2_regs;
>  	bool fast_ipi;
> +	bool ipi_regs;
> +	bool uncore2_regs;

I don't quite understand the difference between fast_ipi and ipi_regs.
Don't we always have fast_ipi suppport when those regs are available?

>  };
> 
>  static const struct aic_info aic1_info = {
> @@ -261,7 +264,10 @@ static const struct aic_info aic1_fipi_info = {
>  	.event		= AIC_EVENT,
>  	.target_cpu	= AIC_TARGET_CPU,
> 
> +	.el2_regs	= true,
>  	.fast_ipi	= true,
> +	.ipi_regs	= true,
> +	.uncore2_regs	= true,
>  };
> 
>  static const struct aic_info aic2_info = {
> @@ -269,7 +275,10 @@ static const struct aic_info aic2_info = {
> 
>  	.irq_cfg	= AIC2_IRQ_CFG,
> 
> +	.el2_regs	= true,
>  	.fast_ipi	= true,
> +	.ipi_regs	= true,
> +	.uncore2_regs	= true,
>  };
> 
>  static const struct of_device_id aic_info_match[] = {
> @@ -452,6 +461,9 @@ static unsigned long aic_fiq_get_idx(struct irq_data *d)
> 
>  static void aic_fiq_set_mask(struct irq_data *d)
>  {
> +	if (!aic_irqc->info.el2_regs)
> +		return;
> +
>  	/* Only the guest timers have real mask bits, unfortunately. */
>  	switch (aic_fiq_get_idx(d)) {
>  	case AIC_TMR_EL02_PHYS:
> @@ -469,6 +481,9 @@ static void aic_fiq_set_mask(struct irq_data *d)
> 
>  static void aic_fiq_clear_mask(struct irq_data *d)
>  {
> +	if (!aic_irqc->info.el2_regs)
> +		return;
> +
>  	switch (aic_fiq_get_idx(d)) {
>  	case AIC_TMR_EL02_PHYS:
>  		sysreg_clear_set_s(SYS_IMP_APL_VM_TMR_FIQ_ENA_EL2, 0, 
> VM_TMR_FIQ_ENABLE_P);
> @@ -524,12 +539,14 @@ static void __exception_irq_entry 
> aic_handle_fiq(struct pt_regs *regs)
>  	 * we check for everything here, even things we don't support yet.
>  	 */
> 
> -	if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
> -		if (static_branch_likely(&use_fast_ipi)) {
> -			aic_handle_ipi(regs);
> -		} else {
> -			pr_err_ratelimited("Fast IPI fired. Acking.\n");
> -			write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
> +	if (aic_irqc->info.ipi_regs) {
> +		if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
> +			if (static_branch_likely(&use_fast_ipi)) {
> +				aic_handle_ipi(regs);
> +			} else {
> +				pr_err_ratelimited("Fast IPI fired. Acking.\n");
> +				write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
> +			}
>  		}
>  	}

This is a pretty hot path and the use_fast_ipi check uses the jump label support
(static_branch_likely, static_branch_enable) to avoid dereferencing memory here.
We'll probably want the same for the other features.

For this branch here the else can probably just be removed: I think that's
a leftover from when this driver just didn't support fastipi at all even
when the registers were available.



Sven
 
