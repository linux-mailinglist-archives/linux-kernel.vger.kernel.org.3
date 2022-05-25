Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED470533AA8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 12:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242267AbiEYKeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 06:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbiEYKeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 06:34:17 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C4295A19
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 03:34:15 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id t26so35498107ybt.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 03:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=twxcJazKwLgxIrC3UAG8Ho1MO7Y4lBN1rQtK/6OcXKE=;
        b=3IaTb3shZB/oWypGeB4XbN8HP2yxZiCY7mNXLwct9tXmBcP2EcRGicDgvt+wg62YNl
         YKAudtIgO9ry+CJeRZcGL58Q/DB9QieOR2SQApj7gnn5CkxLMBV4oeh4G6dVJEmH4FF4
         eCrKmD/CG+/iHCPFT8Sp3Fh2gTIR4rGrGFrxhq7h0LaO86kwdrSpb/tlhnpRpHgcG50U
         BP1z6vdc5uxa7CYmAjFGNjtuIJnae+ItD7OOWoVVVezbwweAHC0ny8dmT5cuIElwBQjB
         XA4P1kvGynPhHJMj+WRpe+4jRI7960MTZQkxS827mA/2d6Pg4G2ZdEGZIXlEksZP6Crt
         H47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=twxcJazKwLgxIrC3UAG8Ho1MO7Y4lBN1rQtK/6OcXKE=;
        b=JhElkHTS9sTOpPrCZspsDSM2tv7NiKlJZRKfGqaTgjdaj7NtNpdU84YBCSxlt0dBQJ
         fT8/CF3l0uDY1ZIzDSVMXFDuASNLGy1WHSUkZqgJlLo1y7cz1EJ6cjp1d/vRCibZ68Ik
         +1/J3j5foLnfpzLoJ0/1Jplelm46lT7XZ7aXYIu2W/KbvRtt0SQHijRjQiHBExmp9Dbc
         WmY9JI/LOqD+9RbyoVoJqJqIRJcFPQBVbinzPFWaSGJ4OCNzUc1BreuF7YSsQlXlF1Yk
         WbBbyNyFTm44xxr/I4sFxLDYpiZrAhKrkUNXKOV7WmuyHYAg0oJ1dNJolLbKWYw01izx
         JKaQ==
X-Gm-Message-State: AOAM530+v3WOK+wfEdqcICREsbS0LNSjic6I9d63GPFqeWSXsvvP9ZbR
        0QU5XgK4YunRLYE/Ht7pYTbojewOu0+cxYGPrVzsxOfZ7J4=
X-Google-Smtp-Source: ABdhPJyqYoEWwNr1x2tVlf1x5ELG6j4d5rUU3GpJVYF9eR7icwiKVUm1n43Il17moGlx68UnivonjIuJqENbpXQJUXM=
X-Received: by 2002:a05:6902:1382:b0:63d:be0c:2e7c with SMTP id
 x2-20020a056902138200b0063dbe0c2e7cmr31193605ybu.122.1653474854930; Wed, 25
 May 2022 03:34:14 -0700 (PDT)
MIME-Version: 1.0
From:   Eric Pilmore <epilmore@gigaio.com>
Date:   Wed, 25 May 2022 03:34:04 -0700
Message-ID: <CAOQPn8sDMbzy6ZatM3sW+g=Y8nrBStg+7xeQrM+nvDmTiTV4Bg@mail.gmail.com>
Subject: What is limiting my CMA?
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running on CentOS7 on a 5.3 based kernel. I have CMA configured
into the kernel and attempting to manipulate the amount of memory
reserved via the "cma" boot parameter. I have one system with 32GB of
memory of which I'm able to reserve 16GB for CMA. However, on another
system that has over 512GB of memory, I can only reserve up to 8GB for
CMA.

My question is, why am I not able to reserve a larger CMA region on my
512GB memory system as compared to my other system where I could
effectively reserve half of the DRAM space?

Thanks in advance for any advice or pointers to where I might be able
to find an explanation.

Eric Pilmore
