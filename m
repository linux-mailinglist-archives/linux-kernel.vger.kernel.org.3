Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2034F5728C3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 23:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbiGLVqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 17:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiGLVqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 17:46:09 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AAACC7B5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:46:09 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 73so8743666pgb.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:in-reply-to:references:subject:message-id:date:mime-version
         :content-transfer-encoding;
        bh=A6xrqQWA6jeLZCKzGyv6HOaKaBTGjGBMWi46TTAW3NE=;
        b=dBCvL7PckWNfimecHeUdndjicSzsENsANzx9a2+4PzMtTJXW++/jGwuHPooILnuMqV
         TFSIO05QVRh4+j/Y+obn6avKugA39neLaq//1a5JKzAJaRgeg93qXqu7BdJNupsXlLuk
         NeH6Mzb77a8+uYfvprFoiSIEQWZ25cRIfQ2HV6umhZoXk1lCY3wGqL+QO8wHWjaUZTd+
         bIhyWMVhHF9JfBUm1WuNxZv37ubas0QkuFGN981rCkgyYJII+nfnEqv+bV4OjFSNcQfN
         5Fu2lUEJ26LVFznC1uNBnoTddjn4Jy+eI8J/oMhZG1hVMngwejPQg8oQHqvpDkHb6fgk
         0S5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=A6xrqQWA6jeLZCKzGyv6HOaKaBTGjGBMWi46TTAW3NE=;
        b=L5XlLwp3NESjtqWdGdwbO/dH3RU4vPKUvrc/rGUF+jXRAMzUdH8SMGbkYNOYk/EtsQ
         QnoH1nhbhHoITc0PPop5qESHmrRPyae4LP47s9ra3/cOoO6GM5Ooy7Yv/iczEDoH6pre
         dafJ0u5BZ5eCh/eEJqwfWzgAoVZIN+5oTZdLWUzlqTd8jOZqch15LNV8BUFh05XB6yuq
         ZVA6yxFmIiE7JiDEODAZF1mNiujZErkFSTyz1xRWkoO6QIF2S23MXGIXzjShPYMXGO6g
         6kuvQcBjMCBTJlAxe4ndq8zgn5isIO0NJHlTr8x9f3ie8AwPXx8+G8kZJki877wJoIXP
         lfKw==
X-Gm-Message-State: AJIora8wEwXbA//2B5U119n4C/Ds/AklX1PDt4N9B9hvupbI+rJxjDQk
        Aj6rnFiZ34X5aaucr6JMFDH8co1MbUvEOg==
X-Google-Smtp-Source: AGRyM1vWI+V7E6AzSreUqm3+cx1ca1Z7Shzh8KEPiwUAjimNW3hM3VzDqrS5RgbhHimZmzGlmWXSUQ==
X-Received: by 2002:a63:e057:0:b0:419:71bd:1d0f with SMTP id n23-20020a63e057000000b0041971bd1d0fmr257014pgj.538.1657662368306;
        Tue, 12 Jul 2022 14:46:08 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l129-20020a622587000000b00528d843afabsm7296402pfl.204.2022.07.12.14.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 14:46:07 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        ubizjak@gmail.com
In-Reply-To: <20220712154455.66868-1-ubizjak@gmail.com>
References: <20220712154455.66868-1-ubizjak@gmail.com>
Subject: Re: [PATCH v2] blk-cgroup: Use atomic{,64}_try_cmpxchg
Message-Id: <165766236676.63083.2141527891325153647.b4-ty@kernel.dk>
Date:   Tue, 12 Jul 2022 15:46:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 17:44:55 +0200, Uros Bizjak wrote:
> Use atomic_try_cmpxchg instead of atomic_cmpxchg (*ptr, old, new) == old
> in blkcg_unuse_delay, blkcg_set_delay and blkcg_clear_delay and
> atomic64_try_cmpxchg in blkcg_scale_delay.  x86 CMPXCHG instruction
> returns success in ZF flag, so this change saves a compare after cmpxchg
> (and related move instruction in front of cmpxchg).
> 
> Also, atomic_try_cmpxchg implicitly assigns old *ptr value to "old" when
> cmpxchg fails, enabling further code simplifications.
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: Use atomic{,64}_try_cmpxchg
      commit: 96388f57d2aad9836b2c589181fa1dbaba4066b4

Best regards,
-- 
Jens Axboe


