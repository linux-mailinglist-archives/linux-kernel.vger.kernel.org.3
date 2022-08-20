Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D45159AD9B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 13:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345304AbiHTLqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 07:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241192AbiHTLqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 07:46:44 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A3F9C2D8
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 04:46:43 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 73so5612343pgb.9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 04:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=59rOYkPYIN5vND2RHdpdK5DJi+/2g+av+qqSSDBCCnw=;
        b=OjHcQHpWoJKYiWkkbfcLWXVdj3+kRPw287FwB7lpv6aEZinWASIxNNKBbapiJXfIFJ
         H2JYaAd483oGU1YY1b8BLeFnLR6uV0QBlCcnpeZjhik1cnf0x6D2pj0DOAsl1oq4adYz
         2MW/+bzn8coCr3RhrGYWPuZp5vQlDXDtvDjL7LAPcSZfk+f/5cJc+rmkgJw/XIYpNDet
         QS+wci6hmhxBXr8f77akL1Pn/InELxozRqNvQs72S5wjsjYjZv+BfI11jRRvo8XiJP5s
         53rrl4gu6UbJ9ilY9D1m5Js0vpKI0Vr0bqElxLkn2tZdXBZMA3WWkDX/85GeqXo+2vME
         m74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=59rOYkPYIN5vND2RHdpdK5DJi+/2g+av+qqSSDBCCnw=;
        b=WdO+waN7XEwFDnPeZbqannfu1WepBM4PcEExJhtsVT22dXGvKnWt/n3iqhpEiFaLSW
         7xa9n4LRWVOuiRoCkWiyCjW7ky42DLsW2bhGJzvxwsGCB3Ls6RoQOzhLGwV6x2VrwAS/
         +6VkfJGPf/yHv5ZqR006IV0CwyngpfUs4p7xL292pBeKvgD4Y6tiUl8mwsgjxJvJw5h+
         dlMZurorphtPrcLZ/u/HXGYsh4Hf0f0ja3b8LYahit82vbYruueGbBSxND0qv7T5QoNp
         dsTaj1LXatMAACi0MVSIMImOIEvTJcc2UE7XexFD5OK+oxcFm9TC7JB2Q5dyFhFwI0Gh
         x0iQ==
X-Gm-Message-State: ACgBeo1SRR155UGTSOkYy16XsGRiefGYupVprj+nOYeGxCh+D+0/Nusp
        zch/qz5uguBsV2JqT4hHzG3k
X-Google-Smtp-Source: AA6agR43PtIofVC+YbgiSz3DSzmga1gvZh3tKV/nc2zsDcX2jdU9xpw0lyMHzZL7EQuz7t74s+Zttw==
X-Received: by 2002:a65:5bc5:0:b0:42a:b6:24c2 with SMTP id o5-20020a655bc5000000b0042a00b624c2mr9182792pgr.443.1660996003259;
        Sat, 20 Aug 2022 04:46:43 -0700 (PDT)
Received: from thinkpad ([220.158.158.232])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902e88600b0016bf803341asm1320728plg.146.2022.08.20.04.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 04:46:42 -0700 (PDT)
Date:   Sat, 20 Aug 2022 17:16:38 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     kishon@ti.com, lpieralisi@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mie@igel.co.jp, kw@linux.com
Subject: Re: [PATCH 1/5] misc: pci_endpoint_test: Remove unnecessary WARN_ON
Message-ID: <20220820114638.GA3151@thinkpad>
References: <20220819145018.35732-1-manivannan.sadhasivam@linaro.org>
 <20220819145018.35732-2-manivannan.sadhasivam@linaro.org>
 <Yv+rxuqUc+an6R3q@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yv+rxuqUc+an6R3q@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 05:27:02PM +0200, Greg KH wrote:
> On Fri, Aug 19, 2022 at 08:20:14PM +0530, Manivannan Sadhasivam wrote:
> > If unable to map test_reg_bar, then probe will fail with a dedicated
> > error message. So there is no real need of WARN_ON here.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/misc/pci_endpoint_test.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> Should this go to stable kernels?
> 

This is not a bug fix but a removal of unnecessary stacktrace, so I'm not sure
if this needs to be backported.

Thanks,
Mani

> thanks,
> 
> greg k-h

-- 
மணிவண்ணன் சதாசிவம்
