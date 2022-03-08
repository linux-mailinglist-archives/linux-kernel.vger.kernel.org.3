Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847AC4D0CF9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 01:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244110AbiCHAsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 19:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238633AbiCHAsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 19:48:19 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B61F3FD9C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 16:47:23 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id s11so15872536pfu.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 16:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=wypaPIA6ghdghr/IDrb/MsW89Q13oqpEaAH1HD6rl2Q=;
        b=5GWNMF7aPQ5cvEpAtHaiMyRSUVh71/WOgLZl7yJJ4pakehav7XEh0jVVHMqPFQmL12
         AyAht2FPHo8A8lVkzPwGI6OTLH3X03ltJOt0M3fzLULv2J+7KgdCxUtQHMP05dVfqdzN
         dVXM+ulgnr46yoSBZJX7xNYny1cumI3o6ArXCytoJ7gMq38lO2yi7gswSLzoc6z80bGi
         oIX2VZRn22zna8kG48HztWrMOy0DMyyZNAcSh7+0KzU8GW90GM3zNnXuYSONkMHLpbId
         sOwHITm4Q4Y5pVy84DhnRCCZonbkFPa6WrNxn9pCrvArhEIE80yX21BUwEvn97jgJasS
         I5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=wypaPIA6ghdghr/IDrb/MsW89Q13oqpEaAH1HD6rl2Q=;
        b=65p+qXRLZjlgwM2JGs81F2MhE+p9MpU1MRodUINQDEsfegJek/BR6uUQ7udjdmZcrR
         frwSAApfHtgbg8D7HkO598JrUDKs/CaifinDX0Y66QgBHDOCy/F4Z/Y0p6htS9abZi8g
         m542312Hd4GdzpOKDiH1yUSVfytsFpYUzm1YMU7XpIEjgcN1XA0r4wZnoEKpaaERBh+T
         ZEaSKi65aze5SQWxaEVYvLAV9Nx4/wVZMu0SaF1cYYGHSlJZcn/r0Uv8TthLDx7QCKxq
         pBW+0ZEm4T/tujYz8rEs1eCCG36gtdbFBqgfqaxHLn7+oSZVkPpmKBI0Hub0CJLQdAIK
         ngzQ==
X-Gm-Message-State: AOAM531cgAfnJkRAYZZ+foi9QUwWzTZUsBb2rX6+8m5BNgQ2dBoc0z2j
        FtMvsHMwTBrplbd0enbGnvWKuw==
X-Google-Smtp-Source: ABdhPJzN0Q+/iTzny+GY7jNEgZYiSy/S/lodFd1M8fC5fiXAiV5Y/3yp0m6imSPSgx/YE1vOCyjQMw==
X-Received: by 2002:a63:1a54:0:b0:375:82eb:7449 with SMTP id a20-20020a631a54000000b0037582eb7449mr12141643pgm.341.1646700442479;
        Mon, 07 Mar 2022 16:47:22 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id t9-20020a056a0021c900b004f72e3838aasm178095pfj.183.2022.03.07.16.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 16:47:21 -0800 (PST)
Date:   Mon, 07 Mar 2022 16:47:21 -0800 (PST)
X-Google-Original-Date: Mon, 07 Mar 2022 12:30:04 PST (-0800)
Subject:     Re: [PATCH v6 07/14] riscv: prevent compressed instructions in alternatives
In-Reply-To: <20220209123800.269774-8-heiko@sntech.de>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, wefu@redhat.com,
        liush@allwinnertech.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, drew@beagleboard.org,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        wens@csie.org, maxime@cerno.tech, gfavor@ventanamicro.com,
        andrea.mondelli@huawei.com, behrensj@mit.edu, xinhaoqu@huawei.com,
        huffman@cadence.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, heiko@sntech.de
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     heiko@sntech.de
Message-ID: <mhng-edc0da56-7fc8-4287-8856-9aac0f7465c1@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Feb 2022 04:37:53 PST (-0800), heiko@sntech.de wrote:
> Instructions are opportunistically compressed by the RISC-V assembler
> when possible, but in alternatives-blocks both the old and new content
> need to be the same size, so having the toolchain do somewhat random
> optimizations will cause strange side-effects like
> "attempt to move .org backwards" compile-time errors.
>
> Already a simple "and" used in alternatives assembly will cause these
> mismatched code sizes.

There should probably be a ".option norelax" in here as well, as 
relaxation will trigger exactly the same issues.  That, or we could just 
remove the constraint that these must be the same size (ie, 
automatically pad the smaller one with NOP/jump-to-end).

> So prevent compressed instructions to be generated in alternatives-
> code and use option-push and -pop to only limit this to the relevant
> code blocks
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/riscv/include/asm/alternative-macros.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
> index c0fb11fad631..3a52884bf23d 100644
> --- a/arch/riscv/include/asm/alternative-macros.h
> +++ b/arch/riscv/include/asm/alternative-macros.h
> @@ -19,7 +19,10 @@
>  	.popsection
>  	.subsection 1
>  888 :
> +	.option push
> +	.option norvc
>  	\new_c
> +	.option pop
>  889 :
>  	.previous
>  	.org    . - (889b - 888b) + (887b - 886b)
> @@ -29,7 +32,10 @@
>
>  .macro __ALTERNATIVE_CFG old_c, new_c, vendor_id, errata_id, enable
>  886 :
> +	.option push
> +	.option norvc
>  	\old_c
> +	.option pop
>  887 :
>  	ALT_NEW_CONTENT \vendor_id, \errata_id, \enable, \new_c
>  .endm
> @@ -40,7 +46,10 @@
>  .macro __ALTERNATIVE_CFG_2 old_c, new_c_1, vendor_id_1, errata_id_1, enable_1, \
>  				  new_c_2, vendor_id_2, errata_id_2, enable_2
>  886 :
> +	.option push
> +	.option norvc
>  	\old_c
> +	.option pop
>  887 :
>  	ALT_NEW_CONTENT \vendor_id_1, \errata_id_1, \enable_1, \new_c_1
>  	ALT_NEW_CONTENT \vendor_id_2, \errata_id_2, \enable_2, \new_c_2
> @@ -70,7 +79,10 @@
>  	".popsection\n"							\
>  	".subsection 1\n"						\
>  	"888 :\n"							\
> +	".option push\n"						\
> +	".option norvc\n"						\
>  	new_c "\n"							\
> +	".option pop\n"							\
>  	"889 :\n"							\
>  	".previous\n"							\
>  	".org	. - (887b - 886b) + (889b - 888b)\n"			\
> @@ -79,7 +91,10 @@
>
>  #define __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, enable)	\
>  	"886 :\n"							\
> +	".option push\n"						\
> +	".option norvc\n"						\
>  	old_c "\n"							\
> +	".option pop\n"							\
>  	"887 :\n"							\
>  	ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
>
> @@ -89,7 +104,10 @@
>  #define __ALTERNATIVE_CFG_2(old_c, new_c_1, vendor_id_1, errata_id_1, enable_1, \
>  				  new_c_2, vendor_id_2, errata_id_2, enable_2) \
>  	"886 :\n"							\
> +	".option push\n"						\
> +	".option norvc\n"						\
>  	old_c "\n"							\
> +	".option pop\n"							\
>  	"887 :\n"							\
>  	ALT_NEW_CONTENT(vendor_id_1, errata_id_1, enable_1, new_c_1)	\
>  	ALT_NEW_CONTENT(vendor_id_2, errata_id_2, enable_2, new_c_2)
