Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0813551479
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239143AbiFTJhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbiFTJhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:37:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3545D13D6F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655717842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VQ+wxgfxoQfff153/vfAo2kcjYPMXeSYBFIlenJ41tM=;
        b=HMQyYN+Cg/n04ftlgHF72xElan9Ki39vONrlxFrkeMIii3PEflsV+Wg5/VBs0WUbupaPBK
        MHb/aUBHBA/elr1hFne4K0Gx0b+AObGY/qF/tDI77TN6EiptlnmTqdXJajIPPU+z9t1fwR
        TPPnhKZGRf1+moQxMs40tBowYgi9vDE=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-O4D51inKMMSY2WEARHivVg-1; Mon, 20 Jun 2022 05:37:20 -0400
X-MC-Unique: O4D51inKMMSY2WEARHivVg-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-317bfb7aaacso22692267b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQ+wxgfxoQfff153/vfAo2kcjYPMXeSYBFIlenJ41tM=;
        b=yE3SyOvmQDjSaqLMPKpiTmCt89gsDs3woo4DnjV0EU77ERdjl8cxRymOCfuWRThOG2
         CobboqPxnamyOnoR8IwXmRu2M55ZZd7C+PdW0Yvk/j0YhYb1JBY9ZsYUf/qLRxix65Hk
         W6zc/6c7zD+75Bgiy7Sznb2Jhcg9YbtpoO0EDJhJO81wSNMxxnjnbTwwwy4b/eGBTbkv
         Xig28J1+U888rd5BmTgyplToqrO4XUhQ02eYSVBAbhsacWiUcTeEaETUouSp5pKo4iFD
         jeeVoWWmOW+8BGdOE3CarUBmM1ZTzG6hA3riOdQ8LMVfkVP1oEgYoOSKa7tNku7BKPOn
         jCEw==
X-Gm-Message-State: AJIora9An3HmBPI4b7vrZfMmNU4Ef1s0QArHKRktyCm8FLFn+hFS7Ne5
        Hfj2do6F+LvsMGEbOODRzLoVZYXq51NRsWUi7BQEVbUg+qOwZB38URslp7KwATYv5VZziHwgFPM
        l37yq5blWpiJFCY7OIufo+HUIQMGnQ36uhNK6KhB/
X-Received: by 2002:a0d:db11:0:b0:317:bb2f:c0b5 with SMTP id d17-20020a0ddb11000000b00317bb2fc0b5mr6574726ywe.353.1655717840355;
        Mon, 20 Jun 2022 02:37:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vrPu6/K/TANEgGnpYuHrIsHuTgK8u6Yev4N3pR40RwsAtj2AcGxEnAUHpyOEoTPgV5V3+odIq4XFdTWxSjiCY=
X-Received: by 2002:a0d:db11:0:b0:317:bb2f:c0b5 with SMTP id
 d17-20020a0ddb11000000b00317bb2fc0b5mr6574712ywe.353.1655717840048; Mon, 20
 Jun 2022 02:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220620085413.948265-1-hpa@redhat.com> <a1decfb3-fd32-a8d1-e627-23430099565a@redhat.com>
In-Reply-To: <a1decfb3-fd32-a8d1-e627-23430099565a@redhat.com>
From:   Kate Hsuan <hpa@redhat.com>
Date:   Mon, 20 Jun 2022 17:37:09 +0800
Message-ID: <CAEth8oGg3U27fHpnvtHXsT8GLsfxk3ZNshGLN5e4P_5Ksx7tsA@mail.gmail.com>
Subject: Re: [PATCH v1] staging: r8188eu: an incorrect return value made the
 function always return fail
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 5:02 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Kate,
>
> Good catch!
>
> On 6/20/22 10:54, Kate Hsuan wrote:
> > Since _SUCCESS (1) and _FAIL (0) are used to indicate the status of the
> > functions. The previous commit 8ae7bf782eacad803f752c83a183393b0a67127b
>
> This is the commit hash from one of the stable series backports, you
> should always use the commit hash from Linus' master branch which is
> f94b47c6bde6 and the format for referencing commits in a commit-message is:
>
> commit <12 char hash> ("commit subject")
>
> so in this case this should have been:
>
> commit f94b47c6bde6 ("staging: r8188eu: add check for kzalloc")
>
> Note that checkpatch.pl would have complained about the wrong format
> (but not the wrong hash)

Thanks for this. I'll improve my commit message.

>
> > fixed and prevented dereferencing a NULL pointer through checking the
> > return pointer. The NULL pointer check work properly but the return
> > values (-ENOMEM on fail and 0 on success). This work fixed the return
> > values to make sure the caller function will return the correct status.
> >
> > BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=2097526
> > Signed-off-by: Kate Hsuan <hpa@redhat.com>
>
> This should have a fixes tag:
>
> Fixes: f94b47c6bde6 ("staging: r8188eu: add check for kzalloc")
>
> But while looking up the torvalds/master branch hash I noticed
> someone alreayd beat you to it. Linus' master already has
> a fix for this:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/staging/r8188eu?id=5b7419ae1d208cab1e2826d473d8dab045aa75c7
>
> So this patch can be dropped since it is a duplicate.

Ah~ I have to check before starting to fix it.

Thank you :)

>
> Regards,
>
> hans
>
>
>
> > ---
> >  drivers/staging/r8188eu/core/rtw_xmit.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
> > index f4e9f6102539..2f8720db21d9 100644
> > --- a/drivers/staging/r8188eu/core/rtw_xmit.c
> > +++ b/drivers/staging/r8188eu/core/rtw_xmit.c
> > @@ -180,10 +180,8 @@ s32      _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
> >       pxmitpriv->free_xmit_extbuf_cnt = num_xmit_extbuf;
> >
> >       res = rtw_alloc_hwxmits(padapter);
> > -     if (res) {
> > -             res = _FAIL;
> > +     if (res == _FAIL)
> >               goto exit;
> > -     }
> >
> >       rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
> >
> > @@ -1510,7 +1508,7 @@ int rtw_alloc_hwxmits(struct adapter *padapter)
> >
> >       pxmitpriv->hwxmits = kzalloc(sizeof(struct hw_xmit) * pxmitpriv->hwxmit_entry, GFP_KERNEL);
> >       if (!pxmitpriv->hwxmits)
> > -             return -ENOMEM;
> > +             return _FAIL;
> >
> >       hwxmits = pxmitpriv->hwxmits;
> >
> > @@ -1528,7 +1526,7 @@ int rtw_alloc_hwxmits(struct adapter *padapter)
> >       } else {
> >       }
> >
> > -     return 0;
> > +     return _SUCCESS;
> >  }
> >
> >  void rtw_free_hwxmits(struct adapter *padapter)
>


-- 
BR,
Kate

