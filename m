Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23BB58FBA8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 13:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbiHKLxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 07:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbiHKLxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 07:53:45 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEAC96754
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 04:53:40 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id x23so16726834pll.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 04:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=928+0dNDnh9BrVH3Kb7MNns7s4CSLu2U2eONjpKru7c=;
        b=etOIlPa3txUXt0w93XsVdkaKQ0zIq0uYs2u2YmMzAtwspOTI4S7kncz6FvCDV6ctTL
         kYkJSpDhP1oJpKJNQWtlbK5B1TAigfqLEDEOG3RS7a6xLh4DsOZwpWuOn8ISr7fdatcy
         POi75YyoeGo9HL7JFohqNWt0Sg0hdNSLME+11kAZl6kzEAU5nENSCe9tAvevqs3sK6OZ
         EA0Ja9CEuC9y4tmbKV64E3iBXLW/JbuFp40jUD/a0XEC6cX9lOaZWEJKbUhMMfb+DUXI
         uo9OxJW7g8xGg1MRp/KMh6CfoPBTbJPc51V0YO8zMlWUcGurKwhm/LqrZaeYywjJAFsv
         yk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=928+0dNDnh9BrVH3Kb7MNns7s4CSLu2U2eONjpKru7c=;
        b=D3JwB+8TgXvDN8wBJLu+6v9s7Nuxx2SnMiwotSZ2baaxNw+RAGYhhwigb4mMwp3qEA
         hEDwiK9CTDxwCMs08CYAK0JNErws+797Lab1kWwy+i7r+lHZeSZ0Y9MkmNlYjJAvmxYZ
         F1CZFjazN9H/mKZjFBASacul/KQfqKFMwTDw5ke2eG50LeblNWwSWGw7vNYC/PDqKO6i
         OrTJL3RlxK8M+cpKdZDpFSdG/5ZhGhGULbTRLXCsaGlgNtF4lGJY8MAm3eLOh0I1Cb9L
         N01EHrtpqgUkH0ZSp5pnLMhhWpvPGsPACSKsHCpVAvuNbF22Qv1G7bCtNVdQw6lfQGko
         hqLw==
X-Gm-Message-State: ACgBeo2i3j7dB7Kb81jYg8oq2h0GL/A+n+3SC8pgV/Gib0RKCVBvZCAb
        Q7bxYNW1t2RRQ8GainAhkK2w
X-Google-Smtp-Source: AA6agR5oH0nx5NKeq3WJX0XIbNZE4NOyyNW1VRoAhKXB1IqLE5TkOZL8BApTG3/jYzX7DwFcopJwiw==
X-Received: by 2002:a17:90b:3892:b0:1f5:8be1:d8a0 with SMTP id mu18-20020a17090b389200b001f58be1d8a0mr8471979pjb.162.1660218820209;
        Thu, 11 Aug 2022 04:53:40 -0700 (PDT)
Received: from workstation ([59.92.103.103])
        by smtp.gmail.com with ESMTPSA id g12-20020a17090a4b0c00b001f4d711e165sm3456307pjh.11.2022.08.11.04.53.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Aug 2022 04:53:39 -0700 (PDT)
Date:   Thu, 11 Aug 2022 17:23:34 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     bjorn.andersson@linaro.org, ckadabi@quicinc.com,
        vnkgutta@quicinc.com, mchehab@kernel.org, james.morse@arm.com,
        rric@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Channagoud Kadabi <ckadabi@codeaurora.org>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Subject: Re: [PATCH 0/2] Fix crash when using Qcom LLCC/EDAC drivers
Message-ID: <20220811115334.GC29799@workstation>
References: <20220811100924.79505-1-manivannan.sadhasivam@linaro.org>
 <YvTehUOIqJGqXgXY@zn.tnic>
 <YvTfqg0q/8kIMY91@zn.tnic>
 <20220811112032.GB29799@workstation>
 <YvTo8tE3DaHifrSp@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvTo8tE3DaHifrSp@zn.tnic>
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

On Thu, Aug 11, 2022 at 01:33:06PM +0200, Borislav Petkov wrote:
> On Thu, Aug 11, 2022 at 04:50:32PM +0530, Manivannan Sadhasivam wrote:
> > I know get_maintainer.pl :) But the problem is, Qualcomm recently
> > switched their email domain from codeaurora.org to quicinc.com.
> 
> Great:
> 
> $ git grep codeaurora.org MAINTAINERS | wc -l
> 5
> 

Yep! Most of the active developers have already changed their domains in
MAINTAINERS file. But the left ones are either not actively maintained
(yeah bad) or the maintainers have left Qualcomm.

> ;-\
> 
> > So even if I use the maintainers codeaurora domain now, they will
> > bounce.
> 
> Hmm, so the mails I sent with codeaurora on Cc didn't bounce back - I
> got only the quicinc bounces. That doesn't mean that codeaurora actually
> gets delivered...
> 

Not sure why. It was supposed to bounce. But could be that Qualcomm IT
decided to not bounce anymore since they have got enough complaints from
developers ;)

> > For that reason, I used their quicinc domain addresses. But since they
> > are bouncing, it looks like the maintainers left Qualcomm :/
> 
> Hmm, is there some way to get in touch with those folks?
> 

I don't think so. I checked in the internal Qualcomm database and
confirmed that I couldn't find the maintainers names there.

> Or whoever is taking over those drivers?
> 

LLCC is maintained by Bjorn (CCed) since it falls under soc/qcom. But I'm
not sure about EDAC. I think we should mark it as not maintainted until we
find a volunteer.

Bjorn, thoughts?

Thanks,
Mani

> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
