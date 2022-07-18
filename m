Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED917577D38
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbiGRIM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiGRIM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:12:27 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432E0CE32
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:12:26 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id ay11-20020a05600c1e0b00b003a3013da120so7286421wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YSNqUjbJHHVQXGD+YZyOP7epS/DXLcoatoQzziYeNEs=;
        b=bNShjbHvHeEQ3gSVjnIO5whoxel6stcq2UydlfVBTOpohpRTXxtS3IfByV8VqGazbO
         nUFjNZhNmZZfnYcZqtHqLBF3NBrnERwwWzXivN7nmfRYKrP/toc1qdA8ZX9X3IoryHU2
         0k0bldox558rmyz6gLY3EqUYccVJ0b8GmW3GeY7f4Nw2fkCWL/q4Xh1pKj8be5vuipX0
         mRBcl3RndLfmsVupMVQJ7Uejiexa9tpOLWNU8dSKRLG+EoZwgaAWVPsbGFi4xNWjmA6R
         7uT2kmI9B8UkWOWCsu4R3ksN9SmAkRF66rgIrRRhtk5lvwI/kwXZYo00TX9axSr6pVAE
         8F0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YSNqUjbJHHVQXGD+YZyOP7epS/DXLcoatoQzziYeNEs=;
        b=QYI84yvJ91bzNK4MDCjFpcf7xh0Lb0FNAeGthYJpq28e+N0TpW5ONZ5b6kgFZ7VFAw
         Eku1N03hOcG3L7XcyBm7CAjm5h3L6wucomxV/kZxV0Mn9P4/ykiCbjotKYdfZ7kCv3Qm
         x4pqZbUidZjqSTeiP0+IryxzjiL4To/x5pq1n9kOIGAf6kf1QuExsaawJWYmSObVOmAW
         mcvLSWC2lxg9SSP8fCEybRBkq7nqMEpRafRC88w0YoJzJijjrNeomlvWhYPPDHYZrodW
         jl0zMmXo6jTh7FXtssOqM90vRgtORnhLs0bWuBUX9C8FzoRxNo/fGIYcuBBwQZDQAJZm
         Xj+Q==
X-Gm-Message-State: AJIora8vQi2aL5OUi4FsBsgq/HGCiylb4md9lj0DLX+GN8xIFtP5gDEV
        UvYbj+4Yr6MGVsdOiM851xNQiw==
X-Google-Smtp-Source: AGRyM1sIldhb1t2tCuEGuki3lYJSqj6oxLQKTbJHwRdGomf/J1kFMUBXmARgtE1Nlre7pVxxmQnCWw==
X-Received: by 2002:a05:600c:1e1b:b0:3a3:10e9:cbd with SMTP id ay27-20020a05600c1e1b00b003a310e90cbdmr11017878wmb.41.1658131944859;
        Mon, 18 Jul 2022 01:12:24 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id l14-20020adff48e000000b0021d7ad6b9fdsm10121662wro.57.2022.07.18.01.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 01:12:24 -0700 (PDT)
Date:   Mon, 18 Jul 2022 09:12:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/9] mfd: intel_soc_pmic_crc: Merge Intel PMIC core to
 crc
Message-ID: <YtUV5sE8A3ayQ/Q3@google.com>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
 <Yrmr175fsQi6ToEY@google.com>
 <YrrO0CQVv6hj1AB0@smile.fi.intel.com>
 <YrxjTD0sJXh8cgVP@google.com>
 <CAHp75VdHpqAxS3jmFi-1Sw6wB1CP3wQVM_+5OP0C_yFFG336LA@mail.gmail.com>
 <Yr1YXHb3GqwZncFK@google.com>
 <CAHp75Vf1UK9Z2P1D9v_j9rsdKoDXWSvb=wJgmkvACYgwofWrxA@mail.gmail.com>
 <35c907e6-6018-d22b-1992-ffc66eb82b0e@redhat.com>
 <Yr1iweMUl+EUY+Q6@google.com>
 <YtHF2giNT1gG1wge@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YtHF2giNT1gG1wge@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022, Andy Shevchenko wrote:

> On Thu, Jun 30, 2022 at 09:45:53AM +0100, Lee Jones wrote:
> > On Thu, 30 Jun 2022, Hans de Goede wrote:
> > > On 6/30/22 10:07, Andy Shevchenko wrote:
> 
> ...
> 
> > > Note that I already did a manual compare of the moved code blocks
> > > to check that they were not changed before giving my Reviewed-by.
> > 
> > Super, thanks Hans.
> 
> Is it okay to be applied?

Yes, I think so.

Can you collect all of the Acked-by/Tested-by tags you received
and submit a [RESEND] please?  Hans' TB which should be applied to all
patches springs to mind.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
