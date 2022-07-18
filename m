Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4855578DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbiGRW7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbiGRW73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:59:29 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A200B33353
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:59:25 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-10cf9f5b500so26725575fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=B31/aK7W3TCrHPuQWtF63vTS+y2Gujm3ucnWccu6dTg=;
        b=p7EmA8FV/+eeA4a1RfsYFI4uAZNgUe/pOiK2TjdDjZzSifiWH8yFm70a1Y1cHvAfBU
         DTzoE1Fut5+rz2Yfgdc/80eIYbzy14g+eawTDKkDSDzBesTaZDptbhFsQUthh8kdUvIr
         W6YkSKZ42wjZqH1WrrjYM48GHUJIT1Y2IbP5vVvonCoV5wN9AxiJGKebBmeQoMYSAy4i
         E4FSMSRNPucC5Vv7DCRY4jkE94rnwoJCcC92XGTqYiqnezCUZmN5rmp+ZNgnOZZJvuu+
         E9VO8pyacmcj4VMAQumcWwfYhZfWdhlCHawyNS6YOLdMGGq6Xy2mzO3UE2y0ftBQZfpG
         7Hjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B31/aK7W3TCrHPuQWtF63vTS+y2Gujm3ucnWccu6dTg=;
        b=IiTer1ReyJ0DgdDjS/wugOnH6TxLuloaQAn0buoFYCsWwZp/PVaRQLoc2ag6zkLihg
         dA2h0XpqFLUwPSScsOjgC1XdaWmwZzO/ne3ZOYNjGTAmUAe+Pb6TP9E8sZuQNJz1QtRy
         T8QL7B7zvQhrxev2ilnoc2kuOGPzjQGqjmHLP6EvTDesiG1pvVTlhDKnDlMsGxFLNZZx
         HR82MRs08T2eIOJY1U/tHzr//MLBWcX7DgkCYF8M2nuljdIR13I3tLAISoo5gb4zoHnU
         C3UfwQDv+Vvqma5/uNeaf6K1wrufmH2BNHO6T2xi+r53Qdg1HmhYlX2EAHVmNRgekYo6
         bGRg==
X-Gm-Message-State: AJIora/v8EJSKKYN0OSj1BhSAOVu/DNQTztax3iHMzqoMi13btcAC7L1
        LsaY0Cx2oUCHOka5OfgBRkZgXA==
X-Google-Smtp-Source: AGRyM1vPPm4kJZEo7j5jkYIz0IITIlMe4kGxXtBf7+dPGXwVcRpOmbyrsE1kMQ+Eb31aKfubxulxgA==
X-Received: by 2002:a05:6870:581b:b0:10c:17cb:ebbd with SMTP id r27-20020a056870581b00b0010c17cbebbdmr18147295oap.131.1658185165336;
        Mon, 18 Jul 2022 15:59:25 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j10-20020a4a908a000000b0041ba304546csm5330931oog.1.2022.07.18.15.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 15:59:24 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, liuke94@huawei.com
Subject: Re: (subset) [PATCH] remoteproc: Directly use ida_alloc()/free()
Date:   Mon, 18 Jul 2022 17:59:10 -0500
Message-Id: <165817634388.1905814.6362323743133289226.b4-ty@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220527073832.2474641-1-liuke94@huawei.com>
References: <20220527073832.2474641-1-liuke94@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2022 07:38:32 +0000, keliu wrote:
> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove() .
> 
> 

Applied, thanks!

[1/1] remoteproc: Directly use ida_alloc()/free()
      commit: 4953012caed20e3d341085a726b97a160d8847fd

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
