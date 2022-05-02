Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78377517002
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbiEBNKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiEBNKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:10:02 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C60319292
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 06:06:33 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id y63so15129471oia.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 06:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YpduY3LUujj9agt2pyGYTYUcOltpq+QJYgSduqrfP7U=;
        b=GV90JjF4D7CFDFpMIEVMlD+rNmMAkAKeJwY/3MeT+jIh15ZtQsFlSqF5wddudZNkWc
         9kolMChs2vjLRYPHYp/aV6Hlpu5E74JJuZoVvrn0VwIEyVwaR6maMvZyBJ9w3IJMtU0F
         YcnzHjtir5Wlt6tZttOiyM/fEZ+wrsYEXsuW7I5S3pbWOMA4DWg5tnqjTC/t3eOMNs6U
         uhGa5aeDiMN79Zwujw9ofbp23NpfxJFfr8GHXk3bJpL9rNKmOGjTG5c5CAMdd2B5tivi
         HLSvfp0IAZuUNSI9UMuaVbeDYcPcUpP0nVMYyPNv+bjr5H/MEXs1Hbz25qwArp3voUdW
         oW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YpduY3LUujj9agt2pyGYTYUcOltpq+QJYgSduqrfP7U=;
        b=gzZyzcD471TSwyP8hVElBnXr85/DcC7zlkzhS+iL9vJQFOwDYJ7PxNJ6+sL9OiDuau
         7F5SnJuVAKYcqLSyCIo8OryTnQ7ViwR9x4hGFcIXtsHVNbZBMeH6yN0axGenfTZ/mL0z
         89Nnl09YMipLS+gKxyMJCCM6S+lvUEKor68A5UpdpdvxHU0qzqEk0Rsy0x/Qpmt+ep0y
         IqPUVC1x2nU+sinoZaWKQjMa5rJZYQ/G96Mfrv4SL7M8gUATsxvsvsyvFuxgCLuSgYxm
         DkyQOXoCBnhfvmyTuSGtaaYKuV4s03+8av+RpIuIiO7pj/2+dwdUE8EpRijtgbtZ2aWJ
         fZfw==
X-Gm-Message-State: AOAM531CjShHPH4JA8eu5zLQVMOYquJcHfrIkzM/hUDXa0u4pyQrRZgx
        eghBj8ofmw1BEKRBn+0oy3OMhg==
X-Google-Smtp-Source: ABdhPJy6gYlkrEw3HdhYgJS+i0PI5/yd6+OPCsHSn/J3tWNjwTbyMiQZ+NvTBxbS58riCDUPJjLlbg==
X-Received: by 2002:a05:6808:2097:b0:326:c73:10c6 with SMTP id s23-20020a056808209700b003260c7310c6mr1321633oiw.182.1651496792671;
        Mon, 02 May 2022 06:06:32 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id i13-20020a54408d000000b00325cda1ffb9sm2282403oii.56.2022.05.02.06.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 06:06:31 -0700 (PDT)
Date:   Mon, 2 May 2022 06:08:18 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/3] regulator: dt-bindings: qcom,rpmh: update
 maintainers
Message-ID: <Ym/XwheROw9Y1JGx@ripper>
References: <20220426105501.73200-1-krzysztof.kozlowski@linaro.org>
 <20220426105501.73200-2-krzysztof.kozlowski@linaro.org>
 <YmlIDn1aHSrcoeoJ@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmlIDn1aHSrcoeoJ@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27 Apr 06:41 PDT 2022, Mark Brown wrote:

> On Tue, Apr 26, 2022 at 12:54:59PM +0200, Krzysztof Kozlowski wrote:
> 
> >  maintainers:
> > -  - David Collins <collinsd@codeaurora.org>
> > +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> > +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Bjorn, are you OK with this?

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
