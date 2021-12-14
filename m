Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C90474210
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbhLNMHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbhLNMHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:07:42 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58060C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 04:07:42 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id d10so45791313ybn.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 04:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iB6ivIESjms0uhDlQqGJKxc8+x2PVejNM8br4Y2QBCQ=;
        b=GcNMIlG4xluex181zEFsAjlb3PJBSn/USEJqafgNRGh6Vqxv0yTQrVqQrernlTWUE/
         58LPm44ocdZ3tOkLeJ5TSKBnwYVNnyLJggTMNYito9Uh7vtrdOFEd5Mg4slINyPLr3MT
         B2y6w0S0ZEzrFAs5Yg0OAkUUVGaFYjZFheOaihH/JsxRNuohdLgJTAkGp2o2I5sYOpoX
         tXcQ4zxOfAs+nT2/DebXC3ouy90W5bAnr+0zWZqbopjbc/3o7hlv0tLlpQDxpKexJHyb
         271KlKQjxp8aiTp4BrXKzJrSDYaGSJNgJfmFRTJ2EJti86ZhTL4jKKsWZKmGpyNfFmnc
         Ouew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iB6ivIESjms0uhDlQqGJKxc8+x2PVejNM8br4Y2QBCQ=;
        b=JhBlktMWVyZ/NqWqifyii8NK3zjAcxuDtnCNxAahDKBhU1myLOQ4oNbrNw81l0PIZE
         FdQO0IlJAFOEr8sNbJQ+3YqIvNXNCkESPGseQniQaOpWpAvkxXYLctfYn4tPeUfiv1vl
         ykha5wGZTIjvB6tX4srtjlIMca3qggCs/BsoOSYbL68RS6apPub1pZtq7Rj7wUV+s3Vb
         Q9RixYL/Ynl0XUCLSZDRrQHN3wCJu9hHPKSF6J3yaptZ5dFSSYZwIqWscXyp36WUXR1L
         muOECyfOZRth8CQKqNuR04PqIefI/PmiuIVanslKlHTnlc8zKzDg7+vIvFD1YYcGSxQ0
         fepQ==
X-Gm-Message-State: AOAM531h3dtobRY8fSYpgUQcakL/TGOF8ZFnfKkQH1OEzl9Ik+G1Vs8v
        MLwx0MsHHkXn3m1I7pPgK1DNHO/ZaZaX0OTvfHa31kCbbZE++A==
X-Google-Smtp-Source: ABdhPJyvHf6LA17wuZ7lECv6wva8I+YNEGrvkKxiOJtI9pZG5e97AyLirlliJEdLIO6am7TGmE2WKw8GNNbbLb69N+Q=
X-Received: by 2002:a05:6902:52b:: with SMTP id y11mr5225536ybs.199.1639483661606;
 Tue, 14 Dec 2021 04:07:41 -0800 (PST)
MIME-Version: 1.0
References: <20211214114447.439632-1-deng.changcheng@zte.com.cn>
In-Reply-To: <20211214114447.439632-1-deng.changcheng@zte.com.cn>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 14 Dec 2021 20:07:05 +0800
Message-ID: <CAMZfGtVmQWsyNTv=_dykzOpRwNDkZtKrGDOJ13MqypucCGrimw@mail.gmail.com>
Subject: Re: [PATCH] pktgen: use min() to make code cleaner
To:     cgel.zte@gmail.com
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, richardsonnick@google.com,
        Eric Dumazet <edumazet@google.com>, zhudi21@huawei.com,
        yejune.deng@gmail.com, Networking <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 7:44 PM <cgel.zte@gmail.com> wrote:
>
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
>
> Use min() in order to make code cleaner. Issue found by coccinelle.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
