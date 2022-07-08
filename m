Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAF556BECD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238555AbiGHRYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 13:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238368AbiGHRYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 13:24:40 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D992CE12
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 10:24:39 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g126so9624067pfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 10:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=taVVHXZCysabggYX/eGgapEaTg3NQMt2ZeKA+oMMy3I=;
        b=fAsZ5jvViNUtezuqqF/z3RUkuZym6HT9+JtV717t7DrssVArf5OD/Aba6siyG1lU2c
         z1OwtcMqrVSBNFfSJuXAyEwJm130MgYj1M0DY4MYc9502a3dPlkTzuo6nTSf2B6l6XBF
         YZXIsOrknhQWIGuCJn16nbTPwkRjnHhxml+TE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=taVVHXZCysabggYX/eGgapEaTg3NQMt2ZeKA+oMMy3I=;
        b=waBQMwfr5ihdHlD+Yybi4zo5Xo8IsKSO163vxFJvQqbTxgWBLfrT1QuMNekem9G5bF
         eKTIGnWfHZSopqu4ZKkCdtoLwfrkXybdL8Oom9YXGGWo+pdPeaAD9ep2+ka214roTt9Y
         j2lJiq9hi8KlHIU+zYf+jdpYbqboUzlfZ2foxXdfG7pTAPrB7cXxEhEFl6hpai/3Ydm5
         lOuSHORvLeTqwTVApDks72FHkMdpGH6efXuQGy9FBL60hHTXfuJsPiAZzI2SBFBQGuWF
         Yeq1EbgnnjYRU3LpnpJxL0to/NFd3vWDyQgVcVG3WJ8thSMgJhnflaBIe6wVF1v1TdDE
         RrHw==
X-Gm-Message-State: AJIora+5ByAzfmOSpz3jvr1L0MlrqwTqhnTTpPK7pH/+CycnFRcNZwF7
        p20SK9/CHSoIHvRr8LBOLQNrNQ==
X-Google-Smtp-Source: AGRyM1uoKaCiZv0+fpTWPpuM9ND4xOyr/blnINkpSw7fBsHkFaVi9rFyGkmQDAjwDg53Z8zzxFe+YQ==
X-Received: by 2002:a63:5111:0:b0:411:83dc:d48b with SMTP id f17-20020a635111000000b0041183dcd48bmr4229310pgb.266.1657301078745;
        Fri, 08 Jul 2022 10:24:38 -0700 (PDT)
Received: from chromium.org (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id t24-20020aa79478000000b00528c149fe97sm5050650pfq.89.2022.07.08.10.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 10:24:38 -0700 (PDT)
Date:   Fri, 8 Jul 2022 17:24:36 +0000
From:   Prashant Malani <pmalani@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        chrome-platform@lists.linux.dev, bleung@chromium.org,
        heikki.krogerus@linux.intel.com,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [PATCH v3 1/9] usb: typec: Add support for retimers
Message-ID: <YshoVFnUafCXObxb@chromium.org>
References: <20220707222045.1415417-1-pmalani@chromium.org>
 <20220707222045.1415417-2-pmalani@chromium.org>
 <YsglSJvB/bvwSGZ2@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsglSJvB/bvwSGZ2@kroah.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Jul 08 14:38, Greg Kroah-Hartman wrote:
> On Thu, Jul 07, 2022 at 10:20:08PM +0000, Prashant Malani wrote:
> > Introduce a retimer device class and associated functions that register
> > and use retimer "switch" devices. These operate in a manner similar to
> > the "mode-switch" and help configure retimers that exist between the
> > Type-C connector and host controller(s).
> > 
> > Type C ports can be linked to retimers using firmware node device
> > references (again, in a manner similar to "mode-switch").
> > 
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> 
> As you are adding things to sysfs, do you need to add any
> Documentation/ABI/ entries as well?  I can't see any new sysfs files
> being created here, but explicitly saying so in the changelog here would
> be good.

There are no new sysfs files being created (there is the new retimer
class directory, but there are no class-specific files being created
there).

I will send out a v4 which calls this out in the changelog.

Best regards,

-Prashant
