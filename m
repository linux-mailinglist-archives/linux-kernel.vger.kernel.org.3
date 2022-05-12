Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A14525066
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355483AbiELOka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245183AbiELOk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:40:27 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04554253A9F;
        Thu, 12 May 2022 07:40:26 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id s27so6806518ljd.2;
        Thu, 12 May 2022 07:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=upk7oiV3ipoyV+9OhHOoOS6ppQQslCnw1gywawi73Rg=;
        b=cn5+WofiBeYl3bkckxw3lYx+LE9Jtav/Xh3MaQ+D2aG9z8L2oXvBybH4W3MDIJPtH/
         vRNdjMTDIoc1wgNdcYa5QiqA5B8Bse+yTFmT2iiJBCBUjHhC/FEozLnVAueGBpuKXAJD
         nmK+CycBUDxLHIJ078FRlEyVDuKZvBqMX7zWyMAHcqHhP7pxNQlvy2KxbUirLxn5Kmfx
         yctxjglw7h+OxUzlN7ra7WQJg1RP+3IUr4KeMG3yzXPZVafoKX1DUdrbP7vEGsYomGEy
         BLZn5StPm9yJh30Ixrysmf36KpBDNvj79K08gdwBoNbrYV/xpc4Sq2G3yG2b052245uV
         gauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=upk7oiV3ipoyV+9OhHOoOS6ppQQslCnw1gywawi73Rg=;
        b=2zQ1j9q9idOCf2GidjdzabD6Lwc7g4rRoMwDrtQhPOKwoNpqXOCjm1xDBoq6xwf+Ei
         Bci5OmmvIvLkGb2OICufrVk8N2uWnROTRqYe+V7VfTcUTStSRlGw/ruV36iJEiguumFp
         Ph4c1FFiebCQNzd98zMyvVAapp85Kx/8+C7ADp47p01tv2vMdZDS2Ehezq00XDlvHFRV
         o9qkAWoIukxozq7GGtG7zoG2H3xNrVvoegfRMj7SofW9wJiY+beq/SMM7zA03H+GScVG
         Vf33M3nQvHd7q+Rg4q/RgQbXP7n+k9BdGDiAGdXErafrF82WEOhekdGF4aarSXp/iCrB
         W2Pg==
X-Gm-Message-State: AOAM5318D4bpGd+kuvMMCTkdWcIuEijuF7+plozqnwqrLCd10jHLiLZe
        9KHvheo+LxkgxTFJuheASt4=
X-Google-Smtp-Source: ABdhPJyJVUpoR6lTQy3LJSg+JMu71sXFnByGqHc7EeHvKP1Wt6Fb+dZ43gvZWqDzDX1hLIL9vLBY4g==
X-Received: by 2002:a2e:8744:0:b0:250:9bfe:b777 with SMTP id q4-20020a2e8744000000b002509bfeb777mr178699ljj.523.1652366424277;
        Thu, 12 May 2022 07:40:24 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id n5-20020a056512310500b0047255d211ccsm809816lfb.251.2022.05.12.07.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 07:40:23 -0700 (PDT)
Date:   Thu, 12 May 2022 17:40:21 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 09/23] ata: libahci_platform: Sanity check the DT
 child nodes number
Message-ID: <20220512144021.stkajc7dimgfkldv@mobilestation>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-10-Sergey.Semin@baikalelectronics.ru>
 <42dfc76f-a9d9-8e63-874d-b7459cef326c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42dfc76f-a9d9-8e63-874d-b7459cef326c@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 11:24:22AM +0300, Sergei Shtylyov wrote:
> On 5/12/22 2:17 AM, Serge Semin wrote:
> 
> > Having greater than (AHCI_MAX_PORTS = 32) ports detected isn't that
> 

>    Having greater than AHCI_MAX_PORTS (32) ports detected?

Ok.

> 
> > critical from the further AHCI-platform initialization point of view since
> > exceeding the ports upper limit will cause allocating more resources than
> > will be used afterwards. But detecting too many child DT-nodes doesn't
> > seem right since it's very unlikely to have it on an ordinary platform. In
> > accordance with the AHCI specification there can't be more than 32 ports
> > implemented at least due to having the CAP.NP field of 4 bits wide and the
> 

>    It's 5 bits wide, actually...

Right =)

The denoted comments will be taken into account in v4. Thanks.

-Sergey

> 
> > PI register of dword size. Thus if such situation is found the DTB must
> > have been corrupted and the data read from it shouldn't be reliable. Let's
> > consider that as an erroneous situation and halt further resources
> > allocation.
> > 
> > Note it's logically more correct to have the nports set only after the
> > initialization value is checked for being sane. So while at it let's make
> > sure nports is assigned with a correct value.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> [...]
> 
> MBR, Sergey
