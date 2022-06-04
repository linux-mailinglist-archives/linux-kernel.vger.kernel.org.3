Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C4053D670
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 12:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbiFDKeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 06:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234830AbiFDKeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 06:34:22 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73666419;
        Sat,  4 Jun 2022 03:34:19 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id s12so13052735ejx.3;
        Sat, 04 Jun 2022 03:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=raYVayQd0HJLSrNtMJvqlNhr7f5muRt3QMZEIQApNYY=;
        b=ozoNcajim+TFczOzIrgalfY2II/oW4IAUGheF5iuCu1SI8wk82Jr1PpGjJYcJv3t9G
         zZUKsJ2vgpWpFvWxb3RW0412drJkKFuxbpl/FfA1VEQMPPOFY6+12eh6cy17JDk1a+VJ
         XrjuS1dTBg2fkVtsXKXCBIXhT23jlvkT1zrppDXCTKqJCU5yd18TVIc3TnnBIzAmHjMK
         XWmNZH6Lq6NbV/DJyur5S8HCJ38yKl9ZY2Og4dC7O6Trb4ADqzQ1ESP+eGZBakhjYn6x
         vW0EaWF/wbu4BjNnQLQqIYrrBuqwii8yOAabyZkPyPbn6y+xZWCgs2Cgc74MRECG6Gte
         bcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=raYVayQd0HJLSrNtMJvqlNhr7f5muRt3QMZEIQApNYY=;
        b=beSYGxv3t5FTcY9MKr+zHuBHYG9hTFafRDgvmDIHCYbgxtt5NNQGK3xFxxzpE+SJyX
         +5m0tJRupBoRs7IbizfagsE62lDA9G1uYh3q65o37Dt2zynAvv+Yo9vingf6mpyvAJkX
         5KN0SLIiuhxXZhspuqIzZdWwwn3AsTlBFt9/owAIoCfh7YcGWIh8HxzSV1ecb8bQn3CJ
         egDSOZ4w27cPiuQBca3e9RT2pkkdcMgxRZo0HC1r6C2C4BHqSj2Wim4PFGQLiGHe3Fqy
         hvOnILEk40glRjqM6UlNwG2KV6SnItW4EOyK1cnLb8+m4yEfZeJCtxKAgg+ALD77OLCh
         /GnA==
X-Gm-Message-State: AOAM532yfjeljf1ayVmixVLPEj2VwGQZlQFbwN1/uNM2dfqSd9u88o0H
        LCf3tg6d2rD4M5fMkw9YNmFDPCrTUeY=
X-Google-Smtp-Source: ABdhPJxhzwmcAlPGaWWCy9Oa4pq1peXADhd69oIvIBSesSNzsGDwufay0+BI4op5fDT2vvCVs81Q7A==
X-Received: by 2002:a17:906:3a92:b0:6fe:9029:b62c with SMTP id y18-20020a1709063a9200b006fe9029b62cmr12406699ejd.569.1654338858124;
        Sat, 04 Jun 2022 03:34:18 -0700 (PDT)
Received: from debian (host-2-98-37-191.as13285.net. [2.98.37.191])
        by smtp.gmail.com with ESMTPSA id 12-20020a170906058c00b006fed787478asm3797577ejn.92.2022.06.04.03.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 03:34:17 -0700 (PDT)
Date:   Sat, 4 Jun 2022 11:34:15 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, WANG Xuerui <git@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: mainline build failure due to fa84f89395e0
 ("irqchip/loongson-liointc: Fix build error for LoongArch")
Message-ID: <Yps1Jw6PJdLBya1W@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The latest mainline kernel branch fails to build for "mips loongson2k_defconfig"
with the error:

drivers/irqchip/irq-loongson-liointc.c: In function 'liointc_chained_handle_irq':
drivers/irqchip/irq-loongson-liointc.c:60:20: error: implicit declaration of function 'cpu_logical_map' [-Werror=implicit-function-declaration]
   60 |         int core = cpu_logical_map(smp_processor_id()) % LIOINTC_NUM_CORES;


git bisect pointed to fa84f89395e0 ("irqchip/loongson-liointc: Fix build error for LoongArch")

And, reverting it on top of mainline branch has fixed the build failure.

--
Regards
Sudip
