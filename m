Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2553F55ABAA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 19:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbiFYRCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 13:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiFYRCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 13:02:10 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DCE15829
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 10:02:09 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x138so2555516pfc.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 10:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Lyqt/8xMEJfXAgB3QKmRd6F7TnQPwfOqSXGZzoVDZfQ=;
        b=GKyB12Ox3fecbB0aczZrQiVi9Yk1LyO8cPu3c2kKBUH1BT+1W+EY6I8OAsoG9EsvBS
         zYFm1eocUpAjMrmj7ORwrzVmA2kgYrzk0AwJwPbj2R7kNdllfBPVmwOYIH1izdWkztxR
         hxdPzm11ROPR4s0Jp/UDa57jBUnQ4YWYxjg6Lko6XNxxreOaNVoZYl8hGPvlg6fh9U4c
         G8sB0seKY6Lhu/l8C6rO2ORpMjINBZ1xVVbDTIQGwUud6WPG3RN2N8s7a/3+m5NhQhbf
         FzAnZjREKXw3B1Pa8Akz65REc/UCjYtKxEcxef0DMmHGUiX8j0LdF9DNd5i61QTD+Vkk
         yi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Lyqt/8xMEJfXAgB3QKmRd6F7TnQPwfOqSXGZzoVDZfQ=;
        b=75gP5qi24NLoLDrA0mL++Y5lpa7zy75bgybzscjZD8TGl8Sw/BTtogKzIfZfEURWcJ
         s5gaIQZCagVCgO0+3quuS0hLXQHXYhawZxWBeuF0I4K6/B8lG7PMFiGN+gw7nFG/czCo
         bGcVmOR+BLhoMyuvvWAozk2ZRMpUXtzNZjjtnp7AEch1r7CRKU4djDjCDoq3oaRiNHMV
         Y2LX5PEj2vpI5MMwwnXiT944h1eLuls7hW8YKwA0eE7TzzOeiTOKht7VaEMajZ35Y/c8
         rhyi61Fq+7pBOMA4+n/ddtUzUNOKPvm2g/zFCKmdFpL1o91RH+0xWhojaidf9IpiArpa
         ZxIQ==
X-Gm-Message-State: AJIora/Wp+wWW6/8sGHP081WdoJK59QynUtVTLpG8VZaJUQDxYBc3qZF
        k4ypohWLxbXEu6IrVErEmPuQyPYE2JKnIg==
X-Google-Smtp-Source: AGRyM1vOj1AtuviiNYkSsNdFzXCEmg0WINR16xuef7hYkKJP7AoH8til4kjwwPRyRlHFEbtkida7oQ==
X-Received: by 2002:aa7:8008:0:b0:51a:cae3:7563 with SMTP id j8-20020aa78008000000b0051acae37563mr5099164pfi.16.1656176528722;
        Sat, 25 Jun 2022 10:02:08 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id r19-20020a170902e3d300b00163f8ddf160sm3932508ple.161.2022.06.25.10.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 10:02:08 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     wuchi.zero@gmail.com, mwilck@suse.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20220605145835.26916-1-wuchi.zero@gmail.com>
References: <20220605145835.26916-1-wuchi.zero@gmail.com>
Subject: Re: [PATCH] lib/sbitmap: Fix invalid loop in __sbitmap_queue_get_batch()
Message-Id: <165617652775.121867.397759941071832869.b4-ty@kernel.dk>
Date:   Sat, 25 Jun 2022 11:02:07 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Jun 2022 22:58:35 +0800, wuchi wrote:
> 1. Getting next index before continue branch.
> 2. Checking free bits when setting the target bits. Otherwise,
> it may reuse the busying bits.
> 
> 

Applied, thanks!

[1/1] lib/sbitmap: Fix invalid loop in __sbitmap_queue_get_batch()
      (no commit info)

Best regards,
-- 
Jens Axboe


