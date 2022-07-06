Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517F856858C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbiGFK2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiGFK2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:28:48 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F4F25C5F;
        Wed,  6 Jul 2022 03:28:46 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id h23so26250445ejj.12;
        Wed, 06 Jul 2022 03:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=VVGeVKDI+7qLtudXmDhJgAOO6mNBIouMLH+809WPqyY=;
        b=Eu4Kft9TSMEQiyAsqjB8hTLmOY1tnTqsg8pnjj+eNbMkzCcZi1BbhFLyG4ZHcFAu/9
         kQ1jX1eMG9p+lhw0FjdynLkG88+TJZtfEPjA8MgBORgNMri2ZuYMh/oyW8Es/vr6muN0
         v8BA6OLj2t7glK77aCkaAVb9frB9vMTzpz+GpjgO/w9mtZhJHvpzJ2jxedfDUMeilOAQ
         TwY4x7ROp2mz0qz0qncFgfpAB8nRPNtMg8+tyNNAgvtiGigitYdwRUEI5OSuBdgOjCOB
         K9fnselknyifufbOv5IxUlfgTJ39xQVMiLu9Ch9DBGFmadACsiWSdfo6oWZa6mTlI3vv
         Lvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=VVGeVKDI+7qLtudXmDhJgAOO6mNBIouMLH+809WPqyY=;
        b=alqIgGjTSMihvNB6+tH0VYj5vuGi3YO94aQoZHIbyADYHiGQVfDCJJ6KPd6eT5uDB1
         RXbETf85wjsuJBWSy/jSCJdOyhL7oc1G+jURCOGndh7ulLXFT+sgnjcLlUTYae4lEQVM
         t4orNn0VQqrZF0e4dVE0zzYuUJTXLSncyMlIJqIhrF4/vh7xWoInmEnWX7NDOQq1tITP
         JHml+C3/oMmUs5ci/uvBjvLEJ1syH8F87b4xAcaOiiBA4caSo8JB1xy/uY9iSKirQEIH
         PY3mx5Q0Co6VtAFZA3ufeLHH9hS0k4u5lfBMhZbdRcY2pr3riiaLMV/XTRYLM3B3Gzio
         PCyw==
X-Gm-Message-State: AJIora+gSmYIKdaTHDeYc9JTf/Cnu+ksQmF1lZ4zGGYowJshZYPPuS+e
        o+GTyACBMsLtHnHNUVUbTrk=
X-Google-Smtp-Source: AGRyM1vsz7hqpb+M/qtLYprfrRnuZbEugc0U0eZ0smm+7sE+ub4ToGlnUFw8+MYP9bocANkTRuCZ2Q==
X-Received: by 2002:a17:906:8447:b0:72a:f120:50cd with SMTP id e7-20020a170906844700b0072af12050cdmr4671142ejy.114.1657103325133;
        Wed, 06 Jul 2022 03:28:45 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id q24-20020a170906b29800b0072629374590sm17220261ejz.120.2022.07.06.03.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:28:44 -0700 (PDT)
Message-ID: <62c563dc.1c69fb81.e405a.e7c0@mx.google.com>
X-Google-Original-Message-ID: <YsVf+NPz6zkfQE3z@Ansuel-xps.>
Date:   Wed, 6 Jul 2022 12:12:08 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH 08/13] ARM: dts: qcom: fix dtc warning for missing
 #address-cells for ipq8064
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
 <20220705133917.8405-9-ansuelsmth@gmail.com>
 <7c3ef50a-2a4d-4b75-3aab-3bfbf12e06c4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c3ef50a-2a4d-4b75-3aab-3bfbf12e06c4@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 10:37:47AM +0200, Krzysztof Kozlowski wrote:
> On 05/07/2022 15:39, Christian Marangi wrote:
> > Fix dtc warning for missing #address-cells for ipq8064.
> 
> Paste the applicable part of warning in the commit log.
> 
> > 
> 
> 
> Best regards,
> Krzysztof

Can I squash here the warning from the smb patch?

-- 
	Ansuel
