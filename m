Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454865679FB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 00:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbiGEWLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 18:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiGEWLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 18:11:18 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98FE1AF1A;
        Tue,  5 Jul 2022 15:11:16 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z25so5323596lfr.2;
        Tue, 05 Jul 2022 15:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t+jlLw01pbpeg71grsXyKUoNlpwX1KBSX1qcVAQ75OQ=;
        b=ZmQmwj/cA1F89iA8lWCQfeLozBC9O+yyrAfvoG5YPUJxWXCt56NGUp7y82DkB7wD/E
         A47s9jrnp63SiFOYfQJwzl8d2kZUob+rIHpe4Jfnsj8fF4b41PAeBMcUBAjl9pjCnuH3
         OwYubVhxTL5hTR254x3YfywmA3HRmoRTADRIgywSULXB23lk/LriTI4iAtT3ciHqSKva
         7wIohbHbVipx8AAZ1/LO+cGKDqPa0suGwP6eILg6mXAUkI8b5MIn2KcSgHIOKTH1F1bn
         PpaH7EXKVWeT2zoDB5SSVtyPlHfiSNw9pr151+97+JvXMnbfvxPZevVoM2dtR2VPZ97N
         +plA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t+jlLw01pbpeg71grsXyKUoNlpwX1KBSX1qcVAQ75OQ=;
        b=QoZpAzXHaLzg5mE247BDjDsaiz5aCwqM7HbyGUJvyOQQ6Ubc3/r2lXdfB6nxdMyAhk
         599dYMOlGhIzJ6qia21jCJHF7POspyj7FRpMYzlHXehStQ7yuDcA2+jKq6GZUgdL/cxI
         7175c4RyBnVXhCdjpOlbxs82TkRKyr+j5RCkyBOZgspP5SgqultBC3gkwvNsZNgqP3yJ
         Q7YhngVPhO2d+TJG45V4HCEFJTR4QKhFrHzGV5ZJC0RENXEG95O7jL0/bP86oraKi0IE
         nhEcsstFl6AoItzeyTUKnap/NfnJX7z9sliDkK09gwrbvKZHa5cki+0Iiamt2OFQ6Ok8
         VGAw==
X-Gm-Message-State: AJIora/WmYvVQj+sGyr4amw4kAVLZ9WgNHq5Px9mPPlb59kX4O+uX30l
        n0yV0670KeneAURD4U3H1iMf0UJIoI73fQ==
X-Google-Smtp-Source: AGRyM1suGhKtFclh9YZZKDm+F08jWGn3b6RjEdBC2jEsPiguREv7fbkCoJ7tJNZb6L+KKgs5fAh/8g==
X-Received: by 2002:ac2:5603:0:b0:484:3be8:c063 with SMTP id v3-20020ac25603000000b004843be8c063mr2555307lfd.263.1657059075373;
        Tue, 05 Jul 2022 15:11:15 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id q15-20020a19f20f000000b0047f6b8c2127sm5890369lfh.186.2022.07.05.15.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 15:11:14 -0700 (PDT)
Date:   Wed, 6 Jul 2022 01:11:12 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND v5 7/8] clk: baikal-t1: Add DDR/PCIe directly
 controlled resets support
Message-ID: <20220705221112.vix772dpl2ql2ibq@mobilestation>
References: <20220624141853.7417-1-Sergey.Semin@baikalelectronics.ru>
 <20220624141853.7417-8-Sergey.Semin@baikalelectronics.ru>
 <094a0d4e1c1b40f51ce7bec42e410500265d7a6d.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <094a0d4e1c1b40f51ce7bec42e410500265d7a6d.camel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp

On Wed, Jun 29, 2022 at 05:16:56PM +0200, Philipp Zabel wrote:
> Hi Serge,
> 
> On Fr, 2022-06-24 at 17:18 +0300, Serge Semin wrote:
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
> 

> This looks good to me, the issues with the previous patch still apply.

I see. Let's settle the main question there first then. Further
actions in this patch framework depend on your answer there.

-Sergey

> 
> [...]
> > +static int ccu_rst_set(struct reset_controller_dev *rcdev,
> > +		       unsigned long idx, bool high)
> > +{
> > +	struct ccu_rst *rst;
> > +
> > +	rst = ccu_rst_get_desc(rcdev, idx);
> > +	if (IS_ERR(rst)) {
> > +		pr_err("Invalid reset index %lu specified\n", idx);
> > +		return PTR_ERR(rst);
> > +	}
> 
> e.g. this should not be necessary.
> 
> regards
> Philipp
