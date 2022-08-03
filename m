Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32365588911
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbiHCJI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiHCJI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:08:27 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9CD12762
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 02:08:23 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l22so20784931wrz.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 02:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eY4En0BOoCCAmSsPwL6benyjn9C8gmoGwOJ68i//GxY=;
        b=ktfWfi9fm5svqAfZHc2jVFs1hbGL76kq7LzSPBTWV4/LXEgfwjkegtg4K7dQph3NJ3
         azFhlavNae0EwGRkaN1Vt2UrYrDjdUz+KliVY2AoGsaHs+pkQlbAv+2eOjVO4IEMSO39
         aP33PosL/KaFIiMHT5jGETdnvnw29gyPB1P8x01/mmfAb5WQMtTHANolV4LFEunjNjl1
         pRuWuILImn7YsjNSrp6d51iokdDa+L2dNuOlQXUsgad893j+0pvlWNfVZcbul8qkf7Of
         fs/xlyDK+SWJJNP5A6eAA+6+U2Cmyu2BnuGrYf4FiwWDA2Mx4zj6ku1zdLv5mqKosHW0
         5/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=eY4En0BOoCCAmSsPwL6benyjn9C8gmoGwOJ68i//GxY=;
        b=bV454AEjPIDoryws0FvOhsFCdfM9PCb71+TpmK1kx2GJn0ffbQgj4YJsjf1tGZCAE7
         k1KKMlu4mTD9eENBKTwONCQ3ZcRtoGEL31bXah2twnFhCAw/FDaYLjuvdzjgs5LFA1OI
         srX+89XZ/RPsuim54G77qDTWRBJqrIK/R7ZMTVHyW/18tFh7hbFdHi12tmhhxRkcMuA9
         qEkn7wFR0hEr2L7X5CP2HO11WZu2qBGXdU4yO037+u0UO2d/uhvQq8dHJCV0SX7gl4py
         8Y/HQ7ImKd5LsNIWk/z2VTwixQxay1OkbYe8BQth8xxQYrv4ydr+v7+M9JMvHwUOyIdd
         BFIA==
X-Gm-Message-State: ACgBeo2foMVZS1AknYXA3/BalkHkCSKK+hT/za28Oeeggs/WNHpF7cYb
        4hWPed/Q2ozNhRaSxOa/xxg=
X-Google-Smtp-Source: AA6agR4OOuglI3wbuGQIpZljSvCvnlsY784WKuSRG/XiY5yyJSSk9WlaqsKsGjK+dXBjuSDtM32XSA==
X-Received: by 2002:a05:6000:982:b0:220:6e5e:1087 with SMTP id by2-20020a056000098200b002206e5e1087mr4708780wrb.82.1659517702033;
        Wed, 03 Aug 2022 02:08:22 -0700 (PDT)
Received: from gmail.com (84-236-113-167.pool.digikabel.hu. [84.236.113.167])
        by smtp.gmail.com with ESMTPSA id y14-20020adffa4e000000b0021eb309c97dsm17172475wrr.25.2022.08.03.02.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 02:08:21 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 3 Aug 2022 11:08:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     x86 <x86@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Subject: Re: [PATCH] x86/numa: Use cpumask_available instead of hardcoded
 NULL check
Message-ID: <Yuo7A0KYoNnbgwWT@gmail.com>
References: <20220731160913.632092-1-code@siddh.me>
 <YukFgFTaq4Aw+uht@gmail.com>
 <1825f63b142.8968bde3116633.1242410031840350968@siddh.me>
 <Yuo2UkkyaYtZ3rMZ@gmail.com>
 <18262ed2459.44b0d74d434377.3690496800292832933@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18262ed2459.44b0d74d434377.3690496800292832933@siddh.me>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Siddh Raman Pant <code@siddh.me> wrote:

> > Does 'allmodconfig' reproduce the warning for you:
> > 
> >   $ make allmodconfig
> >   $ make arch/x86/mm/numa.o
> > 
> > ?
> > 
> > If yes, then this could be due to gcc-12, as it doesn't reproduce with 
> > gcc-11 for me:
> > 
> >    gcc version 11.2.0 (Ubuntu 11.2.0-19ubuntu1) 
> > 
> > Thanks,
> > 
> >     Ingo
> > 
> 
> There is no reason why allmodconfig would trigger the warning, [...]

Well, unless I'm misreading your changelog, all the warning needs to 
trigger is CONFIG_CPUMASK_OFFSTACK=y.

> as it has CONFIG_CPUMASK_OFFSTACK=y, but the warning is because of the 
> other case.

What 'other case'? I've re-read the discussion and don't see it, but maybe 
I'm a bit daft this morning ...

> Did you try the config file I had linked to earlier?

Yes, and it didn't trigger the warning.

Thanks,

	Ingo
