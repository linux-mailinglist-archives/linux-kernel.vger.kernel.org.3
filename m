Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C800D4C3DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 06:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbiBYFXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 00:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237155AbiBYFXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 00:23:52 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C1B20DB0B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 21:23:13 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id b22so3856618pls.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 21:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7tLPU/x1xI7l7ftCBE2gBrH6yE5gXp2cEYUNop4zpLg=;
        b=QS8yYEdndXKOxvnN63x0H/ZetD3WcIX60MpRUTPQ033yOZHGQNpNO4ymFJYMHCxgBV
         dMePb6ata3IIKsTy7ErtMacy0wRyCgszG8b0ngHl64wYc6UhqZYA0Iv7gE/sWJqX8xPS
         tV25SOngLO6eX6cOvh5DQ4Mxpb/guUzN5+8fQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7tLPU/x1xI7l7ftCBE2gBrH6yE5gXp2cEYUNop4zpLg=;
        b=jBdX8PCVGI2f8u7xHt2YotHrx5QNrvca+3uN/QUWOnL3jf7afLum4QZ/KpA59d5eMC
         NHthBHK47HBm20Css9RbjbcP2OEA+TNOAQoj/rbmK7gQiC0lgobaF8XEswxS4VhaaO2j
         LY2cspAUcRYpAKFX0c07hYowtfPJ56nKQ30TP9kGsJ1WuI6q7iJ5y6zMZKdRLx/rHmDx
         /0Oo28SE41jcSeYOycYoGHn622kHmkNtvQ24K00sF6O1Qt16goePjDRr0v/DsFtYNhPp
         EE3cAxu7AxjJUY99ppYKc5VSuyUs9YueWa73LAXCMbb6xLXCzoF0hSBSobJLWkdYUlJc
         G5ww==
X-Gm-Message-State: AOAM532RLelVZblUUAZEiGYJ1I37FNWr1HRohdljRmnIYWTbYtwRk1wg
        K7MNEAFcuGue2JSwAkA1AVqoow==
X-Google-Smtp-Source: ABdhPJwbGPMPqXrlFPKcc9c8/xOjExMS8mUDhJw163P/02Kh4m+vjtJyd6NDQGtL0FMWAOIhuVyEfA==
X-Received: by 2002:a17:902:a982:b0:14f:f55:a09a with SMTP id bh2-20020a170902a98200b0014f0f55a09amr5749402plb.33.1645766593048;
        Thu, 24 Feb 2022 21:23:13 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:e94f:9f5e:13f6:a198])
        by smtp.gmail.com with ESMTPSA id 124-20020a620582000000b004dee0e77128sm1220444pff.166.2022.02.24.21.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 21:23:12 -0800 (PST)
Date:   Fri, 25 Feb 2022 14:23:07 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-kernel@vger.kernel.org, bhe@redhat.com,
        akpm@linux-foundation.org, anton@enomsg.org, ccross@android.com,
        dyoung@redhat.com, feng.tang@intel.com, john.ogness@linutronix.de,
        keescook@chromium.org, kernel@gpiccoli.net,
        kexec@lists.infradead.org, rostedt@goodmis.org,
        tony.luck@intel.com, vgoyal@redhat.com
Subject: Re: [PATCH V6] panic: Move panic_print before kmsg dumpers
Message-ID: <Yhhnu8K71Gz53aeO@google.com>
References: <20220214141308.841525-1-gpiccoli@igalia.com>
 <YhRFNKtxSE8Xrbfw@google.com>
 <7e15bc6a-ceae-aa3a-0a86-18d24181b0ed@igalia.com>
 <YhWNhzacAVDuFtwB@google.com>
 <YheXRmmWr619Qxin@alley>
 <YhhmnmgAlVCcVqSV@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhhmnmgAlVCcVqSV@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correction:

On (22/02/25 14:18), Sergey Senozhatsky wrote:
> > 
> > Or just split panic_printk_sys_info() into these two functions.
> 
> Agreed. I also tend to think that panic_printk_sys_info() is needed anyway,

							^^^^ split
