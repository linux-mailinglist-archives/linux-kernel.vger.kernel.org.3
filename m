Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7307A58FB2F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 13:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbiHKLUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 07:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbiHKLUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 07:20:40 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFB4D4D
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 04:20:38 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id s5-20020a17090a13c500b001f4da9ffe5fso5026815pjf.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 04:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=u6elEvtkgatUwtnESJJKM95epGfhjgSWF6jAcnT9ZmQ=;
        b=zCeTC9Qk6YtrncbxP867FmhE0JvuJ+J5tsywHyMOr995OFng+nTmV7UsvrwgfS/EgA
         IV3FHMdxTGcPxe5Xtu42ZE7P9S4qkkUkox4zpEx//ym1cSAV6NNs220Jhk2DewBpLwyY
         6w/TIrDhyLY01D8bXHUa/uCJVQheyhLQIxVw5Jxs7gUR6z6QqBEqJBXEu0g0N6khGKmH
         4NlnKr/t7UjnIHh4Z/6rNFrkVX+xTHVVaBEt/2Mj5+R/7kWVQU6oAETiZ82HTrPyMwgw
         /RgWLc4+V3xhecLFzD7R9ltShCInEFj8FcHz8PMQ9l/AxqH6MmQAZeSlJbtnBX0z/ryc
         WXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=u6elEvtkgatUwtnESJJKM95epGfhjgSWF6jAcnT9ZmQ=;
        b=E0wEWaIgzmjEFoCTPvpQihtFXID+wBm+Ey+s79asSpJ2/RuIPdRCupD6A53PYs/AKt
         dmRG2dj0hjPheHgHG+QhPRlbLeY9K3ZXfltpHp5DlyPTMXyaoz39k9gPi4/j4LmFUqNu
         CbFamkc/QO5nXwbNkbVfE2gtu+bXY/8UvV6qLnT7UPEmaQhmNwOz0xGTNqyO6rOv+M6W
         LHvWf5GDGipZM983OmQlS+PL+2BPcCFmsyzw4jrCZ4sCzNU4CWrebvO9BjKEkM3i1luE
         XCE5V+9w1LD8WZKir0P3DaQNiwtZe9+di/7YvwZxQ4RUGuG58c7NxRKq7tAw/PCkEkvb
         T2zQ==
X-Gm-Message-State: ACgBeo0DPUTdwceXXyFauvbLYP0bYZiQOawqrAA1Jydn6pUnk50fJJYK
        pvmtMp6m0kU2d+9Kf++wrwmF
X-Google-Smtp-Source: AA6agR6AyXO9Lr2YhZLJ66w/x5GWppUjfm7EoSN0EM2wGmVftF6kmQyRZ7heALd6pIdi0l7ff5epTQ==
X-Received: by 2002:a17:902:b481:b0:170:a33d:7bde with SMTP id y1-20020a170902b48100b00170a33d7bdemr19323675plr.6.1660216837517;
        Thu, 11 Aug 2022 04:20:37 -0700 (PDT)
Received: from workstation ([59.92.103.103])
        by smtp.gmail.com with ESMTPSA id n184-20020a6227c1000000b0052c87380aebsm3800101pfn.1.2022.08.11.04.20.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Aug 2022 04:20:37 -0700 (PDT)
Date:   Thu, 11 Aug 2022 16:50:32 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     bjorn.andersson@linaro.org, ckadabi@quicinc.com,
        vnkgutta@quicinc.com, mchehab@kernel.org, james.morse@arm.com,
        rric@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Channagoud Kadabi <ckadabi@codeaurora.org>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Subject: Re: [PATCH 0/2] Fix crash when using Qcom LLCC/EDAC drivers
Message-ID: <20220811112032.GB29799@workstation>
References: <20220811100924.79505-1-manivannan.sadhasivam@linaro.org>
 <YvTehUOIqJGqXgXY@zn.tnic>
 <YvTfqg0q/8kIMY91@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvTfqg0q/8kIMY91@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 12:53:30PM +0200, Borislav Petkov wrote:
> On Thu, Aug 11, 2022 at 12:48:37PM +0200, Borislav Petkov wrote:
> > On Thu, Aug 11, 2022 at 03:39:22PM +0530, Manivannan Sadhasivam wrote:
> > > Hello,
> > > 
> > > This series fixes the crash seen on the Qualcomm SM8450 chipset with the
> > > LLCC/EDAC drivers. The problem was due to the Qcom EDAC driver using the
> > > fixed LLCC register offsets for detecting the LLCC errors.
> > 
> > I see you've CCed the QCOM maintainers using different email addresses:
> > 
> > $ ./scripts/get_maintainer.pl -f drivers/edac/qcom_edac.c
> > Channagoud Kadabi <ckadabi@codeaurora.org> (maintainer:EDAC-QCOM)
> > Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org> (maintainer:EDAC-QCOM)
> > 
> > Does MAINTAINERS need updating?
> 
> No, it doesn't. The email addresses you used, bounce:
> 
> Delivery has failed to these recipients or groups:
> 
> vnkgutta@quicinc.com<mailto:vnkgutta@quicinc.com>
> The email address you entered couldn't be found. Please check the recipient's email address and try to resend the message. If the problem continues,
> +please contact your email admin.
> 
> 
> ckadabi@quicinc.com<mailto:ckadabi@quicinc.com>
> The email address you entered couldn't be found. Please check the recipient's email address and try to resend the message. If the problem continues,
> +please contact your email admin.
> 
> In the future, when you wonder who to Cc and how,
> 
> scripts/get_maintainer.pl
> 
> is your friend.
> 

I know get_maintainer.pl :) But the problem is, Qualcomm recently
switched their email domain from codeaurora.org to quicinc.com. So even
if I use the maintainers codeaurora domain now, they will bounce.

For that reason, I used their quicinc domain addresses. But since they
are bouncing, it looks like the maintainers left Qualcomm :/

Thanks,
Mani

> HTH.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
