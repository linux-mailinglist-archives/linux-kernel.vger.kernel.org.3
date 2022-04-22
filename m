Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC3B50B72E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447421AbiDVM0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447372AbiDVM0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:26:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19CFE5677E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650630189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=njebc7Dm0AoMVQ2bbp0IWL/4+XRs/wUKBlW88zEnLjs=;
        b=d3HWAna1E7t6EHqzLJe5kv9AaGgx0s1WDQ1EEaONEOC0YL6VKDRowNvYGbEckdfJxoA86K
        b5/hlvvanlzvZzEhempY5rZo4LZ45hBibdQQdZOW5nCUEQ1GQ1MzfeOPWuWmCnE4/Iajdb
        +6rtf7AvXwIh51omSARSt56pfyyWVL0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-ZSCQ_Gp0PpSJgN3d7El80w-1; Fri, 22 Apr 2022 08:23:08 -0400
X-MC-Unique: ZSCQ_Gp0PpSJgN3d7El80w-1
Received: by mail-wr1-f71.google.com with SMTP id v21-20020adfa1d5000000b0020a80b3b107so1864641wrv.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=njebc7Dm0AoMVQ2bbp0IWL/4+XRs/wUKBlW88zEnLjs=;
        b=OVFjlqF3z2nK4nDCwF3HjwC9izoLfD7bG7KyLAmcnJXu2P7zQ10PDtXMpyVJWjdRsX
         DXo9lV0P8tgziDtoC5IwvCh41/zekMc4WrTRHYkgkiEDsIgP/GyvhhbIRFWx/AGv8Yn+
         rv8yP5YHNobwQKrwavZwPZ+NZABWVlUnmqNEYDtmSIbQI0KDLLDrVYrHfN16/Z5hvHv5
         yrM/CD+8n4IYIHHOxBN6EBPHpv6sqHsDaWFEwxfbg5fgXSI+OvX4BZftjLZ8v4fd82Nn
         bjZAy8/jNti3QAGTh0axSE5sleI3fX+Rb6CaQdL4K+stRXDNxGacpvsT/VxlkWG46oGx
         ahSw==
X-Gm-Message-State: AOAM533ZkoyC2o8J3i6UZ6N7Cgg9Exu6mHgnMsxGmeF3KYz+rvM9lOw8
        jH48huUqkr4Xs/FvY2pTpnq08gw0TcnF5620aOPMoYABswCJ34Y5mNbppWiKrPOMSGzTL+kxfJE
        +1Q/s1qpoTYwDJD2QsJLaVq0=
X-Received: by 2002:adf:e887:0:b0:20a:c52f:e01a with SMTP id d7-20020adfe887000000b0020ac52fe01amr3605311wrm.42.1650630186919;
        Fri, 22 Apr 2022 05:23:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWeZvJxtsTrqzhfeXMP6u3ngA/qLBiQrI7jgEjqI65fhDzdU3y4DB1H1Jgs1wgzmaHE3kREA==
X-Received: by 2002:adf:e887:0:b0:20a:c52f:e01a with SMTP id d7-20020adfe887000000b0020ac52fe01amr3605289wrm.42.1650630186697;
        Fri, 22 Apr 2022 05:23:06 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id p3-20020a5d59a3000000b0020a83f00487sm2357447wrr.9.2022.04.22.05.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 05:23:05 -0700 (PDT)
Date:   Fri, 22 Apr 2022 13:23:03 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>, mcgrof@kernel.org,
        pmladek@suse.com, mbenes@suse.cz, christophe.leroy@csgroup.eu,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, neelx@redhat.com
Subject: Re: [PATCH v3 2/2] module: Introduce module unload taint tracking
Message-ID: <20220422122303.6lbcrknnbs6vsgr6@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220420115257.3498300-1-atomlin@redhat.com>
 <20220420115257.3498300-3-atomlin@redhat.com>
 <2100545.irdbgypaU6@natalenko.name>
 <20220421145757.zfn6zxh6rx3dp75o@ava.usersys.com>
 <alpine.DEB.2.22.394.2204221009390.1397495@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2204221009390.1397495@gentwo.de>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-04-22 10:11 +0200, Christoph Lameter wrote:
> On Thu, 21 Apr 2022, Aaron Tomlin wrote:
> 
> > > > +		if (len == strlen(mod->name) && !memcmp(mod_taint->name, mod->name, len) &&
> > >
> > > Here, two strings are compared, so I'd expect to see `strncmp()` instead of `memcmp()`.
> >
> > Good point. There are other examples of this throughout
> > kernel/module/main.c; albeit, I will use strncmp() here.
> 
> Comparing the length first may be an attempt to avoid the expensive
> memcmp. But here we need to first execute strlen() to obtain the string
> length. This is already accessing all characters so this
> check is wasteful and a straight str[n]cmp is better.

Hi Christoph,

Agreed - we can skip the extra strlen().

Thanks,

-- 
Aaron Tomlin

