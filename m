Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2475C5785F1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbiGRO6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiGRO6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:58:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D62CF2654D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658156309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y84+fqq0ic53Qb8imRAdbfxigr2ZrJ0QF7UhEw8hqwU=;
        b=Ar4qt2cB7rmwkvzjXwVblIR3fKjMTJvEi7GA5FYLF93gewy6z0Hy6MTSi50tepMYiZAjii
        kfy0G26VlfqmWmNGYtISFvnePRO/M0EBh88/7PN08/6jYESvNWKzK5Vl76zE0JbiioOzbm
        k7lASd/+QiGUlzguZp9FMnb6FSkG7uM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-OZwmCm_nO2OOfLvN0LnibQ-1; Mon, 18 Jul 2022 10:58:28 -0400
X-MC-Unique: OZwmCm_nO2OOfLvN0LnibQ-1
Received: by mail-wm1-f70.google.com with SMTP id ay27-20020a05600c1e1b00b003a2f3b04262so3591004wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y84+fqq0ic53Qb8imRAdbfxigr2ZrJ0QF7UhEw8hqwU=;
        b=xtkFGyHU7iKhPkprClSBaQLuHo+rSSyYJdffe57IQKfs68KhUAeZ4ILTagBp+k4h2S
         azJjFugHaCA2qG1f/V9hggctfIx2lJuBZZyU/Z5tDSSpTdKiGpwri5HaFkZOmlPEKNA9
         xV2xMsKzLVx9vLIPQHHXCYnMkI/l7Cijno4JrBTB6uxjf4ZKNPFFjpLnbzoVbkG8gGPi
         PpsdM5uSK0y5BRchIEUZLokNge+yW+Bcixf+0E5fu1qALeDOO5OvEvu6J2vK12bSbGv0
         /kKLkJbu9Y5i6T90zVkU0oFBRuqc81zGt7ZX7kDGVajjUp/tl6JaF7z3pzgkNu88fF2y
         xTDQ==
X-Gm-Message-State: AJIora/m0zGkctTuEGTiPWfvDvna+UUFSK9hpmf4Oaj/WG+saeqdrRsa
        SFaL1nwP3AW3p7lGOaziKuaUgDDoL2e1D3n3AIdIMOKvxJnjndqTwKeIe2iCwZWC7q3KXG6FALp
        BN7pz0jwB9vmUPd1m6YlwuLk=
X-Received: by 2002:a7b:c30d:0:b0:3a1:861a:b9bc with SMTP id k13-20020a7bc30d000000b003a1861ab9bcmr26347259wmj.97.1658156307243;
        Mon, 18 Jul 2022 07:58:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uSr7sUpCPiES1pHGOAztVCqqEUoPZgST6vOGQw2A0+oXcpwZHEXiCM7up4uQSFVn2Yki3ZPQ==
X-Received: by 2002:a7b:c30d:0:b0:3a1:861a:b9bc with SMTP id k13-20020a7bc30d000000b003a1861ab9bcmr26347243wmj.97.1658156307039;
        Mon, 18 Jul 2022 07:58:27 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id bd20-20020a05600c1f1400b003a3211112f8sm78442wmb.46.2022.07.18.07.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 07:58:26 -0700 (PDT)
Date:   Mon, 18 Jul 2022 15:58:25 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     frederic@kernel.org, cl@linux.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, pauld@redhat.com,
        neelx@redhat.com, oleksandr@natalenko.name, atomlin@atomlin.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v4] tick/sched: Ensure quiet_vmstat() is called when
 the idle tick was stopped too
Message-ID: <20220718145825.ojncoyjoumjibisx@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220621172207.1501641-1-atomlin@redhat.com>
 <YtVkHf8C0GcSBPl8@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YtVkHf8C0GcSBPl8@fuller.cnet>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-07-18 10:46 -0300, Marcelo Tosatti wrote:
> Aaron,

Hi Marcelo,

> You'd probably want to separate the vmstat_dirty changes from the
> tick_nohz_user_enter_prepare changes, for bisectability.

Thank you for the feedback and will do.

> Otherwise looks good to me (and comments made on previous 
> RFC versions have been addressed).


Kind regards,

-- 
Aaron Tomlin

