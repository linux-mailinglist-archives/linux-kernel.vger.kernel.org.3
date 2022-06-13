Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C360549CA8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346560AbiFMTBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346301AbiFMTAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:00:54 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5744B99813
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 09:26:15 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id g8so311611plt.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 09:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J1RWi167fIKnMNjaR08zesQVT30i6h2kbyWDzKMWE+4=;
        b=ehDqdc1siKQKeniiqCQs4IItLbHYD47+/BZiGU/Zb0uftr9ePdeUHFrYDj2XTq9XCP
         1Kh61Ls/0kMl9beuCjp7fd9H84EOIUDX57h4+F/Y1gegbMXXPY2BFD8BQ9f0gSTFL5U+
         liiYTQW1PmpItIc8cC2nAgYkakZalTQD/JRgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J1RWi167fIKnMNjaR08zesQVT30i6h2kbyWDzKMWE+4=;
        b=73zlpjTGtNEU4pqYmcAJ0LBj5ikGrhhy9p6H/QH5gHHjC7xsj16KPuYRFriMrPokvk
         EQeMugPPGH7AbWz77DzFXc4kg8n+WjHgQTHpdfswi/DK6nlfNj3gzj1/G4eC4cz3xGpI
         Hvs856ttUpyVos1DYw83fDbnMvu5B3QFYOq5Vrs/I0DNKJBYhK6d0ky7khbWsZMz/ogm
         eIkU6FA1Hk3XqEwUVNev12Mc5Ppn81eUS6MPaQYlOxodaXwlW5qV3QKmTNA8pd9SNEAV
         943rcu36OHqupYfUbkc4ZRJrGmb6OfMU2KZ9sMluOeKjS2kKBJM7LO1/QKaQWlffEGma
         3/dA==
X-Gm-Message-State: AOAM532dgsO+g/oMKs8dPopsm7QaEYfDwqy5Igb/vHBRArEJxcdOEv5i
        Tg9kBO0+B6WFgODgnqFYepfNTQ==
X-Google-Smtp-Source: ABdhPJxSn/zEAGXFFALT3BQJdt0yv827pjR4PNAAROwuNxZWh+wV+7HZ0h+SSHcbzzyihGdIecqB2w==
X-Received: by 2002:a17:90b:4ac8:b0:1e3:4f6a:2d04 with SMTP id mh8-20020a17090b4ac800b001e34f6a2d04mr16793660pjb.233.1655137574841;
        Mon, 13 Jun 2022 09:26:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s13-20020aa78d4d000000b0051c70fd5263sm5587153pfe.169.2022.06.13.09.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 09:26:14 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     samitolvanen@google.com
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, ndesaulniers@google.com, nathan@kernel.org,
        paulmck@kernel.org
Subject: Re: [PATCH] cfi: Fix __cfi_slowpath_diag RCU usage with cpuidle
Date:   Mon, 13 Jun 2022 09:26:10 -0700
Message-Id: <165513756775.2849041.2389986534725002694.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220531175910.890307-1-samitolvanen@google.com>
References: <20220531175910.890307-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2022 10:59:10 -0700, Sami Tolvanen wrote:
> RCU_NONIDLE usage during __cfi_slowpath_diag can result in an invalid
> RCU state in the cpuidle code path:
> 
>   WARNING: CPU: 1 PID: 0 at kernel/rcu/tree.c:613 rcu_eqs_enter+0xe4/0x138
>   ...
>   Call trace:
>     rcu_eqs_enter+0xe4/0x138
>     rcu_idle_enter+0xa8/0x100
>     cpuidle_enter_state+0x154/0x3a8
>     cpuidle_enter+0x3c/0x58
>     do_idle.llvm.6590768638138871020+0x1f4/0x2ec
>     cpu_startup_entry+0x28/0x2c
>     secondary_start_kernel+0x1b8/0x220
>     __secondary_switched+0x94/0x98
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] cfi: Fix __cfi_slowpath_diag RCU usage with cpuidle
      https://git.kernel.org/kees/c/57cd6d157eb4

-- 
Kees Cook

