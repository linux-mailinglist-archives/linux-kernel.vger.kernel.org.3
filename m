Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846C748C1D9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 11:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352245AbiALKBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 05:01:14 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:58338
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239524AbiALKAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 05:00:55 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6F9443F1EE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 10:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641981654;
        bh=sxpoeazVKfRv/TTxlIPcEu0VInhZebJSCyyifiEPVW0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=QZUYb41T2r0gJfdj/JmDwla5q8wYEtI9NUG9iQdPMhA0U0eXvqP8G0mA3astSE+vI
         FUIBSv15HA131v5blSaslsxmFsSnm7J1jz1A82Y0ircmq4DaeBUt0XCtYSaVwJlllQ
         F+fuL08NAZz093cOHoav4Y2w+Dqt5TQ12lAg8ZrQcs10zAQf3FB5Xv8Lx08qPWaBqA
         f3t4fwZYvrqr0dRI87CpyfyRVcFmVVwbdS7DhOVXqobVtDHOoFt1irdOOzeoUereyr
         FPCYroFeRq/qJVjnavE4rIIkn1u4PG/PJP2BPebaBNpp4I66qQoyyxR8ROHChuvvCl
         ChjA46oUZG4HQ==
Received: by mail-ed1-f72.google.com with SMTP id q15-20020a056402518f00b003f87abf9c37so1786808edd.15
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 02:00:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sxpoeazVKfRv/TTxlIPcEu0VInhZebJSCyyifiEPVW0=;
        b=mPBAtVT/q4yQ0F7DOEw7Z52LMZOqcfCBcm7iXJJOXWI5IBlvILvAU+Aj0MuN9bQ8gV
         uDIMgKXKUQi74QC8I4Oe7yygijCIUnOijdRVG0YEOleGoUYv+q8/oJbrwxTjAwPj4nJE
         Ie0GQb8xmn4+oQhjDPpFkbVlfjSX1UYt8FGJJfkRuCq6qnl2ACadPqr3y8o5RaacPwzQ
         o4/u3SXGOVr8knGBTH1TmDV7PbUSOrcyTX9msKIMFUaRyccEG/YOw+f8zwzAWicAx9pO
         CsP/rfsbEoKrmQ7fQews0/4m2WuUeZ4Fb4xqxj0Di6YCe9f9EuyY+WaSPx77MOnpNclu
         og6g==
X-Gm-Message-State: AOAM533AsVzRgw6hvDNHHRGRhUxIoaaSN15SkB+jrio3m026o0Y9BaIp
        /Itrsc6mrOZOVW7U0+YB1quVWzsx4S45dfXH6ME1NtkKYRyloejsJdL7zAfetUURqdfMZO1+Wso
        AMtODcHdD+UW8OGsw5dop7RnHOuIy6wEAua8LKwzIdg==
X-Received: by 2002:a17:907:7d8a:: with SMTP id oz10mr2375257ejc.320.1641981653521;
        Wed, 12 Jan 2022 02:00:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzzXqkrKxbgq5mvkmGUzVcTyBUQLnw1MTu9OyibOn3Q74mOavVnNmdXwrnaGEsFJ/VZr09+g==
X-Received: by 2002:a17:907:7d8a:: with SMTP id oz10mr2375244ejc.320.1641981653311;
        Wed, 12 Jan 2022 02:00:53 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id hb11sm4311083ejc.33.2022.01.12.02.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 02:00:52 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 3/4] spi: dt-bindings: samsung: allow controller-data to be optional
Date:   Wed, 12 Jan 2022 11:00:45 +0100
Message-Id: <20220112100046.68068-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220112100046.68068-1-krzysztof.kozlowski@canonical.com>
References: <20220112100046.68068-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung SoC SPI bindings requires to provide controller-data node
for each of SPI peripheral device nodes.  Make this controller-data node
optional, so DTS could be simpler.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/spi/samsung,spi-peripheral-props.yaml    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
index aa5a1f48494b..cadc8a5f061f 100644
--- a/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
@@ -28,6 +28,7 @@ properties:
            - 3: 270 degree phase shift sampling.
         $ref: /schemas/types.yaml#/definitions/uint32
         enum: [0, 1, 2, 3]
+        default: 0
 
     required:
       - samsung,spi-feedback-delay
-- 
2.32.0

