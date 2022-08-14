Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF057591F38
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 11:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiHNJMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 05:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiHNJMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 05:12:14 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCB930F74;
        Sun, 14 Aug 2022 02:12:13 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id y13so8870730ejp.13;
        Sun, 14 Aug 2022 02:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc;
        bh=OVl5WwZ+rC/n/1eWPeM+OsUxxYZUFvZkzjci5mIvKY4=;
        b=YXtShR4m9kiYeT0WkRWu/ot1EzFyfuWzx3Dn2tkQZ8zOSjjo5yXKj0+mNuyIcfEco5
         YjD2MWjggJUT+Lp2XD6eeD4Hir3y8F46x7iD+D56sH6zvKXTS9eb3ONEiPI0omf2VYrC
         j1wscWBKv54JohAIIhtOGGlUdEvYyC23v8uiuZnIejGS1Ct7mQ6bXfjtPdbHnMdsL2a6
         7wrfY5SYrH0BnKXU+91vYFqyJ/RPptug7BK7te37ZJw+4W8bfLKer6L2oJCsHdiEmqzd
         qSqTgqnZsWl84XoYBTXMxm9PThEqrbCT/rbN2tsmQacrpxKbdv6d2kBI8OHU1bXEj2uD
         RuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc;
        bh=OVl5WwZ+rC/n/1eWPeM+OsUxxYZUFvZkzjci5mIvKY4=;
        b=CfntsJXlNv7fBNB2nxTNS6EJdNHWu/2LUdaO7dqR04I7EGIWZ3b5rFDpICVNEqaq86
         jl+ig6gPedtP3tzaGBsE7ACb0CU4bplANRlEn6tfxw/uluTmFFrbUa5LxbnPboNd1v02
         NgF0UTO6TCjWB1WuWjveK3K1Hzdw8ZCD4PvREpGOZgNUWn+uj3NFwemkQzdfrTXsCsO2
         +6rpwjqJYfwhCoLtLZe462SbI2DgiMhtGHiJiiHGnrxOuuxIzgd2Oe/u4dx6Ii2xqQUE
         rKiyb+lzpBzfhfoxc2smQ3yThd1xoPyDOhLmoprKEE3iflu/j7da3t12XNwnJyW0a0ld
         eL2g==
X-Gm-Message-State: ACgBeo2kRD7ghkblFn+tGYeCfhlHCe6ip2ZuWWwC0g/YvgTIThlw/isa
        czvVxN1ROgj8zvn7XJ9B5uU=
X-Google-Smtp-Source: AA6agR6RKoK46K88EqkeoAQJcJbbFf37K9T1OqvCbGqVz7wZgWG381Fn4KK/6QNvpqlrF2dvDo1kYQ==
X-Received: by 2002:a17:906:8461:b0:730:a43a:9981 with SMTP id hx1-20020a170906846100b00730a43a9981mr7191753ejc.552.1660468331834;
        Sun, 14 Aug 2022 02:12:11 -0700 (PDT)
Received: from gmail.com (195-38-113-253.pool.digikabel.hu. [195.38.113.253])
        by smtp.gmail.com with ESMTPSA id q23-20020a056402041700b0043cfda1368fsm4459654edv.82.2022.08.14.02.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 02:12:11 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 14 Aug 2022 11:12:08 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        corbet@lwn.net, fenghua.yu@intel.com, jdelvare@suse.com,
        linux@roeck-us.net, len.brown@intel.com
Subject: Re: [PATCH 3/7] hwmon/coretemp: Handle large core id value
Message-ID: <Yvi8aBtytJ1pEDoe@gmail.com>
References: <20220812164144.30829-1-rui.zhang@intel.com>
 <20220812164144.30829-4-rui.zhang@intel.com>
 <YveBgsVINyKjXW9g@gmail.com>
 <e5a8d07eda23baf07a89ebf54b70d1cfab183837.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5a8d07eda23baf07a89ebf54b70d1cfab183837.camel@intel.com>
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Zhang Rui <rui.zhang@intel.com> wrote:

> On Sat, 2022-08-13 at 12:48 +0200, Ingo Molnar wrote:
> > 
> > * Zhang Rui <rui.zhang@intel.com> wrote:
> > 
> > > The coretemp driver supports up to a hard-coded limit of 128 cores.
> > > 
> > > Today, the driver can not support a core with an id above that
> > > limit.
> > > Yet, the encoding of core_id's is arbitrary (BIOS APIC-id) and so
> > > they
> > > may be sparse and they may be large.
> > > 
> > > Update the driver to map arbitrary core_id numbers into appropriate
> > > array indexes so that 128 cores can be supported, no matter the
> > > encoding
> > > of core_ids's.
> > 
> > Please capitalize 'ID' consistently throughout the series.
> > 
> > > -       attr_no = pkg_flag ? PKG_SYSFS_ATTR_NO : TO_ATTR_NO(cpu);
> > > +       if (pkg_flag)
> > > +               attr_no = PKG_SYSFS_ATTR_NO;
> > > +       else {
> > > +               index = ida_alloc(&pdata->ida, GFP_KERNEL);
> > > +               if (index < 0)
> > > +                       return index;
> > > +               pdata->cpu_map[index] = topology_core_id(cpu);
> > > +               attr_no = index + BASE_SYSFS_ATTR_NO;
> > > +       }
> > 
> > Unbalanced curly braces.
> 
> Sure, will fix these two issues in next version.
> 
> > 
> > > -       int err, attr_no;
> > > +       int err, index, attr_no;
> > 
> > So it's 'index' here.
> > 
> > > @@ -524,6 +538,8 @@ static void coretemp_remove_core(struct
> > > platform_data *pdata, int indx)
> > 
> > But 'indx' here.
> > 
> > > -       int indx, target;
> > > +       int i, indx = -1, target;
> > 
> > And 'indx' again. Did we run out of the letter 'e'? Either use
> > 'index' 
> > naming consistently, or 'idx' if it has to be abbreviated.
> 
> I'd prefer 'index', but here, this 'indx' is from previous code and
> this patch just initializes it to -1.

Then queue up a cleanup patch as patch #1 - but idiosyncratic noise like 
that makes review harder.

Thanks,

	Ingo
