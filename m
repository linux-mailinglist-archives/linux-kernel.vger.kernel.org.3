Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6545A725D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 02:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiHaAWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 20:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiHaAWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:22:42 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D179E0E8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:22:40 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id h78so10674516iof.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=CjHJ6guV4AQZerFE0TWAnwta/uUYJx/V52zAnUvT6/E=;
        b=B+Z3LtgOINbbiKNxf7rfsgWZcXD31cS2mUqAoLt11dXa4TmB3Z9cTVJC7uIJaYrtyl
         baMjKg2MGdzwJInfHmIRXQsAyyP1vB2J0Gtf8KLZtdZVIrmzubfN4jUeez0W7yzH/m1f
         invrO3bUao2ae/NM3XJ2vyuG0WoC3UTpWsZhVudvcqFjkOf4B5r/iScU1VyvufqPJ8cu
         e3/7WDny8sDp8n+e4JLFXfp0WHyxvCK0TXTzPZiGHhuBK3RpkPQO4GqWQFal2qAXf7Uk
         QhCsDBYlmQaFpko9nD+8apP0RZSsubqkDZsaaSW2AvNGp3yuwGBwp7t+zoO/SqB//I+U
         NZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=CjHJ6guV4AQZerFE0TWAnwta/uUYJx/V52zAnUvT6/E=;
        b=bRbsSC4K04un2N69FbcIahXc/Oo/3neypfuAImpfDGuITVDWJI1ZLVfExOWu9znmfu
         BIf+IJE35jNatbwI3MHTW6+mQpXU8DFwVYx+0Mg//ClI3vCRhRX0PRnO9ItdHFAnPRS3
         WN+YSuWKNyl04hs4xoTExWnOO+7cVFcJVPhzm6Jqi7/dGjsXRgpsdzXiOy+1Blsmz/aI
         Q41oeLW91hgwm5x920KTCQ18TsN+Y5Oy86LAyYJSv16gUGtJL5lJTdgd7NBQ7A6wjy88
         sD3F7+CTLrQjTZICgvqUU31UsYB/73rs/u94PBIg+4onnh3pn48AxFnQgk3AdGJMfVfW
         ZB/Q==
X-Gm-Message-State: ACgBeo2SLXAiMD7fu1i6F6MVBR/2maCn1ln1klO+ZoXiySUWswTauOjA
        yk2CSCCoRWY9iO2R/DiHJXSg1n6z8ZY8DMs1Suh+2g==
X-Google-Smtp-Source: AA6agR6JsDyNkBl/c6DnU+AKMAnb6qKQhg2RYhUPHDUIplj92y10BtV9xLaH22IHr9hCtav15WV8kUhbIC1rCDr354s=
X-Received: by 2002:a05:6638:218d:b0:34a:1684:b21 with SMTP id
 s13-20020a056638218d00b0034a16840b21mr13670116jaj.178.1661905359984; Tue, 30
 Aug 2022 17:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220826084001.3341215-1-badhri@google.com> <20220826084001.3341215-4-badhri@google.com>
 <20220830175523.GA239841@roeck-us.net>
In-Reply-To: <20220830175523.GA239841@roeck-us.net>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Tue, 30 Aug 2022 17:22:04 -0700
Message-ID: <CAPTae5+xgdHUCwdrqp=Of5THUmdWLnLZu2qf1ZhysESLyPFioQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] usb: typec: maxim_contaminant: Implement
 check_contaminant callback
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 10:55 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Fri, Aug 26, 2022 at 01:40:01AM -0700, Badhri Jagan Sridharan wrote:
> > Maxim TCPC has additional ADCs and low current(1ua) current source
> > to measure the impedance of CC and SBU pins. When tcpm invokes
> > the check_contaminant callback, Maxim TCPC measures the impedance
> > of the CC & SBU pins and when the impedance measured is less than
> > 1MOhm, it is assumed that USB-C port is contaminated. CC comparators
> > are also checked to differentiate between presence of sink and
> > contaminant. Once USB-C is deemed to be contaminated, MAXIM TCPC
> > has additional hardware to disable normal DRP toggling cycle and
> > enable 1ua on CC pins once every 2.4secs/4.8secs. Maxim TCPC
> > interrupts AP once the impedance on the CC pin is above the
> > 1MOhm threshold. The Maxim tcpc driver then signals TCPM_PORT_CLEAN
> > to restart toggling.
> >
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > ---
> >  drivers/usb/typec/tcpm/Makefile            |   2 +-
> >  drivers/usb/typec/tcpm/maxim_contaminant.c | 338 +++++++++++++++++++++
> >  drivers/usb/typec/tcpm/tcpci_maxim.c       |  34 ++-
> >  drivers/usb/typec/tcpm/tcpci_maxim.h       |  68 +++++
> >  4 files changed, 429 insertions(+), 13 deletions(-)
> >  create mode 100644 drivers/usb/typec/tcpm/maxim_contaminant.c
> >  create mode 100644 drivers/usb/typec/tcpm/tcpci_maxim.h
> >
> > diff --git a/drivers/usb/typec/tcpm/Makefile b/drivers/usb/typec/tcpm/Makefile
> > index 906d9dced8e7..81e4e9421fa0 100644
> > --- a/drivers/usb/typec/tcpm/Makefile
> > +++ b/drivers/usb/typec/tcpm/Makefile
> > @@ -7,4 +7,4 @@ obj-$(CONFIG_TYPEC_TCPCI)             += tcpci.o
> >  obj-$(CONFIG_TYPEC_RT1711H)          += tcpci_rt1711h.o
> >  obj-$(CONFIG_TYPEC_MT6360)           += tcpci_mt6360.o
> >  obj-$(CONFIG_TYPEC_TCPCI_MT6370)     += tcpci_mt6370.o
> > -obj-$(CONFIG_TYPEC_TCPCI_MAXIM)              += tcpci_maxim.o
> > +obj-$(CONFIG_TYPEC_TCPCI_MAXIM)              += tcpci_maxim.o maxim_contaminant.o
>
> This creates two separate modules, which doesn't really add any value.
> I would suggest to adjust the file names and create a single module
> named tcpci_maxim instead. Renaming tcpci_maxim.c to, say,
> tcpci_maxim_core.c and
>
> obj-$(CONFIG_TYPEC_TCPCI_MAXIM) += tcpci_maxim.o
> tcpci_maxim-y := tcpci_maxim_core.o maxim_contaminant.o
>
> should do. This would also avoid the need for exporting symbols
> from tcpci_maxim.c.

Thanks Guenter ! Done. Just sent out "[PATCH v2 3/3] usb: typec:
maxim_contaminant: Implement
check_contaminant callback".

>
> Thanks,
> Guenter
