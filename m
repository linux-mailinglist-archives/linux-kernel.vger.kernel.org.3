Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5291952FF1C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 21:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345779AbiEUT4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 15:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343951AbiEUT4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 15:56:04 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5E213E15;
        Sat, 21 May 2022 12:56:01 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y199so10386703pfb.9;
        Sat, 21 May 2022 12:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pahlxMexkmb3bBQA6Xo5H+RyP2uDtCGR2tGr0pnfrto=;
        b=kxRL2LKA5PWfRzabVz4llBGK5GbU10XVYfiNbyO520sbIzAyhQ0U78eQtYfx+7Db3j
         5KOC0PNvAPjAFefRdWJO6F6rfZEapF1cN++hxtpJI3biY/p62801KDJOW3c0I24zcpsa
         QnUVD0mNSBvaipEYHH+eNe10aO9SI8ef4UJK+84417/lmzTyf/tWNWGTw9mR3VDa6xd0
         +a9B+Wb8TEqRjFoTbP8my7BFu0qMSXy7Z+N6Q1qbCoYr5hGfb8VGaGuTiVwkGEt4mawl
         UN6tzQGPZKgVp1Mmfnquv1M2NHf4Bp0thQv4ZK6E3Z37eYNzc5GLzQBkJ6nCrZWOnp18
         5fmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pahlxMexkmb3bBQA6Xo5H+RyP2uDtCGR2tGr0pnfrto=;
        b=ahXFXN7luTCJZsbq1DpWfbjNfHCDNmqnJJnSpPrkGRgeoTj8aIKZMwkZT3178puucx
         68RbL8zKURKPVfD+frAZHhaGtAw55TFGt2SmsqAdAn8IPEE7FhY3xziXZvggi+VlS1CF
         IxKdPPNMYtsvuCNUIS+Fj/nKL9rFMc7PrL84ssfFi6OE5jFS1Wh/2B1TDiSG3jKZvpn/
         Y8AJMwazXhoO7fH2r5klhS+4zJtpQ0eJ9bL8E7wy0/AwhTxYOhEHe1jQBLSLnFgcOsIs
         dH2ZsjNjWPK6L8HlUIHX/BAcsO4K/ia8CAhneik1GgBz456ZD3CxCXEsFRKJfRKS8g3m
         UM4A==
X-Gm-Message-State: AOAM53149mBMkHwPYirnuCEMo1af28eut1OVNpA0Je8Nr5ypDo/XiHDC
        WpP/V+SZnRC132hipn+4GuPLqZxjFN/t7w==
X-Google-Smtp-Source: ABdhPJyMsuLlslN40Ir06YGFTs98HuVnqrw63vJ9EHLB9HKkCH/+1VU5nKatOpnEUcsbKh/KwG90SQ==
X-Received: by 2002:a63:d244:0:b0:3f2:5897:99c7 with SMTP id t4-20020a63d244000000b003f2589799c7mr13563407pgi.533.1653162960530;
        Sat, 21 May 2022 12:56:00 -0700 (PDT)
Received: from Negi ([207.151.52.3])
        by smtp.gmail.com with ESMTPSA id mn2-20020a17090b188200b001df983f9a3dsm4069958pjb.29.2022.05.21.12.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 12:56:00 -0700 (PDT)
Date:   Sat, 21 May 2022 12:55:59 -0700
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mips: Convert plain text file to ReST
Message-ID: <20220521195558.GD14144@Negi>
References: <20220521015613.6197-1-soumya.negi97@gmail.com>
 <YojoMzjahyP+HW4m@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YojoMzjahyP+HW4m@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 03:25:07PM +0200, Greg KH wrote:
> On Fri, May 20, 2022 at 06:56:13PM -0700, Soumya Negi wrote:
> > Converts .txt documentation file to ReST format(.rst).
> > 
> > Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> > ---
> >  .../devicetree/bindings/mips/cpu_irq.rst      | 56 +++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mips/cpu_irq.rst
> 
> That did not "convert" it merely added the new file.  Where was the old
> file?

I will correct the patch. The old file is Documentation/devicetree/bindings/mips/cpu_irq.txt 

> And does this get added to the build somehow?

No, I don't think so. When building documentation using make htmldocs, the file
does not show up in the Documentation/output directory. 


Regards
Soumya
