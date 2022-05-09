Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCB05200DD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbiEIPSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238074AbiEIPSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:18:13 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742A01EAD8;
        Mon,  9 May 2022 08:14:19 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id x12so12301770pgj.7;
        Mon, 09 May 2022 08:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qg+PjIH80BWgPjryO+lEfxqIjbHNYFW9R/NziKjRsqg=;
        b=nFXJ7/e777voUuCQ7olvjfLpPspuAnXo0pnZq71CqcDX1y8rQ75IXVDXvU0Xpg+s2N
         JdNHFGQqvLLCSw/qzH8VR9bhjWdFkehVN8jzErv6Iz5UNtOT7QwGKYDfqdMr8HalGoSH
         bU7KMhyFOn4aeIwf+OpyRt2qHtJVYkpxV7jmBqW/GvWsVA8KAYqEgDKmCyCLTSltIHqV
         OJTf7vuc6bHQ1rIxaNZ8uHPUPsn9crBIjQzLgAdVpuUU+IXrOeZTHO6QdsVep3kPk/HM
         xqbwSWXeC4ksVThoEZfmKR06Zy2WRIvx4BqxFDWiEBE+fHRrY3+WuNpoMwbXmkGy3Bvl
         id7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qg+PjIH80BWgPjryO+lEfxqIjbHNYFW9R/NziKjRsqg=;
        b=yJu7S2paMQgK/HiDbP1eo84fKFWZbxBw9eCDC2UxJfkw9Ihwj97GXttTt3hGVZuATc
         Kn/2qroeCykOG3FvPHcNEkFzvn8fq75JcHtqRaHLNdwz0tmpyls6mjNcnxlhFY8xKwLK
         +dvMccFUDNEiPcBq/afKZwLp1sCboL/x5VjcWEvFSYzv6jSYYAcyL2Oj/z8ifF1RdXDN
         19uzPY0j8EApWiTliExgKuTQyl67DSTp9+FrscxAlQa/CrcJ3Yd+tRv18EAI3YqJ1XeX
         omeyB0vrCx0wRugMwuefFwBLduwvJyChKlswRYyI2Zl8IZfJ8Pwme6CcnTOjrhiaDVLk
         gZfg==
X-Gm-Message-State: AOAM533STf1z5GkInrDcYyyO8mM/xxkvm/Ezk7l5X0pXC/VczKabwdj9
        vqVQlPjILFBWcAnqxqFzmhuLU82+zZPqkSgI
X-Google-Smtp-Source: ABdhPJzqnTOXeTQ4O1sXqY7E5WC4qdsqLpqMgymb+DcBsNbTzji3GC2bw0lIanvntFtT1EdmpOHW5Q==
X-Received: by 2002:a63:874a:0:b0:3c6:aa29:15f6 with SMTP id i71-20020a63874a000000b003c6aa2915f6mr5982815pge.210.1652109259085;
        Mon, 09 May 2022 08:14:19 -0700 (PDT)
Received: from potin-quanta.dhcpserver.local (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id k7-20020a056a00134700b0050dc76281b6sm9221596pfu.144.2022.05.09.08.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 08:14:18 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 1/6] ARM: dts: aspeed: bletchley: enable ehci0 device node
Date:   Mon,  9 May 2022 23:11:13 +0800
Message-Id: <20220509151118.4899-2-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220509151118.4899-1-potin.lai.pt@gmail.com>
References: <20220509151118.4899-1-potin.lai.pt@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable ehci0 node for USB2 host feature

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index be76cd955129..b7439df65423 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -840,3 +840,7 @@
 	status = "okay";
 	/* TODO: Add Marvell 88X3310 */
 };
+
+&ehci0 {
+	status = "okay";
+};
-- 
2.17.1

