Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0190D4E5A7C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 22:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344861AbiCWVNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 17:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240625AbiCWVNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 17:13:47 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B79638797;
        Wed, 23 Mar 2022 14:12:17 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g20so3364027edw.6;
        Wed, 23 Mar 2022 14:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=X2+OcNrbzDp5B4Ve0adV2puYvqZ6ezMUh9fPKK/Tp1w=;
        b=LD9/G5VmePzcUqAWYbnmsVNgSgzMV5SgftIdlZyyEJcZRmjm0pXfqi3JOxpHh3VhjP
         8S/3AIFtiND+nN+j+yXGY9qOpaXHvTCn4z6jsp59skJBthyAr5vYVwoXSyZEST2MeRRo
         RhSolSH0wPzG0F3NDU0JC8IEdiv0X10qUeA0Cgn5F2Fbifl3aFnpEZOIyOVCnEkv6puX
         hY8AjFvyYI9xERaLIZwK8t2eU0leTjiILn0nR9Go+2ZvM/SP3LR3jmfCl2j11AJ7ZhWu
         F1K968YFRkNpVRPWqnCvjwDRv7PMXyrvZIgVA1rns+6wmwayzqiIrFzSb53auqNHr/UN
         qLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=X2+OcNrbzDp5B4Ve0adV2puYvqZ6ezMUh9fPKK/Tp1w=;
        b=p5niDT3ced8H0qZRFTnUMzrnvB7e4Rcr8du0LnzdJAeWMGyZQH3/ncgpzey0+klMeP
         hCtLd70Ky0pt1v5J2DfI82N4UWFerLthTXq/NNJKigRJCWTK+pz8l8L9bNPolA6DSegp
         lxFhqDqHdmH204Z/szzf42lftQpiYZqTC/r4zdbCacn6v1U2oaQEiID4oyKJOnX43oKE
         CONTfwyQ+qW4q5nbwCM5NgWyO5JxvQSSowj7RDPX67x07t3m6NrMsez2ASBMJQo1rMNk
         dtAjAijNPtPTYx/lAZJlcHhSSC183phcVcoRBxY6RturDb/+ZDlANglgJcs0pjtcdxpl
         EaKw==
X-Gm-Message-State: AOAM533XfSSXxiKbmGGDISTwxbzea9cHeN2G9hI+nXksufxQfJ/BIb5c
        r6FllrxfWp6qKk+4kea4x5kyHgMQzvVJkQ==
X-Google-Smtp-Source: ABdhPJyCPP6sx07lgRLKmsVw1l60qOOeDEgj6/C4mFFS/Fh6wDZpDxuoqsBvpdgmxt6vbIewieUL0g==
X-Received: by 2002:a05:6402:438d:b0:419:4550:d52b with SMTP id o13-20020a056402438d00b004194550d52bmr2674112edc.83.1648069935712;
        Wed, 23 Mar 2022 14:12:15 -0700 (PDT)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
        by smtp.gmail.com with ESMTPSA id e26-20020a50ec9a000000b004193fe50151sm450563edr.9.2022.03.23.14.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 14:12:15 -0700 (PDT)
Date:   Wed, 23 Mar 2022 22:12:12 +0100
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/15] arm64: dts: qcom: msm8992: Use the correct GCC
 compatible
Message-ID: <YjuNLIv0frA6WMSE@pevik>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20220319174645.340379-1-konrad.dybcio@somainline.org>
 <20220319174645.340379-7-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319174645.340379-7-konrad.dybcio@somainline.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad, all,

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

Kind regards,
Petr
