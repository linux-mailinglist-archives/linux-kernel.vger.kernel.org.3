Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0891C583798
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbiG1Def (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbiG1DeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:34:24 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26165A3D1;
        Wed, 27 Jul 2022 20:34:22 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id o3so691914ple.5;
        Wed, 27 Jul 2022 20:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FCyuMS+MYtaXjHcIxmL31JDLi03JrIO2qsiSj9P1Eho=;
        b=CqnwOOBEEvCpmhikYJ3JqR5kKGQKEcHIAFmX3WraUqqWfCHTg/3/ho7b2LG1xtN6MW
         SAxT0lRJ3uJhj3jneu/Bb5Rq+j8+masl2huLxdBwc1ZWItOLd3VHmBpiZ6+r337LYEsh
         VKMdCjVr+QKj09HmSOEQuIy0QwX8x4uU4ZK5L2h32arGX2BkcYJ8k3Pdarh/6HSxsxmS
         puUDL9HUL7zA4lHFxfhJQFmFxuGW27f/XBUT6tN3slrmNzg7IgHISrFG0oJA0BVXiOwL
         NZjSgXdw8mkvvdYhBwZAejxfv+tgU2Fg29/7c10O/Jr8vlAFk1JgnUvEU4Lw8WJ2u7Pf
         6MOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FCyuMS+MYtaXjHcIxmL31JDLi03JrIO2qsiSj9P1Eho=;
        b=4xVKEhXsjWIBdLNsQrsdNGqbbnBK5W4kLWuFUAvuRvIrpOEml+mLPYbEsVCW6ckFm1
         X4HIN7sOpnfkg0hVqQhwU4U4f2YJwjwbqhj5A7ZIR/5AB/HMNnR59M6a6riCqOl9l2xb
         vnAGH/C/nWwMEFDq3lRRXH6v6EvvsetIrqsSsw+Tmp+fg5Q0vepPJmgZyBoXipM8Zx1N
         ibsMUiBtnscL5QpLu4kkilto2zpbxStTYhAC+36O894MnMa7Qzs3RkEjbkXLUNoHaoUh
         mlVHTG0VczEVrDbBi5iKMeo0nwwiC/v5UrWW8TZ3yPbdTEsxXMdaIc6BOqV2EDr5lWdb
         h9Ug==
X-Gm-Message-State: AJIora+rF62ypI2f4dxXA5/anny9kd0sARqrqGNdnCOXUFUt/muJkNUo
        6w6MqhzW0xECj1xMGj99Xds=
X-Google-Smtp-Source: AGRyM1u09bL67UJ4D22OsPriM3aYVau9eNR+g2LJANdPbWk7JIFHDJdMAaRCIPQk8nM62BjKho6bVw==
X-Received: by 2002:a17:902:900c:b0:16a:4521:10fd with SMTP id a12-20020a170902900c00b0016a452110fdmr24586283plp.75.1658979262231;
        Wed, 27 Jul 2022 20:34:22 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-54.three.co.id. [116.206.12.54])
        by smtp.gmail.com with ESMTPSA id j5-20020a17090a318500b001f035bfcc53sm2582722pjb.18.2022.07.27.20.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 20:34:21 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 7AB39104A8D; Thu, 28 Jul 2022 10:34:16 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org, linux-next@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Nicholas Piggin <npiggin@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 3/3] Documentation: powerpc: add elf_hwcaps to table of contents
Date:   Thu, 28 Jul 2022 10:33:33 +0700
Message-Id: <20220728033332.27836-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220727220050.549db613@canb.auug.org.au>
References: <20220727220050.549db613@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

elf_hwcaps documentation is missing from table of contents at index.rst,
hence triggers Sphinx warning:

Documentation/powerpc/elf_hwcaps.rst: WARNING: document isn't included in any toctree

Add the documentation to the index to fix the warning.

Link: https://lore.kernel.org/linuxppc-dev/20220727220050.549db613@canb.auug.org.au/
Fixes: 3df1ff42e69e91 ("powerpc: add documentation for HWCAPs")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/powerpc/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/powerpc/index.rst b/Documentation/powerpc/index.rst
index 0f7d3c495693e0..85e80e30160bb6 100644
--- a/Documentation/powerpc/index.rst
+++ b/Documentation/powerpc/index.rst
@@ -17,6 +17,7 @@ powerpc
     dawr-power9
     dscr
     eeh-pci-error-recovery
+    elf_hwcaps
     elfnote
     firmware-assisted-dump
     hvcs
-- 
An old man doll... just what I always wanted! - Clara

