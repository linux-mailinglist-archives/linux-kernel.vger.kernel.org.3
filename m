Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404034B2BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352210AbiBKRfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:35:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344286AbiBKRfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:35:46 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640B2392
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:35:45 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id m7so8772466pjk.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BGhaxVIEQMKlnFcodkGDs2B0bdbA1zu7/HNHNzxtIHQ=;
        b=TMLCyor1ZmLwTWfr4X1GkFJXppyTuhx25TVidRmaZktchdJmqD3wYAkmh1LHUZTjz+
         B971b9sHPctgI8QZhriH6JfI8XxRY+3vRvzAIc+eurPCXyV0vlTvfbeRb4mNCprKi9yC
         /MQq7b0CJvnAJ9hIQPoq4e1w9Dqch4DtGDxxNHoO7QBJvdtEQiqstXCvvNAyqFflIqNR
         6ntY3bmnR1dqF4c+X8UtZUv2AIral2oQVaP20dmnGUxo2X3xfeAc7fIrtgU4Z3sUD3GE
         QxfJerqjGITv3l/v27fEK5g542vh/WA7tpR85d05sf215sd36X/yZyGynMA3CPCT8kWD
         RP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BGhaxVIEQMKlnFcodkGDs2B0bdbA1zu7/HNHNzxtIHQ=;
        b=Cd6IAxi6syGoxckv/WPnTvfv6OhxWJSST6fkIuZXGbWc8tJJdIA1qLMaVb7YyI8dCM
         w3qwz+v1/XoAUwHOVqwdU660NtlHBHaxqv5X5ENi42yGKZPEB3P0OJwrHtAZSqDPvdyg
         ac/tQgP/NDAF3CnsUN4/Io/3G6NqKZCq2YeVxEAEIZdeXHE+3TMNKQFyORBaSN4AxgSP
         JuhFkpC4qospku5Fm+F/upYLCOdXrHyhoVvtfeHYycZnCuu9YZ3CRySe8eu0mdB08ntf
         rZTJ2OZgdtmsguSFTxPpBGpukae1Qp5d8FNPboAwdvGFj4jCDV4El7J1d0wOf/Y/Sqw8
         A9LQ==
X-Gm-Message-State: AOAM531QsQBMbtDo2wlCm1N1vZXXFE3FiMfw2Eiwzykm36+Q01yGqO+P
        QGwxtJRefFuE8agl5Enu5ipfGX5XxdatNA==
X-Google-Smtp-Source: ABdhPJxLBFiNsLm9NmCNa99SYDvQhCe9XTvaZ+13rA/bWT9PyY5haNVekt2sL8iCfJwKFO94LL5fLQ==
X-Received: by 2002:a17:903:1107:: with SMTP id n7mr2665212plh.59.1644600944724;
        Fri, 11 Feb 2022 09:35:44 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s6sm20408450pgk.44.2022.02.11.09.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 09:35:43 -0800 (PST)
Date:   Fri, 11 Feb 2022 17:35:40 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        mlevitsk@redhat.com
Subject: Re: [PATCH 3/3] KVM: SVM: fix race between interrupt delivery and
 AVIC inhibition
Message-ID: <YgaebIQH+IgsfQjf@google.com>
References: <20220211110117.2764381-1-pbonzini@redhat.com>
 <20220211110117.2764381-4-pbonzini@redhat.com>
 <YgaYyJGN0v07vfzc@google.com>
 <3f8e8e3d-8bd7-dfd4-f4a0-63520d817c10@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f8e8e3d-8bd7-dfd4-f4a0-63520d817c10@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022, Paolo Bonzini wrote:
> On 2/11/22 18:11, Sean Christopherson wrote:
> > > +		/* Process the interrupt with a vmexit.  */
> > 
> > Double spaces at the end.  But I would prefer we omit the comment entirely,
> > there is no guarantee the vCPU is in the guest or even running.
> 
> Sure, or perhaps "process the interrupt in inject_pending_event".

s/in/via?

> Regarding the two spaces, it used to a pretty strict rule in the US with
> typewriters.  It helps readability of monospaced fonts
> (https://www.cultofpedagogy.com/two-spaces-after-period/), and code is
> mostly monospaced...  But well, the title of the article says it all.

Preaching to the choir, I'm a firm believer that there should always be two spaces
after a full stop, monospace or not.  Unless it's the end of a comment. :-D
