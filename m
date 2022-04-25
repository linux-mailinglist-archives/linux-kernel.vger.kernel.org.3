Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BB350E3AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242486AbiDYOyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiDYOyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:54:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27C7364CA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650898275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Cq4af9zXFtyWFTPQYSYW60+ZqAJ/Qje6bRIbvw79WA=;
        b=duDZ49xlxIIjIcxUzxl2NlcNlhHRFpOvqGqvpd30zkCImjbCNy9Pt5rciyCKsiEQdB9GIE
        RnHmcXKBjX7LoVmdpussJ1LHnoG0JIRU1lQGXVZmzbuCF4EOJ2+vscEuMqlBv8FGQxBEQw
        jLx4RNkan1hnCc+oAR8s5VvZ2RmWtqI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-pvYgYTAYP0mqQa0Yr_IOzQ-1; Mon, 25 Apr 2022 10:51:14 -0400
X-MC-Unique: pvYgYTAYP0mqQa0Yr_IOzQ-1
Received: by mail-wm1-f72.google.com with SMTP id d13-20020a05600c3acd00b0038ff865c043so10388529wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Cq4af9zXFtyWFTPQYSYW60+ZqAJ/Qje6bRIbvw79WA=;
        b=TIRL7TSpk7hSchhW6YpnPxK3fsKotcTkFA5skkHFxlZMmKecHdRJC50S5j2yonCyC7
         0bT86uEU0jDq39jqwFEHLhERXXkjR7ORy+CzwRoMTgG/jncx8AA1rQAUD2b5Fg2AXnL/
         8fg09U1RY+dS+gHshSENp6TP47/b4FNqdund9nrjr8+Nj+1t4Rosz0gKqALONxASjWZd
         Vq3+E4QnfD43QCDg4P8tprh/MvAh8lHmsnthaUGeFi8Q4H+x9EDwN5/853RDztSOWPVB
         InB2o0AZzqaw99wtwEqzoUrupOcUtbgTR1OmiteEtqUaQQA1rxqkDfFGOkuwjMWqyAhe
         ITMA==
X-Gm-Message-State: AOAM530yFTs2r6vIietUG2qbPoTUxJTOyMoPxpTALI4O8/5zcmZoe++a
        rdlLwKqyxRVkyx6ecRuSol7nZYzySmfaeUFX1O0SVZbXR7k1Jgno+U0GJYDtOem7CIKq1LzPbUR
        q0lB+PFcXn/I/XQoyX0wDFtQ=
X-Received: by 2002:a5d:584e:0:b0:20a:9122:2c3c with SMTP id i14-20020a5d584e000000b0020a91222c3cmr14551930wrf.193.1650898271746;
        Mon, 25 Apr 2022 07:51:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzYrwVElWy2gr0bSKJTXkRO7AqEyqH2mM3C3/Vq8lwAVd/Q/IrCzPIJwEVJtSkbNiNyPbbGw==
X-Received: by 2002:a5d:584e:0:b0:20a:9122:2c3c with SMTP id i14-20020a5d584e000000b0020a91222c3cmr14551916wrf.193.1650898271550;
        Mon, 25 Apr 2022 07:51:11 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id f14-20020a0560001a8e00b0020aaf034e59sm11263209wry.90.2022.04.25.07.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 07:51:10 -0700 (PDT)
Date:   Mon, 25 Apr 2022 15:51:09 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, frederic@kernel.org,
        mtosatti@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        pauld@redhat.com, neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v3] tick/sched: Ensure quiet_vmstat() is called when
 the idle tick was stopped too
Message-ID: <20220425145109.td4b7npcom4xgcli@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220422193647.3808657-1-atomlin@redhat.com>
 <alpine.DEB.2.22.394.2204250919400.2367@gentwo.de>
 <20220425113909.u3smtztp66svlw4o@ava.usersys.com>
 <alpine.DEB.2.22.394.2204251406370.13839@gentwo.de>
 <20220425132700.GK2731@worktop.programming.kicks-ass.net>
 <alpine.DEB.2.22.394.2204251603570.25814@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2204251603570.25814@gentwo.de>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-04-25 16:06 +0200, Christoph Lameter wrote:
> It may depend though on how long the idle periods are. Do we have
> statistics on the duration? Always folding the vmstat deltas may also
> increase the length of the idle periods.

Unfortunately I do not. I noticed that this situation can occur via source
code and vmcore analysis.


Kind regards,

-- 
Aaron Tomlin

