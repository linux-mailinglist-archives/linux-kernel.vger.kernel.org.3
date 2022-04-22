Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B46650C4D4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiDVXZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 19:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiDVXYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:24:54 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8971EE1DE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 16:00:04 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-e5e433d66dso10144003fac.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 16:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ElI2t4nByDOB6dr+yLR266lxMKTIEX40DDSnpkzAfdk=;
        b=AAL18eX8s5pFrRM+VhPDxLjLMGLkQCN9PL+jVRgw0V7kN4VQZrGyrC9yvnUkDDTA9m
         kUoPiX2AeDEFGlhQgafrnJM6b0hbFWx6As1XdFyzsaPMNT+LFL88wT8KL6EtbHBVMNiY
         XmAZFpWedjwOngPwoyeeBAkh1yzof7YA1rRPwXRc4zrYY9xeqwYv73OLXw569g5RyDJ/
         4UItx60O5ACzGqIv8o1yXv3z55PWWdx2axpX7VycwhT98ePwWGv8hegxjQnUJGFg1Nsc
         Uj1hIqqdCUTMkyisAjlr4sM4FbKyYp5nyDGNaJ/+DYjN1Lwjt3DbfgXDofNsTFiWo2YU
         ZsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ElI2t4nByDOB6dr+yLR266lxMKTIEX40DDSnpkzAfdk=;
        b=l+97gDrwEJtSyLl1gT9a7hXD5R8N/F9YeG99V380zIszTGtAdCb7ZI3prURg8zSncW
         9wErvtkzLh53XK4hMW4M9/SloSJhbmaDRNjlmXpPEsrmoRCXdFQlsvR/QN0iTOdjdqNy
         +UEKLFob/0sUkGUyweTRKOXbgoAxfcxQirDyXnUdpZopMZN53vGWjk16i1ZbxaRcHdTf
         w9A0rnpD6F9u4usQa4G++dHEMIQ02v3bYDgEq6gLiUrrLsaZcQv5OAt4HOWAoFFXQ0g9
         ZRrOl2ODqGV9HiPlMk9a3Br5vWrjdrfzXkZu3UgftAc2jRrGDE3BK2vldAMLO/RNBCfP
         ZVvg==
X-Gm-Message-State: AOAM532aZE/bduZxaBVXRnBITQhYMaoWw1ngqzGR9xJcTZRDwjusxImr
        0kCMZ8d7TZuIFCp6CkESDm7T2Q==
X-Google-Smtp-Source: ABdhPJyhzjfmiSNV9pg+MVvlFlGDkq8CvnWd0Mwcnumh+SSclYdBOE1HNA5Unl92+fFrCF1gMYMSkg==
X-Received: by 2002:a05:6870:ea89:b0:e6:4acc:9302 with SMTP id s9-20020a056870ea8900b000e64acc9302mr3081663oap.203.1650668403484;
        Fri, 22 Apr 2022 16:00:03 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id v65-20020aca6144000000b0032259d24076sm1250566oib.30.2022.04.22.16.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 16:00:02 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>
Cc:     Tinghan Shen <tinghan.shen@mediatek.com>,
        devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v1 1/3] dt-bindings: remoteproc: mediatek: Add interrupts property to mtk,scp
Date:   Fri, 22 Apr 2022 18:00:01 -0500
Message-Id: <165066838719.2742284.7900096409445311556.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220225225854.81038-2-nfraprado@collabora.com>
References: <20220225225854.81038-1-nfraprado@collabora.com> <20220225225854.81038-2-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2022 17:58:52 -0500, Nícolas F. R. A. Prado wrote:
> The SCP node can have an associated interrupt. Add a property for it.
> 
> 

Applied, thanks!

[1/3] dt-bindings: remoteproc: mediatek: Add interrupts property to mtk,scp
      commit: b7da6f517214c307efece604ac9dc58dc6123c07

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
