Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A5B46FAA9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 07:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbhLJGge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 01:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236965AbhLJGgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 01:36:33 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AD3C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 22:32:58 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id j1so5382526vkr.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 22:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E7Db6cZOx7+zF2P1oxzlfET6kWoFM1x3rhmeA+RzWaE=;
        b=hetUdH+2SYPBibTTIV5LIFazy7ow2hxl0guatHon9Rt8xNhZRjRcvr9QoVpxR6m/SG
         jMX9siIC/tluEZXJKiGfHhU56ObCJJsfUeSJfCUl41b7+Go+pAu+0m6CeuL3qz4MhHnB
         ptuMHQ4yZ00olCE4ZgFyRTJnFG9ivxcyPQu8Bs5knYcLUPncUTQuA9fAt7U7fT4c2VRg
         ansbo07ByfY71yiEwJyN3O/GDZ8FrxbReqqmOCPtGaf1AES4ZK4/dUaNVDI8qjl0LGCi
         rFbzYuX/Cy3olMOHFXaemv3SSFxNzMx6K19NEvKzdNkwg+wTGIk3iiFJtz+dg/qbIJsH
         4XhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E7Db6cZOx7+zF2P1oxzlfET6kWoFM1x3rhmeA+RzWaE=;
        b=786l5Q7e29C4p9jeEWa/VIMkH8Vlw3PWToU6NbzfM2aCWO800tGqgLGx+VHtzZrrx/
         uYb0i5UX/5wujSX6yOutIN7o2kcG0k+Fjrcasov6or3YzH/moMjzWUnqnOWHmHNJL5he
         XJHbdfukpFojr9wwVGJIwUrG6JR0U/7wj8z00oQJNL+HCqU61PPBR5nU99LfvJq7GzFf
         71CfHhP5aluQOA231BZQoJNDhc+ETQopn1YPAaWHWmCbestYxR3PBN5GicY8b2p8uKdj
         13KRkDafZIUEOhZnHE6Mesy7ncpPthKOoS7BW0yMcnR1zPiEEPWm0OdSP+DJL6JT6rFA
         VtBg==
X-Gm-Message-State: AOAM531x8H8kb+eZcGodXDFejgID86SzHOt5i1y1sn8YMU0AiZ7qzq8F
        vZ6QlwySmi/CzZGhHAsPRFujeY1xftg7gySAFPw=
X-Google-Smtp-Source: ABdhPJxApUf+VMltsFLv5WKSplt3FgcUSBsWlZsIDFE5m3SS1bDrjU/VKkKJnobnde7uO+uaitdyqtCx8wbtTy+fhIU=
X-Received: by 2002:a05:6122:732:: with SMTP id 50mr16654120vki.28.1639117977233;
 Thu, 09 Dec 2021 22:32:57 -0800 (PST)
MIME-Version: 1.0
References: <CGME20211210043017epcas1p38cc53389a50e33752e97618498b18f33@epcas1p3.samsung.com>
 <20211210043012.180588-1-hj514.kim@samsung.com>
In-Reply-To: <20211210043012.180588-1-hj514.kim@samsung.com>
From:   fengnan chang <fengnanchang@gmail.com>
Date:   Fri, 10 Dec 2021 14:32:45 +0800
Message-ID: <CALWNXx9CXeVLpj--YoMJpZbYdyvBgzz8HCn1jLOXvLF1di-4jQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress: fix potential deadlock of
 compress file
To:     Hyeong-Jun Kim <hj514.kim@samsung.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Great work=EF=BC=8Cit fix my problem.
