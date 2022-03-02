Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485304C9FCD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240225AbiCBIuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240218AbiCBIuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:50:17 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96AE5C34E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:49:33 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id y5so683495wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 00:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SYfvCwb/W3WNk+L8cxBMzh00xT5wfH+9eEmldGfOgI8=;
        b=DYr6ubscevfBzbcdY+Y9vEBZXdqvU1A5XxM6fUGLF1mEO6KKzkqEn29Dfp8csk96S1
         /WmC2LDDWi+cMCk7SWUqsMTiv3Ry1Bq0MQ3mrYnCStTJ7MXqdj9kXF+EmJd8BSn5pX5g
         fU5wt6z0wUNZZ35dLueFaGEU5az84yyQsFFJBDVUKvGgY0w3Vm9SlXfPKAyg9HGPRXvw
         tMpMXNCXWg+KNFa047heYu8i3Vl07PvJ5MKc00Ze+wDkQ5D+Gw7/lFulUwFT10iEVQ+v
         HdK7VgMwdff2FLC2w4Z9l0wlzRwbI0t8FrNhGvOKgEXE08SvhSMu4peaKCaLdNXDxqKG
         pZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SYfvCwb/W3WNk+L8cxBMzh00xT5wfH+9eEmldGfOgI8=;
        b=wjl1vxIBkOSwNgGmdVHNSfqzSglkTvHZOkXEgWW5WTga1KAM0lMxbFd6atBMjbsRp1
         6mdTg/paQGrQBSudDioaPu3Xq2KuZjtxf03bCx557ZTVZg7UtvrEMd4wucM4Qz7U7dv4
         7i5EDath+A8CefESnuSxRGrL+Bwnnc5XQsb6q78RBaJ++v6TTnMiRBw/RfUtKUX3dgqe
         D2bCMPBlXXGKl8+vPLn20zL6R6hMnuoCZ3askNpWqLHkdHh57EZfDcEDx1Ne2ut9mGII
         OuaboC6bGX0nuKLhYPbLRjYD0E8l82aqtlwFJtm3+wiAENEotH1vKrZs1t/axOuMptj7
         OCmw==
X-Gm-Message-State: AOAM533SWzzxu0SoCn7mP+DDCT10ySMiGmvrLGQBpFn8x304h6+7+wwm
        3D+julPgsn9JE+WB3tDLmueDTZusNCQkjDC8
X-Google-Smtp-Source: ABdhPJxTl9Qootm9SKZ4yKKoOvXTgf5Y4iGxV9pCsD/8iYqSo/nBkR8s0sch9TfhEXHnUlSTHwRN3A==
X-Received: by 2002:a7b:c5d6:0:b0:381:4127:84d3 with SMTP id n22-20020a7bc5d6000000b00381412784d3mr17613363wmk.24.1646210972309;
        Wed, 02 Mar 2022 00:49:32 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id 10-20020adf808a000000b001edd413a952sm16055534wrl.95.2022.03.02.00.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 00:49:31 -0800 (PST)
Date:   Wed, 2 Mar 2022 08:49:29 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <alistair@alistair23.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Robert Marko <robert.marko@sartura.hr>
Subject: Re: linux-next: manual merge of the char-misc tree with the mfd tree
Message-ID: <Yh8vmWeW+sPz0DdD@google.com>
References: <20220228193928.3ec6ee98@canb.auug.org.au>
 <YhyPfcjJtIKNQtF8@google.com>
 <Yhyn72NO/roH1gA8@kroah.com>
 <YhzENKPtY+WOp566@google.com>
 <Yh09/r/nT2LeE82n@kroah.com>
 <Yh3pZXQPP9kmcSSx@google.com>
 <Yh325S5PyPiJf4F5@kroah.com>
 <Yh37gTCPaESkgNzV@google.com>
 <Yh6N4mWCfHtlBM07@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yh6N4mWCfHtlBM07@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Mar 2022, Greg KH wrote:
> > > How do you want to see this merged?
> > 
> > The plan is for the whole set to be merged together via MFD.
> > 
> > All of the other maintainers have now Acked, so it's ready to go:
> > 
> >   https://lore.kernel.org/all/20220131133049.77780-1-robert.marko@sartura.hr/
> > 
> > Looking at the diff, I'm not entirely sure why you took it in the
> > first place?
> 
> As I mentioned above, someone else asked me to as it was sitting around
> for quite a while with no movement.

Okay, just went to investigate.

The set hasn't been merged because it is missing a DT Ack from Rob.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
