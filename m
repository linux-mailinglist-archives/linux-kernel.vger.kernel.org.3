Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074A15613FB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbiF3ICF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbiF3IBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:01:36 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D645341316
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:01:35 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j7so1049747wmp.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wmeVQCv/BTtKEPouA66b5836BFHscFDp5iXGi7nKjiU=;
        b=iMaIOumKVh71nxm81FfULOqNly5GlCFDAyoQ6RRqVzfQwtxwLD3wxjGOvaPOfNxEdK
         /T2B4wrPNUHA6IgP3vmb5C8cLClTUS8dGzHHLQah6L2QSu/zi+FFpSWD5qavjQchOM00
         BkaCpu2/ScfsJHzuXUytrKLjYqTl7jAy1QP64npyVUNJYtD582niewSBBDQfsps4vKYt
         oikjNf9ChL1gI3De2+cqiHW/oEUrwU/+oTHeeBUWpEOSAVBCSdFmYspPZxNqJPlHdP9Q
         V0uQFJDa8v78HqSwu6+1sDoca4ftbUyjOFptXOhd0T8CJphOJBM24iGQnJ++/VRUUGN3
         Wa8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wmeVQCv/BTtKEPouA66b5836BFHscFDp5iXGi7nKjiU=;
        b=fmEAahFvKFJJwHlJaUDjDAe2Esh5mgC64oR1Nyyox2ynsVCpmq9dYeWJizWqObG181
         oUgXG4OOWfpxVYlLOLnyLrqctYA5PV9WfhkImFnSNutwqpSjNfKLMTuYrHoOq1d36GEa
         YVU0KjE7HsMaKReRw5jHyrmws/+O/UD8eoxogJ2JxErWqZ0SZgMGSkK67VmVLlsYIh+u
         zuKs0wYHygLV5HkGm2RYPx+u5wPVcu8XZb5NjesdrMQQJj7Tshz2iVJHWM39azHaAjVr
         SzVjIBShH685qou8cAd0t7V7IJxGZTbVZKak0W51Ibv081pighGoTbhysz3sJtTgmXwb
         Lhxg==
X-Gm-Message-State: AJIora8nkYSyRXdLfSUj/QLrJUcPtQt3CdA9HmRm3xd6y8L63lvHqZZA
        eSRjyrdnpseho77I7ZnLJ1wV5w==
X-Google-Smtp-Source: AGRyM1t5ZsDvA8XRTSBAXqDCoho8fFlhA/DGe7asPQiXFRNyZwulOFtC7idbnUlQBcMVDSV8nTdXtQ==
X-Received: by 2002:a7b:cc96:0:b0:3a0:4aa0:f053 with SMTP id p22-20020a7bcc96000000b003a04aa0f053mr10670049wma.89.1656576094371;
        Thu, 30 Jun 2022 01:01:34 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id d10-20020adff2ca000000b0021a38089e99sm18651884wrp.57.2022.06.30.01.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 01:01:33 -0700 (PDT)
Date:   Thu, 30 Jun 2022 09:01:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/9] mfd: intel_soc_pmic_crc: Merge Intel PMIC core to
 crc
Message-ID: <Yr1YXHb3GqwZncFK@google.com>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
 <Yrmr175fsQi6ToEY@google.com>
 <YrrO0CQVv6hj1AB0@smile.fi.intel.com>
 <YrxjTD0sJXh8cgVP@google.com>
 <CAHp75VdHpqAxS3jmFi-1Sw6wB1CP3wQVM_+5OP0C_yFFG336LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdHpqAxS3jmFi-1Sw6wB1CP3wQVM_+5OP0C_yFFG336LA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2022, Andy Shevchenko wrote:

> On Wed, Jun 29, 2022 at 4:36 PM Lee Jones <lee.jones@linaro.org> wrote:
> > On Tue, 28 Jun 2022, Andy Shevchenko wrote:> > On Mon, Jun 27, 2022 at 02:08:39PM +0100, Lee Jones wrote:
> > > > On Thu, 16 Jun 2022, Andy Shevchenko wrote:
> 
> ...
> 
> > > > >  drivers/mfd/intel_soc_pmic_core.c | 160 -----------------------------
> > > > >  drivers/mfd/intel_soc_pmic_core.h |  25 -----
> > > > >  drivers/mfd/intel_soc_pmic_crc.c  | 162 ++++++++++++++++++++++++++++--
> > > > >  4 files changed, 157 insertions(+), 193 deletions(-)
> > > > >  delete mode 100644 drivers/mfd/intel_soc_pmic_core.c
> > > > >  delete mode 100644 drivers/mfd/intel_soc_pmic_core.h
> > > >
> > > > Can you submit this again with the -M flag please.
> > >
> > > This is done with this flag. Basically for the last several years I do my
> > > submissions with that flag.
> >
> > Odd.  I thought -M only showed diff for the changes.
> 
> It's exactly what happens here in this patch. What did I miss?
> 
> Note here is not renaming, but merging contents of one file (actually
> two files) into another. What you are talking about is probably -D,
> but AFAIR Git (at least that time) can't catch up deleted files from
> the mbox format. That's why I do not use -D for submissions.

Ah yes, that's probably it then.

From a quick look at the diff (I missed the 2 "--" at the end), it
looked like this was a rename.  In which case -M won't do anything
useful here.  I'll have to brain grep the differences instead.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
