Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3B6589A13
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiHDJqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiHDJql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:46:41 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B569B248CD
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 02:46:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id tl27so18025587ejc.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 02:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a1sj3keWWECHG9q5wjH5xmyLByOGTE53nodjSfqoRDk=;
        b=a99aSjNgG2uxR9nNtLTkMElTztLf+EKIRREEyIpWszbotB/JO5KqyburT/8NQvdMuA
         GC6052FsDG1j73dTnWFdIgQm0Xo7YQPgd9oc4VQzXa3+Dp6QXrKJPyyzNht5eYThiYTl
         gO8ECz21Khh0uy5d502U05EswBUBEIrwr5pQ8RhBAJ5Kq7CIzMEjgnDsEHLyuuOHoOXs
         bbDmZxPSbRFtFeEtpe8DlMvFK7BGzA817cp78G45HTWVkM7EIwBqRoxrrfYXk8uIiQ5h
         +qQF6mPbEhIhdGdfANlKtMtynUnQX5RM+HGGyWBF8qMgZ8KBWQaD/9DqKvOQjhXwlICU
         82fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=a1sj3keWWECHG9q5wjH5xmyLByOGTE53nodjSfqoRDk=;
        b=45BHpknfHVsayfgA9TGwm+ESPcPZGTXKvZe5HVbgWT3N9xAu0IF4ejI6U+e2+7m/cT
         idQpv4I/j+ngpZ8KZRVF5wUUI/ap7InWP4mRHuDSBGdukCKFVpUFUpY8mCoDshZsVekU
         LmrRZ/k5OQHIduNBkslKKOED2xVPloYY2GIluJlZ7tlpxR+dP7e4fQchDjXuMCPDhH/G
         YnH50iEmZdGgSZ/T55LaeHJFS2N7Kdib84afkg/bKQLVcmJos21g5n0GIOzLtInMQiWJ
         Y4EpkKekm9p4I/D5cunpfOnBDENVzq3UPD6C2EWLghRDAlqsas2oS5+0RkGI6aDKZ4hx
         J+KQ==
X-Gm-Message-State: ACgBeo2aTqRna0sAuNyZCpozu+LjoKePtyfL9hkVI/+kbU79aHVS+two
        O+sQmgAS4YrFdWYZ82f4R5w=
X-Google-Smtp-Source: AA6agR4EyiOTKbTWGzkAljZYLv5p3a+wKGD5H5SEgqhLsnGjhHb4HPQaVPGeQMj1NAPM3h6HJdW6kw==
X-Received: by 2002:a17:906:5d16:b0:72f:248d:525a with SMTP id g22-20020a1709065d1600b0072f248d525amr830878ejt.441.1659606398348;
        Thu, 04 Aug 2022 02:46:38 -0700 (PDT)
Received: from gmail.com (195-38-112-141.pool.digikabel.hu. [195.38.112.141])
        by smtp.gmail.com with ESMTPSA id r25-20020a056402019900b0043a7c24a669sm387143edv.91.2022.08.04.02.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 02:46:37 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 4 Aug 2022 11:46:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Bharata B Rao <bharata@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        dave.hansen@linux.intel.com, nikunj@amd.com, hpa@zytor.com,
        Abraham.Shaju@amd.com
Subject: Re: [RFC FIX PATCH] x86/e820: Stop kernel boot when RAM resource
 reservation fails
Message-ID: <YuuVezQMK/ytzMTe@gmail.com>
References: <20220718085815.1943-1-bharata@amd.com>
 <E7A3FF43-C49F-415E-81C6-CD14F4107349@alien8.de>
 <be498c32-bed6-d31a-ae94-6006dd59ea1e@amd.com>
 <YtV3Ipvt96X/iO2J@zn.tnic>
 <24ccd22f-6708-3265-4012-66f01108ff22@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24ccd22f-6708-3265-4012-66f01108ff22@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Bharata B Rao <bharata@amd.com> wrote:

> On 7/18/2022 8:37 PM, Borislav Petkov wrote:
> > 
> > I betcha you can generate a lot of "kernel bugs" with weird qemu
> > options. If it is not a real use case, nobody cares.
> 
> I see that we will hit this problem by default when starting
> a guest with 1T or more memory using QEMU.
> 
> > 
> > And even if it were a real use case, panicking the machine is not the
> > right fix.
> 
> I couldn't see a clean exit/recovery option in 
> setup_arch()->e820__reserve_resources() where this happens. Any 
> suggestions?

I'd emit a low impact, non-fatal WARN()ing to make sure users aren't silent 
victims of an easily detectable firmware (Qemu) misconfiguration.

Thanks,

	Ingo
