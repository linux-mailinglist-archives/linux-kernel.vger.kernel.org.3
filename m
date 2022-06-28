Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786C155E0BF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245195AbiF1I2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344015AbiF1I1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:27:48 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6B35FA5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:27:47 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id jh14so10436989plb.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7VhI4uV7Lz+ufbvONj+FhRzkoi1GG7X2XmgVe2YYPGA=;
        b=SJisHhGGPZGxc9IF/aBYFWosdJ6yDA8l8niRm1E1AFy9FPGtfDCPrKUVmTcwZ7yp4K
         sd3ellhkQ14xJ6vfFGwVsTmHDERE+FVuWLMHrKTp2+RFrxwCGbRXXEZf4nkQBU7zb/pt
         wSW1ylNAmWyQGP4MQM88qpPviXw9jUrNrW2vzT21ac5CH8ry1lwCDSJBHmBR0CZt5QOx
         Ht/WoLRUBaaPMj1Gdd8U4I94GPtPQdysm1OiAigfCNawCKK6iYD63d9UdHKPDoUSd8el
         BQTYBRVKITT1OFQcm+zIUHOm2SLgpuEylSEDaF7+K8JwbRgr71MocD6VpCXiYf2cQcV/
         O8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7VhI4uV7Lz+ufbvONj+FhRzkoi1GG7X2XmgVe2YYPGA=;
        b=dqqqnfuYux02+pfnWHziz/NpREPRcxMcqgpdRdQ1JP9+Z5NSPPUg1reiGGB2Z/UwOS
         u40lLwhC57uXlTLS/FC6bgSNm+O9Ev0n12YAYRhIkVcot2bDddjgsEENliR4Du1W2ddp
         m2ujaLcm7G9MbKW72qKgPYymlUahZoNJ05GDbY14ZMD4h2Cxjb4B9xZ9yYshhtUbBgFq
         v8Mg9L1CSdpgPl/nIj3P0SPiJfxbwC9oqfb5ioC31vNoZTDESpacJERLbCXvh4Gvk6NK
         dDH7A4ir9VqFEp1qmaVtssblLpNP1sTJZjzwMMWTYaeatnsT90ZU6RQ4JDY9WYdLz1U9
         1nTQ==
X-Gm-Message-State: AJIora+k+zHfGA+Ex8dQLt9/2zh7GiVCgjYqzmyv9xbNCke9VXNGHgT4
        pIXJazsli19YTO3n3oKJY/A=
X-Google-Smtp-Source: AGRyM1uXQjIkhKm4Gl1Uct9nuONWq71XvxjUpP2XeeFIcIf2bu1icL+jBSuKWFxXbdP9wbg3aSr1/g==
X-Received: by 2002:a17:90b:1d06:b0:1ec:cd94:539b with SMTP id on6-20020a17090b1d0600b001eccd94539bmr20129991pjb.215.1656404867267;
        Tue, 28 Jun 2022 01:27:47 -0700 (PDT)
Received: from desktop-hypoxic.kamiya.io ([42.120.103.58])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902b40200b001675d843332sm8599262plr.63.2022.06.28.01.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 01:27:45 -0700 (PDT)
From:   Yangxi Xiang <xyangxi5@gmail.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        nick black <dankamongmen@gmail.com>
Subject: Re: [PATCH] vt: fix memory overlapping when deleting chars in the buffer
Date:   Tue, 28 Jun 2022 16:27:40 +0800
Message-Id: <20220628082740.4685-1-xyangxi5@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <10b4e5f7-95b9-38e6-bcd5-1132d595301c@kernel.org>
References: <10b4e5f7-95b9-38e6-bcd5-1132d595301c@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Why not to use memmove in both cases? I.e. simply switch scr_memcpyw to
> scr_memmovew?

Both of them works, and I pick one of them.

Yangxi Xiang
