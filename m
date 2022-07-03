Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E884E56444A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 06:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbiGCD7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 23:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbiGCD6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 23:58:33 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1530DBF63
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 20:57:40 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-10bd7fbc0ddso2841943fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 20:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nWUbM1QO+xcB9DJ8bgLAmaBbOykL1mmTX4oz4sv5DMU=;
        b=i5DSNyHZXPTWebDSN8WALRkLrbQ2w9ufTMW4wMGpaCjvY5jDk3vbHcYQsmP+dy6k7g
         ELS5plsRe2pYZUkM/U4h4pQOzIeuGP2K++NaArenbUDKmwUMQQlq20lhmdMAtKWHhzds
         vqOaupLzAHoJd9ULlRHhOJyBqW4KOfplvFIXk/bgl4wxmEjwxVtTajLDNbAvedbZelJQ
         jRZluosCe+3v691ZnCdq77oKiW7/S+U6OMHF42mz8rd9+DHvWVMeaYaOo4T6EU34D4bb
         dd080dLVA1xUoMoRO5/zMqbjr0ETcZKBHhiOnCwcAKuJ7XU6HtJ4Ztn4HutVqSjO1R4F
         3gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nWUbM1QO+xcB9DJ8bgLAmaBbOykL1mmTX4oz4sv5DMU=;
        b=cI5sZIcSRgnSP5i0egZ35BqgGF9Rg3jX5RecnQevS4338UmJlQ0ON83tDJwqcPgwGw
         cC03idh8kgcE4cYf/2nNnOFQ4q2qhEkYiYi4jAfq8RLqk1pI+lCgHk7U6+5EMpLbO/S+
         hJLqZYcLHah+QJ9Vktcb7BduFpvuhiLoiWnBGXcf2bC5ftfW+i61w2EcWa6t203M8xat
         ZJPzRpn2ew28uhQHBKCvyKBW9M4zjFdHWyOVWvPlBPppuCnRrHrcQG2tiKpUi5Iyuay8
         WYpZtIO7Wi0iMDSW8OnENxEnETt01ytaVUsATvqhCsVO7eORCX2PqJnuEqgUMrM91wvO
         EIeQ==
X-Gm-Message-State: AJIora+3Qr0wzhp3cnGS1uO5BaPEJ5j+0zenCzRYEeAuzW9mJERyOj1e
        ShYZ5lb5tw7Eam6/hzScngpjVDh8xwiKfQ==
X-Google-Smtp-Source: AGRyM1sqLexwtJnrzF1qOkUVOnpFuDcbGEEUApIdEyVUgA8qxlNS8eVMR2q8JzwPmWq7rFWu3Lkwjw==
X-Received: by 2002:a05:6870:1601:b0:108:2d92:5494 with SMTP id b1-20020a056870160100b001082d925494mr13866510oae.109.1656820659840;
        Sat, 02 Jul 2022 20:57:39 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 25-20020aca0f19000000b0032e5d0b5d5fsm12965910oip.58.2022.07.02.20.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 20:57:39 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [PATCH] soc: qcom: aoss: Fix refcount leak in qmp_cooling_devices_register
Date:   Sat,  2 Jul 2022 22:56:33 -0500
Message-Id: <165682055970.445910.6550423116947481475.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220606064252.42595-1-linmq006@gmail.com>
References: <20220606064252.42595-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jun 2022 10:42:52 +0400, Miaoqian Lin wrote:
> Every iteration of for_each_available_child_of_node() decrements
> the reference count of the previous node.
> When breaking early from a for_each_available_child_of_node() loop,
> we need to explicitly call of_node_put() on the child node.
> Add missing of_node_put() to avoid refcount leak.
> 
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: aoss: Fix refcount leak in qmp_cooling_devices_register
      commit: e6e0951414a314e7db3e9e24fd924b3e15515288

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
