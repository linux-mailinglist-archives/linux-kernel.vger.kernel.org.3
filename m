Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1630F495F1F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 13:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380415AbiAUMlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 07:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245692AbiAUMlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 07:41:10 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A58C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 04:41:09 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c66so17691627wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 04:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xWfgomS6846339tFx+NSP7zGmTMQQj38WUStg/a8mqQ=;
        b=Et5bslgymy2GBgp+a43l/XIrxb478OlJDRpppLv06q/dUsaoJF6uQa/1aftPwI3NrT
         R1MVARsMZSfkpEgFirMa3PByX7ih3I5tWNzpcu9bajiEco2JzYHf3PGi9g+UhthbpIfF
         nzz/RdtSe3zmzRIImdh6wTWRv5D8gsSdWYPKA44hR8niJl6krdInwGZgKl6ihK3pgola
         rZ5SpATOc0Hyd+8fPqsx9PkEIKNkM00haehX58tpetl1PS7Gy9H5G362FaHpIyqT1JSO
         HXEm1Y86glKpuhi8fO+NZ4SV4rxtFzEYsr2RdO/8nH4w6QleUhK8m+9iukj4cLlWR8fg
         wQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xWfgomS6846339tFx+NSP7zGmTMQQj38WUStg/a8mqQ=;
        b=p+ZieMsWEC/NSMqoXbTDnNtJefZYCwAWPuvp63vhPz5KzaR9fjaWN3/UGWTq7Py7h9
         d+XgQ7wIZKNCRHpfH11T39iUWTTFP2Q9d6B58Li9ZniWT1voW1sxWEkWLlvRMSIzuDJj
         57htO7trHago/wKobmcJIszepB6nIzZYOD7RMAWuMAq7zt5TZsCfH+5PyU7xDGCUHmjn
         krPjgnMqTGt0SDpu2FIWGDxdv5xkAz52rQcEr3qFk9om6Tu8gwRZ/cvc6qooX8MtWqGH
         7yDact2U+/MEY/OoprYT7lKdAWgAantiZw860HJ0GkGvEAo3g4+9LewzggPzkFFRMMAT
         Ppyg==
X-Gm-Message-State: AOAM532z1gieUOtZt8jSFfQ/CKlmO6f65cY2Z17JnXLw1KBEYJBc3Fsu
        0xPSP+3JevVj1IbvF+uputKeClmUtcPU6Tu85EmMBA==
X-Google-Smtp-Source: ABdhPJzpYKfZBwLZ5RN3eq2ef/HrhjFmG7waD4b+nfiKo6cp62INvfZWjrc/Jgfz3JOxyNwKLpYfIydLNsNjVXCdV1o=
X-Received: by 2002:a5d:618b:: with SMTP id j11mr3693182wru.619.1642768867668;
 Fri, 21 Jan 2022 04:41:07 -0800 (PST)
MIME-Version: 1.0
References: <20220114173254.1876151-1-james.clark@arm.com> <20220114173254.1876151-2-james.clark@arm.com>
 <CAJ9a7VhedrLMKfXBqzD_9fFxzKTg63-9wUM38Tw6ukhmSR9aoA@mail.gmail.com> <139e5fb6-b917-163e-751c-1ef745852529@arm.com>
