Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8897A4CCFC3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbiCDIOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 03:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbiCDIOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:14:16 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EBF54BEC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 00:13:27 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1B7FB3F5F2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646381606;
        bh=KY3j6GzmOt8fX0p2jIG9irP/hzl+hjlDmh8fW9j6n1U=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=KY8QWKrF82+SkvP3oo2TOfv3JYT+CA3y3N+miIK9+t4DejY9z7WYFcofiwtPrm9Ht
         irPjfd9QQuZCHTnsv7ILMsiiksvdFftbeMzhXJiY9js9GPaQwyTsxLmIcc36CXv3tv
         EXNlH0+x0tNJ3Dx09P1tFl/f6dqmEXjPR3PLOml14XpXVad+tFD/mJfJ/uvdD2XxUX
         uIniV9nK/xRFxOTOWyj6GIq/HiY72ULitevODQn6gvXlkpFzZD5ArVq503F1vcXvB0
         dwMyPaORts/1RDzsGMqRB/XzgjY/Rv/6oEn544ILjHF6IMq1SXI5JM2I2nIyKkO4J6
         aEcXonZiRcS5g==
Received: by mail-ed1-f69.google.com with SMTP id x22-20020a05640226d600b0041380e16645so4244688edd.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 00:13:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KY3j6GzmOt8fX0p2jIG9irP/hzl+hjlDmh8fW9j6n1U=;
        b=HsPEdx3B9dV6y9ESdeDhcROEWImIUtTnOmZ7XuoyClcYVAq5XaQ57MocNB/9TphIQ0
         f/9tQQoXYwA7N2qs0zLFlPjvv/LJwmsvLsvfNMB5y6/ukfDpjqktLTA4tLRZ2SK7g+li
         yHo/3/iK2d5NfcchV7Z60q2x8whBUK8G5YtFjmTL0ved9jV1yJFEZz+kYS/bpSCQW6QB
         s6BAMlbEqa0JZUIEU0Cm2xLoOm384cv+26KASlCSWSwsY3F7Ogd9vlvecmOAhIznO1C/
         jvy9DI87FkNF5gPxx3GN/p4SJMgVUAgMK2INFIOrFy0e/wivyO1KWI0dg6UxckJwUobH
         FcjQ==
X-Gm-Message-State: AOAM530MO8u4SiKe8FlDPLYP0qrojVcqqJ+dlVzNg4EZuYtADIwqa/P4
        LEUwvTUjnFlzi8eEwf5+xtGyTrO1pgjOefjqFXMAGinbTgBwjO1dbbrfrOmHkyD/n2TYdrN/qo6
        AB4z8PVH3LLqZmfrTlhxl5MX5Yv5P/DUIyJjpGMy2eg==
X-Received: by 2002:a50:ee90:0:b0:40f:349f:7368 with SMTP id f16-20020a50ee90000000b0040f349f7368mr37957151edr.236.1646381605747;
        Fri, 04 Mar 2022 00:13:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzuwab0krTL7gBqonB1LVsc2xM1c9M6xF1CmSuTXRpa2iDTLUYP7/dzn+sKB0U1ka+8rSwHJQ==
X-Received: by 2002:a50:ee90:0:b0:40f:349f:7368 with SMTP id f16-20020a50ee90000000b0040f349f7368mr37957141edr.236.1646381605601;
        Fri, 04 Mar 2022 00:13:25 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id z2-20020a05640235c200b00415cec386a5sm1889584edc.16.2022.03.04.00.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 00:13:24 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, ssantosh@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory: emif: check the pointer temp in get_device_details()
Date:   Fri,  4 Mar 2022 09:13:21 +0100
Message-Id: <164638154584.220122.2312358895225740646.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220225132552.27894-1-baijiaju1990@gmail.com>
References: <20220225132552.27894-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2022 05:25:52 -0800, Jia-Ju Bai wrote:
> The pointer temp is allocated by devm_kzalloc(), so it should be
> checked for error handling.
> 
> 

Applied, thanks!

[1/1] memory: emif: check the pointer temp in get_device_details()
      commit: 5b5ab1bfa1898c6d52936a57c25c5ceba2cb2f87

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
