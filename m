Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFE74F05D8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 21:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245477AbiDBTeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 15:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiDBTeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 15:34:19 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B96C5EDDE;
        Sat,  2 Apr 2022 12:32:27 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id c15-20020a17090a8d0f00b001c9c81d9648so5431798pjo.2;
        Sat, 02 Apr 2022 12:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xC5YcP5OBaUnFuFbRoRxcX6ebnCWUc8hnbBRPxEaIoA=;
        b=VBRumCCITyVZiYpvBfLNOYi5QkQjqGsnpeDdOsG9c4fqF5Oi2efZzF8vQIvUNGYOrl
         recgRpSVjhzSm3t/1pfuFC4RMLpWgUUN985VHE0Itv2hDEcqOPVYYvKOMxAbOzNxAMvn
         51qSiDl8g/md3y+PdAROYkDsRE/BzMukqjcjcm82iQRbzAdYYJI6mv8Akqd2rIUq6Y11
         0di6VkIezGe1jeeEwOt6mct1yIB3Z4LVYKSfGGOBI6NYM0F1mpuwuYZYMr9cjNkXQGCA
         flKl107xNUS9IQuchBR3EavODP1PPzEilJBN4GRNKcpvN7vVODU2ZVGgoT6UYalOrU8T
         cT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xC5YcP5OBaUnFuFbRoRxcX6ebnCWUc8hnbBRPxEaIoA=;
        b=AZKGTrzfR6zpEDtETWIm8y21Swzuv1Cgr4D4BKwbH29Q7M+UHPNsrurND+sI8Rxh3s
         8x/20Dhbh5PjjkdyVr3SDxxkpzOxNjNXXHyYMPPWvMiKlfTgG5nFDW+yHiQlogDa3ocC
         VTxWyhjiQp6L0VYuOeO77+mUXMYsOPpac2jmZ+IJsc73aUrinWXRwlya/Qgwod7yRyPc
         aue8Oyzl+Vh2+qFyVWH1WRwPtAd4ltqiRYygyjaN5ZbgK53eg0ALC5XypOKd8Eto35nF
         DtpDdvIkWVL7nvynWe3CNlvFx6UIzkHYNbEj9+S+ZWvt/zymnt6aXg0Z3npDzQavH7zZ
         yp3w==
X-Gm-Message-State: AOAM532k5M+SlmDY5+fnUfjYn/vk8A/yP6bVD6bykXXhyaFu/YqAHYSK
        JsaCRhKH8GDNDv0drEOJK53dne0vvmo=
X-Google-Smtp-Source: ABdhPJxu0U+phwrtFmwO1PIo2dSRnZun7JNEAIeDB4py45Dkcug4jsqbnb+1ymJka0ga3s5Ms/FszA==
X-Received: by 2002:a17:902:bd46:b0:154:b936:d1df with SMTP id b6-20020a170902bd4600b00154b936d1dfmr16329508plx.73.1648927946693;
        Sat, 02 Apr 2022 12:32:26 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id lr6-20020a17090b4b8600b001c7730210e5sm19261617pjb.6.2022.04.02.12.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 12:32:26 -0700 (PDT)
Date:   Sun, 3 Apr 2022 01:02:20 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mukesh Savaliya <msavaliy@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 5/5] dt-bindings: qcom: geni-se: Remove common controller
 properties
Message-ID: <20220402193220.GC35664@9a2d8922b8f1>
References: <20220402051206.6115-1-singh.kuldeep87k@gmail.com>
 <20220402051206.6115-6-singh.kuldeep87k@gmail.com>
 <5822a845-3291-70da-cbac-933983a22442@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5822a845-3291-70da-cbac-933983a22442@linaro.org>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2022 at 05:41:57PM +0200, Krzysztof Kozlowski wrote:
> On 02/04/2022 07:12, Kuldeep Singh wrote:
> > Now that Geni serial engine controllers(spi, i2c and uart) have their
> > own individual bindings, it's time to remove all common properties of
> > the controllers from parent schema.
> > 
> > Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> > ---
> >  .../bindings/soc/qcom/qcom,geni-se.yaml       | 33 -------------------
> >  1 file changed, 33 deletions(-)
> > 
> 
> This should be squashed with your previous commit, because removal of
> last direct child schema, makes the common parts obsolete. IOW, the
> common parts are only because there is children are open-coded here.

Initially I thought the same, but then this patch will do more than what
commit description says, that's why I kept separate patch.

Nevermind, I will squash it with previous one.

-Kuldeep
