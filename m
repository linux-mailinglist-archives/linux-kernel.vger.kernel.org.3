Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0D053C9B9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244184AbiFCMNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240041AbiFCMNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:13:02 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE731289A1;
        Fri,  3 Jun 2022 05:13:01 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u12so15546723eja.8;
        Fri, 03 Jun 2022 05:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oSn+qALKHYEwcZ0UGKZ6LRYOpOj2VTnTzs3AikaDunE=;
        b=nc90WpIZeQWxyFlgnF0IWWIbCOc0FS3/BB0jofR8MQaqRMOwFBCdc3IgIXIiWwlHrc
         zKp7KQV5Up0fo7Jmd+dxxVRMEKmSedM+va8lgto82BageliJC960ZpGLJD4JIJn20Sfg
         7/LuHmbfiyW7uHv5B0dnBN7M/uzxdxUa5057JDlWT1iFu0mZ/XlYBHojhkdAA9GNdAST
         msuLAHghaxNxGdT2lbzfw37fY0rzCnJbZ+DQ34KWnl8XUeH09ZUQTXOogFWitRYMZrDQ
         xPKC4XbHfP9uNk88bJURrp+zwvpltqD/Sw9lgCnrL2tpJIYaF8mG1ZRhxNvE5K/qDNTT
         zApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oSn+qALKHYEwcZ0UGKZ6LRYOpOj2VTnTzs3AikaDunE=;
        b=6DjFAV9TBJWBlLrvIBjKMQldWO+ySzeaDIoTbDFsDBG+4XS9aZ2/9WeSzLYsFfrwXo
         1OFdgGgrlcMMVRFGsxqs+ja1vm+40mVn9oN5ltlkVTyQs/iV1+LTVpovFeMFmXFmi+oO
         jcbUD2dBIJa5yrtBWoFeSapquG6zDfVZ4GJQmiv8krVIgayyyuGGChxen6q15yTDx3Xl
         TP3oNlFTIYkbCxxi0lMg1ZfRnVU74CSrLpm1M7gBpb6YGKD/lkQtmDdO2ZCd2BElMvnH
         DzH7L0uOF+uZOnTRLcxQF/7+ZUswEKjT4mPazoqB4uK/xsUiiCwXDV8JtLkgqmsYdPds
         rVGg==
X-Gm-Message-State: AOAM533Ds6W83/NmGxmlr3W2CkPt8S3yCd1snwTIz12jaam/kY3Wn53/
        kHzG/8l+42kAnjNgObOVcQA=
X-Google-Smtp-Source: ABdhPJyeK1lbMDJvtp7U5Ikzsw9E39URbnoaLcUVfQD3XrffaHAgOPByB0YZG1+srSBvYaAwZ0KZKQ==
X-Received: by 2002:a17:907:62a6:b0:6ef:8118:d3e2 with SMTP id nd38-20020a17090762a600b006ef8118d3e2mr8211127ejc.605.1654258380357;
        Fri, 03 Jun 2022 05:13:00 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id j3-20020a170906050300b006fed99e1143sm2742144eja.61.2022.06.03.05.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 05:13:00 -0700 (PDT)
Date:   Fri, 3 Jun 2022 14:12:58 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Convert
 rda,8810pl-intc to YAML
Message-ID: <20220603121258.GA4919@standask-GA-A55M-S2HP>
References: <20220527125633.GA5145@standask-GA-A55M-S2HP>
 <4bb8e18a-11d8-c617-7952-8887aa815301@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bb8e18a-11d8-c617-7952-8887aa815301@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2022 at 04:05:12PM +0200, Krzysztof Kozlowski wrote:
> On 27/05/2022 14:56, Stanislav Jakubek wrote:
> > Convert RDA Micro interrupt controller bindings to DT schema format.
> > 
> > Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> > ---
> > 
> > Didn't know what to do about the interrupt sources listed in the original txt file,
> > so I've split them off into a separate file. Hope that's okay.
> 
> Interrupt sources are not kept in header files.

Ok, should I move them somewhere else or is it fine to drop them?

> Additionally are you
> sure this is a property of the interrupt controller, not a property of
> SoC itself? I would assume that one interrupt controller implementation
> (e.g. GIC) can be used in different SoCs and the sources are every time
> different because they depend on the actual wiring...
> 

I honestly have no idea, I just wanted to make some YAML conversions.
Maybe Mani could answer this?

> 
> Best regards,
> Krzysztof


Thanks,
Stanislav
