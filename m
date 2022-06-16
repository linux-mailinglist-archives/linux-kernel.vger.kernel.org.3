Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8AF54E757
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiFPQa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiFPQa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:30:26 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BF52F007
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:30:25 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 184so1694379pga.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NGZra2EXAzLHhvW+Rx2ltiLUVuZcwe1XdYZcnOjkDHg=;
        b=NOwRne8XqcUUhyuKhlF+5HvgP3UvdzK8/fh9MFgoTFqiNh0P1LFPED1MPYxudrHJQD
         s0LNPDJGZYu3fewhvZ4e0qLKZFXlbMxc70IuVSyQ4FzetS2enU17cVKevqxx8+dSPuep
         hx3rhBWdNcqhVw8ur8q7WYdWttqTiZKhjIxi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NGZra2EXAzLHhvW+Rx2ltiLUVuZcwe1XdYZcnOjkDHg=;
        b=yJAzf54ym+8r1v7zuayYFMePCurePo/MqK6Usx3VRIDsQkK0f+YVJXHtJmwnO4VzBl
         8GUFOhuz9QgfgclKlLe86Q31HDawZfSpBjJs0wBw0pYtmIY0IP9LcYvMnIWDwSYHsmXh
         +u5vnCZU7Fe7w4Fk9PWEpJPWUq/JNtVuFhJJtzdsylptqMU9Bypo5frDsC/XA9vjQa7u
         bFRWEXCmhD+Y4RaEQpljn5DZkgmCB+hYaRc0RGDUBpBf3WA7SIQeKup6xh8row8wQdXn
         UES3lA9I51Ao689M5VtcTrwZ8NGtS1CHVQTXAif4gLoneMCch3pAQZ4bK5I/Fho2cR2V
         JD0Q==
X-Gm-Message-State: AJIora/3yG1ypIrtjCv+bM9A6LChgRwEG57jmwUf8Oyww/L6OeWixK0k
        5eTz+TEqxF4LM/ZSQjpEpzCwOQ==
X-Google-Smtp-Source: AGRyM1uuN87FEV5uTWR0IbCKzPsRK7nTwh7zISxsaLIezfzPOdcOQ5ZoPRB0MV7eFCd74z9myE1g6g==
X-Received: by 2002:a63:f944:0:b0:3fd:4f29:67e9 with SMTP id q4-20020a63f944000000b003fd4f2967e9mr5033941pgk.593.1655397024977;
        Thu, 16 Jun 2022 09:30:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y5-20020a170902d64500b001641a68f1c7sm1831548plh.273.2022.06.16.09.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 09:30:24 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, Jason@zx2c4.com,
        linux-xfs@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, urezki@gmail.com,
        joe@perches.com, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, willy@infradead.org
Subject: Re: [PATCH] usercopy: use unsigned long instead of uintptr_t
Date:   Thu, 16 Jun 2022 09:29:12 -0700
Message-Id: <165539694985.1107767.16603574353239972239.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220616143617.449094-1-Jason@zx2c4.com>
References: <20220616143617.449094-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022 16:36:17 +0200, Jason A. Donenfeld wrote:
> A recent commit factored out a series of annoying (unsigned long) casts
> into a single variable declaration, but made the pointer type a
> `uintptr_t` rather than the usual `unsigned long`. This patch changes it
> to be the integer type more typically used by the kernel to represent
> addresses.
> 
> 
> [...]

Given Linus's confirmation: applied to for-next/hardening, thanks! I
do note, however, that we have almost 1700 uses of uintptr_t in the
kernel. Perhaps we need to add a section to the CodingStyle doc?

[1/1] usercopy: use unsigned long instead of uintptr_t
      https://git.kernel.org/kees/c/e230d8275da4

-- 
Kees Cook

