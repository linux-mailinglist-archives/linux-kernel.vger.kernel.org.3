Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89E54ED86B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 13:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbiCaL0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbiCaL0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:26:09 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA8CE01D
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 04:24:22 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g9-20020a17090ace8900b001c7cce3c0aeso2230822pju.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 04:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=i57N+tGNg9+lxUlQKsWwq5Omt6VcQdu96X0KROKr1/k=;
        b=KtqlA9fX/tJSJ02dmocwpAP424iX3FqSF65XaMLx81Uaubal027nAO76/jDh9EelCQ
         CXOr5jfPzHhERNgPvaSFHrrdb813KKHX3/GeQQiP/Wjh+ANE3dD7DLqxWMdDW7zmZaLi
         WTK21c7ESmN2y5EmUTLI3rNGuBTER4hMGiqfajejPzkmaBL35k1zsfe7+j2qFDAPzQ1S
         Vaxonxny+3ueKDkJNqaZQOPFEYg9BNFUK8QwH28NxXJh3V29BkJvUs732E8+zEciHZBX
         VU4oVld459kWWj3uQZr+YhGMPBlX4xY5VKA8PnBZ6VFVqV74+A8r4eBBEqh30GsYJk7r
         4fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=i57N+tGNg9+lxUlQKsWwq5Omt6VcQdu96X0KROKr1/k=;
        b=ixRAJImCLGmxkdxelkadzopoutrHH9F2VyLBDt6GcKb/5pPVkeMxPiFLwzQ86WyXQ9
         Fsa+u9TNJSF4FZnwuR12hYvlzQLj7EtjwH36mkaPsWVOrxDr4zWCsQXCHYUIMeA0Ajt5
         wLAgRO+JpCqWsT6bSLqQZ1alGiZDFRVznupQd4T51W/EKizUzTfLN/UZhpHBJorZAiYM
         GR89i8QYYfLGs4YIm9EUy3volmVMYyabSqhyd9ha3NAxBekNH5G7zuqIJiS2Lf63R0DB
         1rGyXBdr5XAjLZZeuTXUGnRUiwWbtB3G4GqTAnaV7F/HVoi+/JMFTyk34yax0uSKqdXR
         N0pg==
X-Gm-Message-State: AOAM532r4W1hHE6jL5tc9IktZocsw02R3NS642ZucnQzOmRthvpIvQ2S
        FOuy7xcYMxKRIvAbL7qXYiI=
X-Google-Smtp-Source: ABdhPJztcnIK6iFTn+TcQVq5JU0xh1tEw3pqrLYDdKQiAGOlzjy4M214ICBNWrIIxeKGLQSIpQ3CBQ==
X-Received: by 2002:a17:902:a404:b0:14b:1100:aebc with SMTP id p4-20020a170902a40400b0014b1100aebcmr41196969plq.133.1648725861768;
        Thu, 31 Mar 2022 04:24:21 -0700 (PDT)
Received: from raspberrypi ([49.166.114.232])
        by smtp.gmail.com with ESMTPSA id nv11-20020a17090b1b4b00b001c71b0bf18bsm9998073pjb.11.2022.03.31.04.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 04:24:21 -0700 (PDT)
Date:   Thu, 31 Mar 2022 12:24:16 +0100
From:   Austin Kim <austindh.kim@gmail.com>
To:     linux@armlinux.org.uk, arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        austin.kim@lge.com, p4ranlee@gmail.com
Subject: [PATCH v2] arm: kdump: add invalid input check for 'crashkernel=0'
Message-ID: <20220331112416.GA1002@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Austin Kim <austin.kim@lge.com>

Add invalid input check expression when 'crashkernel=0' is specified 
running kdump.

Signed-off-by: Austin Kim <austin.kim@lge.com>
---
 arch/arm/kernel/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 039feb7cd590..1e8a50a97edf 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1004,7 +1004,8 @@ static void __init reserve_crashkernel(void)
 	total_mem = get_total_mem();
 	ret = parse_crashkernel(boot_command_line, total_mem,
 				&crash_size, &crash_base);
-	if (ret)
+	/* invalid value specified or crashkernel=0 */
+	if (ret || !crash_size)
 		return;
 
 	if (crash_base <= 0) {
-- 
2.20.1

