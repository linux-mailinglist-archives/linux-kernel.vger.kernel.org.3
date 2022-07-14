Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161C957479C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbiGNIzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237477AbiGNIzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:55:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD06402FF;
        Thu, 14 Jul 2022 01:55:44 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b26so1647962wrc.2;
        Thu, 14 Jul 2022 01:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Pd0s7pfe+tSy6Zgyr/2+hXl9JvN+53ozZq3gL+wyK/M=;
        b=Xuvter0RBrh9MX3/Pb+Mj7eC1QfF1ydLL9v5qHPRgib4vj+ZdmWEmh2umCkpKJh8SM
         y8NF4Ki1myo4QkPvgoyORzfGd1SN38VGB2psdRLzp59/VgIgaok29xtIAQ/XQoeKVMu9
         yL8z4LmxXrH8MTJw28M3Nwo3pXn+TpxtazoomrQTBPeyrGIgphVAIQOTzDD/LLBdNdUV
         wj5Zvx5TJsBMJTzGX/WlVHV5iDak0nClAYPXY7nACAVOwiC7YxcnZ/gf+OBLa0sanlK3
         Ii2mMhHlo324/otp/OtGpH7vJKEBAM/6js+a+vPfayyAHZMhoJfNcRzrcj10XJW3EQha
         AHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Pd0s7pfe+tSy6Zgyr/2+hXl9JvN+53ozZq3gL+wyK/M=;
        b=LtFS9LN26MGtuq/w4Ch/eqaEYwx6QTBbdxKCQB6ML0P4H8CHGP2bU65HzsLgBXmbUi
         ecU5ZgtZamvpFBjvjJ/Afy5wn09u19+KF+uS5Qf677sB9v/OXVWJ4SQjZp9DBFHkGBR2
         mEilllDd7OPW3tlVvuCGsoXDu4BlzSKXZbI8JlYetmlRT8C4OFiiIuxWvKraOBoM+Wct
         4nWBTBmFMEEcF/fvaAtG+7fum9s1ZTRi+9+6DkaJEYEmkjD18ZLx9v5VzES7PA1VeMcm
         +2I4ox1To9/nILWg1jOj8NYthKxHSsty0HHewqs3HU8HSdoMHILSop1zVGbTczJZNJnh
         jhlw==
X-Gm-Message-State: AJIora8Oo5v+Awqgoijjxv3BJ+JjGamLKRvPjEIZuEzACx6gR8nSkHMx
        bChRk6bv2+i811QHbMzTcLn5Mq3r5QqodQ==
X-Google-Smtp-Source: AGRyM1utCuahz4E7ykNJPLlcno4icCMBdFOP4g3e7uUfZNXmhAcQ/BHe9adH2rCC0hzyKAM5Eiy37g==
X-Received: by 2002:a05:6000:1f0b:b0:21d:6dae:7d04 with SMTP id bv11-20020a0560001f0b00b0021d6dae7d04mr7314231wrb.414.1657788943226;
        Thu, 14 Jul 2022 01:55:43 -0700 (PDT)
Received: from debian (host-78-150-47-22.as13285.net. [78.150.47.22])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c465000b003a03ae64f57sm1173997wmo.8.2022.07.14.01.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 01:55:42 -0700 (PDT)
Date:   Thu, 14 Jul 2022 09:55:40 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: mainline build failure of powerpc allmodconfig for prom_init_check
Message-ID: <Ys/aDKZNhhsENH9S@debian>
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

Not sure if it has been reported before but the latest mainline kernel
branch fails to build for powerpc allmodconfig with gcc-12 and the error is:

Error: External symbol 'memset' referenced from prom_init.c
make[2]: *** [arch/powerpc/kernel/Makefile:204: arch/powerpc/kernel/prom_init_check] Error 1

The commit ca5dabcff1df ("powerpc/prom_init: Fix build failure with
GCC_PLUGIN_STRUCTLEAK_BYREF_ALL and KASAN") looks similar but the error
is still there with gcc-12.

Note: I don't see this error with gcc-11.


I will be happy to test any patch or provide any extra log if needed.

--
Regards
Sudip
