Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2455B49737A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 18:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239195AbiAWRKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 12:10:51 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:43136
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239161AbiAWRKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 12:10:47 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 40EBA3FFFC
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 17:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642957846;
        bh=xDXKi7JGbcFAIN75n+fskAz4fLROZVWhmg1xwTYWTaM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=vFHlFNPcWzZN3i48+prT9iLU9UcWWm9/wUdeswEtzF1sluDTAMVuqxD21SVMfMNnt
         xftHaxXY7eHvG1brn5ZFq4A8Nb86c/o94cv0dOVHHud+WHl3+myTpVzgb+HDsmCXeZ
         mQD3We8Zjm+pz+1J4wB2TI2DbMrjnOtqaXZ0WrwuC8FIfDimXuIe4UAAz8MrkPu5IV
         jACLzHZ+8JJU6Ktzt17Ktbzkl6kqh1af42BSF3WCGd4pvubbKuGpV4yYZIXhww9n83
         SBDnG2iFRvKy8vtn0XuZUCFnsgY0Ljq8Sr3PyMWyWXQud5FlKgvyCoLb3oCeMQ5dDA
         xA3XoE3z8rbXg==
Received: by mail-ed1-f72.google.com with SMTP id a18-20020aa7d752000000b00403d18712beso11588592eds.17
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 09:10:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xDXKi7JGbcFAIN75n+fskAz4fLROZVWhmg1xwTYWTaM=;
        b=gRIiX/QCTkNKlp6vsKC8SoGeBVRxcDk6fLT2nUeMN2MDj+uldQCjhGGmmCMhkgw93H
         9uK4NNKakzg1cGkYe3j/phSTJmn0JGCSafII3lJ6OQ74XbRjlEyXGHKuOd6lsaUHlpGB
         VNfs0Mn7cUlZtN8kRhHpzk1Vo+cYJF/U2LdNNW+W8qdFWEy86DmwY5+qjAZM7841U0G6
         kYFlUCj7gArF5e+ySUYX46NLwT3Ocjil8GRtf4JuxSiYvVUmLYTZKlhhZDk1ZC6VUx4k
         tWdCezuiUM0uYsOoGLu5tKdJW6bJGiyZYXKRk2wFBx60zDW4JPXAGIAvAbhqhrAZIGSh
         ko1w==
X-Gm-Message-State: AOAM531vBpM3hKrOEAAiWoTiQHoigD4AmUJaYMFOBsV7rlqHk6vL+DV6
        kwUNPe0RMciQtYiwd3dVA2slDgGiXLyii0l50ebgc+WLV0IqpGJhrvQrhrIfd0sysXJTjOceuQv
        tX3RAFBSEv4KpkrLtBCd5Gij4ZVZtTZ3wYEz3CPBKxw==
X-Received: by 2002:a17:906:c0d3:: with SMTP id bn19mr5822210ejb.617.1642957846007;
        Sun, 23 Jan 2022 09:10:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEwgwyC6py20Us9CXTtk8hy7gvk7QbsUsT9zTj+fmJrSTrQrjp6cdTGsUPJFslHAJdT1BKlg==
X-Received: by 2002:a17:906:c0d3:: with SMTP id bn19mr5822197ejb.617.1642957845861;
        Sun, 23 Jan 2022 09:10:45 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id l2sm5208665eds.28.2022.01.23.09.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 09:10:45 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-samsung-soc@vger.kernel.org, Pratyush Yadav <p.yadav@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andi Shyti <andi@etezian.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sam Protsenko <semen.protsenko@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: (subset) [PATCH v5 1/4] ARM: dts: exynos: split dmas into array of phandles in Exynos5250
Date:   Sun, 23 Jan 2022 18:10:38 +0100
Message-Id: <164295777263.25838.3565314490773058737.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220120175747.43403-2-krzysztof.kozlowski@canonical.com>
References: <20220120175747.43403-1-krzysztof.kozlowski@canonical.com> <20220120175747.43403-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2022 18:57:44 +0100, Krzysztof Kozlowski wrote:
> "dmas" property should be rather an array of phandles, as dtschema
> points.
> 
> 

Applied, thanks!

[1/4] ARM: dts: exynos: split dmas into array of phandles in Exynos5250
      commit: 88829baee3db050a06fd5ce8a2be0c39992f90da

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
