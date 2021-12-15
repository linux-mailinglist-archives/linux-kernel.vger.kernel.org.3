Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B42E476677
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 00:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbhLOXZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 18:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbhLOXZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 18:25:15 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC14C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 15:25:15 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id p18so2995714pld.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 15:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vDUcxi+1vGmZblRbJ1Sm9A93/BTFWuWvpCJG8LRDqkk=;
        b=DXYPMTYBbhpvhrxDXuuENJokIN1C4FOkTY68o9ZdjY2X0pGgYoeO8rgMJaLTIsJsrs
         hmhV7bxWtULdRgZPqxLDrtgFNOXSv0KV8oWxGpMGFNLqSmTy7fmcHkQ1kpl4yEeKFaCQ
         UoJ3WJjaqxJiystBa+XimfZjMEBdQR3ZC1UQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vDUcxi+1vGmZblRbJ1Sm9A93/BTFWuWvpCJG8LRDqkk=;
        b=5JH5lm3hVVMeeIpOTZzYCtdbr3vFnmv/rFJsH+xHGq/dA63xD3rfwX+LkdE/g1wF/d
         UsYr2ySoCcTKu/SZs0AbbGfASaHM5EaK240NjwQPkYgeN5tCqPFABC2mjNY4yityLnNd
         FJDMp6ym8GoqpUVPWGnm3d3Gyz8lKztnOzHfdRv6FTsv2IOI61axBbXP8Ks3+8grkfXH
         cqOs7xbhIIdu3njD6EIEW/SHp/G0m7jHZBkTJ3WvKZJ3hGLnEcDRS2V5y20FZnSOZEV/
         nuMaFNBNxtnOyWy5OA1ttXi0YRrowVkSUJlOHsZ6bD0Asf6vZV4HXtjZ4YvWC2ATi95p
         4axw==
X-Gm-Message-State: AOAM530oZrbSrPGYFFM/0YolrfQhEk7xkcPg0qBLhOT0skXJn4kKbrNO
        FGiHSGx4BvX+UDBRD27xnnTJHA==
X-Google-Smtp-Source: ABdhPJy5py/792S478eMSZrNlgV3972pgHifUoF5SICCwYNK+P2sBeyjHIvi7Ls6eSNJ7zV9Rq3Hlg==
X-Received: by 2002:a17:902:b712:b0:143:72b7:4096 with SMTP id d18-20020a170902b71200b0014372b74096mr13995974pls.25.1639610714881;
        Wed, 15 Dec 2021 15:25:14 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b18sm3120925pjo.31.2021.12.15.15.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 15:25:14 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] iio: stmpe-adc: Use correctly sized arguments for bit field
Date:   Wed, 15 Dec 2021 15:25:13 -0800
Message-Id: <20211215232513.2070158-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2545; h=from:subject; bh=S+yja+ZH2OmWXK3ijI5wGcAm/sNwDDcR7CmSYgsRQzo=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhunlYeGsDYpcqYmqKGq1gspbWZM1i9uJh+lhO3VSQ FHREJxSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYbp5WAAKCRCJcvTf3G3AJlBiD/ 9NL3ZLujTHevof7dlDGHJPmKwu+YtML22gc59bhFYHNlrW1bYIyk8TVkzq+kmWec+iWtOk61RpCSXS Z0k7OnyjFshW0V/lqBxlh9J5enIY+QUpyTtjZItLHc+peGRRmKU3uDXa8yjTgmYevNLvTHfOipZRzz YX5h1sDytZpE3iLSCyn/6iQF51ttub/xD2LyDYPWCVRhJxhfyqNNLqMT9ieTj7XSNP7ho0xpLojXtG tYWFm1l7YezgqMr59jAE6fQpMkolVM6/jLRvwm94HRifQWDQlVIJz2D/fE/HI8uMpMN9h/dj3lWqCz b4ueQOnKzDV9J1CjKjjZzWHmB+YITuSkqr1zsPTHvccwOfdpBMTwPqh9G2MRm0jUXjYh5wbbdX0RnY JVZy4dPkxUArpoQx+Xv4Tfh8F/WXlRyqbV/+GBScF9djq6yabzoTpogdl8ms5SWTD/qQZalMX7vnQS b71qchU1Q+2z06VaTVhRZQ/+9b0CpOQNr0Dwnp7anmFBJ+HiWBzxsh5MK6pgbk4EDXUwePl6dA/RyO nVDXPwtQGKzNPzhRAFRnnBCAqowSzkQzNAUNtmHVyPfmg5yUjLgG9QlaoTPq/J+G5/qAgZv8HMan4Q g/nbEXYvBPu9ipCueVOY3evU+0zo1CFssLloRyC7DBje0O6J/hslJrPUKIfw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The find.h APIs are designed to be used only on unsigned long arguments.
This can technically result in a over-read, but it is harmless in this
case. Regardless, fix it to avoid the warning seen under -Warray-bounds,
which we'd like to enable globally:

In file included from ./include/linux/bitmap.h:9,
                 from ./include/linux/cpumask.h:12,
                 from ./arch/x86/include/asm/cpumask.h:5,
                 from ./arch/x86/include/asm/msr.h:11,
                 from ./arch/x86/include/asm/processor.h:22,
                 from ./arch/x86/include/asm/cpufeature.h:5,
                 from ./arch/x86/include/asm/thread_info.h:53,
                 from ./include/linux/thread_info.h:60,
                 from ./arch/x86/include/asm/preempt.h:7,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/spinlock.h:55,
                 from ./include/linux/swait.h:7,
                 from ./include/linux/completion.h:12,
                 from drivers/iio/adc/stmpe-adc.c:10:
drivers/iio/adc/stmpe-adc.c: In function 'stmpe_adc_probe':
./include/linux/find.h:98:23: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
   98 |                 val = *addr | ~GENMASK(size - 1, offset);
      |                       ^~~~~
drivers/iio/adc/stmpe-adc.c:258:13: note: while referencing 'norequest_mask'
  258 |         u32 norequest_mask = 0;
      |             ^~~~~~~~~~~~~~

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/iio/adc/stmpe-adc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
index fba659bfdb40..d2d405388499 100644
--- a/drivers/iio/adc/stmpe-adc.c
+++ b/drivers/iio/adc/stmpe-adc.c
@@ -256,6 +256,7 @@ static int stmpe_adc_probe(struct platform_device *pdev)
 	struct stmpe_adc *info;
 	struct device_node *np;
 	u32 norequest_mask = 0;
+	unsigned long bits;
 	int irq_temp, irq_adc;
 	int num_chan = 0;
 	int i = 0;
@@ -309,8 +310,8 @@ static int stmpe_adc_probe(struct platform_device *pdev)
 
 	of_property_read_u32(np, "st,norequest-mask", &norequest_mask);
 
-	for_each_clear_bit(i, (unsigned long *) &norequest_mask,
-			   (STMPE_ADC_LAST_NR + 1)) {
+	bits = norequest_mask;
+	for_each_clear_bit(i, &bits, (STMPE_ADC_LAST_NR + 1)) {
 		stmpe_adc_voltage_chan(&info->stmpe_adc_iio_channels[num_chan], i);
 		num_chan++;
 	}
-- 
2.30.2

