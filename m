Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4F4480B90
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbhL1Qwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhL1Qw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:52:29 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C81C061574;
        Tue, 28 Dec 2021 08:52:29 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id i11so19163443ljm.13;
        Tue, 28 Dec 2021 08:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FIkiA0FD+7sqxfQ1GH6hzg05sbLrtvkdUl+v4CjNfos=;
        b=Oe20vn56LEkOO+MoKZbIQaUDYsK5R3BybpMDkx9mREZRbol6Iv/L8REHWWMUwPOZqZ
         Mmud9EbmIloELT+CxnKdVpNj7ZOZlDi2Myt0PHAtgOCUxP4Ps5TELmvdA+xB/uWHOaVO
         uEPX/hezMo3lt6WmW/l6HIdOk49LErvF5ayg8LL62ec6ayN2qaOc5tj/1bMc7XTSeQvs
         xCAdfjNRx7LJHjLGMnevqxH+I90V3DcjoS0hla4QnX3zXAZSFvrM6O9OBZlt9K7GFs+t
         m5aXRohUPFrwFksC+JpuGmZZYYo2VHpDYPvAbm3uZUIPpgtWNdFSHhVhe0viqwTmIFuQ
         Ipbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FIkiA0FD+7sqxfQ1GH6hzg05sbLrtvkdUl+v4CjNfos=;
        b=4lxbcMR3qH0NCmHF047yoB6HvS+Ff3FcxT2tvbThlTB+Zyl7aogdmaJZIDnG/7zfWB
         1VIks8pigdfMCghLyJceeV+mB7Y5gze0A8HS3AH/jOmsCfeyVNaRy0wFoq0UaFYyiSh4
         YyCZVpve3ThmgeIfRZN2ufnrYDV25aauL4cxs1KrdAPc7wBddLSHeIHGJiY83fUk4wey
         yBJKDdGEOpgBgWsfRvQuVct3U7mV0fh4szASnE0SQC8FYfbsO4z2Puw2otUpaZiRw5gx
         oOcv9oIXvTh8/8Y4zNfHyuaOK22Q1/39uPidcapB7ir3JA+oLsux6SQ77nWA7M1cHlRT
         50mw==
X-Gm-Message-State: AOAM532QfLON0/5c6EyRROFSAtGQeFCka2b9SOACOmeTyg+AZid8SR/s
        AyhlUw0LhB/vumr4nQYo/9SsAZdpu9PRUsgG9ho+ycYcLw4=
X-Google-Smtp-Source: ABdhPJyNuMAKLcrPC8ghRF9M6vGYt3bD/gjcpzp/if6kcvTb7RX++DMwCJ919ni3axJYJeWmz+fAs2Uidzr6ORd9PZk=
X-Received: by 2002:a2e:a545:: with SMTP id e5mr2859239ljn.5.1640710347326;
 Tue, 28 Dec 2021 08:52:27 -0800 (PST)
MIME-Version: 1.0
References: <20211228144252.390554-1-gregkh@linuxfoundation.org>
In-Reply-To: <20211228144252.390554-1-gregkh@linuxfoundation.org>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Wed, 29 Dec 2021 01:52:15 +0900
Message-ID: <CAKFNMona12jPJMGveSHgVDks_EYd_ZAJ_gDRLZo=exyFD3Y8+g@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: use default_groups in kobj_type
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-nilfs <linux-nilfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 11:42 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the nilfs2 code to use default_groups field which has been
> the preferred way since aa30f47cf666 ("kobject: Add support for default
> attribute groups to kobj_type") so that we can soon get rid of the
> obsolete default_attrs field.
>
> Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Cc: linux-nilfs@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Looks good to me.
Please take it through your tree for your convenience, thanks.

Ryusuke Konishi
