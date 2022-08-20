Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A516059AD9F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 13:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345679AbiHTLrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 07:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241192AbiHTLrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 07:47:39 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA1C9C2FA
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 04:47:38 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id g129so3111407pfb.8
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 04:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=L6UXJxoCT0v19DhLEd9TsvRlOgr8FYzGj2KGDNpjfZ8=;
        b=jjg4ixOlks/J+aPf3Z60I2jwuhhSVa+poGaIuc91x8AvkLAgE+yjQkpLZsLPFnsaWQ
         pMKCbI4FXETa+wQFCZJ3MIkRmqLPwvy1uVjpmS0FyzOGdA7rU/yZVIZ/F96KmFlYGVTQ
         vdsGTxtpHmOh7EG/0y+bNickD6bED+lmqifaMoLLlKvxnzTNl1KIp56hMNxOvX6C6Pee
         Y6Ivaf8qQo182m3jDZO0XtO3tdYXgK1MrjSKKpfKUJjb2EfK+gFBwClNBgd3O7BPOIdB
         HHJC5xby3impoRK/Z7zcQrxWzID4fLY8cqW0+IvgYsp39PGB7MS2D8av/1EltbgaBCB0
         I79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=L6UXJxoCT0v19DhLEd9TsvRlOgr8FYzGj2KGDNpjfZ8=;
        b=oszUJIVuDqD+8QAkjXB/6oMbQpD34N1Qwb4+VIrXv6RhOmo+E17xkZn504hJpdFz8Q
         n28nSlJQSnyXxIQ5mV433eNIC4LazrhQNy3YCFz2wgHiL2FB3RRo1t1fUHcRB+A+b578
         pruhdCc99W1VQsLzOCW2zkRreCpv+wYm4J41msgN6sFP86idj4ikbDr8CkrVQSyrtcmk
         wzrrB5KvMkVKFNYgeJrkCdypDP79zR5b46U+lZFUWuKdMn6N5WAEYPvpKA7JTwdlkh2W
         LMC4I/RwPlJbzJ1mYst3i6oY0VShHMoG841eMu2Q6UDZ1YE1TeTJ7VV4B+A45b+iEx7H
         Wtyw==
X-Gm-Message-State: ACgBeo2P/0LmlBXJZ6dBMYmxbrG2DRc2FsZBNNo5412aEQtEsHkv3Vzx
        2gMRCs8DT4UoqlKH/ekYPvhn
X-Google-Smtp-Source: AA6agR4xCnwIwX7dtv/jksc4rjG0eOA0qIO2qwAiKXS/IhIokh4qTj3NMH1sT5LaaAwE9G+NkZTlEQ==
X-Received: by 2002:a62:e804:0:b0:536:3d1a:1b33 with SMTP id c4-20020a62e804000000b005363d1a1b33mr4591912pfi.4.1660996057573;
        Sat, 20 Aug 2022 04:47:37 -0700 (PDT)
Received: from thinkpad ([220.158.158.232])
        by smtp.gmail.com with ESMTPSA id l15-20020a170903120f00b0016bb24f5d19sm4796984plh.209.2022.08.20.04.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 04:47:37 -0700 (PDT)
Date:   Sat, 20 Aug 2022 17:17:32 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     kishon@ti.com, lpieralisi@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mie@igel.co.jp, kw@linux.com
Subject: Re: [PATCH 3/5] tools: PCI: Fix parsing the return value of IOCTLs
Message-ID: <20220820114732.GB3151@thinkpad>
References: <20220819145018.35732-1-manivannan.sadhasivam@linaro.org>
 <20220819145018.35732-4-manivannan.sadhasivam@linaro.org>
 <Yv+r3BwBel8X/8gE@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yv+r3BwBel8X/8gE@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 05:27:24PM +0200, Greg KH wrote:
> On Fri, Aug 19, 2022 at 08:20:16PM +0530, Manivannan Sadhasivam wrote:
> > "pci_endpoint_test" driver now returns 0 for success and negative error
> > code for failure. So adapt to the change by reporting FAILURE if the
> > return value is < 0, and SUCCESS otherwise.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Fixes: tag and cc: stable?
> 

Okay, then the same needs to be done for pci_endpoint_test and Documentation.

Thanks,
Mani

> thanks,
> 
> greg k-h

-- 
மணிவண்ணன் சதாசிவம்
