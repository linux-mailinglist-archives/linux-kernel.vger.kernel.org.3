Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18BF58465C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 21:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiG1S4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiG1S4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:56:04 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF6522289
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:56:03 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id z19so2588711plb.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Bvq190uYRxwRpB0SDsOwrjOA2Tovqp3zJ8Noufja73c=;
        b=Lu6i5dvS3bzFKsbUZm3QfSW51jaI2HbWilk1MngHkXXuftVS75s7FdZX0hDEzAL2a7
         ZgJ8KOJwK2W5/7nSyRs6TCgi8Zme4WANlnYFbxMB5qKSWj/aCPbcJ6rQR111qvPoLI1U
         5RCG+k1iwjFk7qUZVqy6buNBw5ulkalystXDPIsQpt/zpi7PndijUdxbxeNgQHh6RwvA
         TQmQDxVEhcec47BJO09Hl9loIL9DLBtVEqp+1ICze1WQWFLrIHUQmlX4t7a4z3alKcjn
         2oDuUtLQSPLaWdLNhf6tLw+u55lln6hI9kGahERddlADumJ7KFV5rpW4REzUp9CDAHHT
         e/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Bvq190uYRxwRpB0SDsOwrjOA2Tovqp3zJ8Noufja73c=;
        b=SKs3uZgqOjiSVznR7Ngc6f5o4UJq54pv3+zGyoK7N4XBdMykQHth+mto6g45jTmZ3q
         Qu3DOZWkK6ecDxApF0fw7ha8DN6KapmtWar6dPx2CSeu8S45GgB0ehhpDY/DkMj3qLLg
         tu2uskGnnvimFiz/RKY4Fdejl5aoHQP8MB8UMVMwpy2lA2b7AEozwr9REE/gKZhiHPWJ
         +/YzTyJ34DvCaKk9LiO8dCH8OEQa1HnznO8gb60APB2eTXQ74Caz9P9oirtVDkg8gzGW
         DUaX1jOHlj+C0RTiZ/GGEym0SH7Ln7rKLnloRuUZGgs5nFVbzff/qnS+X36mLuXe+i0u
         bJTw==
X-Gm-Message-State: ACgBeo1N/GqXb8PZMMRrbvxlFc2ghvzxnlDVYfv+oN5xbA4e+5LS2xvK
        j5skcIDSVr016IMn0KYbv2ZVVQ==
X-Google-Smtp-Source: AA6agR4noA+jGjLcQbcbdUm+DN2Q1tPxz2EM/wcktmFiqiv2dwFZBnRYzDtSOaOGVYxz3jakjaGk9A==
X-Received: by 2002:a17:90b:1c8e:b0:1f1:b5a8:330f with SMTP id oo14-20020a17090b1c8e00b001f1b5a8330fmr732906pjb.179.1659034563057;
        Thu, 28 Jul 2022 11:56:03 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id r17-20020aa79ed1000000b00528c26c84a3sm1138822pfq.64.2022.07.28.11.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 11:56:02 -0700 (PDT)
Date:   Thu, 28 Jul 2022 18:55:58 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dmytro Maluka <dmy@semihalf.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Eric Auger <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Rong L Liu <rong.l.liu@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Dmitry Torokhov <dtor@google.com>
Subject: Re: [PATCH 3/3] KVM: irqfd: Postpone resamplefd notify for oneshot
 interrupts
Message-ID: <YuLbvl7BBuLTBXO7@google.com>
References: <20220715155928.26362-1-dmy@semihalf.com>
 <20220715155928.26362-4-dmy@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715155928.26362-4-dmy@semihalf.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022, Dmytro Maluka wrote:
> +static void
> +irqfd_resampler_mask(struct kvm_irq_mask_notifier *kimn, bool masked)

Ugh, I see you're just following the existing "style" in this file.  Linus provided
a lengthy explanation of why this style is unwanted[*].  And this file is straight up
obnoxious, e.g. a large number of functions put the return type on a separate line
even though it would fit without any wrap.

My vote is to break from this file's style for this patch, and then do a follow-up
patch to fix all the existing funky wraps.

[*] https://lore.kernel.org/all/CAHk-=wjoLAYG446ZNHfg=GhjSY6nFmuB_wA8fYd5iLBNXjo9Bw@mail.gmail.com
