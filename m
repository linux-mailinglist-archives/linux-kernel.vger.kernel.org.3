Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC63F54C120
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 07:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344439AbiFOFZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 01:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241100AbiFOFZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:25:07 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C772B488B9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 22:25:06 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso1061093pjg.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 22:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pGeqO4UYbPjEpueFQQzkGuJa78VBFe2OGHm+1nShac0=;
        b=DNajTQmeSO+SYkqEP2ISK2l0hgbr8KRNFEXaQ8NnViOlc3F5D94YL/OLjpnDBQJwwP
         xSHTJqkXvi4GTvke57PM7+VB9BOXiRgP4SyyiK3uEzMhFgjvnG9xPcInHE2Aeu9ExNVV
         s9gTBcBlQK7K6S1Rr35C6fUVBpbgP5h+3pA8paeHgw+dEmQuE+wmT5Rg7Ez5zIybWvJ0
         x/1+9UfAwqed2j374GtIXVET+jlOh+ZloJp6a2QMGEqJHgYWY6mudi8jvygCga/cHaKa
         ueVqoewdaXnWCSHodRxQU4bPPbHsYYiIRHpvsbQQVCYYI0Cn1NbjUWmH9dOMf4yq+k9o
         2Mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pGeqO4UYbPjEpueFQQzkGuJa78VBFe2OGHm+1nShac0=;
        b=5/WSzv6qzVyqCSzeO0ZUu1dFMwjPyCwfOAsp6LNcLpRK1nKDxAukWrUf0mfd7qQ33Z
         V5DWH+BYFdrfZYNOHpPSDEHAyWZDNyHtdMEIySbiIS8dxpB6kT3F+ETJY8XJjllzjKBp
         i6L4CSs41JKRMTLyr04OpYQiiGhc7je4F4XK+eQ/Qg7sfoHvq+4lTi2Mxism7b1fWiOh
         1anFA4rk4iR50HFlfkps0jWqLb+PPLu1Zr/2AYDRvBL3unxwFsZDlGiWWKFFWnr2tV4k
         OQCXH4TkwJyOl6qY3RPQgea6JaK1XD7+zLluN/gX8vOW0Rd0C2wZBGXeqv5BFT8iq8hk
         wwEg==
X-Gm-Message-State: AJIora+jiaAO+Y4BN9B4SRQ6eu9GVnKQgNxkv2Cko1d7oONc8QNVYa0+
        9Nlrn+1tJt2/cd/lb/K4r9FleGTUSPAPLQ==
X-Google-Smtp-Source: AGRyM1ti86Qt00H0607v2/YgsHCgzhTX2lNkz2oGZq+mJRwXwRtPq1rCzO3pJcstWnHsxogh8xIWOg==
X-Received: by 2002:a17:902:c94c:b0:168:f73b:f824 with SMTP id i12-20020a170902c94c00b00168f73bf824mr1033345pla.103.1655270706262;
        Tue, 14 Jun 2022 22:25:06 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090264d000b0016362da9a03sm8128077pli.245.2022.06.14.22.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 22:25:05 -0700 (PDT)
Date:   Wed, 15 Jun 2022 10:55:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        regressions@lists.linux.dev,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: Re: [next] arm64: db410c: WARNING: CPU: 0 PID: 1 at
 drivers/opp/core.c:2265 dev_pm_opp_clear_config+0x174/0x17c
Message-ID: <20220615052503.6dvtnuq2ai45pmro@vireshk-i7>
References: <CA+G9fYsP05V+bVoZsPto-ZdZra3Mo4unBjNqyk1dOjfMEK1XWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsP05V+bVoZsPto-ZdZra3Mo4unBjNqyk1dOjfMEK1XWg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-06-22, 02:49, Naresh Kamboju wrote:
> Following kernel crash reported while booting arm64 db410c board with
> Linux next-20220614 [1] kfence enabled on this kernel.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Boot log:
> ---------
> [    0.850420] WARNING: CPU: 0 PID: 1 at drivers/opp/core.c:2265

A print like this normally comes when we hit a WARN or something.

Here is the line 2265 from above tag

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/opp/core.c?h=next-20220614#n2265

which doesn't have any such WARNs there. I wonder where exactly we hit the WARN
here and why it isn't showing up properly.

> dev_pm_opp_clear_config+0x174/0x17c
> [    0.850447] Modules linked in:
> [    0.850459] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 5.19.0-rc1-next-20220610 #1
> [    0.850470] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> [    0.850477] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    0.850489] pc : dev_pm_opp_clear_config+0x174/0x17c
> [    0.850501] lr : dt_cpufreq_probe+0x1e4/0x4a0
> [    0.850513] sp : ffff80000802bb00
> [    0.850518] x29: ffff80000802bb00 x28: ffff80000ada1c30 x27: 0000000000000000
> [    0.850538] x26: 00000000fffffdfb x25: ffff00000311f410 x24: ffff00000389ec90
> [    0.850557] x23: ffff80000a9eea98 x22: ffff80000a9eed00 x21: ffff80000ada1b68
> [    0.850576] x20: ffff00000389ec80 x19: ffff00003fc41308 x18: ffffffffffffffff
> [    0.850595] x17: ffff800009f21700 x16: ffff8000080955c0 x15: ffff0000031c2a1c
> [    0.850614] x14: 0000000000000001 x13: 0a6b636f6c632064 x12: 6e69662074276e64
> [    0.850632] x11: 0000000000000040 x10: 0000000000000020 x9 : ffff800009006964
> [    0.850650] x8 : 0000000000000020 x7 : ffffffffffffffff x6 : 0000000000000000
> [    0.850668] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> [    0.850686] x2 : 0000000000000004 x1 : 0000000000000000 x0 : 0000000000000000
> [    0.850704] Call trace:
> [    0.850708]  dev_pm_opp_clear_config+0x174/0x17c
> [    0.850722]  platform_probe+0x74/0xf0

Nevertheless, I see one place from where such a WARN can be hit, which can be
fixed with:

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 58eae9de4b91..c3d4058d33fc 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2437,7 +2437,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_config);
  */
 void dev_pm_opp_clear_config(struct opp_table *opp_table)
 {
-       if (WARN_ON(!opp_table))
+       if (!opp_table)
                return;

        _opp_detach_genpd(opp_table);

Not sure it fixes the issue you reported here though.

Can you run the tests for my branch once, it has the updated fix as well.

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next

-- 
viresh
