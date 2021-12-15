Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EE6475042
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbhLOBFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239413AbhLOBEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:04:16 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5551CC07E5E5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:03:14 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id s139so29441589oie.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uw6bN6d4TEpZ4w8TTcuB+Vquo3dAMeEaia/fJgaxXHs=;
        b=H4muOgjK5/dmipKYb548E8BJxPqSbo3j0zUgv2RPxaIY0janIUUZNlsnqB/Uu2IjEV
         X1oyh+GZmEWsi+4TIxhCX0N0XQ6y8IqecJX/8d+GY3LMattPjYOXZ41rmOfIh1b9cHgt
         wPVE7vKeIPmfH95eql9uPMTETbzvrR9Nu9JECandS49rg0WENRiHo8c2p89DRJsi1G9j
         9ruLwk03ONpGADcAwzoOnNrqb+ug4Rh+Pm6Vxnlxw3tKhEiVGbbZ/5Rs0zmX9BMbiQ4S
         KmJeYJmVSpuzUsBtnyHiTIwNPB1Gx1v+8zNwA6aS0EV6kTE43xLDlSD4yqxilZrI4UBk
         rR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uw6bN6d4TEpZ4w8TTcuB+Vquo3dAMeEaia/fJgaxXHs=;
        b=UUn6iWtghxiXOMNgxglT6jY3+4QSrLl+PLp9u0NxyeiNk9NZZE8v4X57vLXT0HTFDT
         1VRpbQDTiyfT5x3ar+IU/x0wMyFTup/DTb/wpPgt+s03KwyXX7xRPE5ilbkBsjdSjKhG
         OrVZ6tl2Rn7UoCctnQO78VI14z3OgLAfcalWCD9ExG3WYLTyPdzBnfWxPwZ3f3dDsK/F
         RIiYbxa34Q2guME3fwnK3hluwtmS/9983QoTuk3VQC4mFrXZWbWwrWypLUXuF8ebQmqa
         up4yIFBTzMg4luAa++AEqAJYndIST6JFGJAbylIx8Dd7HxB16bfZSELSHDRGfwsnRBgF
         p5fg==
X-Gm-Message-State: AOAM532VwmkxG7FZa8SFkWRosr5ztyXjHYwnbtgUoQp6G1c0eLT3NdNI
        HiVxbITsTSXz+5IGA5ApQ8wJ0T99yEzXMAKJmiS//w==
X-Google-Smtp-Source: ABdhPJxliBCdAwd2D2fYqD1C2K2IdEZ42OdIUesvDoXQZeocLw/E99x719/CgLnSa9cMHZF1p6JG+ArPNcBQZ24Ri7Y=
X-Received: by 2002:aca:120f:: with SMTP id 15mr6921450ois.132.1639530193662;
 Tue, 14 Dec 2021 17:03:13 -0800 (PST)
MIME-Version: 1.0
References: <20211215010008.2545520-1-javierm@redhat.com> <20211215010008.2545520-57-javierm@redhat.com>
In-Reply-To: <20211215010008.2545520-57-javierm@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Dec 2021 02:03:02 +0100
Message-ID: <CACRpkdbmLyXhGbuKEaCL=M=52huK3H-8_O-z_gyjf_95gO-fsw@mail.gmail.com>
Subject: Re: [PATCH 56/60] drm/tve200: Add support for the nomodeset kernel parameter
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 2:01 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:

> According to disable Documentation/admin-guide/kernel-parameters.txt, this
> parameter can be used to disable kernel modesetting.
>
> DRM drivers will not perform display-mode changes or accelerated rendering
> and only the systewm system framebuffer will be available if it was set-up.
>
> But only a few DRM drivers currently check for nomodeset, make this driver
> to also support the command line parameter.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
