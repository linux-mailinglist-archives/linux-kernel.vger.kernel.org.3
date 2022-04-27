Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53FF511B3A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236685AbiD0Nyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbiD0Nyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:54:38 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C85533A1A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:51:27 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id a1so2032989edt.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ME3k6FVz9MhikZB8YeQDQMy2j/6J30B2O0RtfV1l4Vs=;
        b=R+1uvwZ+roIC65MCNVVtIZlXIdCojO529o26SqQVucBsTFonn2EyQX0WvTDI6z5i5J
         ahaOo5k/LSry8UJiPSrYiXRl40gVZ5IAyWx5WlaChPxQfiTdA2Ut4GKiN+5ew/k9vedZ
         ZrVemdWVQF65SNTUWQopxVuHV/KUcmgG8gTDn7gMDNuyFtqeol5V7Rnmr1vv8k2etFHn
         541O2ahIp1GHuAxMII3XddclDsTulr+/okLlBMYwemCvYhFLVhTdNxeDC1tWDCZJZjdu
         ypsmzG3DfgyiqD6pkGm14bVib9RQTszLIUiLlrX9CXRliUEQhTYl0DeQzwl2p0JiwCHP
         IbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ME3k6FVz9MhikZB8YeQDQMy2j/6J30B2O0RtfV1l4Vs=;
        b=I6zG+PxRwNVQkZMkpezKhSgwcKR3DRc0uTBK9d9Rji9P34oAua7U2gFhK3xI16mvIh
         TqAH5TVS/7fcc/fxWm9jKIA16Ep4Y+jwX4OcMAGnAOu1BXkdM36+ZYOAJqejp6TQR7Fd
         r5ktMCPanqfsuCjjXEJP6e0rsSkDt3r5ONNm/Y6mEJwLhaOFT8fLbkY5L9B0ctBX8rRh
         k3LYqNZp+foSxW4jcF7Ja/25cek+D1HBsFKDJncVakUAlLsYWh0jDGgeBx8WMqvK0Fal
         W4tB/B8BNkwXgRA2sTcAC3aWG5rkh1I31iCqW6L2O8WLP2AbII4LOgW986UtsZzYchW9
         eiFA==
X-Gm-Message-State: AOAM533KE7aRB61GxOyDBu+Kia31jteinGiOuT6f8Uxsq41yfEqCvn43
        DTHXTuv2ENDIHebU+gpiAzjprrPLcK/peaEYEi0=
X-Google-Smtp-Source: ABdhPJyPt00gR6kCyybTagoxwc0M5rLTuN5tBDFNG5rBmddOwlzJgfpF2F7hsTIVixrMAh3zGL6yoX2RtAsE1BzY5Rg=
X-Received: by 2002:a05:6402:54:b0:419:9b58:e305 with SMTP id
 f20-20020a056402005400b004199b58e305mr30077944edu.158.1651067485669; Wed, 27
 Apr 2022 06:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220426064001.14241-1-jvgediya@linux.ibm.com>
 <YmfzJVPng1U8X+jV@smile.fi.intel.com> <Ymf/yyPLGErQji06@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
In-Reply-To: <Ymf/yyPLGErQji06@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Apr 2022 15:50:49 +0200
Message-ID: <CAHp75VeAVFNA7faZjsHOyAM2ZKU=xWTVZDKiPwY2woKW712Qpw@mail.gmail.com>
Subject: Re: [PATCH v2] lib/kstrtox.c: Add "false"/"true" support to kstrtobool
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, ying.huang@intel.com,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 8:49 PM Jagdish Gediya <jvgediya@linux.ibm.com> wrote:
> On Tue, Apr 26, 2022 at 04:27:01PM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 26, 2022 at 12:10:01PM +0530, Jagdish Gediya wrote:

> > > At many places in kernel, It is necessary to convert sysfs input
> > > to corrosponding bool value e.g. "false" or "0" need to be converted

corresponding

> > > to bool false, "true" or "1" need to be converted to bool true,
> > > places where such conversion is needed currently check the input
> > > string manually, kstrtobool can be utilized at such places but
> >
> > kstrtobool()
> >
> > > currently kstrtobool doesn't have support to "false"/"true".
> >
> >
> > Ditto.
> >
> > > Add "false"/"true" support to kstrtobool while string conversion
> >
> > Ditto.
> >
> > > to bool. Modify existing manual sysfs conversions to use kstrtobool().

...

> > Also Documentation update is missed.
> I am not finding any related documentation. I can update
> the comment on the function for true/false change.

Yes, please.

-- 
With Best Regards,
Andy Shevchenko
