Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB404BF4F3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiBVJre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiBVJrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:47:32 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B9E8BE33;
        Tue, 22 Feb 2022 01:47:07 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h6so31943507wrb.9;
        Tue, 22 Feb 2022 01:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BmCM771/H8fMGA2TM9vIMuFjbF0aY9kc+ryD8RCZwDs=;
        b=idzQPKZoLATAZxfyuZGOcDY/2sUODvMOnd/QV1CEQCDccF+PWPrqBdSJUbkutKn6uq
         Lzp/jKHgQ6uQXsauKGJ2KAztiFzZ8Fj6mQ8lwRKK/oRT5BpMwabXVRzhKN1dxscDWNNw
         6R7+qhb78rincI66EA87GH3lUlbKWdm/gddbv385b+2n8uXNbk0ZBRWf89UqfwMJJbAD
         cH13YFUDCxt9gYdAvmiR5cJgEeQjPwoYsEDSHA4SdHGigQShR5b4qHOhGrR+fMVDkbFN
         F9W1M/atDfXtUuu4X5VwAJiKOe8nd0SXdTiMZmlpuj5n9fT4Y7O7kYqlLIrLEuIyez3f
         Y2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BmCM771/H8fMGA2TM9vIMuFjbF0aY9kc+ryD8RCZwDs=;
        b=E9qyPCB4zifrNujkwkft5jus8lrw8HA7hZTN0yX6q16+ZwpoA3QuF4pEeQkemvF0fk
         ZNs2LZof0Yzklvfa6HGyBkEm1HF1+5m+oT101J85CpxAEqDrHh3BaSNSROOl0ee6nzgn
         YWioVkKW+s7d+LoVlijWoEe4PXHGveQwiwkYnbEzHlqtzjiDq7C2iKkoN/XvWpnHQNJH
         82dk9VhyjRFgII46eEwRQ/xanGXCLHYzb7YC7a/h3UmXzH5/I7XlEECmJKGwk+GJ+Oxv
         bXMFutEyHeLs/Tp2+GBwyzwbf8+23RKBPnSAbztG9USGu3YBBvVQGhOXfRmVsC27fCZy
         iTmQ==
X-Gm-Message-State: AOAM532JtjfhOtvO+hmSrxPAa39oEuL4qLSYrc2P53ONOsqhhwbZ1K+N
        vrZ08hSMSl2oB2oHGfokUyCDXmpX+FY=
X-Google-Smtp-Source: ABdhPJxK24rkLm2wkZV8z8R7xDAF5lTZl8sNGmPovb/9HW2VOQ3JIudeOlcRuv9J+GZ49zKqu/oa4A==
X-Received: by 2002:a5d:5888:0:b0:1ea:118f:4a82 with SMTP id n8-20020a5d5888000000b001ea118f4a82mr8365095wrf.502.1645523226065;
        Tue, 22 Feb 2022 01:47:06 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id x17sm43745672wrv.107.2022.02.22.01.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 01:47:05 -0800 (PST)
Date:   Tue, 22 Feb 2022 10:47:03 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Harsha Harsha <harshah@xilinx.com>
Cc:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Michal Simek <michals@xilinx.com>,
        Sarat Chand Savitala <saratcha@xilinx.com>,
        Harsh Jain <harshj@xilinx.com>, git <git@xilinx.com>
Subject: Re: [PATCH V2 2/4] firmware: xilinx: Add ZynqMP SHA API for SHA3
 functionality
Message-ID: <YhSxF5nDzwsY9BFS@Red>
References: <1645125264-11033-1-git-send-email-harsha.harsha@xilinx.com>
 <1645125264-11033-3-git-send-email-harsha.harsha@xilinx.com>
 <Yg9qOrjJuttVSetN@Red>
 <SJ0PR02MB7279894629DCA2758355A9D2DE3A9@SJ0PR02MB7279.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ0PR02MB7279894629DCA2758355A9D2DE3A9@SJ0PR02MB7279.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Feb 21, 2022 at 12:17:02PM +0000, Harsha Harsha a écrit :
> 
> 
> > -----Original Message-----
> > From: Corentin Labbe <clabbe.montjoie@gmail.com>
> > Sent: Friday, February 18, 2022 3:13 PM
> > To: Harsha Harsha <harshah@xilinx.com>
> > Cc: herbert@gondor.apana.org.au; davem@davemloft.net; linux-crypto@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; Michal Simek <michals@xilinx.com>; Sarat Chand Savitala <saratcha@xilinx.com>; Harsh Jain
> > <harshj@xilinx.com>; git <git@xilinx.com>
> > Subject: Re: [PATCH V2 2/4] firmware: xilinx: Add ZynqMP SHA API for SHA3 functionality
> > 
> > Le Fri, Feb 18, 2022 at 12:44:22AM +0530, Harsha a écrit :
> > > This patch adds zynqmp_pm_sha_hash API in the ZynqMP firmware to compute
> > > SHA3 hash of given data.
> > >
> > > Signed-off-by: Harsha <harsha.harsha@xilinx.com>
> > > Acked-by: Michal Simek <michal.simek@xilinx.com>
> > > ---
> > 
> > Hello
> > 
> > Your signed-off should contain your real name.
> 
> My complete name is Harsha which I have mentioned in the signed-off section.

I am sorry, I believed it was your pseudo. If it is your real name, no change are needed.

> 
> > Furthermore why did you drop copyright from previous poster ?
> > See https://patchwork.kernel.org/project/linux-crypto/cover/1556793282-17346-1-git-send-email-kalyani.akula@xilinx.com/ for
> > reference.
> 
> I did not understand the comment. Do you want me to add Kalyani's name also in the Signed of section?
> 
> > 
> > Furthermore, the previous poster didnt answered my questions about parallel processing and tests.
> 
> Since SHA3 HW engine in ZynqMPSoC does not support parallel processing of 2 hash requests, so we have changed our approach. 
> Now  to support parallel processing of 2 hash requests, software fallback is being used for init, update, final, export and import in the ZynqMP SHA driver.
> For digest, the calculation of SHA3 hash is done by the hardened SHA3 accelerator in Xilinx ZynqMP SoC.
> 

I asked for parallel processing since I didnt see any locking or way to prevent hardware to be used in the same time.
But the final work is done by a firmware call, so my knowledge stop here.

> Following tests have been done for the driver:
> - Enabled kernel self tests and extra run-time crypto self tests
> - Tested SHA hash computation for different sizes of data using userspace application
> - Tested SHA hash computation using multiple updates of data using userspace application
> - Tested parallel hash computation
> - Tested using the tcrypt module
> 

This should be in the cover letter.

Regards
