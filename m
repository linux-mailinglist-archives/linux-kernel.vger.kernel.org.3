Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B3354EB87
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378732AbiFPUsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378692AbiFPUry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:47:54 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9FE13E98
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:47:53 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so2839748pjm.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=l23GN/U2DrIJrN/6AEssfMKzsUHbsd5fPbDMrm48ijg=;
        b=Hlhlfrt/BJXdyf2w8kNa+QzSqO8cQj4lod7jTR2Ma07k8drLJ7tyJdl/R1YMZkIsDr
         y5njbGkxTrgiaAevYqgykQxDCCo+8D1ds4Wcvzy88/kTMrq3J3WHmHN8le+Qd1+GzDxR
         +/XdD9/gFkq5ktys+ZaLzxDVJboC2+1dLyZa1iX5aLnkDYMLRorGDXIPM+EsnITuAm/h
         d4fcbn5xBna0jpES0gnwB98SYs8GI3XsDZEpfVU2PXujg8B8Xcb63PojcdsbXJj8oB4y
         qNqUtJEbyhPGaBJvagvlYs5RhtTNO2lV9EILkWL6rHgdUFFKMZNbCbU5R6Vr+/pwYzPs
         XK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l23GN/U2DrIJrN/6AEssfMKzsUHbsd5fPbDMrm48ijg=;
        b=zyeU507dE5EOjAZ3DnNvosOF8ygLZrxNxdFQ5E3PHBzCNKYf9woT4B4euiX+jYr4d6
         y0aCAD7yBeMh3Vd8ii49W9hWfIB+NDxFBXWZpt49e4+srmwTk1dxXvKg4c9l0cPc/saH
         c4C1U0XPlcX7lQ/yfqb/KZT+/aUtSWvSn/pyFHtYE8Op2WqwaCT3DLb7+mqt9oS2P7Dx
         /LxsCXOPF6qtLnn6NqOscOog3GqWBAPzoVgi7sZ0DQg3A5NCVkLfeOEW7YA7sVzddydB
         n03nCNhQJvVbGrHbucmWhzw0VOkXFR7VCS4WObaEqzitPv+catqAzhWL9pd5PiPC8yXB
         SLhw==
X-Gm-Message-State: AJIora+shEzqfMwsKhtWnZb4nf/SMNKKN9THF3V4KdwOIsmgl+UZkbR9
        6UiMFcIAYZ579FuLqLanrRPguA==
X-Google-Smtp-Source: AGRyM1sGQFKhrRTWYkWHrvqeQMdQ//vcR5llvQ5SaH3z0VWqOAf04UfgsXRSWIQ6CWv0tnyQGtdkAw==
X-Received: by 2002:a17:902:efc6:b0:167:8177:60a7 with SMTP id ja6-20020a170902efc600b00167817760a7mr6252404plb.110.1655412473000;
        Thu, 16 Jun 2022 13:47:53 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id 203-20020a6218d4000000b0051ba0ee30cbsm2165453pfy.128.2022.06.16.13.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:47:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     soc@kernel.org, Wei Xu <xuwei5@hisilicon.com>,
        Olof Johansson <olof@lixom.net>, arm@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: hisilicon: adjust whitespace around '='
Date:   Thu, 16 Jun 2022 13:47:13 -0700
Message-Id: <165541242280.9040.2541894516124804642.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220526204453.832681-1-krzysztof.kozlowski@linaro.org>
References: <20220526204453.832681-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 May 2022 22:44:53 +0200, Krzysztof Kozlowski wrote:
> Fix whitespace coding style: use single space instead of tabs or
> multiple spaces around '=' sign in property assignment.  No functional
> changes (same DTB).
> 
> 

Applied, thanks!

[1/1] arm64: dts: hisilicon: adjust whitespace around '='
      https://git.kernel.org/krzk/linux/c/11357f103f2e641e2744d527886ff248dbef13d8

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
