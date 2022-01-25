Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4E849B9C6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239503AbiAYRJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:09:04 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:54582
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242612AbiAYRFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:05:38 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9C5CA3F1D8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 17:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643130334;
        bh=nMdW5v69q6Wohx/luhbyzlU9+wYmArcJIac8Q+rwqeU=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=qGDycotR9fy9D9pUTazcK1pdos+/bsTEs/cc6dTz3ntJ7jzGn3w7Z84CmF2QziLjc
         3VloLuh0XkSWMHrQK3Xvk+SC6EmzX00hbrp1XH41UZt7PEmRkl6Ysgo/TrcTHQRzLj
         3um5Ok3gdLi3fMKCcTkemmMnwBCESMVF2pjK7whAIhSTE6tWI//EhiEepJnXAtFeos
         8gW8NXw8aZAjWHfcob+ekPhKtCLUfGjbpCaxXc4y2lfnQxIvEsTfOchVimvnbUhmbc
         +e3OC7bxiXWqnh9Exyikloqaa6ZEB0pSud7TW3b5z/wAz2pOLxC02c0hHBoBc/PyW9
         evZUG8yNloFLQ==
Received: by mail-wm1-f71.google.com with SMTP id j18-20020a05600c1c1200b0034aeea95dacso1425578wms.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:05:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nMdW5v69q6Wohx/luhbyzlU9+wYmArcJIac8Q+rwqeU=;
        b=btjhp430cOJW7QiHg8V712IwZE9xRIiSKK0a4Ylqbbhy6vdFEKiwa48ELhqCu1G1MR
         RRQpvnXlmyRl81enMzJ6aGES+wMKxOCmND9qQY68fS+yEaRwHvcY0nzmXA7tbgMUjB1h
         zt5mOQyng1s85rHdbtXu4ZUmV/2wBkVpuCfOuKKrAAmagEJffICUwDLZHIWHgsHmTqEm
         uSuPrlNL8yF+AeciKusLzDI0l9G93r7C/oMaQ5rEj5HkgvRVy6wWlomVAk1PCBUIomzt
         yWWltN/JK0MjdkNOQgFOqbJxQSRL1IXXv53wWJtBhsDty4puh3jxN+ksztynG8nYndvJ
         RDQw==
X-Gm-Message-State: AOAM533CQuzzuyAADZznrwmBQ12qfXuzsL+IQ8VCGVki+rG3DERqUhFt
        tkxSYlToZ/im2CuOFQbW/i++rtfH8cRDytz3/8DXcSIRP9SLMT89TOoIXevA2xVZrUUZ3/yqGCc
        BHHkH1k04K+AGqYN7pUb7zrkX+gQtN7dRukTpySbwyg==
X-Received: by 2002:adf:e3cf:: with SMTP id k15mr14685562wrm.5.1643130333916;
        Tue, 25 Jan 2022 09:05:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyDMNurXGEYwtfMsLt1TRMNkY4zf895J7er0VWSTdW1WADBBTbrJZhBCjzjcyuRZBB6Z7JRYg==
X-Received: by 2002:adf:e3cf:: with SMTP id k15mr14685547wrm.5.1643130333723;
        Tue, 25 Jan 2022 09:05:33 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id o15sm1082377wms.9.2022.01.25.09.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:05:32 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: exynos: use define for TMU clock on Exynos4412
Date:   Tue, 25 Jan 2022 18:04:55 +0100
Message-Id: <164313029072.79782.9597131661612342819.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220122131457.63304-1-krzysztof.kozlowski@canonical.com>
References: <20220122131457.63304-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jan 2022 14:14:57 +0100, Krzysztof Kozlowski wrote:
> Replace clock hard-coded number with a define from bindings.  No
> functional change.
> 
> 

Applied, thanks!

[1/1] ARM: dts: exynos: use define for TMU clock on Exynos4412
      commit: 86955cb6ba16cd35323f498acbf0f07f8671c1b4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
