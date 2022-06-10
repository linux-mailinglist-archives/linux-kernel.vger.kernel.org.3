Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60903545C7B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 08:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343703AbiFJGoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 02:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346605AbiFJGnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 02:43:45 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D185CB71
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 23:43:43 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id i131-20020a1c3b89000000b0039c6fd897b4so160261wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 23:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+pMYTdTOwcWkh7F/q0j0AiuTSMLZ7GoNW5PGLysPGgQ=;
        b=RY0+3FU0v4gL04KoZBho/SaD7j9RO8it3RTo+CNH9f+5KS/uvSeAfZCjs0d34jJGB5
         lsoRPDGq0g7zFmKVmMm0g1grQHXNaARt5wgIXnY/W/11KM+wTFGwGHvICwf8Ji2BKm2B
         irT9Uk2ydvgv7peGrN1GShuBnLBMnjAjiCdivYPNWxVrSF7gp7p3ilC9qi4HYXj9DA9N
         6hJmKhFeJbhMmr3htXMx6ng1NDUuitPa9w/FilqUhftxR6wBQwBwg6f8Vk5NxUWTpZGG
         jIq/cILt9VsVBgJY5KWln8kaXo/HJqXr0+Cn0wVHZNER1aTJ8xiPTs4kGi88gRT9H4n7
         2I4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+pMYTdTOwcWkh7F/q0j0AiuTSMLZ7GoNW5PGLysPGgQ=;
        b=vTXQXYqnvXLjylcc82cp1mBcgU8CjAodJogdQrPTfYkdQHloowAKSfO0oDbtbB0oIb
         QDTfKjHF7QjYrrEHwcqmvqXB1pPNfkGlRgpM9CC80NcyNkR740096IygE2kyTv+fQepg
         hwFZu3J+YOiZdDKlqCSrTWIUL22qbUrXKLm5YjsoUPdAJG0G3R9xPhL9leB/RWRYLTYp
         ulmKt0DOn+ppNszRBPPUdTNMNIY+X/Q11hcU1eziIYmrkNqUX/Ter+goZwgJIDtvEI8l
         h0ydHvJk0KE/CQIRzlTFn7gl8V+kO9ci4YB+p8m9kdF+RuymVLC/KRBek6I/Ms1RnOtg
         nYIg==
X-Gm-Message-State: AOAM532N/p4uVXxryj+/rcKPTZeXatVD7D1OwrLm/7XIztktIRChgBGh
        pqJgHztOaBdS8wOIMHnH+8gLBA==
X-Google-Smtp-Source: ABdhPJyfRLX7Z45385BozdvtX7Q1i5LrdI5pS4W17si77omQpV9Jutm5XmEuywAMqOBLbVOjy6g81g==
X-Received: by 2002:a7b:cd91:0:b0:39c:4a18:1533 with SMTP id y17-20020a7bcd91000000b0039c4a181533mr7051332wmj.148.1654843422354;
        Thu, 09 Jun 2022 23:43:42 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:27b0:82d9:d0c6:702a])
        by smtp.gmail.com with ESMTPSA id i65-20020a1c3b44000000b0039c5a765388sm1799916wma.28.2022.06.09.23.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 23:43:41 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Carlo Caione <carlo@endlessm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Miaoqian Lin <linmq006@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Cc:     Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] ARM: meson: Fix refcount leak in meson_smp_prepare_cpus
Date:   Fri, 10 Jun 2022 08:43:38 +0200
Message-Id: <165484341553.1385009.11750075420975194525.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220512021611.47921-1-linmq006@gmail.com>
References: <20220512021611.47921-1-linmq006@gmail.com>
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

Hi,

On Thu, 12 May 2022 06:16:10 +0400, Miaoqian Lin wrote:
> of_find_compatible_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> Add missing of_node_put() to avoid refcount leak.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.20/arm)

[1/1] ARM: meson: Fix refcount leak in meson_smp_prepare_cpus
      https://git.kernel.org/amlogic/c/34d2cd3fccced12b958b8848e3eff0ee4296764c

These changes has been applied on the intermediate git tree [1].

The v5.20/arm branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil
