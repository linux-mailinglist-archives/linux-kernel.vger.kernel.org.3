Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3834450338B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356653AbiDOXqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 19:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356651AbiDOXqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 19:46:36 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF95FB6D3E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 16:44:06 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id s14so8151717plk.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 16:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w2QrILTyqQ+Pt7TX+dc/u5nUBhPOOUFyhDJl0/uG8KA=;
        b=WQYEUw+TfPdba4M0qoV3YoYNx0EokWXTwcm94AT/cqahCQWwwjBWEbOZD4bvmT0NFb
         Xcx5ODn0k7YRALA13OhixgkDU8uYYogteOunDDY5goCtmJyK/qUBiMez/8Ex2AWPKxfs
         zWYTFOtjGivIKkh9dDxV5C6NheZrsC87+NjXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w2QrILTyqQ+Pt7TX+dc/u5nUBhPOOUFyhDJl0/uG8KA=;
        b=uY+k+EhwEn1uUTLNQDnDyiCXfruxtu6RjXrLXevpw7gA0LPX0uUESaW4X2YWjsfAmU
         hkoXy51k2iftX5f2uAORp3vtQOKJ6F8COnSwmvRTI2gCdThnG+RBbn1qXfySs1YHm6Vl
         GMprNDFOc2TBgHSyqxQ7uzimgu1s+X1zmfLfUrc7bkjsvvdfJ7NBccYHqONH3opir8ns
         ZHXWknG8YP4s1xbiD58bAM9wknfnMWppEJ1uAZzliHbioX5D4LLdtHpf5hVuHU8mkCRE
         4qlcEw86XPeI6M19KTSRoRa1fgms3ntaU79O6lEOyGpTx1JDqFzvjBLoW3o6kyhGVl90
         bZUQ==
X-Gm-Message-State: AOAM530FHitzv/U9CK3y0FrBlmXf6QAtl3cOUbIZNy5C0XyOJA1tN93G
        24bhWv3am8I4hZ/1AZclMWyDMQ==
X-Google-Smtp-Source: ABdhPJx5DUqDtUFoTZutT3tV3A+5mldSPzpeVrsrxCdXDbVcaqBeXAPd4TrSNpEqM3FQkJq1z1ovDg==
X-Received: by 2002:a17:90b:1b44:b0:1cd:49b8:42b8 with SMTP id nv4-20020a17090b1b4400b001cd49b842b8mr1313605pjb.102.1650066246324;
        Fri, 15 Apr 2022 16:44:06 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:b27a:b3e7:2e3e:e4be])
        by smtp.gmail.com with UTF8SMTPSA id k10-20020a056a00168a00b004f7e2a550ccsm3938967pfc.78.2022.04.15.16.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 16:44:05 -0700 (PDT)
Date:   Fri, 15 Apr 2022 16:44:03 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v12 7/7] pinctrl: qcom: Update clock voting as optional
Message-ID: <YloDQ7V7JTNYkjWu@google.com>
References: <1647447426-23425-1-git-send-email-quic_srivasam@quicinc.com>
 <1647447426-23425-8-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1647447426-23425-8-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 09:47:06PM +0530, Srinivasa Rao Mandadapu wrote:
> Update bulk clock voting to optional voting as ADSP bypass platform doesn't
> need macro and decodec clocks, as these macro and dcodec GDSC switches are
> maintained as power domains and operated from lpass clock drivers.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
