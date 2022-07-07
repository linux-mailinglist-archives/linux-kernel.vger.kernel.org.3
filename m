Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7781E56A8BD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbiGGQ6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbiGGQ6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:58:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 301D32CCA1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 09:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657213082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b5Se+ncO6ecEP2j0IGRLm2ErCWYimTOfWI6Y6AOlL5w=;
        b=BJjWMyxeHuNY3aC4ZsF3I+JDEPBD61eKOkxk+UOOSFNQBvprkYm7mSgJzo2atg3X25xjD4
        GJGX5uXL3/lqkjYHoV7u9khB+aiVDSeg59DZQi3pN9dosrqs3UkxNDMadBUlqwxL3OWHUt
        ZvVXqeY6MxTSxQgLJdscOSSalGazTHg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-uCXKLXZ6PC66DQ59OqAq9w-1; Thu, 07 Jul 2022 12:57:53 -0400
X-MC-Unique: uCXKLXZ6PC66DQ59OqAq9w-1
Received: by mail-wm1-f69.google.com with SMTP id h186-20020a1c21c3000000b003a2cf5b5aabso1003844wmh.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 09:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b5Se+ncO6ecEP2j0IGRLm2ErCWYimTOfWI6Y6AOlL5w=;
        b=yKG2u73SwnLBW9jVS2ru0IwTtXOl2M/oVTy/T7meq8zje+56X5E2WrzkTN6ZpLcn1p
         Q+uZwFUF2PkN4J6wkyChDIikuLPtNTAe4O17YEY/vncOZC5q/lpFlpufVOjzIeEaDTE1
         Hx8E1Nk/eBVmDL7ubNkgiyty7B6eqKnJcMSpIFi25q+tKlPKVoWQpezvAxm+jteuECvp
         5Ftla48p+Av1eVSvVLMbvFdTy/s7hcdOFLiOYV9XUlzcH3/jEXFxCabKImAVor9PsYrq
         HLQO0gUC/IbKULzKjMoI0I1Kso40dAkV7olg0Kq8JqNwV69bgcPcOG0+QEhLElMQxCVn
         JE7A==
X-Gm-Message-State: AJIora+OkDtNGQ7vEnPL1CjzpyDtDmhzNo6GB7fDL3Gf0c5TVIynnLnZ
        wAfWw3X0T3W95iRoPbDVWnmZK1ACLuEnl9R+NhnaX+EKs4zR4kmrc1wK7VG4w9Ek6Bteb6/W1IG
        UuldoDJ2+QpOrCK0jpJkJU4s=
X-Received: by 2002:adf:f304:0:b0:21d:7656:83e5 with SMTP id i4-20020adff304000000b0021d765683e5mr14230060wro.407.1657213072537;
        Thu, 07 Jul 2022 09:57:52 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sigDFIJcjtmUc1O7k0RVKhIrrr7aDHeemIxnkS8BpfHtXpLin1X8wgxmCtbkdtLWp+U6eoIg==
X-Received: by 2002:adf:f304:0:b0:21d:7656:83e5 with SMTP id i4-20020adff304000000b0021d765683e5mr14230040wro.407.1657213072309;
        Thu, 07 Jul 2022 09:57:52 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id x2-20020adfdd82000000b0021d62e30a62sm14742505wrl.50.2022.07.07.09.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 09:57:51 -0700 (PDT)
Date:   Thu, 7 Jul 2022 17:57:50 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     rostedt@goodmis.org, cl@linux.com, pmladek@suse.com,
        mbenes@suse.cz, christophe.leroy@csgroup.eu,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, oleksandr@natalenko.name, neelx@redhat.com,
        daniel.thompson@linaro.org, hch@infradead.org, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2] module: kallsyms: Ensure preemption in add_kallsyms()
 with PREEMPT_RT
Message-ID: <20220707165750.tk4fadpv3d4zr2mb@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220704161753.4033684-1-atomlin@redhat.com>
 <YsXNVSAtO+VDggcI@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YsXNVSAtO+VDggcI@bombadil.infradead.org>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-07-06 10:58 -0700, Luis Chamberlain wrote:
> Hey Aaron, thanks again!

Hi Luis,

No problem :)

> On Mon, Jul 04, 2022 at 05:17:53PM +0100, Aaron Tomlin wrote:
> > To disable preemption in the context of add_kallsyms() is incorrect.
> 
> Why, what broke? Did this used to work? Was the commit in question a
> regression then? Clarifying all this will help a lot.

Sorry for the confusion! If I understand correctly, nothing broke
intrinsically.

Rather with commit 08126db5ff73 ("module: kallsyms: Fix suspicious rcu
usage") under PREEMPT_RT=y, by disabling preemption, I introduced an
unbounded latency since the loop is not fixed which is generally frowned
upon. So, I would say this was a regression since earlier preemption was
not disabled and we would dereference RCU-protected pointers explicitly
i.e. without using the more appropriate rcu_dereference() family
of primitives. That being said, these pointers cannot change in this
context as explained previously.

Would the above be suitable - just to confirm before I send another
iteration?


Kind regards,

-- 
Aaron Tomlin

