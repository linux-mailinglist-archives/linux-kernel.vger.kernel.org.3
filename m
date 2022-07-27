Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA475834C3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 23:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbiG0VNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiG0VNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:13:51 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF7D4E60F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:13:50 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s206so16877452pgs.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YHrp+/mnJmHfV69EUAYZdN7aFUtabolaTlyqxdvvPaU=;
        b=Jtp2twDnzN+4lWaWTsFbsKGaBtyat8ch1PmoFuOXt68nO5wqOiMFomfJhAZjw3mihm
         Cj6sAu38qi4Mhu0CXP0FrbKv+B9zeWomjPcPK7nT9VNK3aUlepC9S5nuNfviS8aFofK7
         CeOTLuly65dMx9aZTq/hzifVONzGQiTDoxNRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YHrp+/mnJmHfV69EUAYZdN7aFUtabolaTlyqxdvvPaU=;
        b=eNJlvJG3r/Pp/tt21nZp5X51tXCTDtcmoorGZcFtLS2xB+i/kA0OTx2kqxeLTMYhty
         NvKIazBWtomNYlViSclXrBEzB1Qg426EGhNJLDk0iM8juX7xj51CEIT+Tg+SqUiPAGbp
         WexH98zGd9gNVZNnBz73thmouqdeF2vLob3UKwBllaVw4+0SMz+gfylC5XsLXd2uk2fh
         x0o4kqzf/RHWj9Cmuzhdn9gYuQd00SWy5fHdWJavdn4IX3gd5T/ZU+apC+YhfPUdbZDz
         dN28PglV+kJvZ4oZOOtxlmxs8cMEgPV6RD9JpctOKuyQOtDG3fsxoorMfb543YYcDUZf
         PA/A==
X-Gm-Message-State: AJIora9u+YPBRANpJW5l6+snSQRm6/NtyvfP3l8wUGfR5vW6sgFPj+bx
        SG/xoIdGxYOn0aSB+0zu2OrLgA==
X-Google-Smtp-Source: AGRyM1vdkfYRiqix/j7n8sooInJkoyk6a2nXU232zrO69Dea58sX+6BxmUs4R8B8kSGyKxalspeuTA==
X-Received: by 2002:a63:560d:0:b0:419:759a:6653 with SMTP id k13-20020a63560d000000b00419759a6653mr20669183pgb.219.1658956429931;
        Wed, 27 Jul 2022 14:13:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n17-20020a170902e55100b0016d6c38d37bsm8013304plf.156.2022.07.27.14.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 14:13:49 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, fmdefrancesco@gmail.com,
        ebiederm@xmission.com, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>, ira.weiny@intel.com
Subject: Re: [PATCH v2] fs: Call kmap_local_page() in copy_string_kernel()
Date:   Wed, 27 Jul 2022 14:13:44 -0700
Message-Id: <165895642099.601089.13587838249930753502.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220724212523.13317-1-fmdefrancesco@gmail.com>
References: <20220724212523.13317-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jul 2022 23:25:23 +0200, Fabio M. De Francesco wrote:
> The use of kmap_atomic() is being deprecated in favor of kmap_local_page().
> 
> With kmap_local_page(), the mappings are per thread, CPU local and not
> globally visible. Furthermore, the mappings can be acquired from any
> context (including interrupts).
> 
> Therefore, replace kmap_atomic() with kmap_local_page() in
> copy_string_kernel(). Instead of open-coding local mapping + memcpy(),
> use memcpy_to_page(). Delete a redundant call to flush_dcache_page().
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] fs: Call kmap_local_page() in copy_string_kernel()
      https://git.kernel.org/kees/c/0ff95c390bc8

-- 
Kees Cook

