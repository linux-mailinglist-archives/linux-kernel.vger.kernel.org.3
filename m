Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD18C578DEE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbiGRW7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236345AbiGRW73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:59:29 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6679833350
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:59:25 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-10bec750eedso27855731fac.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=L2ugrH+vV2/fshk7A8AN1ZS6scfn8XmrA1rF0sehwrQ=;
        b=yuHOIPPdm19zaAsiSHjZBpRrspvcmjZpQ5R3BHnEFdLfJD8hU29D9hN8L7eKKgKQDK
         DeBKL5Cq0reAHR7SxIZcWKvZZ27NYcTBODkPPxJCRCuwHcRjEtK1xEDS5ztI/CBHgb85
         qyulOE++8gId4lqw4zQk/xwwpSbW5cx9aCvAAwH3qCpgfZ6XZLgUCzR40ztZyGYnCgjw
         3NhjcNLZ6qMs8gx4UDd5e4PAVuNG25Ey/FIGtvUj4Fg5t15rdeqGp4B57s3lzKZkpmbC
         F7fIt8CmhlY3w1OBHR5xZfFco3Ftl/kKYSlMDE6bS/65yF0XKL3sjRrngdraO+01WAEW
         5NYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L2ugrH+vV2/fshk7A8AN1ZS6scfn8XmrA1rF0sehwrQ=;
        b=q8Ubj+Cap+f/fAwmRdhisxgGMPWz1dKp5hA4aR/nmiIqP59x+tUiz8NzW+LjLuf7VX
         j2skVWH4B3hiynxaR+xjTGDKyGvvkYaBYeM3HjEGXi/qByCJJclfXBejFHNVIK9ygA8J
         0V3O+C3Op8rChH557bqSkjm5Y8KIu4yYYp7/X6my0Hlu5vCc6tJ+vzN04PLiu935agBp
         mtqjoSOCuf5g6YNhmESUo6kVRZrPWFogY7LLbZdfm1r7+uDEIl9S7qLsQcTAO3wNSmcP
         L8fOmwJt+SrkmbsStO7AnREDqp3MQdhf7PB6f7/CG7FlTyl3By9I22ZWc4KHEJzyDd+q
         5Wuw==
X-Gm-Message-State: AJIora/o458kEIVsITWEUhBoA2jBaFTfSQ0jC5EhjDsdvRC7MUQz5d0e
        gHurwj4CddyAPh9ucfUYPkVhSlprstlFWQ==
X-Google-Smtp-Source: AGRyM1trQRwmcDs9HmVw8Wc+ZYZq17t65W0M6cKZAm/AQ6Pfd8IouTBn0qpKkQT71IdYGV4yz6jmnA==
X-Received: by 2002:a05:6870:9a1d:b0:10c:31f9:9434 with SMTP id fo29-20020a0568709a1d00b0010c31f99434mr15454682oab.233.1658185164491;
        Mon, 18 Jul 2022 15:59:24 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j10-20020a4a908a000000b0041ba304546csm5330931oog.1.2022.07.18.15.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 15:59:23 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-kernel@vger.kernel.org, linmq006@gmail.com,
        agross@kernel.org, mathieu.poirier@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH] rpmsg: qcom_smd: Fix refcount leak in qcom_smd_parse_edge
Date:   Mon, 18 Jul 2022 17:59:09 -0500
Message-Id: <165817634385.1905814.17910663719629021480.b4-ty@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220511120737.57374-1-linmq006@gmail.com>
References: <20220511120737.57374-1-linmq006@gmail.com>
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

On Wed, 11 May 2022 16:07:37 +0400, Miaoqian Lin wrote:
> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> 
> 

Applied, thanks!

[1/1] rpmsg: qcom_smd: Fix refcount leak in qcom_smd_parse_edge
      commit: 65382585f067d4256ba087934f30f85c9b6984de

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
