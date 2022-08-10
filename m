Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D799258E69D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 07:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiHJFIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 01:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiHJFHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 01:07:50 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A68683F02;
        Tue,  9 Aug 2022 22:07:49 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id dc19so25623748ejb.12;
        Tue, 09 Aug 2022 22:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=AYDlJnJ9PdqwWRCOXeLaxSS9GQWnExGZMPNDuuoNCE8=;
        b=bTfzSFHuqdVV0lFN/lzZnjifaJWhlYjtaAo1Ju6X9xnrzPfdXvNksvX94Xy3RNm4e0
         Mo9821IeGlN16p7oF4bUNWkUMBEiRDR38mAAkiW2tfLcSgRkWH+IL1kn4ANYCty1o6FO
         JMDWgAvxgqDhHN+hFR+CCGW6kuN4qer/EH+w2ZizF74vETRMr4fe46dEjzLc96Xb+Hq3
         adWDwQQXFnqviSrvb4sOEBhnqHqlumBOX2bQxTIsdGaLukSgPKq2vPqQpRd0ggX86e2f
         HHqjuoTg0lIPNrCr4nqOHYPSmPTrTRLnScYdD7VqPdv9v4IAj6I0dDN+Dx1GyCjxL/je
         bnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=AYDlJnJ9PdqwWRCOXeLaxSS9GQWnExGZMPNDuuoNCE8=;
        b=SpNwxjjC+JzRuiojvQDkehuD580JLKOhWhI4FWkJDmbS6IyMOgo4k62oCp178YUYBM
         dME5yN/zKrEKgiitOWxoUcYRiG4W+7VvLHp4DE0JKkne4c8cEKpxVJu+rIaRniM5sCpa
         sZkK2e5JObwzqdFEpxeTPhka2SQ8apptFZ5tx8rtTHuO3vAL/jNfFIPn2MpcnDlwPzcx
         kK550tz6HnL5G5cwYcBmJAl2EjPnBdMECYuQeUayUJZ/DS85p4YiV0YlKpUKz7ZOZUuS
         6dvBhNto2hkYljmNTEhscHen801xafT4lyDgEGSUkf/Y8e+HEIS6MEvMzZaaxDUQH9pe
         wUdA==
X-Gm-Message-State: ACgBeo22OuINBFDio5wRzVXaJtPG7xX5MENOssFTWV6dJhA03sQqpuym
        +d65acpfNCz9JD4N6smvjEcqPhHGwyI=
X-Google-Smtp-Source: AA6agR7N5grn3FLzeXuLrRUfydMKCMsMWlGBR3iW3evvHqazBms9Xge3hhbgiHz69CDY/9axn9gf4g==
X-Received: by 2002:a17:906:7950:b0:730:f098:86ce with SMTP id l16-20020a170906795000b00730f09886cemr15915974ejo.390.1660108067589;
        Tue, 09 Aug 2022 22:07:47 -0700 (PDT)
Received: from felia.fritz.box (200116b826504800504e9aff21bf95aa.dip.versatel-1u1.de. [2001:16b8:2650:4800:504e:9aff:21bf:95aa])
        by smtp.gmail.com with ESMTPSA id ew12-20020a056402538c00b0043bbbaa323dsm7009781edb.0.2022.08.09.22.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 22:07:47 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 4/4] MAINTAINERS: add xen config fragments to XEN HYPERVISOR sections
Date:   Wed, 10 Aug 2022 07:07:12 +0200
Message-Id: <20220810050712.9539-5-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220810050712.9539-1-lukas.bulwahn@gmail.com>
References: <20220810050712.9539-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make changes to the xen config fragments reach the XEN HYPERVISOR
maintainers and mailing list.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ee2098fc6f7c..6c2516b3da21 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22217,12 +22217,14 @@ F:	drivers/*/xen-*front.c
 F:	drivers/xen/
 F:	include/uapi/xen/
 F:	include/xen/
+F:	kernel/configs/xen.config
 
 XEN HYPERVISOR X86
 M:	Juergen Gross <jgross@suse.com>
 R:	Boris Ostrovsky <boris.ostrovsky@oracle.com>
 L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
 S:	Supported
+F:	arch/x86/configs/xen.config
 F:	arch/x86/include/asm/pvclock-abi.h
 F:	arch/x86/include/asm/xen/
 F:	arch/x86/platform/pvh/
-- 
2.17.1

