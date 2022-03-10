Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410964D5233
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245364AbiCJSSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 13:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbiCJSSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 13:18:09 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B3113D900
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 10:17:08 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id fs4-20020a17090af28400b001bf5624c0aaso6021176pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 10:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8i9PcoBgS4Z5fTHkHhwCw2b7OCjvoaGKsCGSTw+C1tM=;
        b=FHz7R3ScT4P/6jx0UHpLjssNo+wzcUAnkAq0eNZlWWEK3aYGOxTGOxoQ/SFYQ4gitQ
         IzTn31mtdV3LRCsbXyZSNMjDZxDVwh14jEA1Mz6aZXSZSmLrPmfX8dxOIT0DkyfXgObJ
         sadA5/c2IF8P5u2OaXSS9m3nK92vT8MhshqvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8i9PcoBgS4Z5fTHkHhwCw2b7OCjvoaGKsCGSTw+C1tM=;
        b=G9yBgob8JeA9LZYZ1iidbcVKHynUkIjoTAdalRCTufioiUUlqeGEIO3yV0+YyYYCho
         PrwcrqwmgCx9/z4lBNvbtL2JUOvSwkpDaUpdimkHPFY4vfJlZFPJUUDRi46QwMbBpVRB
         RAihBxk9LUNRjKEATPF+bpVfzVqc3yMUdaSjViufAOPxlRCvmGiX/+FAWgg6Epg4OW7v
         k9Cvt3euicZQ2ddPx6wrek8nxDZeMX8wb7KDqcP0muAnOdH/NIY6w3uywhSlMBIQFl71
         xBndgA98UTGvOokZHu61S/6VrZkKyIeEfjM+rcb+OGHnxV6uBkhZ5FOH527hZinJHFQP
         9tcg==
X-Gm-Message-State: AOAM53129j9SdYMt9ih8mRDa7jlxYn7ajRe35hjpSi97KekngGEXyvdB
        TLwSHskvxlcAh11DO8ElWjvqug==
X-Google-Smtp-Source: ABdhPJzmiruB6ATSxE49WZKgHvZiUJtMXmtRjvqxJVHf8r+8/uOrEQawYL1mjAJMJLNoP66nxh0ubA==
X-Received: by 2002:a17:902:9a4b:b0:14f:fe0b:5546 with SMTP id x11-20020a1709029a4b00b0014ffe0b5546mr6364220plv.46.1646936227861;
        Thu, 10 Mar 2022 10:17:07 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w5-20020a17090a4f4500b001bf3bdf39a8sm6785842pjl.4.2022.03.10.10.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 10:17:07 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     luc.vanoostenryck@gmail.com, nathan@kernel.org, shuah@kernel.org,
        mark.rutland@arm.com, akpm@linux-foundation.org,
        tglx@linutronix.de, ndesaulniers@google.com, linux@roeck-us.net,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, npiggin@gmail.com, arnd@arndb.de,
        masahiroy@kernel.org, ojeda@kernel.org,
        Dan Li <ashimida@linux.alibaba.com>, elver@google.com,
        samitolvanen@google.com
Cc:     Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: (subset) [PATCH v3 1/2] AARCH64: Add gcc Shadow Call Stack support
Date:   Thu, 10 Mar 2022 10:15:37 -0800
Message-Id: <164693613561.1275052.17242543278628621803.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220303074323.86282-1-ashimida@linux.alibaba.com>
References: <20220303073340.86008-1-ashimida@linux.alibaba.com> <20220303074323.86282-1-ashimida@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 23:43:23 -0800, Dan Li wrote:
> Shadow call stacks will be available in GCC >= 12, this patch makes
> the corresponding kernel configuration available when compiling
> the kernel with the gcc.
> 
> Note that the implementation in GCC is slightly different from Clang.
> With SCS enabled, functions will only pop x30 once in the epilogue,
> like:
> 
> [...]

I'm taking this one now so it'll make the merge window. We can hammer
out the lkdtm test after that.

Applied to for-next/hardening, thanks!

[1/2] arm64: Add gcc Shadow Call Stack support
      https://git.kernel.org/kees/c/afcf5441b9ff

-- 
Kees Cook

