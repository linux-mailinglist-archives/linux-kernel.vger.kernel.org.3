Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8416A54374E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244013AbiFHP0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244617AbiFHP0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:26:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23AD912F37B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654701737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NyDm9mJkVzWDvK67KOw2wVt/yPUnzdXp5ZRYjgzzgOM=;
        b=LG8MiH6iDGr3eI8Se/81iMUfPGgs65eMMQmzwvsFUcSbEgFVj9eA1pEMIoVUXD/TIuiTRI
        8XUGKU0trXPez1VBrilrGXBvajXl7JUTVW/KamFPjobxZ1AoBW4GbPYX8P7plxANO43uAN
        U3O1/3G2xQpgzjyM8B5aAHWgb2fA/Bg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-TT6xXS53OXCGeI1b9QPVdQ-1; Wed, 08 Jun 2022 11:22:16 -0400
X-MC-Unique: TT6xXS53OXCGeI1b9QPVdQ-1
Received: by mail-wr1-f71.google.com with SMTP id m18-20020adff392000000b0021848a78a53so2409300wro.19
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 08:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NyDm9mJkVzWDvK67KOw2wVt/yPUnzdXp5ZRYjgzzgOM=;
        b=8IP9msKkzVD90Fb+FWVfwsbi8uRjADrt7Ksa2CPqGcIbw/+eCkD5PDvSHfi7jyVScj
         hyqUiHO4xKoqdjMlg3/xcTs7r324hl4HvvuWcM1tEXTg1ZexZNpX6EjCZQbx4KVjhkfo
         WgU+fGiGxAPWrzFin6/4OKmPhHvz8lTOLAgTROJPmyX0NBlKOWWRwYiR2ebDM8VXF/Ih
         fhGIXS/eumqx03kkwAz3as8Hz7v/jDTHi1Az+YPKcdTxputGGm9/HvqbZ2uaDCka6mSe
         kXgzHEG3+TiFlEj5tnVibQWJxpYubiGqTeGoN6HxxybQ7w0hahHntnYyCsRyzNWtskF3
         fHOA==
X-Gm-Message-State: AOAM533ivwqeVABJ2h+SIFXrB3HkyX1of1wb/HjMY2lsUOFuHy7sKa2R
        XALFb2crlzm12qdr0tJ7mHaQjJXOMEXH80kutc320S8luDK4taQVPBiGvV2fMIuBuWHLHOtEUhH
        50KoNPX1X4XcpzXtvKsf9A3Zu
X-Received: by 2002:a05:6000:1e0a:b0:210:32e1:3b03 with SMTP id bj10-20020a0560001e0a00b0021032e13b03mr34460813wrb.642.1654701734988;
        Wed, 08 Jun 2022 08:22:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwz1NacuKsD9Aiuiwfgs4mtvzYjxoK6GpJ+CUOQV9DQmdpxl+FGkRyQYBzIs2H+7wWliDQAsA==
X-Received: by 2002:a05:6000:1e0a:b0:210:32e1:3b03 with SMTP id bj10-20020a0560001e0a00b0021032e13b03mr34460796wrb.642.1654701734835;
        Wed, 08 Jun 2022 08:22:14 -0700 (PDT)
Received: from gator (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id l9-20020a7bc349000000b0039746638d6esm23908334wmj.33.2022.06.08.08.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 08:22:14 -0700 (PDT)
Date:   Wed, 8 Jun 2022 17:22:12 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 049/144] KVM: selftests: Return the created vCPU from
 vm_vcpu_add()
Message-ID: <20220608152212.fzaijzuxypbmn5pa@gator>
References: <20220603004331.1523888-1-seanjc@google.com>
 <20220603004331.1523888-50-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603004331.1523888-50-seanjc@google.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 12:41:56AM +0000, Sean Christopherson wrote:
> Return the created vCPU from vm_vcpu_add() so that callers don't need to
> manually retrieve the vCPU that was just added.  Opportunistically drop
> the "heavy" function comment, it adds a lot of lines of "code" but not
> much value, e.g. it's pretty obvious that @vm is a virtual machine...

I agree and would like to see all the heavy function comments reduced.
Maybe you do that somewhere in next 100 patches :-)

Thanks,
drew

