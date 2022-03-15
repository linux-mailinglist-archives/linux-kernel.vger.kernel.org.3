Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD634DA21E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 19:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350996AbiCOSNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 14:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351017AbiCOSNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:13:01 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3F25A083
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 11:11:49 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id s11so200559pfu.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 11:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZQPIygnZI3s8wOTqewXSrnx1w2bIQcvKOq/SiWBkQU4=;
        b=oRELj35FqUFc8yaeJQtZTjTyV/Qpr9lpHQrTxaVY+TpV1hPoRQSaUl/aI0HJqYcGjd
         1bvRTiXC7xEFoLyOvUqhr0L0/jhE9bBAgXxf475dEOYgVGA95Yt+XBtjx2waxkapzvJd
         qmyd4pf57uxVrcBSYI0VlHD2sdi6NtQ3L9G2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZQPIygnZI3s8wOTqewXSrnx1w2bIQcvKOq/SiWBkQU4=;
        b=R/nkNYrRpa8kKMsWdj17wN1O9xpzLjYN8PYqrjN9x7d86vAZX+WxKMSYAaQUV6fDgu
         fQKdcWQm/UJCOh/u551CIYq93tlR7jmvVPst5gkRd5xXW6vN9xqNv8UZaHkJEUHL9/l4
         PTjiwczCuKt7QlNqZj+Wo1VCh7LEVUkNjVKjZPeaditDHVCvt9ZJYWMxtFglLYBJqcqz
         e9XjdYRqs53LGSAYyc3mj5jOGtYPlqJoj+njtPSlTCNwYlH4JyRN2h+P63/UFEq6z3Ij
         R2AXrdoAN6142jKnjDByUGsxBNnwSS0FVljVzsiSV7CT1HesP+V07NWsRBwFxdUZMCAU
         23ZQ==
X-Gm-Message-State: AOAM5317vfxWUI/xF/ice7YsL7D9bZQlu32quBaakURqhkDvVLIrjRnK
        +nZOFbCZy12UssBnZ/oPlqxR/Q==
X-Google-Smtp-Source: ABdhPJxUCx9Xypk8fGvJvwDZp5k7IY+g+PskUfFuPWQ6wT0L2qvzlM8InrxBy4DDdiVx8Hsv9B1XZg==
X-Received: by 2002:a63:2a8b:0:b0:380:b9e1:afe7 with SMTP id q133-20020a632a8b000000b00380b9e1afe7mr25301727pgq.5.1647367908628;
        Tue, 15 Mar 2022 11:11:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o7-20020a63f147000000b00373facf1083sm20698127pgk.57.2022.03.15.11.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 11:11:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        stable@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Anton Vorontsov <anton@enomsg.org>, linux-efi@vger.kernel.org,
        Colin Cross <ccross@android.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pstore: Don't use semaphores in always-atomic-context code
Date:   Tue, 15 Mar 2022 11:11:43 -0700
Message-Id: <164736790118.3742734.9257736142357327917.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220314185953.2068993-1-jannh@google.com>
References: <20220314185953.2068993-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2022 19:59:53 +0100, Jann Horn wrote:
> pstore_dump() is *always* invoked in atomic context (nowadays in an RCU
> read-side critical section, before that under a spinlock).
> It doesn't make sense to try to use semaphores here.
> 
> This is mostly a revert of commit ea84b580b955 ("pstore: Convert buf_lock
> to semaphore"), except that two parts aren't restored back exactly as they
> were:
> 
> [...]

Applied to for-next/pstore, thanks!

[1/1] pstore: Don't use semaphores in always-atomic-context code
      https://git.kernel.org/kees/c/8126b1c73108

-- 
Kees Cook

