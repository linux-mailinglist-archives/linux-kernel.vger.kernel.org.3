Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AD1524C5C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353538AbiELMEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346106AbiELMEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:04:46 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EFA22A89A;
        Thu, 12 May 2022 05:04:44 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id b18so8625297lfv.9;
        Thu, 12 May 2022 05:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5KdZkGPOMKFoYWGn89lEH4wEYbxX5oNPD2nPGAq2itM=;
        b=YDfCLtXCLPWwDETkhJdG6lt+L0IATMHdACKjlCie0JtR+zxfARZzWLfKVQRQGhez29
         v+LjTnCzCImXRWYO9TjE4dDVFag001hDJmwU9g9hDrwa3IFpAFTSgoLeAEljUYtz765B
         xFjjNKRoXuAj32jnlD/iVFCKVXFXpi5ou5dcD2bixzARGhP3J8pJwdrna6JYfhqam/TW
         tTeaaVTnM+M5rENqICgX093HvrATRiP7nSNCYSGeZczs3pZcxJ05nn/nMOmrIXfLLmub
         lD/NEX+qYzPgHGGHG/vTvUEPTneOWFVPhFB0mHPlgoUvhMTXydZC7YD+9naDrfmCAjrp
         cdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5KdZkGPOMKFoYWGn89lEH4wEYbxX5oNPD2nPGAq2itM=;
        b=tXeDJsWo9EENPqsnIoaHxEtz9r4nZuBp3BiOhQdV8cfDJOLrUw2LAMhKzalUuH4j8U
         ufi+YU9EvOvysNHlUzB5GTWpnjRLETfE90OhbTgy3bqg4CF1xzgmasMEh37SaUo3lxxg
         u/xswYoUtd/FahD6rLZrzpGxQzKdCKLNj48fUFjXXfWEzz8Z5+iH2ikA5nHxE8AaQkLD
         cExBKJDSDqyN39h7agp8onOAtbh2mTSe3dgtzWNZkqvFk2tss8ttpUpAvLf7LJWh4RAN
         ZlcNX8Mp7CnJH+mfgwPjjgH+Isvc667aAAC/wsOd8sC8BkJj5hTUGGlPFXgujuToFcw/
         LE8A==
X-Gm-Message-State: AOAM531ngtelU3hMXKzCGYCEZH1vZPdwPOqmE7D2xLx+pZHQYWNn2N9w
        V9ot96WM1N3d1NVFENAi/dM=
X-Google-Smtp-Source: ABdhPJxhedCMd7PTu1DAntYZHh0feSOaw5PZ7n6Eg55nP+HDLFfR4rMnWT75CnH+2j+xEO0U92Wx9Q==
X-Received: by 2002:a05:6512:554:b0:472:1891:a14b with SMTP id h20-20020a056512055400b004721891a14bmr23815604lfl.677.1652357081972;
        Thu, 12 May 2022 05:04:41 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id m3-20020a056512114300b0047255d21193sm757969lfg.194.2022.05.12.05.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 05:04:41 -0700 (PDT)
Date:   Thu, 12 May 2022 15:04:39 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 03/23] dt-bindings: ata: ahci-platform: Clarify common
 AHCI props constraints
Message-ID: <20220512120439.uysohhdllax6upim@mobilestation>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-4-Sergey.Semin@baikalelectronics.ru>
 <68d51092-1a4c-0d42-e28d-c3b5316d580a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68d51092-1a4c-0d42-e28d-c3b5316d580a@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 11:11:22AM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 5/12/22 2:17 AM, Serge Semin wrote:
> 
> > Indeed in accordance with what is imeplemtned in the AHCI paltform driver
> 

>    Implemented? :-)

The "paltform" word is misspelled too. Thanks for noting.

> 
> > and the way the AHCI DT nodes are defined in the DT files we can add the
> > next AHCI DT properties constraints: AHCI CSR ID is fixed to 'ahci', PHY
> > name is fixed to 'sata-phy', AHCI controller can't have more than 32 ports
> > by design.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > Changelog v2:
> > - This is a new patch created after rebasing v1 onto the 5.18-rc3 kernel.
> 

>    This normally goes after ---...

Right. I've got it noticed too on taking the @Hannes comments into
account.

All of the denoted problems will be fixed in v3.

-Sergey

> 
> [...]
> 
> MBR, Sergey
