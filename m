Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68879497BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiAXJQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiAXJQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:16:31 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D460C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 01:16:31 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id s127so24551082oig.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 01:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZRN5vWJAxkj8OOhK9WNkjB+abR7dFbVqjkPzo3NIMyE=;
        b=Tk1aG7x8bDsvpHwzPDDbjglqlnUBuM/Vw5/O7TeuPWe/+bbzVPDKyO1tJk/UhSQjTI
         wwEelgqnNno3r0HbDum2C2Xj5se6L8WD8ja36+tL0ANH9FjWTwcDy3rsNhdM2M1t+MDj
         Z4frco5gvIZzxwDAqQcVDvK2hscAkFfpel3jEZppPZl4FS/oTY6cNwGkuBzAL/fSNEQ1
         2vkTZR8MYcxfUyXIZHL1eutYwye/DnPqRGjxTfEJFWS6UA5ehqoH4KoYVZ+jGvifkvBK
         cOjM70cAG+/5rz6I3RIC03meJmF4bTyv1LAY30jppdYI+fzzqDQEJpD/E6SqgrNIAiCB
         T2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZRN5vWJAxkj8OOhK9WNkjB+abR7dFbVqjkPzo3NIMyE=;
        b=AFKLSYAQ7rLiXNUHb8NVWSCvISsyeOu9fd+5Jjo11zVaQvzHfvnjNVtAICruXVsiUB
         S5Bol/v8FHyhc5DvHbyX1DtUGW/lnozxJnSxUb8V8lJq0VdxqKCahCNzZqysTToRq8ml
         9VD+FxxsBIj5hpZOHjbA91PNhDIG/4nwuUFqUwAIpKiQveArhMzjyV/fDNuqSiv47GS7
         d90DDbVrZCBcC4OueiKaru3m9N/GJjdurcy1MCiQFuESYryFtrX6lJhSSL2CQO3BTZbd
         +CxEOsIIKFtfzSzglMGSg1uajAO3MDYW3WECByRuf4bHg2a3onj+hgGjytpAvORZXIp0
         m+WA==
X-Gm-Message-State: AOAM530jI9qIW0cjF4VkIR9TQf0nN2LYeUTu7fS2+jlgxgjfqdovC82z
        msap+XbrdvQ3wzn+vtGnTdnCd21kVooIYowje7o=
X-Google-Smtp-Source: ABdhPJxSI+GfoxY1I4bFw7NAKktdRprPZhTJ56hsLTsI80Qsx0BMUGA38IYXps5v363j0KE+U6M7QVUlQNu+aACpFIM=
X-Received: by 2002:a05:6808:20a3:: with SMTP id s35mr706861oiw.170.1643015790773;
 Mon, 24 Jan 2022 01:16:30 -0800 (PST)
MIME-Version: 1.0
References: <20220123181734.10402-1-makvihas@gmail.com> <20220124064918.GR1951@kadam>
In-Reply-To: <20220124064918.GR1951@kadam>
From:   Vihas Mak <makvihas@gmail.com>
Date:   Mon, 24 Jan 2022 14:46:19 +0530
Message-ID: <CAH1kMwSNtDAS26TsqWs+bm0B333dSJyK-m_XnU3pgoMZf1MGhQ@mail.gmail.com>
Subject: Re: [PATCH v2] staging: r8188eu: handle rtw_init_netdev_name()
 failure appropriately
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing the patch Dan.

>> TODO: re-write probe error handling

Will submit a series of patches in upcoming days, based on the steps
you provided.

On Mon, Jan 24, 2022 at 12:19 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Sun, Jan 23, 2022 at 11:47:35PM +0530, Vihas Mak wrote:
> > rtw_init_netdev_name() calls dev_alloc_name() which allocates the name
> > for the device as per the given name format.
> > The name format is specified by the module parameter "ifname".
> > It returns a negative err code if the format is invalid. Handle this
> > error appropriately.
> > Cancel the timers ininitliazed by rtw_init_drv_sw() before calling
> > rtw_free_drv_sw() and then proceed to free the adapter.
> >
> > Also, if register_netdev() fails then goto free_drv_sw instead of
> > goto handle_dualmac.
> >
> > Signed-off-by: Vihas Mak <makvihas@gmail.com>
> > ---
> > v1->v2:
> >     free the adapter and netdev instead of warning the user about
> >     allocation failure.
>
> Thanks!
>
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> Of course, all this code is staging code and terrible.  This function
> is needlessly difficult to read/review.
>
> TODO: re-write probe error handling
>
> Step 1: Keep the success path and error path separate.
>
> -       status = _SUCCESS;
> +       return padapter;
>
> Step 2: Eliminate do-nothing-gotos.  s/goto exit/return NULL/
>
> Step 3: Delete the vfree(pnpi->priv); from rtw_free_netdev() and call
>         vfree(pnpi->priv); from probe and rtw_usb_if1_deinit() instead.
>         Avoid a layering violation.
>
> Step 4: Every allocation function needs a matching free function.  Move
>         the rtw_cancel_all_timer() into the rtw_free_drv_sw() function.
>         Open coding it is a layering violation.
>
> Step 5: Get rid of the rtw_handle_dualmac() function.  It has a bad
>         name and a global variable.  What is the point of this function?
>
> But that stuff is for later patches.
>
> regards,
> dan carpenter
>


-- 
Thanks,
Vihas
