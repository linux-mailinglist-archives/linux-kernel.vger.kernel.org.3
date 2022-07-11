Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813995700FC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiGKLpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiGKLox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:44:53 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166AC1A1;
        Mon, 11 Jul 2022 04:41:33 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id v21so1684902plo.0;
        Mon, 11 Jul 2022 04:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XFN3Kyiudf896LabgETt2hdX1v48HrkVIcYMpIGJ6GU=;
        b=LLnwtfTzrW5Jxiby1mAMYGY6pje0/utXz7cGptyMG7FNOB7GPN0OXr1le5yB99IQgS
         jCWU/5f7iyBrEcrXRnhYllHkgwNGMV+MuAuFJNjj+CBwDhcl3Cs2AKPFCEFTPhIAvKXY
         XCKn36WHJFgSkr+Con5OEoj5DKA53TwHdEqPynJAtJz+TJ0/CeV81aqHPGtvdIgUjP2o
         hE3WvW/kDOrY0pDdoL3rJihXga6vswzbRj5uDHRho1M1pWAU8Ea0m1RsCasWU5NDfZx/
         cBSjr3HpOU8GBMMNSEJ2hESOPXES2qWR/OH9syYVMjprKBjVBgtJke2hcS1CvFPome8N
         BQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XFN3Kyiudf896LabgETt2hdX1v48HrkVIcYMpIGJ6GU=;
        b=QcpVIEV/63WsuHmoFfZF8oAILMFeUH1OYCc2RLc87UoVHIo3c/NSTAmNAMPDsieCOg
         92DuRtalupajLGsy4c2D235joZq2QpTO/9uGSfte7ENCcQNV3CkWnQIf3m54yNZHK7sA
         XgICM/+bCBUACFAlf5SEqHs02u3Ew3TjLpm/C0VjJKZL9R9cY8E3UGXoLyuvvLlFQxsY
         JTCH7RwGZQwKJ6XN3aaV7/MzdOm2l5JXAbsY4kq6/WZTvpFNPxDSx+MyxFehqt/9RT91
         clk8wMcE6J3eiYewG0dYKScQv0qHppYzP6JNuFiiaTX7lZoQdyM18LrgaqPK/uCB6iBW
         afRQ==
X-Gm-Message-State: AJIora/P1ay6cs41zuxgK2Qfy6JcHddq1YyecyrDPfkgK9ElD8lCzJec
        LtPGId1DDcWYEubnv0NQdqA=
X-Google-Smtp-Source: AGRyM1uFuNYMi8HbuR1ZPtyNiT+jzToYC5Qgwr1xGtqjrfJys4b0Zij24tlW9WkQBYXQtjfIBkEtAg==
X-Received: by 2002:a17:90b:4c0f:b0:1f0:3dba:bdb0 with SMTP id na15-20020a17090b4c0f00b001f03dbabdb0mr5209790pjb.6.1657539692273;
        Mon, 11 Jul 2022 04:41:32 -0700 (PDT)
Received: from paddy-ASUS-EXPERTBOOK-B1400CBA (61-216-65-192.hinet-ip.hinet.net. [61.216.65.192])
        by smtp.gmail.com with ESMTPSA id e7-20020a17090301c700b0016c4f006603sm1463359plh.54.2022.07.11.04.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 04:41:31 -0700 (PDT)
Date:   Mon, 11 Jul 2022 19:41:27 +0800
From:   PaddyKP Yao <ispaddy@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     PaddyKP_Yao@asus.com, Hans de Goede <hdegoede@redhat.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Corentin Chary <corentin.chary@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luke Jones <luke@ljones.dev>,
        Mark Gross <mgross@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: Add mic-mute LED classdev
 support
Message-ID: <YswMZ5Il+5yde3+f@paddy-ASUS-EXPERTBOOK-B1400CBA>
References: <HK0PR04MB33636680A6DC47211560BB43FA879@HK0PR04MB3363.apcprd04.prod.outlook.com>
 <20220711024718.1700067-1-PaddyKP_Yao@asus.com>
 <CAHp75Vfnt0DX9wnx0pKhit4JWCjBST+4caTjY6x6VYNdGjqn9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vfnt0DX9wnx0pKhit4JWCjBST+4caTjY6x6VYNdGjqn9Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<accidentally hit send to soon, trying again>

Hi,

Sorry for mistake about send two patch mail again...
After some try, I cannot remove legal message from asus mail.
I will use my gmail and send patch again.
And may I use author PaddyKP_Yao@asus.com instead of my gmail account?

Many thanks for your kind feedback.

On Mon, Jul 11, 2022 at 10:50:29AM +0200, Andy Shevchenko wrote:
> On Mon, Jul 11, 2022 at 4:47 AM <PaddyKP_Yao@asus.com> wrote:
> >
> > From: PaddyKP_Yao <PaddyKP_Yao@asus.com>
> 
> Besides we got two emails again of the same version...
> 
> > ===================================================================================================================================
> > This email and any attachments to it contain confidential information and are intended solely for the use of the individual to whom it is addressed.If you are not the intended recipient or receive it accidentally, please immediately notify the sender by e-mail and delete the message and any attachments from your computer system, and destroy all hard copies. If any, please be advised that any unauthorized disclosure, copying, distribution or any action taken or omitted in reliance on this, is illegal and prohibited. Furthermore, any views or opinions expressed are solely those of the author and do not represent those of ASUSTeK. Thank you for your cooperation.
> > ===================================================================================================================================
> 
> ...this is problematic and can't be used in open source projects. Ask
> your legal team how to deal with it.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
