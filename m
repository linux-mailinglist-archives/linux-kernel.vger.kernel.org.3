Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1DE5A129B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242433AbiHYNpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbiHYNpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:45:09 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8FB11C2C;
        Thu, 25 Aug 2022 06:45:07 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id l23so8458579lji.1;
        Thu, 25 Aug 2022 06:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=LNQ1P5VfR2hkrO1KVSkVyiPofBvt2GF2rWkw17ZqdPc=;
        b=Uj3kdoKnIficr7T0mxpriXp3Bhpz+uGwLNnfEOqvw4QJBLkF1DPeQBXj12Rx9AMBHl
         /9GbNFs8SAt20sraYH0vWtihEXigfs1Jz46PtgxQE3fCnhweauy24KnfVUNMHylbAN7q
         488xIslKivbNcFC3fszq2p6rOXKAPj4tWhBr4T9LkyA7Vcee4QBsYWXl4wfaEruusuy0
         HThiG1HWcPt9moxHpq1CsIqfQHvtpTKBVSbOdEOWRkVNbvYr5WzgHwriNyqvWlyeXMxP
         havgWHIFHhQzEi88LyOBZ9EOyCS05e6rQGAVvgIqIjVh8ICOQT27pErGJzvTJxJy3dW4
         baHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=LNQ1P5VfR2hkrO1KVSkVyiPofBvt2GF2rWkw17ZqdPc=;
        b=mpzA2x12QaKTXcUcIxAo8ZsuHjpyjV1YhDIuCqBl0/8IengnmckaxpW1LVBjAXZSPF
         KZSP6KocW6KVqMyePR2uv7mzFjSPdfIzfA80Dh81CQRyq2+NQA1CM+L44Dtf5tuYKmJB
         VgwQd6f1NfwqDMCSNYcAQeNKiM9nUzGyJeVJAgnvZfOI3bVk2xOQCqKutB3xe5o1CFLC
         EOcSIjxBR2p1xwuGGK1GWQKKpmP085UjukrXnxUM1kEsLvZs1ehjTXka6FuUspGSXUMq
         Fvt21+WkJ5P5tWPA/vjqZw5mR0yzmYHFShmtMFmcl4ioxvUdLkAOMWBISAJdtKZo0ENO
         61nA==
X-Gm-Message-State: ACgBeo335xD7DC2Ou2rXe6kH3ehRt881SnHQ6hQAwZQ3EuxOIqBRwqj/
        ep6CzKVAzGUUjI4TLtQSHU+jy7m/7M+8sw==
X-Google-Smtp-Source: AA6agR6W/G7rOoiqL0vEYBlVB5eoB4lN8B1UfT+c7FAeskxQeqGUO6kguGNrdSz6l9Bzihl67aZmPQ==
X-Received: by 2002:a05:651c:221e:b0:25f:f069:1c13 with SMTP id y30-20020a05651c221e00b0025ff0691c13mr1200422ljq.390.1661435105696;
        Thu, 25 Aug 2022 06:45:05 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id a12-20020ac25e6c000000b0048af0df1041sm496671lfr.255.2022.08.25.06.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 06:45:05 -0700 (PDT)
Date:   Thu, 25 Aug 2022 16:45:02 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND v10 6/7] clk: baikal-t1: Add DDR/PCIe directly
 controlled resets support
Message-ID: <20220825134502.alxzlikv7ftir2fi@mobilestation>
References: <20220822182934.23734-1-Sergey.Semin@baikalelectronics.ru>
 <20220822182934.23734-7-Sergey.Semin@baikalelectronics.ru>
 <c3831c5a-7e10-2112-83e0-4ec2d70001c2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3831c5a-7e10-2112-83e0-4ec2d70001c2@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 01:23:32PM +0300, Krzysztof Kozlowski wrote:
> On 22/08/2022 21:29, Serge Semin wrote:
> > Aside with a set of the trigger-like resets Baikal-T1 CCU provides two
> > additional blocks with directly controlled reset signals. In particular it
> > concerns DDR full and initial resets and various PCIe sub-domains resets.
> > Let's add the direct reset assertion/de-assertion of the corresponding
> > flags support into the Baikal-T1 CCU driver then. It will be required at
> > least for the PCIe platform driver. Obviously the DDR controller isn't
> > supposed to be fully reset in the kernel, so the corresponding controls
> > are added just for the sake of the interface implementation completeness.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> > 
> > ---
> > 
> > Changelog v6:
> > - Refactor the code to support the linear reset IDs only. (@Philipp)
> > 
> > Changelog v7:
> > - Drop empty line from the sys_rst_info structure initialization block.
> >   (@Philipp)
> > ---
> >  drivers/clk/baikal-t1/ccu-rst.c     | 66 +++++++++++++++++++++++++++++
> >  drivers/clk/baikal-t1/ccu-rst.h     | 10 +++++
> >  include/dt-bindings/reset/bt1-ccu.h |  9 ++++
> 

> Do not mix drivers and bindings. Bindings always go separately, so this
> has to be split.

Ok. Sigh...

-Sergey

> 
> Best regards,
> Krzysztof
