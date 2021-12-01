Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7974646F7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 07:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346819AbhLAGE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 01:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhLAGEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 01:04:25 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F12C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 22:01:05 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso460273pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 22:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=p+h1Ci/5eM23w48d10JZjE3E1+seAEm4EAViYXAETPQ=;
        b=EMHBw0e/vGvcPCdRzYL0MfE/37rgfduTDk9qLZ0R3VsAFToDzsY/A2ZyZ55i+ws7OC
         0NL1oAJDxinVH4PZ9cqcxaQji1byUi4VBBM5seBz+tqYgz/yhelWO7a1trjSCybQ3lcc
         pYciQPv0k6n7Hwx2dgGPY2QSQxnkTHGPCPmxujPrXi76r1YIneRk3+Dos1ye+XfYOd2i
         VvBSarZjbLT9XBYH2mkWnOmV0bD/AoTKSuoMmLv+z7Tqnq4tqUwJ+nlHapIl9iQR9Sfq
         cQMSM+DZl4T0/eKs/Idrs599QBFIKXg03quXFFHV1VsZovNYt23a2gDS0ak+hDJvHwwB
         28QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=p+h1Ci/5eM23w48d10JZjE3E1+seAEm4EAViYXAETPQ=;
        b=LBTbIw3wCaqmSHB9fm1FTzHkiC5UAoIMk1t89bxy0py2N+6ZbU28bAmah7N+INwKUU
         hPYDITWvEd18VIRje+R/jug6ZW8f9XP3wZuQFU36H7+X2+EcFxSzIbPNJKrjjPSJ2dIN
         noxD8IB7EmB5yH2n8lPoj1/cIdRnWWjUTfPhrMINNI2/7HCfKZW+XCSPb22L6U/tQoc8
         OvsV1Ja2HiDBzo50KS8JmguR8lxw8yuyb5rd6oh8lAM3kesi1338hkl2n0FuzWSkEBI4
         046i2smgmTGKRoFfTX8TbOeyzc9z6aEffI/ot1Mv/xdeEVJOvU/sp+bKQqG3C2mIkzQ8
         yJnA==
X-Gm-Message-State: AOAM531/StCthpNlDydJ+dT0g3sF+dWa+6PpvhmcXrmIFs0H1qmBDAHX
        u63uThbCrDTnQ/f416gQgOA=
X-Google-Smtp-Source: ABdhPJyVjW0vwT2dzIxQQRiiYKpz/cJyyLjekGgJiHEOZGOEmsuBfOcYzGxu/rMy5VtmahhvpyRyHA==
X-Received: by 2002:a17:902:c202:b0:142:2441:aa25 with SMTP id 2-20020a170902c20200b001422441aa25mr4897937pll.68.1638338464453;
        Tue, 30 Nov 2021 22:01:04 -0800 (PST)
Received: from localhost (115-64-213-93.static.tpgi.com.au. [115.64.213.93])
        by smtp.gmail.com with ESMTPSA id p10sm22499478pff.173.2021.11.30.22.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 22:01:03 -0800 (PST)
Date:   Wed, 01 Dec 2021 16:00:58 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 rebased 5/9] powerpc/mm: Call
 radix__arch_get_unmapped_area() from arch_get_unmapped_area()
To:     alex@ghiti.fr, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org
References: <cover.1637862579.git.christophe.leroy@csgroup.eu>
        <6ba86b0ef347c04a6c4e475c059f486b0db170ec.1637862579.git.christophe.leroy@csgroup.eu>
In-Reply-To: <6ba86b0ef347c04a6c4e475c059f486b0db170ec.1637862579.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1638338152.00yryi8b39.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of November 26, 2021 3:52 am:
> Instead of setting mm->get_unmapped_area() to either
> arch_get_unmapped_area() or radix__arch_get_unmapped_area(),
> always set it to arch_get_unmapped_area() and call
> radix__arch_get_unmapped_area() from there when radix is enabled.
>=20
> To keep radix__arch_get_unmapped_area() static, move it to slice.c
>=20
> Do the same with radix__arch_get_unmapped_area_topdown()

Same comment with this one really. It would be better if we can
reuse generic code.

Thanks,
Nick
