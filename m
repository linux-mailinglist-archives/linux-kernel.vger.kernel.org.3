Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A060463CA6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 18:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244746AbhK3RWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 12:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244730AbhK3RWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:22:19 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81450C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:19:00 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id i12so21288348pfd.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vP1gOxpWYPAIQlMTwhoxIT14ZcEJgFWWlGVkqAobYg8=;
        b=Y37uRRP6o5MgMyQkqD8PiX/6xflfPptaSOoyAyqy3Lfk2a5P/z7mGFluDx4VVWa7Jh
         BnE+fEbZc12cpwUlbwjg0Au2pJyCvopQscefnR2glrX1+Xietw2AEtyiiQxrjJeUOZJg
         9cjNHfsNmtfIewzx6a89icdLEvynVHHy447Iv3YZ6zSxKKcpQRGgcHrm/hLyqJWZ+JDx
         mi92gUoptO/NICpuQsiy25PIkfOGf23mvVewgyObhm+RZ0hJ1PQfXVH7vmze3+xuktI3
         ricyOMbMarDy8ltTqLqZXKRd9NAT/+LcoyNKYjEqve6DojhMykVJzSjrYNYXcCLOmSP6
         EM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vP1gOxpWYPAIQlMTwhoxIT14ZcEJgFWWlGVkqAobYg8=;
        b=rj1utDX0te8SOZ2v8vN/EgB205nlxAXXR66FSmmER93posEGZw8yf+oWDqbT2OZ4/i
         K4b7z/a/pCznz6objfqw/DsYv2P9D3YlmNusVcF1aWlq3ftRvfnY6qLVDbEtQubBeXk2
         il8eipnYBV0tWlAS8QNOW2NYiStLiYGuMbvYex9yaOHJUItWdJtdwvH6XMYvaLUmug4s
         tdFYNii11YElG32ibLI+N5iTq7jggDunVM0y+JgHOKMQY1XOd12EV+HvaeZiBIoYio9P
         m+iuKLR/90nMfGfyYMmGWxaj7fZdIeLcEjuKGcPlrBrorCBMFGK0Md/UsZ2sX7UzMTQC
         J3Rg==
X-Gm-Message-State: AOAM5300H8Nm+5IMT6lrZYv0n8DVjyJMqe4NHc2FArMnEPYFVnk7xSkR
        iGZ9NXwPHuRNAs8Du++Th6s=
X-Google-Smtp-Source: ABdhPJy9Yxr+6bmNEhtjihDtbK4VluzB9Hi4XbxmPxyhDIcAapDKFGM9GnicxQgxuAJYtDpfqnG7Ww==
X-Received: by 2002:aa7:9a4e:0:b0:4a2:71f9:21e0 with SMTP id x14-20020aa79a4e000000b004a271f921e0mr272066pfj.77.1638292740085;
        Tue, 30 Nov 2021 09:19:00 -0800 (PST)
Received: from localhost.localdomain ([47.242.44.139])
        by smtp.gmail.com with ESMTPSA id il7sm3446332pjb.54.2021.11.30.09.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 09:18:59 -0800 (PST)
From:   youling257 <youling257@gmail.com>
To:     brent.lu@intel.com
Cc:     alsa-devel@alsa-project.org, bard.liao@intel.com,
        broonie@kernel.org, cezary.rojewski@intel.com,
        christophe.jaillet@wanadoo.fr, ckeepax@opensource.cirrus.com,
        cujomalainey@chromium.org, gongjun.song@intel.com,
        guennadi.liakhovetski@linux.intel.com, hdegoede@redhat.com,
        kai.vehmanen@linux.intel.com, lgirdwood@gmail.com,
        liam.r.girdwood@linux.intel.com, libin.yang@intel.com,
        linux-kernel@vger.kernel.org, mac.chiang@intel.com,
        malik_hsu@wistron.corp-partner.google.com, paul.olaru@oss.nxp.com,
        perex@perex.cz, pierre-louis.bossart@linux.intel.com,
        rander.wang@intel.com, rander.wang@linux.intel.com, tiwai@suse.com,
        vamshi.krishna.gopal@intel.com, yang.jie@linux.intel.com,
        yong.zhi@intel.com, yung-chuan.liao@linux.intel.com
Subject: Re: [PATCH v5 4/6] ASoC: Intel: soc-acpi-byt: shrink tables using compatible IDs
Date:   Wed,  1 Dec 2021 01:18:41 +0800
Message-Id: <20211130171841.17277-1-youling257@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211029171409.611600-5-brent.lu@intel.com>
References: <20211029171409.611600-5-brent.lu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cause Bay trail-CR z3735f tablet rt5640 no sound, bytcr_rt5640 bytcr_rt5640: Error cannot find '' dev.
