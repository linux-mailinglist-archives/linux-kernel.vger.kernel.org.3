Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136A4478011
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 23:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbhLPWnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 17:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhLPWnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 17:43:00 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8875C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 14:42:56 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z9so980959edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 14:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Bpd9qIWI4GooBV7UkYv1em2TTB6qYXE3G0DCMiO5eY8=;
        b=zpIs7buOLrssHZEPvLwN6eNfPZ85p3RbdZmhW3i08kdHtCIKEKpa/UB6oybfy19s1Q
         XMk/uCIGWEVzVCFFyj5ug+T0dSn5uTsSE77dtIACj/CH3xf4/qEXpyLSJ4JLdLpuuaib
         Yk+2Mt+oDnj+OfPXnFVfSWI9w529AXGn97R4vKRgVNN9FQWboaETn+z9nuBKezDo2FpK
         N9OrmWIkhXj7iDzq0sRzWqeRO5gQiuX37Vzvx214hlAUwk4WyJy2Sd64odN7/XZNjDhG
         qKnxBAAzfr90b9/bNuCvag7opcVSJAp33SWO6pxxjgmf4IYY541FeZUqEK2ytN4xRehU
         nBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Bpd9qIWI4GooBV7UkYv1em2TTB6qYXE3G0DCMiO5eY8=;
        b=wXcKPrpyVkkf3wrCu7adNH5H0jMfZwrB90KwT5zx1LxLUEqFnxTeaICGawFvgscqHg
         Njqx+RHKP3UQfOZFc0aXdlGBgH/Dh1Vn7ij0h9OrvepNi8IlmZdo4kG8flctn6NY3RXF
         b78LBAdyy1gD1SgbFUoHpgZU8SDBUGP8DJaDSUls97IYwYEk72hgmzunyVFI/v+aceQf
         52jvF4CMubAlFbLgDoAn7gzjgvVUuKn8LJ7M+Cw5XCoO/mvCGdtO5+kXZeqiOCu7T83K
         Hf9EmwObf/yHr6++CAZHjdOmBXHyxSOVTNFVsEqIDdejyxuSmZ1j0SVb/Y8G3Y0MAxad
         QmXQ==
X-Gm-Message-State: AOAM530bOZJX7w9IfkoWlYjvEU64VOCqbw8cVKrYH7u/k/p65iCgbE+f
        whJtrL7erPknYIeaGvL1paxpb2+H7Zz8wXGeuTf4
X-Google-Smtp-Source: ABdhPJygfyhcvZXZfX+vvJmR8OHzjuptqlssny8m9J2c/OQnGFmlM/AN0ppu0KmJoy9Fu+J4XGi8y0coezv/biRRyGk=
X-Received: by 2002:a17:906:3a8c:: with SMTP id y12mr162207ejd.517.1639694575109;
 Thu, 16 Dec 2021 14:42:55 -0800 (PST)
MIME-Version: 1.0
References: <20211215030420.72324-1-xiujianfeng@huawei.com>
 <20211215220004.GA21862@embeddedor> <ade6655d-a62e-1d57-d623-4bfc93ebbc57@huawei.com>
In-Reply-To: <ade6655d-a62e-1d57-d623-4bfc93ebbc57@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Dec 2021 17:42:44 -0500
Message-ID: <CAHC9VhRCMp=E15FKVVSmkrat_u_WqWY6WE=Evsj=Ar-hHm3y3Q@mail.gmail.com>
Subject: Re: [PATCH -next, v2] audit: use struct_size() helper in kmalloc()
To:     xiujianfeng <xiujianfeng@huawei.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>, eparis@redhat.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 9:05 PM xiujianfeng <xiujianfeng@huawei.com> wrote:
> =E5=9C=A8 2021/12/16 6:00, Gustavo A. R. Silva =E5=86=99=E9=81=93:
> > On Wed, Dec 15, 2021 at 11:04:20AM +0800, Xiu Jianfeng wrote:
> >> Make use of struct_size() helper instead of an open-coded calculation.
> > I think you should also mention the flexible array transformation in
> > struct audit_rule_data.
>
> thanks,  and due to the previous patch has been merged into linux-next,
> a diff patch about struct_size() and
>
> a seperate patch about flexible array will be send.

Please make sure to send it to the audit mailing list as well.  I
don't like merging patches that haven't been sent to the mailing list,
it's a bad practice IMO.

--=20
paul moore
www.paul-moore.com
