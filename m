Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2014590B8C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 07:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237011AbiHLFf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 01:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiHLFfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 01:35:48 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B6C74DFA
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 22:35:47 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 130so25484pfv.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 22:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=JGnD3l9t4SkK48ITST5G9Acthlp2sOgptI0b4WEHZr4=;
        b=HvbTScr18fV1zTYfyM7LcIPhZVpK4f8i4MOC2xIoldmIw9qLjWgrjvzmXHFyREPFLX
         eCr27APqcbRFW2lMknyaje3WlCld4GgahZYAFFkbHptL0JqXMhHG6hUXupvYk46RCJz+
         pPyKo6beBZFHgeXPLiElikFL23Pb7hnJwJETEA14sAbfm+ujtgCA/dqU8+keHRsk6yfE
         XqAUkSzwBdp5cgzlXAEgsS54VBKbZ5gX6MfnXb87d5OirO1Mm55DU+9twmgpMwgOLzIC
         vgW64hEsEHZFJ7BwKgjQByQp9/EY4gM2pImBDrSKw82tcswI8HaT/qwYnCvHujSOvibT
         oKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=JGnD3l9t4SkK48ITST5G9Acthlp2sOgptI0b4WEHZr4=;
        b=Aiq6IOBISBQAk1sKSdDib78gdbb41c5J/v7O59ccQ4zfqcYfQZAkvLFcmaIzy9H9c7
         jr/hGH0TZ1EnBMDBowi9vXaOevtksexslyN2RGe1WkBff/DsZq9hZ2nL731vaZJ+yDAB
         DrkGFvk/HlRPbGdBVAzzgoa7e1AZLg3kZLzREaje20sbVpbUEYz/zD13y2PiZz+PlkCr
         cbOsSUQIJwXD80v81+DuRt+lhLnSk6owyM9N6l/KKRXT8Y9RHYRjQcjEWbhKpMFaVeFv
         33O3d8s7y+NWvwpr9NCT9+Tu1T7V8V0kkNz+TMrmPACs/7JsEo6reuY4vijuqUSt+biw
         PQ9Q==
X-Gm-Message-State: ACgBeo0ktyaaLY3+7HWZm7WCNN40J1lrmpkPA+KWaV1VkPym0zgbKRDo
        kD+ARwSEuLiyqH1baUeOzvs7
X-Google-Smtp-Source: AA6agR6QKykT59/PsxCYm9H7RCEKDXN+emk2X2xl3Y+/vwPcq7Shj96oy/11FSIXJdyQo6aenYxg1g==
X-Received: by 2002:a05:6a00:1a49:b0:52d:4ad7:3bea with SMTP id h9-20020a056a001a4900b0052d4ad73beamr2168009pfv.66.1660282546657;
        Thu, 11 Aug 2022 22:35:46 -0700 (PDT)
Received: from thinkpad ([59.92.103.103])
        by smtp.gmail.com with ESMTPSA id d7-20020a170903230700b0016efc27ca98sm672477plh.169.2022.08.11.22.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 22:35:46 -0700 (PDT)
Date:   Fri, 12 Aug 2022 11:05:40 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Trilok Soni <quic_tsoni@quicinc.com>
Cc:     Borislav Petkov <bp@alien8.de>, bjorn.andersson@linaro.org,
        mchehab@kernel.org, james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix crash when using Qcom LLCC/EDAC drivers
Message-ID: <20220812053540.GA4956@thinkpad>
References: <20220811100924.79505-1-manivannan.sadhasivam@linaro.org>
 <YvTehUOIqJGqXgXY@zn.tnic>
 <YvTfqg0q/8kIMY91@zn.tnic>
 <20220811112032.GB29799@workstation>
 <YvTo8tE3DaHifrSp@zn.tnic>
 <20220811115334.GC29799@workstation>
 <20220811115711.GD29799@workstation>
 <343d1491-49a0-ea38-1b65-dc2bdfb4726d@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <343d1491-49a0-ea38-1b65-dc2bdfb4726d@quicinc.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 09:08:14AM -0700, Trilok Soni wrote:
> Hello Mani,
> 
> On 8/11/2022 4:57 AM, Manivannan Sadhasivam wrote:
> > Clipped the bouncing email addresses...
> > 
> > On Thu, Aug 11, 2022 at 05:23:34PM +0530, Manivannan Sadhasivam wrote:
> > > On Thu, Aug 11, 2022 at 01:33:06PM +0200, Borislav Petkov wrote:
> > > > On Thu, Aug 11, 2022 at 04:50:32PM +0530, Manivannan Sadhasivam wrote:
> > > > > I know get_maintainer.pl :) But the problem is, Qualcomm recently
> > > > > switched their email domain from codeaurora.org to quicinc.com.
> > > > 
> > > > Great:
> > > > 
> > > > $ git grep codeaurora.org MAINTAINERS | wc -l
> > > > 5
> > > > 
> > > 
> > > Yep! Most of the active developers have already changed their domains in
> > > MAINTAINERS file. But the left ones are either not actively maintained
> > > (yeah bad) or the maintainers have left Qualcomm.
> > > 
> > > > ;-\
> > > > 
> > > > > So even if I use the maintainers codeaurora domain now, they will
> > > > > bounce.
> > > > 
> > > > Hmm, so the mails I sent with codeaurora on Cc didn't bounce back - I
> > > > got only the quicinc bounces. That doesn't mean that codeaurora actually
> > > > gets delivered...
> > > > 
> > > 
> > > Not sure why. It was supposed to bounce. But could be that Qualcomm IT
> > > decided to not bounce anymore since they have got enough complaints from
> > > developers ;)
> > > 
> > 
> > Okay, seems to be bouncing for me:
> > 
> > The response from the remote server was:
> > 585 5.1.1 <ckadabi@codeaurora.org>: Recipient address rejected: undeliverable address: No such user here.
> > 585 5.1.1 <vnkgutta@codeaurora.org>: Recipient address rejected: undeliverable address: No such user here.
> 
> It is ok if someone from Linaro team becomes the maintainer for this driver.
> 

Thanks Trilok for the confirmation! I'll add myself as the maintainer.

Thanks,
Mani

> ---Trilok Soni

-- 
மணிவண்ணன் சதாசிவம்
