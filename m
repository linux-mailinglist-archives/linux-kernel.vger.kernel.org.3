Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DF4473521
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242446AbhLMTlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhLMTlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:41:13 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A337BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:41:13 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so15416749pju.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s5k/PwxaMQgjhc2k5k6bBS/QXPiAS4Yz8oXpA49pnJU=;
        b=H1tjoiUSA/Je1yNxPkVDOswa4cHpuj3XTE4jgDRxMDCuNaE7XAqkaWGWDk0L54n2Fo
         jH8XLlQXvGPOHww8kBvhyeu44s4hvTDcw9Vgz8l2fxtCgJCFXaLTKqc+7vdir4gS1bOe
         mSKZU749+IF1G8BFo69ETrc73IsWIbxG3MgfPxR0o8sIMY62QDUtC5mfOjYpGTKPATJY
         U/ixZIBmvYrwpSJYtCskorg+4/aC+c7zn85Hc93j5D8lpxo55KqlaA3NXx3NvcNATzWT
         2JZPn+KVNNDF5sRD40LdJJrI2tyJZ/3hFApok7VlGkw6ujn5d/2BKdx6w+HFkCy4T+SB
         8F4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s5k/PwxaMQgjhc2k5k6bBS/QXPiAS4Yz8oXpA49pnJU=;
        b=u2ZBCzdKGBxidlYLBDUhexzazOCq0hIBTRgJpBHHqNZZ816VrvxXpfCzNtHz57it9c
         uBF7bLBFmIvWa+uVWOSea2swi4DGarZbNkM2KOdzrxEt24/Hku1GSvBIcYG9/jcy7ISi
         DYV6+7/BF3QpethDWmDbNwxQuF3+iTreYDNRlNuSjV/OqOvTC3fDzrqvNguPCxGFDw+B
         DOwmU09nHz9fcTz+zXRuRjp2P9iu7QM85cCOI4hi6q72OmbsrdD6ggZ8tKWskpetMJyq
         z+o8seNJudOdGwozs/b36lzZ6zZmk+QCM1Qhf1k1HBPoY8eifo7zkZ1iXm9yLZ/O6BA0
         A7Cw==
X-Gm-Message-State: AOAM5331/NatwQT9Nnj8bECo9WFrooHim2BlnPm0iYdfuNMvKmpUgK5V
        0Wm0lRfktwWSOia61KObfyM=
X-Google-Smtp-Source: ABdhPJxYXYVLpDCGYEKhDwzei1fV2Gl50AjqWwwXKYPu+Wgl855SMqWuCswiSjmJWSTuQ0FCk5LPSg==
X-Received: by 2002:a17:902:ea05:b0:141:c6c8:824c with SMTP id s5-20020a170902ea0500b00141c6c8824cmr80614plg.86.1639424473139;
        Mon, 13 Dec 2021 11:41:13 -0800 (PST)
Received: from google.com ([2620:15c:202:201:6d07:5ea2:4ced:3b3d])
        by smtp.gmail.com with ESMTPSA id h128sm12666802pfg.212.2021.12.13.11.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 11:41:12 -0800 (PST)
Date:   Mon, 13 Dec 2021 11:41:09 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lianzhi chang <changlianzhi@uniontech.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, 282827961@qq.com,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v20] tty: Fix the keyboard led light display problem
Message-ID: <Ybeh1VGMvL7DkG2I@google.com>
References: <20211213061244.13732-1-changlianzhi@uniontech.com>
 <Ybc5XPfd5f66L92i@smile.fi.intel.com>
 <97eb3c3f68042443aa71c10766f3bef364e8f90b.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97eb3c3f68042443aa71c10766f3bef364e8f90b.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 04:41:24AM -0800, Joe Perches wrote:
> On Mon, 2021-12-13 at 14:15 +0200, Andy Shevchenko wrote:
> > On Mon, Dec 13, 2021 at 02:12:44PM +0800, lianzhi chang wrote:
> 
> > > +	struct kbd_struct *kb = &kbd_table[console];
> > > +	int ret = 0;
> > > +	unsigned long flags;
> > 
> > Slightly better to read:
> > 
> > 	struct kbd_struct *kb = &kbd_table[console];
> > 	unsigned long flags;
> > 	int ret = 0;
> 
> I don't think so.  Why do you?

I wonder why we comment on cosmetics of a patch (and have the submitter
rush to fix that) without considering if the proposed solution makes
sense in the first place?

Thanks.

-- 
Dmitry
