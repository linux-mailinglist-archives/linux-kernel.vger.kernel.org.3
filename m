Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6125647A0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 15:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbiGCN5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 09:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiGCN5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 09:57:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19E85F47
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 06:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656856638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WDfzjz194PcCWxTAzz6bDcDIHTW8QXy07c2UacTGGhM=;
        b=EBp72nUne9RGUeeMTXfK9NrXA7mQzvOvHmvcpgUl9v72+vSF8++tLmwf8te686B27jyi7q
        gnPRD/KzVHch3NIJvXWsDksg5fgpsltkK4+0S5vNnCYmc5nhifPiz+ga7LhbCio0NErDWM
        h/aCuNMv5vm/Oh4YcM1ANQ5eCFyjGxk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-eZFscSBAOcyh-Nys8gDwbQ-1; Sun, 03 Jul 2022 09:57:10 -0400
X-MC-Unique: eZFscSBAOcyh-Nys8gDwbQ-1
Received: by mail-wm1-f71.google.com with SMTP id i184-20020a1c3bc1000000b003a026f48333so3213183wma.4
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 06:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WDfzjz194PcCWxTAzz6bDcDIHTW8QXy07c2UacTGGhM=;
        b=o9Zt2nw23GfSlBFL15gjjm1VoKrKEBO1kAB+Wed5uiALFc/69N1SDcudR9nsEt50H5
         HuudNgWuC2SGLX3n/d0GQ3cWHm2LCGSXHkB2zzoncjcU9XPGteTpEGIgjTQtlcAgIO/v
         2UFep3kzwZRcVEs7RSb3SX/uA7qZlLR7Z+sPZ7lNrgHAGz4o0hm9IsPRwp8aaU7mzBhC
         QbJ0lk+ftMMUCYpqAS1ZIQUaz3xqqZgtIpk8DddbrdKk8gcqmgbnn9jhC+xK40LXFDEf
         shbLH9q+PN0ZmfPIkz7cKWo2puNDGXtjYPmCuSVBsbCG1eyBBB0ireF5UNncF7ebkPZJ
         miNA==
X-Gm-Message-State: AJIora9+IsAMEMv6N0ibXaVvn4A67IPp0rZ0uwxkDSRTkApSRS2eszok
        pbioe0Chukmha93+jkXTJHZKueBT+/3uKSM3XxHDh+4Gd60FzuJu4wuUe3IlnFfYmIHJjPYGAVh
        zUYPOFfmJIQ8caW20BWn6hq8=
X-Received: by 2002:a05:600c:1e13:b0:3a0:45c9:8480 with SMTP id ay19-20020a05600c1e1300b003a045c98480mr28929866wmb.51.1656856629591;
        Sun, 03 Jul 2022 06:57:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vMV0/K1HCQLYKV63GnYHKrDh7xS2FLDOGOPdw9hQdu6D2Nby5TPOEGWoKjXnC6/KsNeq+l8Q==
X-Received: by 2002:a05:600c:1e13:b0:3a0:45c9:8480 with SMTP id ay19-20020a05600c1e1300b003a045c98480mr28929852wmb.51.1656856629421;
        Sun, 03 Jul 2022 06:57:09 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c144900b0039ee51fda45sm16618553wmi.2.2022.07.03.06.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 06:57:08 -0700 (PDT)
Date:   Sun, 3 Jul 2022 14:57:08 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, christophe.leroy@csgroup.eu,
        cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org,
        Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: [PATCH v11 09/14] module: Move kallsyms support into a separate
 file
Message-ID: <20220703135708.kn535pdrqv24f7kn@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220310102413.3438665-1-atomlin@redhat.com>
 <20220310102413.3438665-10-atomlin@redhat.com>
 <20220628000526.11c57cd8@gandalf.local.home>
 <20220628081906.jln2ombfej5473xi@ava.usersys.com>
 <Yr92YtG12f+II+ea@bombadil.infradead.org>
 <20220703083324.az24ou7nrngvp73v@ava.usersys.com>
 <20220703092305.1e5da4c2@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220703092305.1e5da4c2@rorschach.local.home>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2022-07-03 09:23 -0400, Steven Rostedt wrote:
> BTW, *NEVER* modify code that you are moving. Really, *NEVER* do that!
> 
> It makes debugging much more difficult, like in this very case.
> 
> *ALWAYS* have the moving of code be a separate patch. Keep as most
> identical as humanly possible. Even keep white space errors the same!
> You can add a clean up patch before or after the move. But never do it
> as one patch!

Hi Steve,

I completely agree and noted.

> You even stated "no functional change" which was a lie. Converting
> strlcpy() to strscpy() *is* a functional change!

Understood.


Kind regards,

-- 
Aaron Tomlin

