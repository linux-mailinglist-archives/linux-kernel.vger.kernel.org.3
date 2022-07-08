Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799EF56C04E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239177AbiGHQuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238991AbiGHQuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:50:10 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3142C2C108;
        Fri,  8 Jul 2022 09:50:09 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id b11so1290942eju.10;
        Fri, 08 Jul 2022 09:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0VmPLkwd+jsfHM5+mRGOUxbGgxotW4G1hW6i/2hpi/U=;
        b=j2lCJer7VQaif4Gj9+tDaqXNkwLb6+hi7pvOFMC5CUPaYGfI7QOihTIbv+xa4yYiet
         Qx+WhsfxNnu4J9IpMo9qzMHwgRt8Z+C10ccQpyCP3dhAKw+LTofuaAP5iA2L3u8iToDe
         ObOrYGT8wE0vN3Dz/QmQNh2zBPUqdfVmQizSjqP2ei6GDkHL92B0hNMmhJPyBWrp9pFH
         IrBrQa8zJ1OYSnLeqTZNw6D8AFNoUCwp0z8vOWQOdw1eh9QTQdhYHGM09XMtiwDBMQaA
         iWvqbkAupyFErhqV665byWsjB8TOIpOvhi5CQkZpBMDz5BEucLauXHoPWiRbLeJyBBxV
         dMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0VmPLkwd+jsfHM5+mRGOUxbGgxotW4G1hW6i/2hpi/U=;
        b=1AMH5lWE+yAS01AlY+9sbJF63mdgZN7uByNtsRfcw7wKoAiIVsz5FYljE6Lq82libq
         SnQIGM3nrZN1ZE8YijbMBFcVfFf4ARi52jLMIF9DJ/QD6IbZETUvH2YCv1fh8k4SuXvr
         jy+1jDGxbYH2IMud1veLetIl3DXloaRRui2tsh9Pkk6pNH0HhPBuvnJgQ8oFrX3FZlm2
         jbI1x+u2tL0dn01GW6b+Xjqf7VC1O/nvRhmaCyvOE3LelrQwd855DadTUqo0jwHpmLJL
         IYnTmlagKgtzVuFpmUVxdSiCLR7llvucqpgYdVD2t2fIEcpfoFBKbwR25nJwBDhoAGy9
         4s+g==
X-Gm-Message-State: AJIora9JUN+/s367spXv9AYv0ug7gpKHCCSke1rUSLTJccRmarO2SgJH
        0DrcwoHckKHowVlciUekMWQ=
X-Google-Smtp-Source: AGRyM1u8pUAPgSJnIA4mi9w1D8Y2TiHSvOt67lcDD4EJjpozOfSw3fl72TuSp8do6cqLJme64f41uQ==
X-Received: by 2002:a17:906:c048:b0:718:ca61:e7b9 with SMTP id bm8-20020a170906c04800b00718ca61e7b9mr4473154ejb.120.1657299007703;
        Fri, 08 Jul 2022 09:50:07 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090669c400b006fe9f9d0938sm20819211ejs.175.2022.07.08.09.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 09:50:07 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/2] dt-bindings: arm: sunxi: Default to the full MBUS binding
Date:   Fri, 08 Jul 2022 18:50:06 +0200
Message-ID: <7534543.lvqk35OSZv@kista>
In-Reply-To: <20220702042447.26734-1-samuel@sholland.org>
References: <20220702042447.26734-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 02. julij 2022 ob 06:24:46 CEST je Samuel Holland napisal(a):
> Some older SoCs use a deprecated MBUS binding with some clocks missing.
> Currently, new SoCs must opt in to the complete binding. This should be
> the default, so new SoCs do not accidentally use the deprecated version.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied both, thanks!

Best regards,
Jernej


