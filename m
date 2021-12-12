Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BE6471BF8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 18:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhLLRvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 12:51:06 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:41042
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230472AbhLLRvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 12:51:04 -0500
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 049243F1FE
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 17:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639331464;
        bh=/TPz8P3jSfI1okGvc0s8UmNi6j6tmzrgUunBy9WIFIM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=aOELrYynDjwpPipOiNdQGQXn+NSlDp2pLqVcm8RpiEuzWT5s+JXMzUomSK8k+OM1L
         IUmhGc4Rh1CPcNRNsWB5uGtrolONihg4niBpgrYLvfscVnfJvysk4SWtHGrwa/1iv/
         sFhl7fZ1qeijlW7sCRbSFnqYHHP49VJX5PNPmGBRvHYk8/zejSv8xvm8MbNTAT9LJj
         tm5KvEXaI3PvqL2wVXecILaBDUDPCm7GaSYpZm+5HoyDq9BQ247m5k6040W3XSqfq/
         w7YL93fnLmmyN8MWunGFsyQixEc+Nv5PHNao8Pz3uQOgbRY9ywyUgq+1XzxlQ9AAX5
         jFLqYzGMRAqZQ==
Received: by mail-lf1-f70.google.com with SMTP id u20-20020a056512129400b0040373ffc60bso6400044lfs.15
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 09:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/TPz8P3jSfI1okGvc0s8UmNi6j6tmzrgUunBy9WIFIM=;
        b=saTVawae9vx8tc6asPL9RQgaGPM25qQSHXEGlHMMkACB6XmdJVhj0iP9t1NkS4MEox
         U2sEQg93byf84LB/SGX7XuoLd7ljWSPDt3ANdqFpagM1f4sWvXjB55mR6Hs/1tYW4umN
         POAPw9TjM+ejjDrHt0rtHIF7I4ew3UbnaQGC5y0T6h40pc6tG+35EMMSliGRQbnGKxFt
         Qt9Gy42ALxzFFkLIaDMX+aLFL219ZsyUWcgcCj6dkoKbAm3r6peabwVauKXPGOMheVrA
         lWRlvlqW6rpJw2UefrUUb4yJKFVJGlrk3xbBgyIsOO6qf8dSTagZRg97GHQLTsSt4sDF
         neHQ==
X-Gm-Message-State: AOAM533xNS6itAwCpkN34gACPIRB7EJBXpnNcwnN6EKMXlC5SRrSaKr9
        nc9IiRRMYvf1yHPE9yFqgZxXqq26UJRRND2VxivxLh4BidJdHOzuUGSUCjKNhyBJjf/e8b2BMrr
        MBTxlyqv4DQ+vEpuzGNp/FrF95cEfC34o2hiEgWtHrg==
X-Received: by 2002:ac2:52a8:: with SMTP id r8mr19052772lfm.560.1639331462862;
        Sun, 12 Dec 2021 09:51:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzbusrCHjNH6xadVyF1sj58ZLOlzRFyG48wu2gchhChpqu6tN9Ez4KxciXixz1qHuCM0+10sQ==
X-Received: by 2002:ac2:52a8:: with SMTP id r8mr19052759lfm.560.1639331462638;
        Sun, 12 Dec 2021 09:51:02 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id x14sm1069893lfg.283.2021.12.12.09.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 09:51:02 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Jason Wang <wangborong@cdjrlc.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, mmayer@broadcom.com,
        f.fainelli@gmail.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] memory: brcmstb_dpfe: fix typo in a comment
Date:   Sun, 12 Dec 2021 18:51:00 +0100
Message-Id: <163933145662.4865.12241424069154629706.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211212033347.67921-1-wangborong@cdjrlc.com>
References: <20211212033347.67921-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Dec 2021 11:33:47 +0800, Jason Wang wrote:
> The double `to' in the comment in line 427 is repeated. Remove it
> from the comment.
> 
> 

Applied, thanks!

[1/1] memory: brcmstb_dpfe: fix typo in a comment
      commit: 2dd6123d3f13d66f4f9b705ac7ec2864ac7861c5

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
