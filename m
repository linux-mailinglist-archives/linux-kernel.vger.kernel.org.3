Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160FB514E40
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377959AbiD2Ox3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359846AbiD2OxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:53:25 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B968A6E34;
        Fri, 29 Apr 2022 07:50:07 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bv19so15916373ejb.6;
        Fri, 29 Apr 2022 07:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=kxG9R+Mj6hQ/bgRaikLvuXkk5Cew5MDIyTZHQmokcDI=;
        b=XIuFoea3IeF9X34o7Yg3zdHgCtAAk+fm6rFmlBkDvKIsuVbKd6BjegPYM5Ff6ITCsV
         tVQNEJdDWkyu6P6GWaDvCaaNnJ1+zZwEtBsbHYJ2ucobJqMh0c3LP6gN/vlBa414vLpQ
         4evPmnlzC7/caRAa7gvnKX3ZINny5bmrIOzUnfLAplVm+8DXVwGv2BSjjBTCLpejHL74
         ipnx6YhPQbwBXfplA5O/pH9MtM1hTY3yBzMeXTJCPe+QT6kMPV/AGMSJ79miJkeyIzyY
         H9eCsUHdRmurrohDAZkpO0sWyZL0ppQHR2lxmV8Y+Y/K6SQO90FnwFnm3/F+MpqND12v
         4tiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=kxG9R+Mj6hQ/bgRaikLvuXkk5Cew5MDIyTZHQmokcDI=;
        b=1ng3CYo3djcN7tA5MJsHDAp5YC3TX0NYZLhbsnm6creC0vsrqZzqs6Z7ldhDwhQcpF
         SjrN4S1QjqbHJthnwusC5MRDuXFd5LVojF8R6QlctiBzNquHuqHj/XjyINgzeA1kOlIR
         C9a0ZB0hsa4ae/H0TSYKu0BJgJeTFWZ4ybeNkYjhNLIjMQlupfWUxSpz97uH8U/tQbFW
         6S5CEZcb0M4oae0pc34hU5v9iVUG2n7B1h+zHG0fGLU6yazDQhXBusq+sVAn8YvrddWq
         Iqp1M9yDzemz+9mg4Zg93VDVnydhW06F9xTYi2ZvR6qDTOajvoHMZTpf5uinNXojk4L0
         rmQw==
X-Gm-Message-State: AOAM530cfWFM2SXDJtba7e2v/c0PD9WYEOpS8EedVUWZTq7VFJCq1BqQ
        iReOhLpIm52cbvKLRheNbJqOK/W21g==
X-Google-Smtp-Source: ABdhPJwkJBEZqlVOka7oGLAdvL6EGro5bKsusSCCIAJaQIEjq1gd0ncIyzjdpEWH5kuhg9t/q5w97w==
X-Received: by 2002:a17:907:2cc6:b0:6f0:2de3:9446 with SMTP id hg6-20020a1709072cc600b006f02de39446mr35955279ejc.690.1651243805956;
        Fri, 29 Apr 2022 07:50:05 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.143])
        by smtp.gmail.com with ESMTPSA id qr48-20020a1709068cb000b006f3ef214e0bsm719709ejc.113.2022.04.29.07.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 07:50:05 -0700 (PDT)
Date:   Fri, 29 Apr 2022 17:50:03 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH] ELF, uapi: fixup ELF_ST_TYPE definition
Message-ID: <Ymv7G1BeX4kt3obz@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

This is very theoretical compile failure:

	ELF_ST_TYPE(st_info = A)

Cast will bind first and st_info will stop being lvalue:

	error: lvalue required as left operand of assignment

Given that the only use of this macro is

	ELF_ST_TYPE(sym->st_info)

where st_info is "unsigned char" I've decided to remove cast especially
given that companion macro ELF_ST_BIND doesn't use cast.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/uapi/linux/elf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -134,7 +134,7 @@ typedef __s64	Elf64_Sxword;
 #define STT_TLS     6
 
 #define ELF_ST_BIND(x)		((x) >> 4)
-#define ELF_ST_TYPE(x)		(((unsigned int) x) & 0xf)
+#define ELF_ST_TYPE(x)		((x) & 0xf)
 #define ELF32_ST_BIND(x)	ELF_ST_BIND(x)
 #define ELF32_ST_TYPE(x)	ELF_ST_TYPE(x)
 #define ELF64_ST_BIND(x)	ELF_ST_BIND(x)
