Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1BC552F79
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 12:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343867AbiFUKMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 06:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiFUKMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:12:05 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0D4286F0;
        Tue, 21 Jun 2022 03:12:04 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id j22so8215690ljg.0;
        Tue, 21 Jun 2022 03:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=03Jq4PVZsTZ/X9cKBPWp0lhW/8xvAGxNyHHzAOjpF10=;
        b=SrLbEFS0VyflCBHWy8qxjLmADDTNnfUoB3nzHcoL08ilgAtm3iTEpGRt9pnRZ2p0Jc
         NAl0hV9vHjcZh7zBK/WWN+ouwfJSnLl5qihby/8yEcuSj7dcYV2Xcc1RzWy8denk//QY
         IJ1FXRlRgogyPjEbdLLhwOtR3d6T6xlMz1dkGYr4+0CAMqRIx8xSIZNP+S5k00G6DEa+
         MBzybVFQqO5m7DZtMAhIAZWhHnknR/4buq7NuzegpZ7iLdDJLDc4B+e8McJxzeefZ6Lt
         TCRM+RI++A+g93b3QjctW4ykLXyJG21pA544Xmi7bYAHLoTZEq9XvOwe4A/DxKVwdis9
         Z/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=03Jq4PVZsTZ/X9cKBPWp0lhW/8xvAGxNyHHzAOjpF10=;
        b=IcrWZLe4G3BRuFRGzAvtt6fs9AC+RT/Qtr1JI40cN887qEko4b6dB5VuasHn7Rwrd6
         EaiIHR64kMrNS911kWjeh/p1/g3wHdwvQD4dOFIx3s/sFe7tUwggKgQ0cx4BJEXZ2/HE
         DPyw9igvbKj4q6GNgt5MLEZxoAinruDuQ+WM4rcH6+L+1DOTXfqKX1WcLV/iybrk8cGl
         s4p28NS6bUuwdThKAysQIOHf7IjbKd6GKuBuMe5HRx8AMtNr4iXPITEAhhLnYG2VaGHb
         CArzX+Kv4en+NyurNtRqPf9mkOS/mT9dmi3BlR+2LPqzdmNBaVV1yeD/r9Wc17y3Zr7K
         hPJw==
X-Gm-Message-State: AJIora8nKjogYItxQIDawQ15Mut/M+GIAevi/vTFfbWf+qMyL74+9idZ
        dHu14htSseg9Rdj27JLYXpR52km9ug/mKDaz
X-Google-Smtp-Source: AGRyM1u7isDdRU5wiug9yDoKlpD2Z75vXUFB9x/5E1nRK+BG/iJsMKUrjIJsxTzMAKvUaZBI1V8dsg==
X-Received: by 2002:a2e:9246:0:b0:25a:6c6a:10ce with SMTP id v6-20020a2e9246000000b0025a6c6a10cemr5393309ljg.501.1655806322381;
        Tue, 21 Jun 2022 03:12:02 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id u5-20020ac258c5000000b0047f71e4b0e5sm69225lfo.255.2022.06.21.03.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 03:12:01 -0700 (PDT)
Date:   Tue, 21 Jun 2022 13:11:59 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Brad Larson <brad@pensando.io>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        broonie@kernel.org, yamada.masahiro@socionext.com,
        p.zabel@pengutronix.de, piotrs@cadence.com, p.yadav@ti.com,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 04/15] dt-bindings: spi: dw: Add AMD Pensando Elba SoC
 SPI Controller bindings
Message-ID: <20220621101159.stvan53rvr6qugna@mobilestation>
References: <20220613195658.5607-1-brad@pensando.io>
 <20220613195658.5607-5-brad@pensando.io>
 <20220620193044.ihxfn6kddif7j5la@mobilestation>
 <0a68aa72-df85-cf78-dcca-2d75038234c6@kernel.org>
 <20220620200445.yew3vo3pnjhos7rs@mobilestation>
 <4ff85493-665a-ee58-07d3-80178c49223b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ff85493-665a-ee58-07d3-80178c49223b@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 09:00:36AM +0200, Krzysztof Kozlowski wrote:
> On 20/06/2022 22:04, Serge Semin wrote:
> > On Mon, Jun 20, 2022 at 09:46:25PM +0200, Krzysztof Kozlowski wrote:
> >> On 20/06/2022 21:30, Serge Semin wrote:
> >>> On Mon, Jun 13, 2022 at 12:56:47PM -0700, Brad Larson wrote:
> >>>> From: Brad Larson <blarson@amd.com>
> >>>>
> >>>> The AMD Pensando Elba SoC has integrated the DW APB SPI Controller
> >>>>
> >>>> Signed-off-by: Brad Larson <blarson@amd.com>
> >>>> ---
> >>>>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 ++
> >>>>  1 file changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> >>>> index e25d44c218f2..2a55b947cffc 100644
> >>>> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> >>>> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> >>>> @@ -73,6 +73,8 @@ properties:
> >>>>                - renesas,r9a06g032-spi # RZ/N1D
> >>>>                - renesas,r9a06g033-spi # RZ/N1S
> >>>>            - const: renesas,rzn1-spi   # RZ/N1
> >>>
> >>>> +      - description: AMD Pensando Elba SoC SPI Controller
> >>>> +        const: amd,pensando-elba-spi
> >>>
> >>> Not enough. The driver requires to have a phandle reference to the
> >>> Pensando System Controller. So the property like
> >>> "amd,pensando-elba-syscon" is also needed to be added to the DT schema
> >>> otherwise should the dt-schema tool correctly handle the
> >>> "unevaluatedProperties: false" setting (Rob says it isn't fully
> >>> supported at the moment), the dtbs_check procedure will fail on your
> >>> dts evaluation.
> >>
> > 
> >> The property was here before, now removed, so I assume it was also
> >> removed from the driver and DTS. Isn't that the case?
> > 
> > Ah, the property has been indeed removed. The driver now searches for
> > the system controller by the next compatible string:
> > "amd,pensando-elba-syscon" using the
> > syscon_regmap_lookup_by_compatible() method. My mistake. Sorry for the
> > noise.
> > 

> > * Though personally I'd prefer to have a property with the phandle
> > reference in order to signify the connection between the system controller
> > and the SPI-controller. Otherwise the implicit DT bindings like having
> > the "amd,pensando-elba-syscon"-compatible syscon gets to be
> > hidden behind the DT scene. But seeing we have already got the Microsemi
> > platform with such semantic, I can't insist on fixing this.
> 
> I agree entirely, this should be explicit syscon-type property. Looking
> up for compatibles:
>  - creates hidden (not expressed via bindings) dependency between nodes,
>  - is not portable and several people struggled with it later and needed
> backward-compatible code (many examples, let's just give recent one: [1])
> 
> 
> [1]
> https://lore.kernel.org/all/20220619151225.209029-10-tmaimon77@gmail.com/

Seems even more reasonable now. Thanks for providing a bright example
justifying the property-based approach.

@Brad, could you get back the property with a phandle to the syscon
DT-node? (No need in adding the CS CSR address as the phandle argument,
just a phandle.)

-Sergey

> 
> 
> Best regards,
> Krzysztof
