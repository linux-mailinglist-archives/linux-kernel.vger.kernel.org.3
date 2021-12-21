Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C5647BE38
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 11:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbhLUKjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 05:39:39 -0500
Received: from mail-4317.proton.ch ([185.70.43.17]:33208 "EHLO
        mail-4317.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhLUKji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 05:39:38 -0500
Date:   Tue, 21 Dec 2021 10:39:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1640083177;
        bh=hPRELDBRRxQ+cyI0/AOFM+F6eiRHj96W1420vRye73Y=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=uFr8Orra0Ypm//GJVgoue4hVc9jVAaOnvqnnPkJ55rVCVgBHmCUuBctPubEruiJql
         0FWTcs9TVmwfVHOWvcBDgQv/QuZcixe7jcVnvLUdkrmRNzkNrj9jStSD6+ULP8Wcty
         5OxqcGqufMOSKvWXiLsjasCiMziIWQv8co+CVqz2NZxHK8qY1DRn44z06y4wKjV4HX
         ooQgMAPzEyVdXeQ1VLNiy7aEvvwZunZEyTQdm8I94jvf/UscKWsfcE5knqz/1kDIZL
         +dWqCJs00R3RExBDMkQP72U7aSjkbLf3GDIqkr4TJ6c7uCEILLWi/O7o8Ka0/o10Zm
         +KDnlxAXVsQKQ==
To:     =?utf-8?Q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        cphealy@gmail.com
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v2 2/2] drm/vkms: set plane modifiers
Message-ID: <t1g_xNE6hgj1nTQfx2UWob1wbsCAxElBvWRwNSY_EzmlEe_9WWpq8-vQKyJPK6wZY8q8BqHl-KoGwS5V91VgN8lGIl3PJt7s2fkdsRd3y70=@emersion.fr>
In-Reply-To: <20211216170140.15803-2-jose.exposito89@gmail.com>
References: <20211216170140.15803-1-jose.exposito89@gmail.com> <20211216170140.15803-2-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Overall looks good, but it is a bit repetitive to copy & paste this in all
drivers. It'd be nice to provide a core helper to do this, and then drivers
can just set format_mod_supported to the helper if they don't have more
involved logic. Thoughts?

See drm_plane_check_pixel_format, where the logic is already implemented.

Alternatively=E2=80=A6 We can just support a missing format_mod_supported i=
n
create_in_format_blob. This sounds like this was the original intention of
db1689aa61bd ("drm: Create a format/modifier blob") and
drm_plane_check_pixel_format.
