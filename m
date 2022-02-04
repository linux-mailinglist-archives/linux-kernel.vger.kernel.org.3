Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C603B4A9F2D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377650AbiBDSfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377582AbiBDSfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:35:32 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B0EC06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 10:35:32 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 4so9449913oil.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 10:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m96YaMQTGjBl6hPvknyKwUDuoQ+EyqlAZy16yN0a1io=;
        b=BGSWoz/iEyR88bhTN9+03yLlQNu6fnKxt7fN4yOn5317DWTBwK+pKJttKCfyft94+v
         6uGri9tDw5N0Vb7hEf21pXwcL71Bjz0NCtbeb2UlAgG2MLEXb2e2G6bUQyqe/2Py691e
         E125Nkor761il+QHIqyfRpRYo08qcY59RhfL3KyOO1XWbOBek16t2+4eB3bq0bnz5OT/
         BlUmv4+erStNi8B49B5e9daC2RLXORdLG3UuHzxLAZtlGyVXSFFisNMvH4nydQ7HeU0h
         nd/UujjCpNq0yuyf0dCfDsggUVAcUND0V7aIi/5EizskuGVHBdxdHf38hvYCwkYjbqsr
         f70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m96YaMQTGjBl6hPvknyKwUDuoQ+EyqlAZy16yN0a1io=;
        b=3aVBFoZlU65/MmeI7gORn3R0FPDjtiThv4R6uRiZ5WIJMl5c2fR+g+ENIAUNLhkRzQ
         jZ4exF15tsFLHxlm2df4U8wlg1MCXxgciZdKFEZh/acgn/ajh2IPvnsSA5r1j6fiu0WH
         YMOXA6qD1dPmpkv4peS3t2G805/1mME+pFhIUXsBwa5a92BDu/QprD3kd8aGYcqQ+bhs
         VIW1ITn7ITaVV1x76uolINVKppX1rTuGLFf56CPV1w1I6ZGktQlNXoOQNclevkYwlKel
         /l8EXj/haCkMEOcEyZNMZE3Sk5Ni99y5BAGyFOmyaQPvWKhj7FsB8N/Ccm0CS5iQM2+D
         0pUg==
X-Gm-Message-State: AOAM532Dgr2ca9/G9rtEKbmJrkb0bWp9HzB9lWmmNBeH2KBjqGvVAmaU
        ASpUH39N+Kjj7cTo45KV71SLwg==
X-Google-Smtp-Source: ABdhPJwIQj++T2UUwmut4NbK6dfIWMrm6kOxD67KOvm3kgR7WvafrmSe8PZ8nv3u3h52L4xp705F4g==
X-Received: by 2002:a05:6808:1784:: with SMTP id bg4mr2000994oib.286.1643999732128;
        Fri, 04 Feb 2022 10:35:32 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id 100sm1044182oth.75.2022.02.04.10.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 10:35:31 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     agross@kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] soc: qcom: rpmpd: Check for null return of devm_kcalloc
Date:   Fri,  4 Feb 2022 12:35:20 -0600
Message-Id: <164399969245.3386915.12317625487296679107.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211231094419.1941054-1-jiasheng@iscas.ac.cn>
References: <20211231094419.1941054-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Dec 2021 17:44:19 +0800, Jiasheng Jiang wrote:
> Because of the possible failure of the allocation, data->domains might
> be NULL pointer and will cause the dereference of the NULL pointer
> later.
> Therefore, it might be better to check it and directly return -ENOMEM
> without releasing data manually if fails, because the comment of the
> devm_kmalloc() says "Memory allocated with this function is
> automatically freed on driver detach.".
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: rpmpd: Check for null return of devm_kcalloc
      commit: 5a811126d38f9767a20cc271b34db7c8efc5a46c

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
