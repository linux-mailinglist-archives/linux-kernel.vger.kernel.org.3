Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBA850DEFE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238806AbiDYLmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiDYLmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:42:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66713369CC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 04:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650886755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dWekVSPYd8xYAt3O60VkUDiNCfHG1joVEXBu5UZWkrw=;
        b=YN8m6mLLkfgMgH7PdaccLvnQQedjuNmnWN95k97ZHgIzlbVK3y0QzwTv1JtBxlBhOWORPg
        WEoeeD+4isws/fxVlYl7ZxCxDng51iqykZYew/Mah2A6QZ3wFruHaAC801gNWzN6FGZT2K
        BZ1q9iUXNb5isWi86jZwQzuzy5YXMkg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439-3DvIA_TDN1CriXLlWdL43Q-1; Mon, 25 Apr 2022 07:39:14 -0400
X-MC-Unique: 3DvIA_TDN1CriXLlWdL43Q-1
Received: by mail-wm1-f70.google.com with SMTP id az19-20020a05600c601300b003914ac8efb8so7062448wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 04:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dWekVSPYd8xYAt3O60VkUDiNCfHG1joVEXBu5UZWkrw=;
        b=vMd66DMc9gmk77Sk8y/9Zg+p579yWvp9dHTIGgp7r8qKIMU4cQZFLD6VAOqHpZ6zRn
         tO/4ZuyANyxrkw2NB4tIjwoZrWAX3RZuIu2umrMjiZ1GU8XK3cmlIsGXw4dnW1IctoSE
         SDWB3CCKhlx09LQSUC4oQCXjjA7/vWzoCdWxZnQAThnzhSi8ufU2O6OvG2zJRt1tDJp5
         7OeDVO6NLefxLRaG+F9bw5Q8v4U8VDvcqM6cZgcwpaiHDsy1r2cxMVNH4oqFN6Wp0WGu
         Im+eRPPxFHGnSv9DFlDeIkvk43I6TPftbSwa3NVCBQCITzQeW6xp3Ztd9IImJjVXtCTL
         r6MQ==
X-Gm-Message-State: AOAM5320TlDhmp7N6OU9yqbDmlIUclwLmdK/yWAnRxy2ZSKh2ascMngI
        5UZ3timrjOyiwjvhnCrpMd4of9BPCLAhmYYhxUwmADgSQ3jaWsDz3rmQx6kZReBIa0mMbQdCEV2
        GgzXIzi/3T/Zx39/mzi/br3c=
X-Received: by 2002:adf:f710:0:b0:20a:e189:9983 with SMTP id r16-20020adff710000000b0020ae1899983mr133525wrp.24.1650886753274;
        Mon, 25 Apr 2022 04:39:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwq4QRElPhL8bLGVswnlIMjcwsK192ldTpRUzZ0gIm2L1nYcCNVDuB8lSD6IXZRABNNdhtiOQ==
X-Received: by 2002:adf:f710:0:b0:20a:e189:9983 with SMTP id r16-20020adff710000000b0020ae1899983mr133512wrp.24.1650886753070;
        Mon, 25 Apr 2022 04:39:13 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id j39-20020a05600c1c2700b00393ee3deaf1sm1758378wms.9.2022.04.25.04.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 04:39:12 -0700 (PDT)
Date:   Mon, 25 Apr 2022 12:39:09 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     frederic@kernel.org, mtosatti@redhat.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, pauld@redhat.com,
        neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v3] tick/sched: Ensure quiet_vmstat() is called when
 the idle tick was stopped too
Message-ID: <20220425113909.u3smtztp66svlw4o@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220422193647.3808657-1-atomlin@redhat.com>
 <alpine.DEB.2.22.394.2204250919400.2367@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2204250919400.2367@gentwo.de>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-04-25 09:23 +0200, Christoph Lameter wrote:
> On Fri, 22 Apr 2022, Aaron Tomlin wrote:
> 
> > A customer provided some evidence which indicates that the idle tick was
> > stopped; albeit, CPU-specific vmstat counters still remained populated.
> > Thus one can only assume quiet_vmstat() was not invoked on return to the
> > idle loop.
> 
> Could we *always* fold the vmstat counters when entering idle mode? That
> would make the logic less complicated. There is nothing else to do since
> we are entering an idle state and if there are any counter deltas then we
> have the time to process them. This may also decrease the time that
> deltas exist significantly and an idle system will have accurate vmstat
> counters.

Hi Christoph,

Thank you for your feedback.

Yes, in the context of nohz, this patch should ensure it, if required, when
the idle tick is to be stopped.


Kind regards,

-- 
Aaron Tomlin

