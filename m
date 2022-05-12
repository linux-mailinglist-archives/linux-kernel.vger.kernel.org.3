Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A937052463B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350602AbiELG5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238889AbiELG43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:56:29 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2821836F
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 23:56:27 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l11-20020a17090a49cb00b001d923a9ca99so4074250pjm.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 23:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WIZMHJ5xRJacnsB6/o2E9laJl0A/k8C1YscKZGNG7WM=;
        b=CDwaq7yh1rz+5ZXUtvYAmjK5GoGl0YKf9usiA8Qr0ncf55O2ooNJCUldcC4OWNITMD
         Bi54+J2lepaOCMCr7j49UhXpQm39vVkbhACXPmy7rxvh+A57/qp7gARCu767qWcqEPm4
         cTsdp4sQDW5zjc9rzS1fFS/Z+EgC3Hyx1Zl9WQjJ6NXoFPPikQbKtGryud/o2IPcDC2C
         bYTlLfyJSJjG+e1cmbp4TUxIn/Zvh82xBUn1cZLzwKSVuIYAwJ0ByDFq4L3TcG7dWypc
         +jCHNYeum0ecMEPenZvIgJ4WTaRiv6AV0vpRaWJBuChT8Zts+6fIuLb2H0IpFrWLUjF/
         bH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WIZMHJ5xRJacnsB6/o2E9laJl0A/k8C1YscKZGNG7WM=;
        b=sD81pLwBx8TQL0C10m67APx8pOJ+C1wdychVIjFfbi65baiyLJ0G/9jr4ZPdya9KsW
         HmPYAZy1Ddwyo9nC8xOpcVM8gqvYE6NmIdBNP/x7WBD8eDylklDAs14CMzQ1geruZAdV
         ClO45bFyYtBHb955wgu5eGbLJGYcHL0/6sU+jZLSzuOYUrRqXXYrJdZ1fSm580nhr4qc
         XfIiTnm2WkeZw7nXEcAnXhnZUpIxkSC/pgmNmDUFIl9Gr+nMmtl75DisnYZMa4hU0er1
         RAJnEqiqZt2jlFhrTMB+3AOH9DoRr8On5gJbSamOIRKT75y93TLSK/pEtTbZQ/FfS8eR
         jpyA==
X-Gm-Message-State: AOAM530s9XM8L4xv6Wf7rIoztF/+uFFBCsxgSt48lSQVc6NHw3qtKeoE
        aTWmsCA7hyvM2jrHzQQH7Fk42w==
X-Google-Smtp-Source: ABdhPJxLokG376TROJxhzuNTRoirq0Y+7oatotyBqsBFWqk0owd9epXW0o/dm8NXds7ePxSBgMFBGQ==
X-Received: by 2002:a17:903:1108:b0:156:73a7:7c1 with SMTP id n8-20020a170903110800b0015673a707c1mr28578721plh.101.1652338586874;
        Wed, 11 May 2022 23:56:26 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id e4-20020a636904000000b003db141a5f26sm1110175pgc.1.2022.05.11.23.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 23:56:25 -0700 (PDT)
Date:   Thu, 12 May 2022 12:26:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Schspa Shi <schspa@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3] cpufreq: fix race on cpufreq online
Message-ID: <20220512065623.q4aa6y52pst3zpxu@vireshk-i7>
References: <20220510035259.5ep52sgahd2a6rie@vireshk-i7>
 <20220510154236.88753-1-schspa@gmail.com>
 <20220511043515.fn2gz6q3kcpdai5p@vireshk-i7>
 <CAMA88TpefB=rnqea2u1zEvNUJNE_kdj4mYito7SGCuMj-o071Q@mail.gmail.com>
 <20220511122114.wccgyur6g3qs6fps@vireshk-i7>
 <CAJZ5v0gN_yDFpvCXRXv8rN-i3TugCi-HKpBKK2z4eWU0Zm1GUg@mail.gmail.com>
 <CAJZ5v0id+7vkqMQEyVRe29oF_dRtzZ0EhoYUn8=yzeENDeABJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0id+7vkqMQEyVRe29oF_dRtzZ0EhoYUn8=yzeENDeABJw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-05-22, 15:19, Rafael J. Wysocki wrote:
> On Wed, May 11, 2022 at 2:59 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > Hmm, I don't think depending on the values of policy->cpus is a good idea to be
> > > honest. This design is inviting bugs to come in at another place. We need a
> > > clear flag for this, a new flag or something like policy_list.
> 
> Why?

Because it doesn't mean anything unless we have code elsewhere which checks this
specifically. It should be fine though after using policy_is_inactive() in
show/store as you suggested, which I too tried to do in a patch :)

> > > Also I see the same bug happening while the policy is removed. The kobject is
> > > put after the rwsem is dropped.
> 
> This shouldn't be a problem because of the wait_for_completion() in
> cpufreq_policy_put_kobj().  It is known that cpufreq_sysfs_release()
> has run when cpufreq_policy_put_kobj() returns, so it is safe to free
> the policy then.

I agree to that, but the destruction of stuff happens right in
cpufreq_policy_free() where it starts removing the policy from the list and
clears cpufreq_cpu_data. I don't know if it will break anything or not, but we
should disallow any further sysfs operations once we have reached
cpufreq_policy_free().

> TBH, I'm not sure why show() doesn't check policy_is_inactive() under the rwsem.

I agree, both show/store should have it.

> Moreover, I'm not sure why the locking dance in store() is necessary.

commit fdd320da84c6 ("cpufreq: Lock CPU online/offline in cpufreq_register_driver()")

-- 
viresh
