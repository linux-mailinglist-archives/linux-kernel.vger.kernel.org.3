Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F8D4F143F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbiDDMDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236633AbiDDMCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:02:54 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93FF3526B;
        Mon,  4 Apr 2022 05:00:58 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id c15so12530508ljr.9;
        Mon, 04 Apr 2022 05:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FSY86kCZ2HjwzWcDZ4lpE9hKeoiB8ipxivBfzTu5z8I=;
        b=FiMfku5oF+Bt0uHGB4ekafWwEkhaqwd2azBHdkG8DCHMg8NtUtMLOmnWGb8zbSZGpR
         Ee1ss5t4bcFCP/L+N6o5jElrHv9m9UqzixLK8PsODjZoDgLVxquWXslnK7ViePdC4yta
         mqmstmU+jrPDq2YUBzXqyraUsJT8o3G8bvyP86YSgtWvQmSC49oogsm+0+YAhoT0Cevx
         9srCGqqeooZjWw1sZc8MGtDntzFTiFonvo4QDFhpPpbD0rtFj+/wLXp6hlsA3wauR/JS
         zQzT4ww4nd7XxVn6FP+KwcSiOfOVCfsJfJ4OfTsIKGEM+B9Te6iogutE3yG5HBTCU7B2
         5cWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FSY86kCZ2HjwzWcDZ4lpE9hKeoiB8ipxivBfzTu5z8I=;
        b=wVAIuf9jFJvP3TGrq4ytd7kVUXDuBq+qlI7Fm9ocTUKY2PA6qIYWmn/ag1aMsIRnTU
         ohfU+LO04aidtjLeVm3ykpPfOwkiusu52wlCOK3OJA0ft9wVqaSiZ5zu3n7s2sNMEGK+
         tS9FTXwbri1TS7fUx3d/1ztCdV0qQtaI3V3/1AaTnQtpQt8rKxtpza5KBOH9xjDnjhik
         zdaYEqHPqNyGxZJJ1hWVvtVWBX4C36VCsDOlkV/s/kxvXqUI/BEwTYKh/wmRJKSsrxm3
         5FJyfr2c9COZOvqOj68Zq0mjw80qxo7QWlCTUyrUphQlA5ce9cI0Hw8cteebNecaS86z
         XLNQ==
X-Gm-Message-State: AOAM5306bQHODdIhqdzvqGk1pHi5bPkoBvvN2zbNmDmJFUCYGJyThKbI
        02xFdfMGnwS9IZb+6CT1rJs=
X-Google-Smtp-Source: ABdhPJx6WsekTTBrXXBudo03jQXdnLtW5213hAE0gicafjtXpPQuDGgHqChN/JoEVBFXq8NKtR/oUA==
X-Received: by 2002:a2e:6f0e:0:b0:249:817e:6b23 with SMTP id k14-20020a2e6f0e000000b00249817e6b23mr20836486ljc.147.1649073656902;
        Mon, 04 Apr 2022 05:00:56 -0700 (PDT)
Received: from mobilestation ([95.79.227.109])
        by smtp.gmail.com with ESMTPSA id q21-20020a194315000000b0044a1e36fda4sm1115225lfa.25.2022.04.04.05.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 05:00:56 -0700 (PDT)
Date:   Mon, 4 Apr 2022 15:00:54 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     "Srikandan, Nandhini" <nandhini.srikandan@intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Pan, Kris" <kris.pan@intel.com>,
        "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>,
        "A, Rashmi" <rashmi.a@intel.com>
Subject: Re: [PATCH v4 0/3] Add support for Intel Thunder Bay SPI controller
Message-ID: <20220404120054.xb5ebveucx6ahwg7@mobilestation>
References: <20220308103331.4116-1-nandhini.srikandan@intel.com>
 <SJ0PR11MB581686619A1E792217F2D76E85E59@SJ0PR11MB5816.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB581686619A1E792217F2D76E85E59@SJ0PR11MB5816.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nandhini

