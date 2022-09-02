Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CF15AABCC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbiIBJum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbiIBJuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:50:24 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7075B24095
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:50:19 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso2998317wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 02:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=p4BB5HEEv1U/G1XcV5dDRUGXUnKJI96ERgbfE9BkLC4=;
        b=CId7laYpem0t29xNQrxbDN5uajUvv7J674hYRhjHIwRot2NzlduoZrqIn4bGMjRLt4
         NCaB736C61TkkRqP9Z7EaqQiLBmIoyLxqTsJUyMlYzwGuqhg1ePaFAf9vG4IZTKLaoX2
         IjlalDqUjpjXElJ3dgiyMyHuPGC2VvtEcIBzy658aV0fSXbiImi45F+dQdNc7KOhJfgf
         89dvPtQOnTE96qMrm6wM9AtcrqGhEAyb1T93vGuSf1YbSkoNkhN1weAEHK00sSU77IZr
         77GT7gDAe3lkkrEm7xxsHZBdsIjoNJyhM6Jetufw0NuXWgwx0L4jWpukn9wQ8d4DcObc
         wl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=p4BB5HEEv1U/G1XcV5dDRUGXUnKJI96ERgbfE9BkLC4=;
        b=7J30ii8QMg1tqkE96ItlXy2xW0OZx2M4p6zse8EWbtfjRPcoAph1xHo7+gr4+IOcoK
         +yQynpjYeuCAgJ6JugPRTXut06++3OcoN+wF7fqUioNyQmNfIO9fExANpGtRzSGpAL2P
         R+lmTRfdRd0HVLsoNfk0ZZtgirK4txx/AlKRZ2U3CrHyjY+LdxzNVcfErf19YnZeY9j+
         Uj4KQ9kpt6sGieKV3+eeWpOacI6tfYCJ+5ab2I0RrNjiTE3L0qMlpbFRwxfsxunwlSLh
         9cbVp/+9UKj6e6h/jn+ENF3Idgq+cHslZutOVno+WtfUTmMbeDpo1jvWfrunzUYBNNYW
         bemQ==
X-Gm-Message-State: ACgBeo3upbX4kmwqBTTiZCiTVe9kdGai0kMKBu6UEFeQDokU7Cd3lHoX
        fz0j0QKptuHRnrF9IaTk63UmxQ==
X-Google-Smtp-Source: AA6agR79dK0AEa2dNrnkz8lWXzy9RsmAgPjIkQXqiyvCeJhhfv9nSqdpJe62GAkWG+pv2SwTvVQSgg==
X-Received: by 2002:a05:600c:4f89:b0:3a6:243d:3bbe with SMTP id n9-20020a05600c4f8900b003a6243d3bbemr2231447wmq.16.1662112217766;
        Fri, 02 Sep 2022 02:50:17 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id d6-20020a5d6446000000b00224f5bfa890sm1067036wrw.97.2022.09.02.02.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 02:50:17 -0700 (PDT)
Date:   Fri, 2 Sep 2022 11:50:16 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com,
        guoren@kernel.org, apatel@ventanamicro.com, atishp@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] riscv: check for kernel config option in t-head
 memory types errata
Message-ID: <20220902095016.bc3bttpdnla6swsk@kamzik>
References: <20220901222744.2210215-1-heiko@sntech.de>
 <20220901222744.2210215-4-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901222744.2210215-4-heiko@sntech.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 12:27:44AM +0200, Heiko Stuebner wrote:
> The t-head variant of page-based memory types should also check first
> for the enabled kernel config option.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/riscv/errata/thead/errata.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> index a6f4bd8ccf3f..902e12452821 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -17,6 +17,9 @@
>  static bool errata_probe_pbmt(unsigned int stage,
>  			      unsigned long arch_id, unsigned long impid)
>  {
> +	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_PBMT))
> +		return false;
> +
>  	if (arch_id != 0 || impid != 0)
>  		return false;
>  
> -- 
> 2.35.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
