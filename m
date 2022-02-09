Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1494AF4CA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbiBIPIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiBIPID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:08:03 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8F2C06157B;
        Wed,  9 Feb 2022 07:08:05 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id x23so4871513lfc.0;
        Wed, 09 Feb 2022 07:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sZuSabn0QbPYa54gWbxUvv8juq6yvTZRiZO+ivNIJxo=;
        b=oOTfBjeMgZVrZqF+jNzMpkNyg/aIpMmvkJR6Q6yy6N+UgGAJu9kaB0F172BnP+Qpui
         4hHKQYg9wT2yNprBHQsRqQyKWc8nwgOM8IhXHjvRi8rDt4r8LnzEVObbLmGsNlDEJW+5
         9+/njMHqJ8cudUi6fofEBme53/m4slVQqlairCKvqQv4e67a9DhLL97HC6CJcZjLt0gv
         ks37KXYTtnIVXauj5DegTnze5iDZ0Ggc8QmOqxpBn5e+ciYCK2YcGX5QDik3OzvNF7rA
         bRWAXwKU1esxZs6bRroxrhlYnAdl/J3s15+XPZc/c2DXG+skIa8AM3RvbmKu1vA9L2im
         NcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sZuSabn0QbPYa54gWbxUvv8juq6yvTZRiZO+ivNIJxo=;
        b=z8uQ7mhPNeXs3zM8IMTw/u6ss0vVpJpdOD4I8xOW2Q06V/7t010EREd9NbX3QXe6LA
         VWDzGGBmYmB3vK+ajetprjMydwNUBv90Vj/6jJ40L51nRGsRY2zYFLKKW6Uo0qKKHXC6
         gO9jliAmvpGQpjoimaUGj1gVRT/TfnT3Zhz1S38nLi3AkTy5+47mZY4s8hPRfNa3yKsP
         zvZcCHP0uQEJGyyfHxi2PHlAGE5eaqJu/3k/gWF1606GFPs2GjHPD9a70umC7LfyXX9Y
         YUX5N814wwia4ZWAg5yklSXe/9MOVt8O+Opsr3mpR3gw5ESzeGuNRV/76c6TIOGABm4M
         KoKw==
X-Gm-Message-State: AOAM533h4m2odLmkvk1f4aRDklkw+zQwd5Fi5pKw/wITL4Z4fJR+yN1W
        q9M0nXx/VpWXTzq80Smku96FxE/T9veGXeO5t9/gno0f
X-Google-Smtp-Source: ABdhPJzLVWTVFbwwe6JN9rlEF0EDcw+knWnGuMm9EFOgUB0hFe2UqOWg4++mfopuj+m5N+mT8qDXoMRBeOMvB6aRBlU=
X-Received: by 2002:a05:6512:118a:: with SMTP id g10mr1918497lfr.356.1644419283500;
 Wed, 09 Feb 2022 07:08:03 -0800 (PST)
MIME-Version: 1.0
References: <1644415355-24490-1-git-send-email-u0084500@gmail.com>
 <YgPOz6pfpFcPmHms@kroah.com> <YgPQgtcO22W3vZDw@kuha.fi.intel.com> <YgPWLselefw3nGb8@kuha.fi.intel.com>
In-Reply-To: <YgPWLselefw3nGb8@kuha.fi.intel.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 9 Feb 2022 23:07:51 +0800
Message-ID: <CADiBU38AYNBpoF=Ez+Bubk10-f4Yf2_TtXeVjVQM=K8a5zhkkA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Add Richtek RT1719 USBPD controller support
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        cy_huang <cy_huang@richtek.com>, will_lin@richtek.com,
        th_chuang@richtek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg, Heikki:
Heikki Krogerus <heikki.krogerus@linux.intel.com> =E6=96=BC 2022=E5=B9=B42=
=E6=9C=889=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:56=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> On Wed, Feb 09, 2022 at 04:32:38PM +0200, Heikki Krogerus wrote:
> > On Wed, Feb 09, 2022 at 03:25:19PM +0100, Greg KH wrote:
> > > On Wed, Feb 09, 2022 at 10:02:33PM +0800, cy_huang wrote:
> > > > 3. Change MODULE_LICENSE from 'GPL v2' to 'GPL'.
> > >
> > > Why?  Either is fine, any specific reason you changed this?
> >
> > Because I proposed it. I believe everything scripts/checkpatch.pl
> > tells me.
>
> It looks like the preference on "GPL" is pretty resent. Check commit
> bf7fbeeae6db ("module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2"
> bogosity").
>
> thanks,
>
It seems to revert it back to 'GPL v2' is proper.
I'll resend the v5 to change the license back to 'GPL v2'.
And add the Reviewed-by tags.
Thanks.
> --
> heikki
