Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CA94E8CB5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 05:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbiC1D5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 23:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiC1D5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 23:57:48 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888BA2ED6B;
        Sun, 27 Mar 2022 20:56:03 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id a11so11330970qtb.12;
        Sun, 27 Mar 2022 20:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=03aR3MfA/hCu36kyVYa11iw/hI3fFEpil9/f9TAKde8=;
        b=NjS0MQrXfhvcMJ+x9aH2I/vR3GPAehQMEVsHxz+Nu6zrwMPJc1er4ruV2asbhbzldi
         uQi6sDRQXIibjUeAiBxNP2ZfbFFmhPzN2TC8odqSAi53/K5QEmlzOtoFWXGREAicNyje
         bz7Z7qLeHRnGjcTFKJaxxIsSGNO7KuPgS3GpYZD+xJ66cEPrGPTndnWpOpcrMWr/7SL8
         1mJCrpSrh3Ysl7RXev6FOZ2UJJFnYGTvvyj1oo2tw7bTEVdaVJsJbf3gzYgE60BjYawe
         lE1bkVk0/Wx2ngFCyakY22Qs53Ij9JmiFe82K6kDAlzWMhEGtmO47InSdy5zCSeATvlY
         rY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=03aR3MfA/hCu36kyVYa11iw/hI3fFEpil9/f9TAKde8=;
        b=lInYB2faBbAEIoicqy5h09p3rKSTgRAx11fwbWQIXo2ejlwDCZmQlZ6ErOIA8btiyE
         9HguJ5cb//sK1Cx/p5M8bAh1KRL77FQ3nH3oaARscY3yxwYpzU0gKcuaf3Jvb7u8jKCd
         TM4TDz0PzMNS/+5HOi0wdrQTKRxg/Q6m4FXVWIcHVldESj53MSh0Wj45V/qMw9I/F6j8
         VAHlTu+e9IVST5Ld4SdEq2Ih2wq4cfLc7BrY7Nnb4pL1nyhWJWgWSg25/hRMXG6lPIFM
         MKrblD0PNsHmsROXiOqygml5VgoObcdnOaVC0ZPC+pmRbFRCF37V9sMpvpxWwFR4mPgI
         3WMQ==
X-Gm-Message-State: AOAM530vUIPlA64+rnzvZ9fDuc+GoFNCbmE9WeeS3XazrJCw+ODtGSZD
        26C9Gw1EnhRX2xQ23xytoi4=
X-Google-Smtp-Source: ABdhPJwjNplIhyndBYfc5+qt988HQZCa95oOuSWKPNZha4EkFwCVG8QEXbRuruK+XT+huSoJhRgb9w==
X-Received: by 2002:a05:622a:178d:b0:2e1:a593:2d63 with SMTP id s13-20020a05622a178d00b002e1a5932d63mr19854077qtk.563.1648439762766;
        Sun, 27 Mar 2022 20:56:02 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o27-20020a05620a111b00b0067d5f359007sm7006967qkk.23.2022.03.27.20.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 20:56:02 -0700 (PDT)
From:   Lv Ruyi <cgel.zte@gmail.com>
X-Google-Original-From: Lv Ruyi <lv.ruyi@zte.com.cn>
To:     damien.lemoal@opensource.wdc.com
Cc:     allison.henderson@oracle.com, bfoster@redhat.com,
        cgel.zte@gmail.com, chandan.babu@oracle.com, dchinner@redhat.com,
        djwong@kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, lv.ruyi@zte.com.cn, zealci@zte.com.cn
Subject: Re: [PATCH] fs: xfs: add NULL pointer check
Date:   Mon, 28 Mar 2022 03:55:56 +0000
Message-Id: <20220328035556.2372314-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <32fad707-fdab-75a6-f7e5-d356a0b86983@opensource.wdc.com>
References: <32fad707-fdab-75a6-f7e5-d356a0b86983@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, please ignore the noise.

thanks
