Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16255A8364
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 18:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbiHaQlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 12:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbiHaQls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:41:48 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B75A81B23
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:41:47 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 145so14609992pfw.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=++G3COAxypeyQZbXuhGnyuZYhw1740DPlPvtNk4Tmsg=;
        b=eeM/Dgpg1kt885I/qM+XTBsuEw05V24t7TMi7qvy3G4nWOsx+CcQd17yJZCz9zA5+u
         mwOd0/jxjigywcioFKSqLgoWysvmVPBUbwws4YmXQTqXUtPOn/M5EWUY/UwZA3cJAEQI
         lD99kvf6tQYgi0qNvEZS2AAt8yUAdkW5rTjWBfcPGc/eCyLaw8eMBoauS0n0mm83mlOz
         yG9F93zFGPQIDoFbzWxJcniH23MqFOdm2UPne/zrIkJvlg9T7yfla9YllD7oU5Ayz6a4
         lp9nZuWOHGbqi+pMNHwqc3ZHcBNYphnn1WplaPofqn44/JRcWP+yuYTJ2TwqOLb1xeb2
         wj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=++G3COAxypeyQZbXuhGnyuZYhw1740DPlPvtNk4Tmsg=;
        b=JmHpiRBg8Psch7sT3vYaBXBHrHJCc6BJ8ar1/9UTPcBlpYrn4IVt5uwdgd+GjQaS73
         1yCL2lfQ9ORs3UIi+pUXREFwftn7cLQQnGbnjaCIvxUlFSkfOuKOY/8lADZddT503r/Q
         tmpBMBfdtzvTkuYUSYEo6v5Plfyh5/VNqF+MgSdGaeIbeAbvUIcri4H4PQvtCvNOHg62
         gH4DGRHWl15JLRt1EYmFdiIt/FZnT8gFt5uLELz8k6hS/4ws4zx7JVPas5wU5vpULtL8
         sWaIMALuFQPQod382YqvTLkHm+OUQYJgCENaaAKVox0yZSowXAyn9fBtQMuOlAtQ7GHS
         D5yQ==
X-Gm-Message-State: ACgBeo2BddQfhkq1SymVIX+KVEf/mzfbwHZg3IBNaK3aH3nFOHm79q/i
        cIpgjpq8yw+dxd4DbdnKcGvJHw==
X-Google-Smtp-Source: AA6agR5ZqTzzZLsVpwr7BHW5VFrZ6tch8D+TEJQrxn5Wajvo8hVtW4Am12cblYbSE/vDzM+Ga+lbjA==
X-Received: by 2002:a63:91ca:0:b0:42b:4847:90dd with SMTP id l193-20020a6391ca000000b0042b484790ddmr22072544pge.28.1661964106293;
        Wed, 31 Aug 2022 09:41:46 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id x13-20020a17090a1f8d00b001f510175984sm1517590pja.41.2022.08.31.09.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:41:45 -0700 (PDT)
Date:   Wed, 31 Aug 2022 16:41:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH 14/19] KVM: x86: Honor architectural behavior for aliased
 8-bit APIC IDs
Message-ID: <Yw+PRS2hScQd4ShB@google.com>
References: <20220831003506.4117148-1-seanjc@google.com>
 <20220831003506.4117148-15-seanjc@google.com>
 <5f6d99bc28fde0c48907991b6f67009430aea243.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f6d99bc28fde0c48907991b6f67009430aea243.camel@redhat.com>
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

On Wed, Aug 31, 2022, Maxim Levitsky wrote:
> On Wed, 2022-08-31 at 00:35 +0000, Sean Christopherson wrote:
> > -		if (!apic_x2apic_mode(apic) && !new->phys_map[xapic_id])
> > -			new->phys_map[xapic_id] = apic;
> > +		if (kvm->arch.x2apic_format) {
> > +			/* See also kvm_apic_match_physical_addr(). */
> > +			if ((apic_x2apic_mode(apic) || x2apic_id > 0xff) &&
> > +			    x2apic_id <= new->max_apic_id)
> > +				new->phys_map[x2apic_id] = apic;
> > +
> > +			if (!apic_x2apic_mode(apic) && !new->phys_map[xapic_id])
> > +				new->phys_map[xapic_id] = apic;
> > +		} else {
> > +			/*
> > +			 * Disable the optimized map if the physical APIC ID is
> > +			 * already mapped, i.e. is aliased to multiple vCPUs.
> > +			 * The optimized map requires a strict 1:1 mapping
> > +			 * between IDs and vCPUs.
> > +			 */
> > +			if (apic_x2apic_mode(apic))
> > +				physical_id = x2apic_id;
> > +			else
> > +				physical_id = xapic_id;
> > +
> > +			if (new->phys_map[physical_id]) {
> > +				kvfree(new);
> > +				new = NULL;
> > +				goto out;
> Why not to use the same  KVM_APIC_MODE_XAPIC_FLAT |  KVM_APIC_MODE_XAPIC_CLUSTER
> hack here?

The map's "mode" only covers logical mode (the cleanup patch renames "mode" to
"logical_mode" to make this more clear).  There is no equivalent for dealing with
the physical IDs.  Alternatively, a flag to say "physical map is disabled" could
be added, but KVM already has to cleanly handle a NULL map and in all likelihood
the logical map is also going to be disabled anyways.

Not to mention that APIC performance is unlikely to be a priority for any guest
that triggers this code :-)
