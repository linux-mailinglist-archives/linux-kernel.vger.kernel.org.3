Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FB65AF409
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiIFTBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiIFTBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:01:47 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0741B7BF;
        Tue,  6 Sep 2022 12:01:41 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x23so12201821pll.7;
        Tue, 06 Sep 2022 12:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=LeDD9kgCZnebxM9P0CzDnwWyxYS+9muvlcBX+ySLqKw=;
        b=XGzqPEShd7ADIiYUo44evl/jDlk/Cg7QncLYjsD4DY95bArht+eUL+hedTIaM/zAan
         h9N4KtXDtm4ynbpZ8zo5W61vqFyUlZTggmjS61D+0tmGLFT58LVSZNl0gAX7UP+pjGrg
         3HkUtuit/34ZyXgsEpwVSO390PjYwCrkPbT13tGPs1m6NYshXjYIg1EGAnZ5A8KdDXYG
         OegvZk6/nj0GAwk97nLLvMtJ3JqUl3hCC6PRb4edZq2e2QVmHrOhSRAuPxUoTh7Sl03A
         ouQm1BE20MhhbRlMR2EkyzSKG/EsGb7RxfGLDdk9a/JCR7o3I4V3MKHrnZaR0ccPzGbu
         aD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=LeDD9kgCZnebxM9P0CzDnwWyxYS+9muvlcBX+ySLqKw=;
        b=6b/rprISbDg0vF1Uk54QRpsCjPG7cgIEigFSeIzgiJ/oEoEibi+cyqyuLVDZL1kTVW
         vuhEkk70zQYkJr0HRz/MIiJP3UDJIIXCayeQKkqtCjH4Ai9anmjUoi3RPUVCF37xF0Jq
         IjchC4FbTcEbMG9HWdvobzMZ13hYD1AaU6jlahoCIkyTxN66jAXnjTF1OwfpxqpuZNnr
         ULYc5wkQIIQgMqN4Lvd0SM3uHAzLsFk9XGcnqmQ4ne4ZaxtTH4W0k+evc6azmdi4CSLs
         XFSPSD2UaCRbE3foP/vqXQNFLYKEp56OoYekS8mQEzF14Tj5qZbO8cIhBk2OnkVUb22z
         E7Hw==
X-Gm-Message-State: ACgBeo1e2s09S3cR3W351exu2kDFYo1ILDpBPkLd2updNGlzgVJ/oWUb
        bmrIskKBPP6oNUsajVtXE3U=
X-Google-Smtp-Source: AA6agR7zVDrS7X9FEXubn/O625K05yZL0IJgJcAan3FxUwO5MEvVGEJGwj4obPKS0sI00KYDWNUz0g==
X-Received: by 2002:a17:902:70c8:b0:175:368b:1255 with SMTP id l8-20020a17090270c800b00175368b1255mr35158419plt.83.1662490900388;
        Tue, 06 Sep 2022 12:01:40 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:1190:fbfa:ae95:111c])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902d50600b0017552749e1dsm10306201plg.195.2022.09.06.12.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 12:01:39 -0700 (PDT)
Date:   Tue, 6 Sep 2022 12:01:37 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 1/1] Input: icn8505 - Utilize acpi_get_subsystem_id()
Message-ID: <YxeZEWAYUDWQbVQ8@google.com>
References: <20220905172001.69244-1-andriy.shevchenko@linux.intel.com>
 <YxZPjsRJXJijZ/K3@google.com>
 <YxdC7i9F1ayR5icS@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxdC7i9F1ayR5icS@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 03:54:06PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 05, 2022 at 12:35:42PM -0700, Dmitry Torokhov wrote:
> > On Mon, Sep 05, 2022 at 08:20:01PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > +	subsys = acpi_get_subsystem_id(ACPI_HANDLE(dev));
> > > +	if (IS_ERR(subsys) && PTR_ERR(subsys) != -ENODATA)
> > > +		return PTR_ERR(subsys);
> > > +
> > > +	if (IS_ERR(subsys) && PTR_ERR(subsys) == -ENODATA)
> > > +		subsys = kstrdup_const("unknown", GFP_KERNEL);
> > 
> > Do we really need kstrdup_const() here? This makes me wonder if we need
> > to also have error handling here, and if we going to tip some automated
> > tools by not having it. Why can't we simply assign the constant here
> > (and continue using kfree_const() below)?
> 
> Which makes code inconsistent. But okay, no big deal.

To me the *_const() APIs are needed when the code does not really know
if it deals with a const/read-only object or not. If we know for sure we
are dealing with a const/read-only object, we can skip allocation and
freeing, so I do not see any inconsistencies.

> 
> > I think this is the case where PTR_ERR_OR_ZERO() might help avoid
> > multiple IS_ERR/PTR_ERR:
> > 
> > 	subsys = acpi_get_subsystem_id(ACPI_HANDLE(dev));
> > 	error = PTR_ERR_OR_ZERO(subsys);
> > 	if (error == -ENODATA)
> > 		subsys = "unknown";
> > 	else if (error)
> > 		return error;
> 
> Would it matter? The generated code will be the same in both cases, no?

No, in the end I think the optimizer will reduce both variants to the
same thing. I do find mine a bit more compact and thus easier to read,
but I will not insist.

Thanks.

-- 
Dmitry
