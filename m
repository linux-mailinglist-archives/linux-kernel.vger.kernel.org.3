Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA5656C20D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbiGHWUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 18:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237215AbiGHWUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 18:20:09 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55680A2E5B;
        Fri,  8 Jul 2022 15:20:09 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 23so95959pgc.8;
        Fri, 08 Jul 2022 15:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0EIlqNvLm4emyzZjhw+3K6rBKNh5VIFKb+1G7bffK9I=;
        b=ebV3ddL3/SV0MqeBPND0Kto4HpBVx99pC3mmEZrjds67/5dQoyBcw+H0ck+L4EARCg
         BtmKz3vgExddcwFO41RAyetDosfU/bKQYwYBTmP00gpj8AyGMAFZgXrvB6+Gw3k051gN
         YmXLfRPuUzxuyfLRjmVq4u6HsXSMoL3uu86F3I8zSYtVrNjiV5BKNww0PLMLn3Fc68L1
         QdXfzC4mJ251GB0VXclaG5SbRAXsFq25wx04GZyE6VMS4G+sQmVDsgK9im3DKiGaE7Ar
         gODnpTnHxdXd/crxRq2U0KdtUBJD9C73rCt36DI2iU/aOl5i/gj04fiZCvG4JGlgPr94
         PghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0EIlqNvLm4emyzZjhw+3K6rBKNh5VIFKb+1G7bffK9I=;
        b=wBstAevSxQovs8AbcMl9sUpR/vDdfa57mrRGvZJ2Ks+/eYmiLHIgcTMVBvl63PV72C
         d90HY25+jFCnkgWISxV0wJ9Q5c6xY2cGIYhxg9f1O8RY/tNMxi8FGHoAhPsOnAl+kkUV
         JNkxZN7r0QJxSW9xHqXo5Qw322qaeNrnR2JwofoM8HUAlLep3REWxqTKM0Amx7+lR5if
         lszcim7AJqR+cI+hMt1t8To7v7wf2y0yx45T+quSPc1qtInxT1AG8ZIr+fKL6JULw0VO
         9FTVl5YbQytfwnkaIq+8Qx8xium/UFUcH04OKH9mTE0sW2G0+B7Lg0erSGF7wD8fQuS6
         El5Q==
X-Gm-Message-State: AJIora/LK9+2zC9xlqc+HrPoczTJPZC6K38Lzq+0yF39TAsEpSiPyY+c
        gasZun29Ck1iklmX4HeGr94vbVcoFZ8=
X-Google-Smtp-Source: AGRyM1v3G4TToMoO3KJm7CpBaZGZmipI+kGIQYaNAfaVb+AzOSrXF9HTDyi6eDJaXOJLHYWm5HhneA==
X-Received: by 2002:a63:4042:0:b0:411:bbfe:e736 with SMTP id n63-20020a634042000000b00411bbfee736mr5121801pga.1.1657318808763;
        Fri, 08 Jul 2022 15:20:08 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:9707:b37:49b0:77c2])
        by smtp.gmail.com with ESMTPSA id t20-20020a62d154000000b0052850947cf8sm68358pfl.171.2022.07.08.15.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 15:20:07 -0700 (PDT)
Date:   Fri, 8 Jul 2022 15:20:04 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Artur Rojek <contact@artur-rojek.eu>,
        Maxime Ripard <mripard@kernel.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] dt-bindings: input: Common property clean-ups and
 adc-keys conversion
Message-ID: <YsitlMhIl/xHuiS+@google.com>
References: <20220608211207.2058487-1-robh@kernel.org>
 <20220628175137.GA694214-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628175137.GA694214-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 11:51:37AM -0600, Rob Herring wrote:
> On Wed, Jun 08, 2022 at 03:12:02PM -0600, Rob Herring wrote:
> > This series refactors the common 'linux,code', 'linux,keycodes', and
> > 'linux,input-type' properties defined in various binding schemas. As the
> > properties are common, they should only have a single common schema type
> > definition. Note that 'linux,input-value' was not included here as it is
> > only used in 1 binding (gpio-keys).
> > 
> > The clean-ups are are result of the discussion on v1 of the adc-keys
> > binding conversion[1].
> > 
> > Rob
> > 
> > [1] https://lore.kernel.org/all/20220606184243.1057145-1-robh@kernel.org/
> > 
> > 
> > Rob Herring (5):
> >   dt-bindings: input: Increase maximum keycode value to 0x2ff
> >   dt-bindings: input: Centralize 'linux,code' definition
> >   dt-bindings: input: Use common 'linux,keycodes' definition
> >   dt-bindings: input: Centralize 'linux,input-type' definition
> >   dt-bindings: input: Convert adc-keys to DT schema
> 
> Dmitry, Any comments on this?

Sorry, applied the lot, thank you.

-- 
Dmitry