In-Reply-To: <139e5fb6-b917-163e-751c-1ef745852529@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 21 Jan 2022 12:40:56 +0000
Message-ID: <CAJ9a7VhA0YLaamjddvsmiiY-6fdzjobobtxj++Bphi1wt6EPsg@mail.gmail.com>
Subject: Re: [PATCH 1/1] coresight: Fix TRCCONFIGR.QE sysfs interface
To:     James Clark <James.Clark@arm.com>
Cc:     mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Thu, 20 Jan 2022 at 11:37, James Clark <james.clark@arm.com> wrote:
>
>
>
> On 19/01/2022 15:22, Mike Leach wrote:
> > Hi James
> >
> > On Fri, 14 Jan 2022 at 17:33, James Clark <james.clark@arm.com> wrote:
> >>
> >> It's impossible to program a valid value for TRCCONFIGR.QE
> >> when TRCIDR0.QSUPP==0b10. In that case the following is true:
> >>
> >>   Q element support is implemented, and only supports Q elements without
> >>   instruction counts. TRCCONFIGR.QE can only take the values 0b00 or 0b11.
> >>
> >> Currently the low bit of QSUPP is checked to see if the low bit of QE can
> >> be written to, but as you can see when QSUPP==0b10 the low bit is cleared
> >> making it impossible to ever write the only valid value of 0b11 to QE.
> >> 0b10 would be written instead, which is a reserved QE value even for all
> >> values of QSUPP.
> >>
> >> The fix is to allow writing the low bit of QE for any non zero value of
> >> QSUPP.
> >>
> >> This change doesn't go any further to validate if the user supplied value
> >> is valid, because none of the other parts this function do, but it does fix
> >> the case where it was impossible to ever set a valid value.
> >>
> >
> > I concur that the input is not checked as valid, However all the other
> > fields are single bit - with no invalid values - other than the cond
> > field, which controls tracing of non-branch conditionals -
> > architecturally unsupported for A profile in ETMv4/.
> >
> >
> >> Signed-off-by: James Clark <james.clark@arm.com>
> >> ---
> >>  drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> >> index a0640fa5c55b..a99bb537ea23 100644
> >> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> >> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> >> @@ -368,7 +368,7 @@ static ssize_t mode_store(struct device *dev,
> >>         /* start by clearing QE bits */
> >>         config->cfg &= ~(BIT(13) | BIT(14));
> >>         /* if supported, Q elements with instruction counts are enabled */
> >> -       if ((mode & BIT(0)) && (drvdata->q_support & BIT(0)))
> >> +       if ((mode & BIT(0)) && drvdata->q_support)
> >>                 config->cfg |= BIT(13);
> >
> > This can be trivially changed to
> >
> > if ((mode)  && drvdata->q_support)
> >          config->cfg |= BIT(13);
> >
> > to ensure that any input mode 2'b01, 2'b10, 2'b11 results in output
> > settings of 2'b01, 2'b11, 2'b11 respectively
> >
> > With that
> >
> > Reviewed-by: Mike Leach <mike.leach@linaro.org>
> >
>
> Thanks for the review. Can I also get your opinion about this one? At the very least
> I think the comment is not detailed enough, but I also think that case 0 should set
> BIT(0) rather than BIT(1). Or is there some edge case and it's correct?
>

Agreed - case 0 should be BIT(0)

However, now you mention it there is a corner case too...
On an ETM4.3 or later, if TRCIDR4.NUMRSPAIR == 0, then
drvdata->nr_event == 0 means zero events, otherwise drvdata->nr_event
== 0 means 1 event as implemented in the code below.

So a check on drvdata->nr_resource (which is the processed NUMRSPAIR
value wrt etm arch ) to skip setting eventctrl1 if this is 0 could be
added.

Regards

Mike

Mike
>
>         /* start by clearing all instruction event enable bits */
>         config->eventctrl1 &= ~(BIT(0) | BIT(1) | BIT(2) | BIT(3));
>         switch (drvdata->nr_event) {
>         case 0x0:
>                 /* generate Event element for event 1 */
>                 config->eventctrl1 |= val & BIT(1);
>                 break;
>         case 0x1:
>                 /* generate Event element for event 1 and 2 */
>                 config->eventctrl1 |= val & (BIT(0) | BIT(1));
>                 break;
>         case 0x2:
>                 /* generate Event element for event 1, 2 and 3 */
>                 config->eventctrl1 |= val & (BIT(0) | BIT(1) | BIT(2));
>                 break;
>         case 0x3:
>                 /* generate Event element for all 4 events */
>                 config->eventctrl1 |= val & 0xF;
>                 break;
>         default:
>                 break;
>         }
>
>
> >>         /*
> >>          * if supported, Q elements with and without instruction
> >> --
> >> 2.17.1
> >>
> >
> >



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
