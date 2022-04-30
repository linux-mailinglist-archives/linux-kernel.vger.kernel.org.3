Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6566C515E68
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 16:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382884AbiD3OyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 10:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382878AbiD3OyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 10:54:03 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852C213D28;
        Sat, 30 Apr 2022 07:50:41 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z19so12051821edx.9;
        Sat, 30 Apr 2022 07:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=35Z38xa8v30mqUUeSUS3HbNABmBpHeiUXWnZOefNVTM=;
        b=AR2MkGG+6LI/m1uDVb5qrF6f8++OLChjDqjv9zvDtU0K8sydE53k6ynYldLCk9Uw4w
         WCvHLH2Bd1oZPk6oYS7zTDOr9lFULgdb0RfyyM786u/NGGZFyzGGUxvLJAsXSXtSQjJp
         +NqUjG7HrKkL9Otj+U2+VkPAV+ZMkPdpuS9TJrAoQEdqipbnGmEkzbC1/DIxrjk6FA0W
         aOtxjISyVu+ZzYkhReLkOxZ43PuZzfBnOnMXFIwbY+8ET+b3Z8jdqCmHFLZq6Glk0o0A
         vrSg/Ptj5oaHklp5WZ5CPjMBI/6obfc+qESRnAqvs6XCDbwOrry99T/taxgcp99Z/hZH
         ftJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=35Z38xa8v30mqUUeSUS3HbNABmBpHeiUXWnZOefNVTM=;
        b=2J8SWQk3VV/Jah0txgiTcQa83ammW7Pe8vCKDNh+Iy/DwHs4QH12B87EVtrLsRFP/i
         Al8ewAtRbzGodqD1CaT6+ESLzXZ0jifW6uddc7KnYYRNf0NrWhsH4+qUzaJJTYk7flMc
         KWsYVj2qISsa031EZXlnzt898/nYQj7oBY8czlcQh+HxI6dLF93i4EmGeVCOliBDYURu
         SodKvHI/d64/bi0xRW87Wn363uB1WP+vwtWjHfvFyXKXd3clfg5hWtkNy2IanqC7I3rx
         bFeAUuM0vBAFRR4jq6kvawcR4zZv27jpddul/U/EpMbnaQhp2RbuPwwoZLWyqNFzZ7XQ
         hhOQ==
X-Gm-Message-State: AOAM5332oVBFMqD5GBibsT2qOcx6Qa0817wQO87MMdP4AbKaUD0YJQ6r
        1Op0K4vJr+ijM7rFrAX6U10=
X-Google-Smtp-Source: ABdhPJzhsoUpvtx4Z6JBYZ5oCMOo5p1WBt6jwZmgE1ZSbLsuBNCk1iQaRSqqVpYgKD2KqRzyv3qhlA==
X-Received: by 2002:a05:6402:2547:b0:426:1763:4c5b with SMTP id l7-20020a056402254700b0042617634c5bmr4857413edb.176.1651330239860;
        Sat, 30 Apr 2022 07:50:39 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id e25-20020a056402149900b0042617ba63d5sm4172358edv.95.2022.04.30.07.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 07:50:39 -0700 (PDT)
Message-ID: <626d4cbf.1c69fb81.e6965.76b4@mx.google.com>
X-Google-Original-Message-ID: <YmzoYl90+KVdkrPA@Ansuel-xps.>
Date:   Sat, 30 Apr 2022 09:42:26 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: arm: msm: Convert kpss-gcc driver
 Documentation to yaml
References: <20220430060125.9124-1-ansuelsmth@gmail.com>
 <20220430060125.9124-4-ansuelsmth@gmail.com>
 <fec305d1-d4b3-3f9d-bc31-bc33490d1ad7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fec305d1-d4b3-3f9d-bc31-bc33490d1ad7@linaro.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 04:40:54PM +0200, Krzysztof Kozlowski wrote:
> On 30/04/2022 08:01, Ansuel Smith wrote:
> > Convert kpss-gcc driver Documentation to yaml.
> > Add #clock-cells additional binding to required bindings and example
> > as it's a required binding for clock-output-names.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> 
> 
> (...)
> 
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - qcom,kpss-gcc-ipq8064
> > +          - qcom,kpss-gcc-apq8064
> > +          - qcom,kpss-gcc-msm8974
> > +          - qcom,kpss-gcc-msm8960
> > +      - const: qcom,kpss-gcc
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: phandle to pll8_vote
> > +      - description: phandle to pxo_board
> > +
> > +  clock-names:
> > +    items:
> > +      - const: pll8_vote
> > +      - const: pxo
> > +
> > +  clock-output-names:
> > +    const: acpu_l2_aux
> 
> It does not make sense having a constant output name. What is the
> meaning this property in such case? The original binding did not enforce it.
> 
> 
> 
> Best regards,
> Krzysztof

Mh. Should I just drop the const and put a description referring to an
advised name? The driver with the kpss-gcc hardcode the name to
acpu_l2_aux that's why I thought it was a correct conversion using a
const but I assume this is another problem of not making a correct 1:1
conversion and adding fixes on pure conversion.
Think I should drop it and put a description to it. (and then later fix
it when I will push the other series with all the tweaks)

What do you think?

-- 
	Ansuel
