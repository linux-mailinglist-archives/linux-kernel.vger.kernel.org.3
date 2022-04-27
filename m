Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE91651109D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 07:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357907AbiD0FpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 01:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiD0FpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 01:45:23 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6C215780E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 22:42:12 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l18so1190880ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 22:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=gFxvg7Y0dhPC/gphydY3fVHC/WWpQi5A5yHvDF5Rd5s=;
        b=k9U+xo8XzI3sb22rLOxvHIROszdR/ZDQp3uJyoHpz3FCeBIpzR9WqQILteCkCxlXeY
         QWRPaQz63T+iGHIIh9dibJGWUc/zZKWYPGlKATqJvhiJ3AGMQvz8T2FuWRRu8DGu8/ji
         akZh79eLdSZ43771o4VcZ9znv6AEIyE43eLUJeG98DadrebCmyMyvv9iKre3hfL8xt/U
         f/r6hXwN1wdjj1p/1/VP9jsq0e1cck7DSBLRYIfKxpFgHVp7WUUYOciYQW05o0DEpK1p
         bv0JKSyTXvoxH6pN0SHXicLn7J+EVNroGUxVDM92iPL5T0zdUNS0uPp5B+2U0XUqLR65
         axog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=gFxvg7Y0dhPC/gphydY3fVHC/WWpQi5A5yHvDF5Rd5s=;
        b=cuXdQGA+L7kSBjl9AchQoL0ectDLLbPV06fyUvoOUXo7IAQ1PrFbmE3j0qlzffWimF
         ya1cdrtNugQAl8+c34jwYdlt7kNSeePLieBgT1TLaugVsR8hBVKDka2lgQ6GO7kXctNs
         GUUn7yLp7TLfPMnMZ0t/FdmICGFBTToYyjCHe91RK4YVTEf3FyIS051a3n4i3UeUfT+U
         h8ih4i08SVp3MnBi35Id7mfDnhvGwFW3mzmbEuIky0boh7DkFFUzifU/QxdAZ0Lov5IB
         ZL822rKqNvz1Uk7KxQKcCilRTZ/OLk8KUJ1wDWjP17SbSwvA4uLSpNImmlvYshWumhnl
         t89g==
X-Gm-Message-State: AOAM532h3WBHKJHN2fB/C9RZ0CykbOUvpDguNSQZVmUQfgYLXgYtOHcT
        3l6JXpIrS2NeMSsNb9awvwuRBxIjnju+Dw==
X-Google-Smtp-Source: ABdhPJwpnPAhtKiwMD/zpsP0qqUQaDzHCWwgakvehdlTAK5k+dxup0ofECpXhGK3I1KgE3hCWJtNmA==
X-Received: by 2002:a17:907:60cf:b0:6f3:9116:201d with SMTP id hv15-20020a17090760cf00b006f39116201dmr14454792ejc.727.1651038131144;
        Tue, 26 Apr 2022 22:42:11 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id o2-20020a056402438200b0041fb0f2e155sm3851494edc.20.2022.04.26.22.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 22:42:10 -0700 (PDT)
Date:   Wed, 27 Apr 2022 07:42:08 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] staging: vt6655: Replace macro VNSvInPortD with
 ioread32()
Message-ID: <cover.1651036713.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro VNSvInPortD with ioread32.
Avoid cast of the return value as much as possible.
The name of macro and the arguments use CamelCase which
is not accepted by checkpatch.pl

Tested with vt6655 on mini PCI Module
Transferred this patch over wlan connection of vt6655

Used this code for testing of fuction: CARDbGetCurrentTSF in patch
"staging: vt6655: Replace VNSvInPortD with ioread32":
	VNSvInPortD(iobase + MAC_REG_TSFCNTR, (u32 *)pqwCurrTSF);
	VNSvInPortD(iobase + MAC_REG_TSFCNTR + 4, (u32 *)pqwCurrTSF + 1);
	dev_info(&priv->pcid->dev, "CARDbGetCurrentTSF *pqwCurrTSF: %llx", *pqwCurrTSF);
	
	low = ioread32(iobase + MAC_REG_TSFCNTR);
	high = ioread32(iobase + MAC_REG_TSFCNTR + 4);
	dev_info(&priv->pcid->dev, "CARDbGetCurrentTSF temp_ph: %llx",
			 low + ((u64)high << 32));

output:
[  +0.000083] vt6655 0000:01:05.0: CARDbGetCurrentTSF *pqwCurrTSF: 116e83
[  +0.000008] vt6655 0000:01:05.0: CARDbGetCurrentTSF temp_ph: 116e83
[  +0.000009] vt6655 0000:01:05.0: CARDbGetCurrentTSF *pqwCurrTSF: 753d80
[  +0.000005] vt6655 0000:01:05.0: CARDbGetCurrentTSF temp_ph: 753d80
[  +0.000010] vt6655 0000:01:05.0: CARDbGetCurrentTSF *pqwCurrTSF: 753d8f
[  +0.000004] vt6655 0000:01:05.0: CARDbGetCurrentTSF temp_ph: 753d8f

V1 -> V2: Removed patch "staging: vt6655: Replace VNSvInPortW with ioread16"
          as it was already accepted.
          Joint patch "Replace two VNSvInPortD with ioread64_lo_hi" with 
          patch "Replace VNSvInPortD with ioread32" and changed ioread64 to 
          two ioread32 as ioread64 does not work with 32 Bit computers.
          Shorted and simplified patch descriptions.          
V2 -> V3: Added missing version in subject lines
          Added change history in cover letter
          Removed remark in cover letter "This patch series is new.."
          as it is obsolet.
          
Philipp Hortmann (3):
  staging: vt6655: Replace MACvReadMIBCounter with VNSvInPortD
  staging: vt6655: Replace MACvReadISR with VNSvInPortD
  staging: vt6655: Replace VNSvInPortD with ioread32

 drivers/staging/vt6655/card.c        |  6 ++++--
 drivers/staging/vt6655/device_main.c |  6 +++---
 drivers/staging/vt6655/mac.h         | 24 +++++++++---------------
 drivers/staging/vt6655/rf.c          |  2 +-
 drivers/staging/vt6655/upc.h         |  3 ---
 5 files changed, 17 insertions(+), 24 deletions(-)

-- 
2.25.1

