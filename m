Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5104853EB6B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbiFFJVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbiFFJUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:20:55 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4094B37BD8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:20:53 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id q21so27734056ejm.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 02:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HXs6HQ5wyWOtIKdzW/IYeIhCcS1S7l5ftevZGxUN+go=;
        b=AVFs69BTF+v2nl8khzB4ASec7iczaV1WEjwifjve4cHCqJVGLV4NVpSYI/wdNlpi/N
         jBvmyTTlUQLhM7hyjskmtZTjDDNMzrDTPLH242cw7ZIK8xaO+bV7RDdmPqAZcpzREU7K
         8e1zf5Fnrnx9g5u1J/yH209/EU5jamOgRsDCuDt5vEStjmDYChcGkrqm4J7zs6w8KV2S
         J1nxpPUW8xDShO6lsLQqutirkjQhgPNoWPh8DggHZNJmFXboWjDefVapqeHBLgLlv/0f
         dGo31ZddTlFaT2kny8FY6aLcFnTUHS7hdakCOoSTNiWDRr9MqvctZ4StmUcDazB8LoSz
         zFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HXs6HQ5wyWOtIKdzW/IYeIhCcS1S7l5ftevZGxUN+go=;
        b=gpbEZyguIve9R4on35jcwsZanw09XJMtAy6LbJ40fbrDi9WeHVV+c0LAOzkp1OPWZo
         igL6QyLwBSw7SnzF00mYa/zyt5Ef5CT0kX3HrR2+dOLSPinW4hUJYB9G1wtDy/mJvXNk
         PlzWeahDg392AUOyDQ4i2OLhHpfnHeRkA918SZvV7VgAoa1C1nyCxcS26FAobTaKuOo4
         /41/hVOsl1eRQy4C9DghuKI3uDmcQVXr74Iaspl4TVmucNZD5Lwfo778e9gcbYnCjhG/
         FWB+e7VpBH5l2P9pFeS7tcsygaRXsGhGeIERIb/GYYvJ8p3RBMEwIbxGE4hLi3X1eKwx
         CPOw==
X-Gm-Message-State: AOAM532YQVbk8wl5OZKI1oFXA+6prTuojZFzfI61400VpR3quACC5m6L
        vXW8ofygmHagqlx/PKAgy9Q8dA==
X-Google-Smtp-Source: ABdhPJwUBwoX6D2ZyEBxBT0G5klDaphwJEUpH6FhwVTkIdE4hmlutl09N7ke28WCzNQ8obWtXq+LpA==
X-Received: by 2002:a17:906:38d3:b0:710:daf0:52f8 with SMTP id r19-20020a17090638d300b00710daf052f8mr9469554ejd.406.1654507252467;
        Mon, 06 Jun 2022 02:20:52 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b6-20020a17090636c600b006feb6dee4absm6067412ejc.137.2022.06.06.02.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 02:20:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Yong Wu <yong.wu@mediatek.com>, Miaoqian Lin <linmq006@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Ikjoon Jang <ikjn@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] memory: mtk-smi: add missing put_device() call in mtk_smi_device_link_common
Date:   Mon,  6 Jun 2022 11:20:47 +0200
Message-Id: <165450724182.62574.15544602026083220170.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220601120118.60225-1-linmq006@gmail.com>
References: <20220601120118.60225-1-linmq006@gmail.com>
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

On Wed, 1 Jun 2022 16:01:18 +0400, Miaoqian Lin wrote:
> The reference taken by 'of_find_device_by_node()' must be released when
> not needed anymore.
> Add the corresponding 'put_device()' in the error handling paths.
> 
> 

Applied, thanks!

[1/1] memory: mtk-smi: add missing put_device() call in mtk_smi_device_link_common
      https://git.kernel.org/krzk/linux-mem-ctrl/c/038ae37c510fd57cbc543ac82db1e7b23b28557a

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
