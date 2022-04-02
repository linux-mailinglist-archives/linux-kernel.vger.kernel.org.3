Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36A04F05C4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 21:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239052AbiDBT0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 15:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiDBT03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 15:26:29 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDECD630B;
        Sat,  2 Apr 2022 12:24:37 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so5458971pjm.0;
        Sat, 02 Apr 2022 12:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZnjVaHo269IMr+SUq74LCC3uGMfBdmt7GCaF3QmVvCE=;
        b=GHB/uJM+vJX+vvTn2qUCwpTkk8vOGsPT8Tr1nh95oL/VKpjppciF6MJw6Trp8vhRhi
         0wH+6gBwKmTNBeHyLUSVxfLeA9Fz/GnxzlarmEYJ8FRoyFSttJy/goe//b5Es8xwYWy7
         H3cMxhPpWJpIqbCQ+3WKGhUQg4qyqPFmldOLWzP/zb/vo4vwNEnlZcTUFpiTO49O0O1B
         MwoTC5jz2HAXrCUC55opvn69sS/maMNPibpyKA+cWnNzvQgLRX5ByqEBKf72XcE/YAwL
         CcacsTg1DGNsJfna/O2OrWeaj4mZctbDKj4xjIUkEer3V+NKhBFlSjI9FfdepTknKYqg
         1pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZnjVaHo269IMr+SUq74LCC3uGMfBdmt7GCaF3QmVvCE=;
        b=m+z1ookDyrougdqM2l1hTuHewOjchbmXvEikcd/1czjhGDE4nnb9JG79IW81bSJHI8
         mew3p7lgDHPDsPvevK+Fz2lMctJpc301amXe4uasdrLndQU24lc215wXsIulq51l0p7W
         gn+sqgJlNh1rNnIkJRGfHuFX2XwaTebmJ0qcj2yD/mFS3o2kR4UDQ+lgYhVGsMDJ8H6w
         9Ox5jWEWvQchoRuQfqQyLMxzFW39Lh/L2/bSYCyLTEI5sLmHRYyYwavKxvFJ7dYjWDQa
         Yr1ApIZPbQVREGnUGCcQVO0fXSn9cWXyK9ERorG41KnkgjvpwOAJxTfnGN8bTIGqjIdT
         OiOg==
X-Gm-Message-State: AOAM531IyuB5s1aHFaR7IFKn3vVyLCla9xtNCpLCjQvMylY+mihM1LLq
        5Fv1WpnqUP1PzuDcVO8evlk=
X-Google-Smtp-Source: ABdhPJyC4Q480HCFcbIyNWI1F3oGALRY+TSJBGuxxw98j5g+bj4mFyZLE42zQgrlhwu4zxU2ToWdjg==
X-Received: by 2002:a17:90a:de83:b0:1c7:3d7b:7a5d with SMTP id n3-20020a17090ade8300b001c73d7b7a5dmr18067420pjv.242.1648927477342;
        Sat, 02 Apr 2022 12:24:37 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id d23-20020a17090a02d700b001bf6ef9daafsm5832785pjd.38.2022.04.02.12.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 12:24:37 -0700 (PDT)
Date:   Sun, 3 Apr 2022 00:54:30 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: serial: Update Qualcomm geni based QUP
 uart bindings
Message-ID: <20220402192430.GA35664@9a2d8922b8f1>
References: <20220402051206.6115-1-singh.kuldeep87k@gmail.com>
 <20220402051206.6115-4-singh.kuldeep87k@gmail.com>
 <523c6f46-54eb-22f0-221c-981879b8311e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <523c6f46-54eb-22f0-221c-981879b8311e@linaro.org>
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

On Sat, Apr 02, 2022 at 05:37:57PM +0200, Krzysztof Kozlowski wrote:
> On 02/04/2022 07:12, Kuldeep Singh wrote:
> > Similar to i2c controller, move geni based QUP uart controller bindings
> 
> s/i2c/I2C/
> s/uart/UART/
> 
> > out from parent schema to an individual binding and let parent refer to
> > child schema later on. Uart bindings also stand incomplete right now
> 
> s/Uart/UART/
> 
> > similar to i2c, complete it along this process.
> 
> s/i2c/I2C/
> 
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Great thanks!
Will update accordingly.

-Kuldeep
