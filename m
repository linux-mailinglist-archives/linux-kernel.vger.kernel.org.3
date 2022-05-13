Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68814526941
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 20:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383306AbiEMS2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 14:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiEMS23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 14:28:29 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88B21C13E
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 11:28:28 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id d6so10937834ede.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 11:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4iZmYfwWJ4woLfygxHtDQ1H4+/ycf7nk+QQuS21hmvo=;
        b=Ju/51i1Gn+EvxVCj5va4zj4cWTnpJ8rAwoJJG8oDH+ZKss/MR6QSw6s+r/OXa7ndDK
         lFTYy5r5MH7C+sND13Em2HCxaotw4gxZqjcNjXyblohb4GwJvfZDjsEDa6mI/v1+e6Yd
         9hOgacoj6IBZRRDS8wFTgjb14txd29YEcS+KQ9AqQEoo/+lF2zotBTqOhLgkad8WE6nr
         WE15AIouxL0xXmLcPUfK8a8k3SbQjJ1GRj3PXybtkvr83E5TmeVhrx9VT1NUKl82j4Wz
         OSYd7bWwgUCYw8QEsW8vtecZZTqzdRQZsweWwU2jr8HV5M/+64wbwJkuw0eUu3cTQV5E
         fldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4iZmYfwWJ4woLfygxHtDQ1H4+/ycf7nk+QQuS21hmvo=;
        b=7HK19LSjuJQB8rzdhKqmqBVpcDR/3CAs62TDQB9AxSWI8TfuKxPsGSPtL5kpVir0lZ
         6FenynSEiXa6mxluJHkIClNHuIqtTuZXj/8s3kPVZW+L4e4KM0lm8V8QVgWOKmXd3qjv
         Ct/GLV7tolh+B7cW3pQ0AaR0zojqlyHD+aIsmt/PsGHhpXPwCB0YarTIrYQtjGm4g8yB
         q4IPujVgjlQy5wkyMpBEfu+wwvgLXvycUI55vKgtYATJT/OVseSf/PG09Hv8n5mIMvKB
         acFra9gdaEGY2kQyEMZX9MpqxL5PDUSUVgoT8d6HAUFsQZSrRf1mfsPxaL/y3Psr3VJu
         NM2Q==
X-Gm-Message-State: AOAM533mEJCXKFB3UF9NNZXwOp+AZSAXmFQ/wluCrZ9Ty4ive0BM9nh4
        1x6Yf83VtZYPMroD2mstmg==
X-Google-Smtp-Source: ABdhPJxsM27XD7ZPQWtLllsk1BYtyuvELscHiUyd3+jcBCwwZewJhyhAgreQj/NwRclapQ9jfMzC2g==
X-Received: by 2002:a05:6402:1f0b:b0:427:b390:2020 with SMTP id b11-20020a0564021f0b00b00427b3902020mr13987edb.70.1652466507506;
        Fri, 13 May 2022 11:28:27 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.148])
        by smtp.gmail.com with ESMTPSA id b1-20020a05640202c100b00427ae00972dsm1332354edx.12.2022.05.13.11.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 11:28:27 -0700 (PDT)
Date:   Fri, 13 May 2022 21:28:24 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jonathan.Cameron@huawei.com, rf@opensource.cirrus.com,
        pmladek@suse.com, ying.huang@intel.com, dave.hansen@intel.com
Subject: Re: [PATCH v2 2/2] mm: Covert sysfs input to bool using kstrtobool()
Message-ID: <Yn6jSElbVPrTJAg9@localhost.localdomain>
References: <20220426170040.65487-1-jvgediya@linux.ibm.com>
 <20220426170040.65487-2-jvgediya@linux.ibm.com>
 <YmleidxlL2/d859f@smile.fi.intel.com>
 <20220512180537.5296f39b27c3488080ff67cf@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220512180537.5296f39b27c3488080ff67cf@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 06:05:37PM -0700, Andrew Morton wrote:
> On Wed, 27 Apr 2022 18:17:29 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Tue, Apr 26, 2022 at 10:30:40PM +0530, Jagdish Gediya wrote:
> > > Sysfs input conversion to corrosponding bool value e.g. "false" or "0"
> > > to false, "true" or "1" to true are currently handled through strncmp
> > > at multiple places. Use kstrtobool() to convert sysfs input to bool
> > > value.
> > 
> > ...
> > 
> > > +	if (kstrtobool(buf, &numa_demotion_enabled))
> > >  		return -EINVAL;
> > 
> > Hmm... The commit message doesn't explain what's wrong with the error codes
> > returned by kstrtobool(). Can't it be
> > 
> > 	ret = kstrtobool();
> > 	if (ret)
> > 		return ret;
> > 
> > ?
> 
> Jagdish fell asleep.
> 
> Yes, I agree.  It has no practical difference at present because
> kstrtobool() can only return 0 or -EINVAL.  I did this:

	ret = f();
	if (ret)
		return ret;

is slightly better because it doesn't require to load EINVAL into
register:

	call f
	test	eax, eax
	js	1f
	...
1:
	ret
