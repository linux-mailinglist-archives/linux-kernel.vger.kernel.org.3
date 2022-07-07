Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4BC569E39
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbiGGJAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiGGJAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:00:13 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290E0266B;
        Thu,  7 Jul 2022 02:00:12 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id w185so14377641pfb.4;
        Thu, 07 Jul 2022 02:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qia7K7oXMVoh++cPl/L18hRITa83j7MGb2ebBNSvcKk=;
        b=qRrDuIpdE/Ta4sjVTzdZDHOsikCs7bP/WvW9c8CAbFe6pSSvzH+eBG2Qy508UAHwI6
         fAS6CssqGhiC/5iuu1cbyA0s1pc0XRWqx3BE7lAqBkWu6FHUHXe7GOQ3eKBDUf4+5nFV
         RnWePmC/UR+IlMZ3xY1VuANZDCe94+lLpPlFdQnQDerwdqbX5J8JLBI9XR7bvrxXm0bj
         Th8qgk6sWyYckErKtlecNLW04NfJYcTPrGoHDlcuv/tA318z4F7+UKUWgTLPbTqFg9a1
         XDdyYLFQLwXTU6n39RdOsv8YHR+qTuZkhnX0f/SMcn61JQ8xTcBwjzPR+NAP/lCpJIHG
         oXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qia7K7oXMVoh++cPl/L18hRITa83j7MGb2ebBNSvcKk=;
        b=OmkEWCkSF2yLzWsBGhtRiGYN5OJqS/g2dkIZvFmhA0xZWsKokhHWf1zxvNCsTOU14S
         P1ibsegPWLGAFuN4BKB+5CfZMHlXA4jRwdr2dEGasajX02r+HKcO/qpjkZF/rqY8prkW
         Vje1aIYJts9YeV7M8O74pfxgPPRWAup1mFIp7yIqzag2rE9v68USQtIRxVrHYvINCS/C
         XDdywyZdI/e4qUxJCJrltmym/hvhswbZiifvFHAUMdkaPmV0hyyjlBZ4FMJYDFVGaPJL
         YFZU5WfzyByyFJ4gvEzc0m1jx/gxYND8y2ZTGPv4uaFv81oLwfM2ZBmpxIB+KxlNsYlP
         5f4A==
X-Gm-Message-State: AJIora9CgOHGRvx2UFidk3KMAFMjLk94GCZRGWZrvDUPBvXwBTJg6AjR
        PWNp3NSW5aoKn6tlbjpahTA6Pz7JLbk=
X-Google-Smtp-Source: AGRyM1vpXdl/O2jwldng7mE8O/8bCID951M7KXbbDEebc7RbmiWCQ3P3g8R0mmjRXKJXsTQ6sK25+w==
X-Received: by 2002:a05:6a00:80d:b0:525:520a:1736 with SMTP id m13-20020a056a00080d00b00525520a1736mr50798742pfk.36.1657184411294;
        Thu, 07 Jul 2022 02:00:11 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id n4-20020a170903110400b0016bef4a9dadsm6156874plh.77.2022.07.07.02.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 02:00:10 -0700 (PDT)
Date:   Thu, 7 Jul 2022 17:00:06 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org
Subject: Re: [PATCH] gpiolib: cdev: fix null pointer dereference in
 linereq_free()
Message-ID: <20220707090006.GB57165@sol>
References: <20220706084507.2259415-1-warthog618@gmail.com>
 <20220706085025.GA2259579@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706085025.GA2259579@sol>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 04:50:25PM +0800, Kent Gibson wrote:
> On Wed, Jul 06, 2022 at 04:45:07PM +0800, Kent Gibson wrote:
> > This patch fixes a kernel NULL pointer dereference that is reported by
> > gpio kselftests.
> > 
> 
> Should be:
> 
> Fix a kernel NULL pointer dereference reported by gpio kselftests.
> 
> Sorry - I rushed this one a bit.
> 

And I might not've been totally clear, but this bug is present in
v5.19-rc1 onwards (when HTE was added), up to and including rc5.

Would be good to get it fixed before v5.19 goes out the door.

Cheers,
Kent.
