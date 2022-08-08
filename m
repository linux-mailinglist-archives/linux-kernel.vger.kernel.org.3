Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C0258CD98
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243661AbiHHSZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243547AbiHHSY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:24:58 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFE91834F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 11:24:57 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id cm4-20020a056830650400b0063675a4dd74so6994785otb.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 11:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=BXmKAxN+waZA2YRA+GAt+cjLZJFu2ji2c4pqzBzqU20=;
        b=aeQR51g04XOu5Nj7Ud55qAtbfS0EAZMwf6/rRtSn5cigxMzW+jPr5Yssat0LtQ73Vs
         tfZykfcNNDFPbD+YSDbDrcpvY+4EqzXLWSsrL300omR5HNxJvhiffQA5rNCXkCdCNKXt
         A5+dlh16TB2+5fGCHHvhYNbHeARmXNEOVuc4LbuntLyhrC1HXwQXA4OR6C6PgXi3MYhw
         ByiWNlxP9lkUg2N/GyNdjL0y9lcfuwgrkKWT5OFQAAChB+o84e/mUjxMzqf9HxXX4F5c
         51t+q4AKBbq6fjuGNpVZzHn23ve3qeqNdeF9roH6huV1ps112YX558b/xx6ogOlLw4XW
         MJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=BXmKAxN+waZA2YRA+GAt+cjLZJFu2ji2c4pqzBzqU20=;
        b=l2VbmkGG7VqepeiGMN8b5mfGiTMAi5Kdj6StYI8HbdK7yYq8kbY+9smfuiV76WUQbL
         KsqhTkJOTfZU+T1KYw2BwECWbNeLZdlB+jU9d6YpVDAZaZ3Ch6+SnbuLUTaEcBhlkyzf
         hljx76tezI8KM3xJvwvS5IsKjH/zklDqheo+JsMnVBEV4856ZmMtHKWgjWk5O7lA5Tg6
         cR3ajzXUZTM8y2FLYx7GdH9mdZGPQXOmSqwh5/hnt4zo0Z7yw4KQ/FinP2RanGqT+mY8
         YgX1VNHRRp+quFsiQAbJHgO8HCmtvZJwITogV9M6Z7lm/OuP69K9qpGj508jpOjjVwcW
         Ab3Q==
X-Gm-Message-State: ACgBeo09jO7mSvduwti7DfcQRxb8jnNpeI2TBiRHwBjO/SvsnsiUIGC1
        QsaLDNdBlhUaad+sUUHd/cqiFg==
X-Google-Smtp-Source: AA6agR6wMajN1waq4CNan0o37rNine9lbypsKoifWSYs8hc9o1Y600KrswfTWx0LROJdF+9SrMDCdA==
X-Received: by 2002:a05:6830:16c7:b0:637:325:4fb2 with SMTP id l7-20020a05683016c700b0063703254fb2mr905875otr.247.1659983096782;
        Mon, 08 Aug 2022 11:24:56 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t31-20020a056808159f00b0032ed2343100sm2135431oiw.14.2022.08.08.11.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 11:24:56 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, johan+linaro@kernel.org,
        linux-kernel@vger.kernel.org, abel.vesa@linaro.org, steev@kali.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2] remoteproc: qcom_q6v5_pas: Do not fail if regulators are not found
Date:   Mon,  8 Aug 2022 13:24:55 -0500
Message-Id: <165998306364.2104555.6923864221478341962.b4-ty@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220801053939.12556-1-manivannan.sadhasivam@linaro.org>
References: <20220801053939.12556-1-manivannan.sadhasivam@linaro.org>
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

On Mon, 1 Aug 2022 11:09:39 +0530, Manivannan Sadhasivam wrote:
> devm_regulator_get_optional() API will return -ENODEV if the regulator was
> not found. For the optional supplies CX, PX we should not fail in that case
> but rather continue. So let's catch that error and continue silently if
> those regulators are not found.
> 
> The commit 3f52d118f992 ("remoteproc: qcom_q6v5_pas: Deal silently with
> optional px and cx regulators") was supposed to do the same but it missed
> the fact that devm_regulator_get_optional() API returns -ENODEV when the
> regulator was not found.
> 
> [...]

Applied, thanks!

[1/1] remoteproc: qcom_q6v5_pas: Do not fail if regulators are not found
      commit: 8447d0e75099eb54eea9306c2d43ecfc956d09ed

Please remember to Cc linux-remoteproc@vger next time.

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
