Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58467595658
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbiHPJbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbiHPJaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:30:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B9C11DF79;
        Tue, 16 Aug 2022 00:50:02 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e13so12400710edj.12;
        Tue, 16 Aug 2022 00:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=btmulgmWYDO5JR8p39p3Iuz/rc2ef0rGseMFoYZH5KE=;
        b=UUwbefUxfrJoEJicacb7h0c1OssFJPnj8GXTCZgjd+Zq0Go7zJ86MlpGb7KBPkgU7R
         6ZXIQy0hond0D9rS9sO7mARyG+JVP9P0xKa44ITziLauJoaVdCN7eruY6dKrgl627zzg
         B02pB+PhgIZnZUQOPAVgPgF9y9i7Y/6meHAtKtFMepMPDBmUty9gzP0TRIjWCglw+1g/
         UhBxMFFAub7F6I+4kfr1GkdChw73woRyjrXCHrij9eXKM+yZiGZfI4/rX+SzUl4gFlG9
         vOKDJUE7uc7BXlzCsfObnc/fdJkmYchuFCOtIvUhzXYt1FisJF9GqfCzNhPgAQwD2Etn
         LQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=btmulgmWYDO5JR8p39p3Iuz/rc2ef0rGseMFoYZH5KE=;
        b=4bvfvJKjM4OevjD6L8QuSmBsQ2n00IPRyh965nLyq+o9wGYfgJYzBkW/h0whcE4QCj
         VutzYrj0+3S8CjF0P1VuXn2zVwb9q4ulXgRGNxhTazrxYZTv93n8FCSnClqvabgv5grD
         1ppg1RA+oFKiufQ7INjS68rqHkXD8K33NtFGvHDXaMPPPw1aRxXm+mftBecBOXM9ZJVi
         oKwbvfquhR1WBaWBHwuosn3MHsc4ndBYfEX7d5IUBHKxdTN3Eyw3NirlHQRktJoLwirY
         MkBuJn1pfcVpeaciGOxslkZ1KY2EauIpI3VZLMpbOp5X7/fVugMx6g7wPO0Eg2m5klOr
         2j8w==
X-Gm-Message-State: ACgBeo1VgDlz6ygLSAD7daMDbpaX9ln7u7h7/aHGCD6W4YJP6BGn38Wt
        KDN4+o9sGQ36HWQo/2F6Gx8=
X-Google-Smtp-Source: AA6agR7BWyk91qEHOc9vxFTS0qUZ56eezGGM4sHl6LeatjVguPj9qJvzTcm3VgsutYCTY31iqEy53w==
X-Received: by 2002:a05:6402:184:b0:442:fd54:2a21 with SMTP id r4-20020a056402018400b00442fd542a21mr17388865edv.129.1660636200714;
        Tue, 16 Aug 2022 00:50:00 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id fn3-20020a1709069d0300b0072fb3704e49sm4954327ejc.46.2022.08.16.00.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 00:50:00 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 06/12] riscv: dts: allwinner: Add the D1 SoC base devicetree
Date:   Tue, 16 Aug 2022 09:49:58 +0200
Message-ID: <5593349.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <149eee7b-a9e9-94ad-1ab2-13812b541a8c@linaro.org>
References: <20220815050815.22340-1-samuel@sholland.org> <20220815050815.22340-7-samuel@sholland.org> <149eee7b-a9e9-94ad-1ab2-13812b541a8c@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 16. avgust 2022 ob 09:41:45 CEST je Krzysztof Kozlowski napisal(a):
> On 15/08/2022 08:08, Samuel Holland wrote:
> > +
> > +	de: display-engine {
> > +		compatible = "allwinner,sun20i-d1-display-engine";
> > +		allwinner,pipelines = <&mixer0>, <&mixer1>;
> > +		status = "disabled";
> > +	};
> > +
> > +	osc24M: osc24M-clk {
> 
> lowercase
> 
> > +		compatible = "fixed-clock";
> > +		clock-frequency = <24000000>;
> 
> This is a property of the board, not SoC.

SoC needs 24 MHz oscillator for correct operation, so each and every board has 
it. Having it here simplifies board DT files.

Best regards,
Jernej

> 
> > +		clock-output-names = "osc24M";
> > +		#clock-cells = <0>;
> > +	};
> > +
> 
> Best regards,
> Krzysztof