On Mon, Apr 04, 2022 at 11:51:14AM +0000, Srikandan, Nandhini wrote:
> Hi all,
> 
> Kindly help to review the patch set "Add support for Intel Thunder Bay SPI controller".

Thanks for reminding about your series. It has kind of emailed away
from my sight due to other incoming messages. I'll give you my
comments within two days.

Regards
-Sergey

> 
> Regards,
> Nandhini 
> 
> > -----Original Message-----
> > From: Srikandan, Nandhini <nandhini.srikandan@intel.com>
> > Sent: Tuesday, March 8, 2022 4:03 PM
> > To: fancer.lancer@gmail.com; broonie@kernel.org; robh+dt@kernel.org;
> > linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org
> > Cc: devicetree@vger.kernel.org; mgross@linux.intel.com; Pan, Kris
> > <kris.pan@intel.com>; Demakkanavar, Kenchappa
> > <kenchappa.demakkanavar@intel.com>; Zhou, Furong
> > <furong.zhou@intel.com>; Sangannavar, Mallikarjunappa
> > <mallikarjunappa.sangannavar@intel.com>; Vaidya, Mahesh R
> > <mahesh.r.vaidya@intel.com>; Srikandan, Nandhini
> > <nandhini.srikandan@intel.com>; A, Rashmi <rashmi.a@intel.com>
> > Subject: [PATCH v4 0/3] Add support for Intel Thunder Bay SPI controller
> > 
> > From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> > 
> > Hi,
> > 
> > This patch enables support for DW SPI on Intel Thunder Bay (patch 1,2).
> > This patch set also enables master mode for latest Designware SPI versions
> > (patch 3).
> > 
> > Patch 1: DW SPI DT bindings for Intel Thunder Bay SoC.
> > Patch 2: Adds support for Designware SPI on Intel Thunderbay SoC.
> > Patch 3: Adds master mode support for Designware SPI controller.
> > 
> > The driver is tested on Keem Bay and Thunder Bay evaluation board
> > 
> > Summary:
> > Changes from v3:
> > 1) Dropped SSTE support in this patch.
> > 2) Rebased to the latest code.
> > 
> > Changes from v2:
> > 1) SSTE support made using dt and created seperate patches.
> > 2) SPI controller master mode selection made common to all DW SPI
> > controllers.
> > 3) Using a common init function for both keem bay and thunder bay.
> > 
> > Changes from v1:
> > 1) Designware CR0 specific macros are named in a generic way.
> > 2) SPI CAP macros are named in generic way rather than naming project
> > specific.
> > 3) SPI KEEM BAY specific macros are replaced by generic macros.
> > 4) Resued the existing SPI deassert API instead of adding another reset
> > 
> > 
> > Changes in patches:
> > Patch 1:
> > Changes from v3/v2/v1:
> > 1) No change in this patch
> > 
> > Patch 2:
> > Changes from v3:
> > 1) No changes.
> > 
> > Changes from v2:
> > 1) Init function is made common for Keem Bay and Thunder Bay.
> > 
> > Patch 3:
> > Changes from v3:
> > 1) Corrected dw_spi_ip_is macro with the missing underscore.
> > 2) Setting CTRLR0 BIT31 without any condition check as in older version of
> >    DW SPI controller this bit is reserved.
> > 
> > Changes from v2/v1:
> > 1)Newly introduced in v3 to make master mode selection as seperate patch
> > 
> > Thanks & Regards,
> > Nandhini
> > 
> > 
> > Nandhini Srikandan (3):
> >   dt-bindings: spi: Add bindings for Intel Thunder Bay SoC
> >   spi: dw: Add support for Intel Thunder Bay SPI controller
> >   spi: dw: Add support for master mode selection for DWC SSI controller
> > 
> >  .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml          | 2 ++
> >  drivers/spi/spi-dw-core.c                                 | 4 ++--
> >  drivers/spi/spi-dw-mmio.c                                 | 8 ++++----
> >  drivers/spi/spi-dw.h                                      | 7 +++----
> >  4 files changed, 11 insertions(+), 10 deletions(-)
> > 
> > --
> > 2.17.1
> 
