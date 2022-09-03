Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D5B5ABB99
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 02:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiICAQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 20:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiICAQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 20:16:53 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C948BF2CA5
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 17:16:52 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-12243fcaa67so8640692fac.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 17:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=fBnAcPL60R4i5WvZyiptdvRLsZSLVLLRY1IeHgDEcNY=;
        b=glSgbFFXvowDD+JhZTH1Wr6MBVWTP8OZk46UaIj+wd1y55JidGWICHZGwkv+c+Lw4d
         aXu8IN1siiOO/t7uKCVmLkJd2hEvppP/hL0+Tcv4UAaoZUu1cwuqeaLlUgfIx4cwpJ0G
         oAXc/5U8xQWDPDXNM0619QYM18mv2N2rF1YKMi9XOT+rZxNSfjL8OoeuWm7BeNi44tyQ
         L5iucehN2mlY7JsTEhLof5GvuFhSzxFkOnRXKKkuwuGlWpjmsZzJfoO0FkWMKyX2Pd5H
         wKWTbn3Xs+80AD65ruo1EmSeCl3yjo9qMEWIgJIvDopvcJ+03OaniF2tn6mAChQq1wJ2
         kK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fBnAcPL60R4i5WvZyiptdvRLsZSLVLLRY1IeHgDEcNY=;
        b=l/yh43Z2BganjEXXrf5xJuSV/nCaQs2S9uEmmncVhbljVq4Mc/zd8b/cRk2Qx++egT
         KeMnunSPSAlo1YhLseifc6BETXgXA27sssVtANaQ9D7aH6CMsE38WH8tPLxuEy7GKMh9
         6CO8GknCXoHIdmAXSpfzmVIrUTYBobDqow4uX54S51eDpc1Sqo2mmNtmsX88/+p4duCT
         l5Rt6upaCf90GaFxa06cUmiVx69zVaTDzLlC4uXyLgk9whflfbw2n/efyZoPDU6Xic10
         /Aopz1WyKhE/kiXI+rXi9/5cReqPcUbSK6oDsWkOJEa3hIMd9etjXvE3wiRYauGNn/qz
         Bv0g==
X-Gm-Message-State: ACgBeo11mG3VMhBJITVNXveRe0d7Ejc8pMIxcghwN8ZJHsiOXeSaeDUb
        HS3Bf24HEfwUyz9Ei9/EjWs=
X-Google-Smtp-Source: AA6agR6alOWg6QLWORtW5F2fJCQgUQpaPohHWaGlbzDH85I76NEN+JY3Y18tdvCV7aZrUy/lSan46w==
X-Received: by 2002:a05:6808:1441:b0:333:3929:d079 with SMTP id x1-20020a056808144100b003333929d079mr3062871oiv.21.1662164212159;
        Fri, 02 Sep 2022 17:16:52 -0700 (PDT)
Received: from localhost ([104.183.150.195])
        by smtp.gmail.com with UTF8SMTPSA id e38-20020a05687023a600b001048f70e03dsm1875121oap.15.2022.09.02.17.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 17:16:51 -0700 (PDT)
From:   Fangfei Yang <yangff1@gmail.com>
To:     luto@kernel.org
Cc:     dave.hansen@intel.com, dave.hansen@linux.intel.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        sroettger@google.com, x86@kernel.org
Subject: Re: PKU usage improvements for threads
Date:   Fri,  2 Sep 2022 19:16:48 -0500
Message-Id: <20220903001648.17171-1-yangff1@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <26078f2a-67be-4aa1-bbb2-dcd1168c9d12@www.fastmail.com>
References: <26078f2a-67be-4aa1-bbb2-dcd1168c9d12@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> sys_sigaltstack() is already pretty much useless with SHSTK, and it’s kinda busted with AVX512. How about we just add a whole new non-kludgy API?

Hi, why is that useless? Signal is not going to change the SSP, all it needs to do is creating a token that can be restored by sigreturn in the future on the current shadow stack.
Can you provide some examples about that? Thank you.
