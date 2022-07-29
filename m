Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE659585231
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbiG2PRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiG2PRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:17:45 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E01E459B6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:17:44 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ss3so9041109ejc.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8uOzxUeHyhbXm38NMH0o9xKNocW39uZURlmCfdDfHVQ=;
        b=X5JFM6ncTKhP0dvBkT3+YMgOXuX7B74bsPN/NF0g+oPNYeC1Ct5yDA690tfkf1XHu7
         GwVt67m+Jb57vP0D/EEdsBmctPZCaptJeV7rTU8Jo/I1sqdIPycTLh0uIArioQ59k/4W
         MIa4fLHpde6VL+mfDFfo/+Pt09NJvWxRLImMv0CuoWiggS5ADBEBOAFchKqPnlENnmKV
         2j7EsqvvumTYVHn7dnmOpYTrv55QmTZ3Bjf00AmvFMyy2/rRV58cXuOhGPev4PTmpwVY
         uemEFnPVxYNOrretMEd0T+AOIYDo8r9/wOLrt3kcmw/YYN1EX/tPDbu906tCsFAZvaPT
         V8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8uOzxUeHyhbXm38NMH0o9xKNocW39uZURlmCfdDfHVQ=;
        b=L3AsB/FSFXzI0n8SN877VsKWHU7tTWCApBvvC6Oenmso0F89WhZP+m+ux/td705iZQ
         hMIrS45Z0GvJ+lCt7BB8PyG0Rt+ykAchFRcHQFn3mFQXXIA6wH/3yVZ0o2Gv+42rD/r5
         Gm3AEbUxkxbjC+AjLqAj0YAH/1+20VH/wdaaAhOzfXeF2DfdnYC5THHLbFlbSEvUguXE
         hw8WUX6k3S64bKY/82zK+3aKmV1XRkL435An/kgEjrIf5s8naT6BKECb9V9Yjb89Siyk
         z7K4vphjdd7v0YdmcSTdoruTHi2pl98mP2IKlUlLyffPOloULcysi5+o5sfrDOgM3yRd
         foFA==
X-Gm-Message-State: AJIora9lUBFiqFFjw9rJ/11YSbsOJ1dIiRUqPQ1sIGzy30DH6C8eVg1k
        n4NDOseNxxob4/jD9g3ITw==
X-Google-Smtp-Source: AGRyM1unZD4CDaqGRE4CcewGTDSkgkSwfbx6+pGS5X/ZxyjvhfDPVd5wl1V9pG7ZMKxGNSQeMm5MRQ==
X-Received: by 2002:a17:907:3ea6:b0:72b:4a06:989a with SMTP id hs38-20020a1709073ea600b0072b4a06989amr3359081ejc.168.1659107862822;
        Fri, 29 Jul 2022 08:17:42 -0700 (PDT)
Received: from localhost.localdomain ([46.53.249.83])
        by smtp.gmail.com with ESMTPSA id c12-20020a056402120c00b0043cc2c9f5adsm2433441edw.40.2022.07.29.08.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 08:17:40 -0700 (PDT)
Date:   Fri, 29 Jul 2022 18:17:38 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ying.huang@intel.com, dave.hansen@intel.com,
        Jonathan.Cameron@huawei.com, akpm@linux-foundation.org,
        rf@opensource.cirrus.com, pmladek@suse.com, will@kernel.org
Subject: Re: [PATCH v3 1/2] lib/kstrtox.c: Add "false"/"true" support to
 kstrtobool()
Message-ID: <YuP6Evijb2oZqD3D@localhost.localdomain>
References: <20220426180203.70782-1-jvgediya@linux.ibm.com>
 <Yt6u34sigPEkeZ0Y@FVFF77S0Q05N.cambridge.arm.com>
 <Yt605xj898VSAsA3@casper.infradead.org>
 <YuPwLq+D8k53GZa3@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YuPwLq+D8k53GZa3@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 05:35:26PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 25, 2022 at 04:21:11PM +0100, Matthew Wilcox wrote:
> > On Mon, Jul 25, 2022 at 03:55:27PM +0100, Mark Rutland wrote:
> > > On Tue, Apr 26, 2022 at 11:32:02PM +0530, Jagdish Gediya wrote:
> > > > At many places in kernel, It is necessary to convert sysfs input
> > > > to corrosponding bool value e.g. "false" or "0" need to be converted
> > > > to bool false, "true" or "1" need to be converted to bool true,
> > > > places where such conversion is needed currently check the input
> > > > string manually, kstrtobool() can be utilized at such places but
> > > > currently it doesn't have support to accept "false"/"true".
> > > > 
> > > > Add support to accept "false"/"true" as valid string in kstrtobool().
> > > > 
> > > > Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> > > > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > 
> > > I've just spotted that this broke arm64's "rodata=full" command line option,
> > 
> > That isn't a documented option.
> > 
> >         rodata=         [KNL]
> >                 on      Mark read-only kernel memory as read-only (default).
> >                 off     Leave read-only kernel memory writable for debugging.
> > 
> > Hopefully this is an object lesson in why you need to update the
> > documentation when you extend a feature.
> > 
> > > since "full" gets parsed as 'f' = FALSE, when previously that would have been
> > > rejected. So anyone passing "rodata=full" on the command line will have rodata
> > > disabled, which is not what they wanted.
> > > 
> > > The current state of things is a bit messy (we prase the option twice because
> > > arch code needs it early), and we can probably fix that with some refactoring,
> > > but I do wonder if we actually want to open up the sysfs parsing to accept
> > > anything *beginning* with [tTfF] rather than the full "true" and "false"
> > > strings as previously, or whether it's worth reverting this for now in case
> > > anything else is affected.
> > 
> > Well, that's going to break people who've started using the new option.
> > As a quick fix, how about only allowing either "f\0" or "fa"?
> 
> I think we need to be more strict in kstrtobool(), i.e. 'f\0' ('t\0') and 'fal'
> ('tru') perhaps?

lol what?

the only way to be strict is to accept "0" and "1" with optional
newline and delete all the rubbish entirely.
