Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655B44AE729
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343627AbiBICoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiBIBNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 20:13:25 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1977EC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 17:13:24 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id d9-20020a17090a498900b001b8bb1d00e7so700532pjh.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 17:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=t5FgH2YJXOPf/xxPjv6QRrKmo/4kA2ug0zb3e+u3Xao=;
        b=zIbTskggTwuJ8Cs4sq0rq+triPMJ73QwqJeAJl8rQPFbTgi9R6UFxKykUlvi2LoERU
         JfrHtLoOEo2RSK7qLDy3j0ClM1pKefSYA/drHmfx4QjoQzLJnW2Km/A5MIhKulJwl9Qv
         jhkGIKcGThJzb+5tYP9Iyh0pn5HgLF/ba+Q9AR8Q3k9b3cKxTwZbWZ9D4aKYsijihkOe
         lpZM1ZR+9/hhfA3fWhGbyfHdzF9Pi3vGiDrlGNkkacJ/7zITVO8irSIW3xVovn540T2p
         +QWlc3FWZdjDBSBgODptqPqPSjLdv3glClBxbuSCWJv0QMkMZrnl266Jo4je6sRoA4q1
         igCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=t5FgH2YJXOPf/xxPjv6QRrKmo/4kA2ug0zb3e+u3Xao=;
        b=Mb83jUSj6gBUKiNHLIUCsfMwKSUdPgUNx1qa1GO3vYebGn+hcE3Ky34dM27gswQNgw
         YU8keKNyD+QwepQuObuDMNpUnQZa8HweIuCRI/UkxTFP4+RoHyLGEhOx3dRCqVa5AVBF
         dYXw6JziWGNFgGpebgGl296JJwx5sTTTEG8e8g9LdG/T6bIwp48fLZqm7VPbaSVxZ06i
         8b0ae8Q4NRV4tbMjokOwcr978phqWvb7KJgvhNvTDPuYU3BiX/v+N++nZpFxzq9iigKg
         p6SgLPqUeVIglwzooBc5BfEa7VKYwsFynb8sViTKQ5UH4HTZmcIYtHo1hR6ncfI1aYrJ
         Z+hw==
X-Gm-Message-State: AOAM533Ps7wFsEA2yGav0rtJBsqJbU4CTkrN57DkfjOjMAsrEkrjpP7D
        SbxLqfXs6e3eM9c6ZQ6yk5Zazw==
X-Google-Smtp-Source: ABdhPJyMzXTZUWesPmKCROa5Vq0xkIcpEaIdsXW7yw+ZtlpYv491NFu63mbL/Q0o7cNRpbRns9anbg==
X-Received: by 2002:a17:903:228c:: with SMTP id b12mr6801223plh.36.1644369203436;
        Tue, 08 Feb 2022 17:13:23 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id pg2sm4559295pjb.54.2022.02.08.17.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 17:13:22 -0800 (PST)
Date:   Tue, 08 Feb 2022 17:13:22 -0800 (PST)
X-Google-Original-Date: Tue, 08 Feb 2022 17:12:33 PST (-0800)
Subject:     Re: [PATCH] riscv: extable: fix err reg writing in dedicated uaccess handler
In-Reply-To: <20220123090417.630-1-jszhang@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        mchitale@ventanamicro.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang@kernel.org
Message-ID: <mhng-1843aa8a-4e63-4366-9b70-42448c3d37b8@palmer-ri-x1c9>
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

On Sun, 23 Jan 2022 01:04:17 PST (-0800), jszhang@kernel.org wrote:
> Mayuresh reported commit 20802d8d477d ("riscv: extable: add a dedicated
> uaccess handler") breaks the writev02 test case in LTP. This is due to
> the err reg isn't correctly set with the errno(-EFAULT in writev02
> case). First of all, the err and zero regs are reg numbers rather than
> reg offsets in struct pt_regs; Secondly, regs_set_gpr() should write
> the regs when offset isn't zero(zero means epc)
>
> Fix it by correcting regs_set_gpr() logic and passing the correct reg
> offset to it.
>
> Reported-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> Fixes: 20802d8d477d ("riscv: extable: add a dedicated uaccess handler")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/mm/extable.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/mm/extable.c b/arch/riscv/mm/extable.c
> index 05978f78579f..35484d830fd6 100644
> --- a/arch/riscv/mm/extable.c
> +++ b/arch/riscv/mm/extable.c
> @@ -33,7 +33,7 @@ static inline void regs_set_gpr(struct pt_regs *regs, unsigned int offset,
>  	if (unlikely(offset > MAX_REG_OFFSET))
>  		return;
>
> -	if (!offset)
> +	if (offset)
>  		*(unsigned long *)((unsigned long)regs + offset) = val;
>  }
>
> @@ -43,8 +43,8 @@ static bool ex_handler_uaccess_err_zero(const struct exception_table_entry *ex,
>  	int reg_err = FIELD_GET(EX_DATA_REG_ERR, ex->data);
>  	int reg_zero = FIELD_GET(EX_DATA_REG_ZERO, ex->data);
>
> -	regs_set_gpr(regs, reg_err, -EFAULT);
> -	regs_set_gpr(regs, reg_zero, 0);
> +	regs_set_gpr(regs, reg_err * sizeof(unsigned long), -EFAULT);
> +	regs_set_gpr(regs, reg_zero * sizeof(unsigned long), 0);
>
>  	regs->epc = get_ex_fixup(ex);
>  	return true;

Thanks, this is on fixes.  I'm not sure if it's saner to have these be 
register numbers rather than offsets, but regs_get_register is this way 
so it's probably better to have them match.
