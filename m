Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E50A5313C4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237836AbiEWPW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237768AbiEWPWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:22:36 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F59F5DBF6;
        Mon, 23 May 2022 08:22:32 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id er5so19538969edb.12;
        Mon, 23 May 2022 08:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZWj/U+5aRM6YxLxUNdZYeVv9rpkLlT9yI/qdq2zgTLg=;
        b=FgNOhRxvF7n6Gipa6/PPNIPg5VDHbFny7dCcnzs2l0K68Xdti83DwDmi+AV97zx30Y
         vTgZVkBYg8WsTEG1CGoCXB+2DRds6QbHc8mazgniMatH/J4WG92yNrutUg4ETIyemwW/
         wy2NFKG1qJES2535Yb7NkV4i4R+OFK1NdB2ldF157uF/7vpFmrZdRFAVdX0C7YAciWbI
         q+yA/hXEcZYhcrk0T/jP0Lus9WBQD+R12YQvrLGjGJ5C8pdOw9ZOIE8UTF70mSCJF1G8
         mB8zuMeSFFncbSpQt+WxOJg6ZkD4KNdeWF5fjA0APGDuTHMcW4IMMs03B36/V1b/u3pD
         kUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZWj/U+5aRM6YxLxUNdZYeVv9rpkLlT9yI/qdq2zgTLg=;
        b=KcCFKSynKGkk2TY7kxj4Z6tLOmjqOku8c9Dns6pRfLSPRLWMlWjJZfO1+OYDAncTqF
         aouRad2ovv481SXbxKmuYCZp4stXNttmt2lCvTeAxjLa6DNOKUD8f62pj+vTHtdFu2lM
         c9E9ahRMa7ReUs/mxBlj/KcZsqh/JSwZ+WYRC30vc/N8wWLRIoiwXC06EvaloYH92ozh
         OQNCa/cdGMZhfdypWSN4TLycQRjChgXw6ig+9u/YBFwiqI52+HrB3TMV3YdgRt0najEQ
         wqMzWsZnlRSmoHOrplG7kacYcwu5mqQzWB5PBfvPBjPLCbOgST79cKl8qfOimyaP5ZNY
         o3Pg==
X-Gm-Message-State: AOAM532PjCGVTfX/WPjvD+28n/cVR4JMIjNAIHGfzADsYKhews/AHLtD
        xmJVx7ULzHCFdBnXFLZvE65ElQSeutPHASA1MwI=
X-Google-Smtp-Source: ABdhPJyURKoo/uqXFQDhgEaNf9F3kV8gtE7FemWSZi9W1OsMdpUpNmBouCeWIKlhY4Enw0z2cbJkIG9CdnTKGpNPhag=
X-Received: by 2002:aa7:d911:0:b0:42a:af69:e167 with SMTP id
 a17-20020aa7d911000000b0042aaf69e167mr23873693edr.54.1653319351194; Mon, 23
 May 2022 08:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220520181323.00002892@huawei.com> <1653103862-36104-1-git-send-email-lyz_cs@pku.edu.cn>
In-Reply-To: <1653103862-36104-1-git-send-email-lyz_cs@pku.edu.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 23 May 2022 17:21:54 +0200
Message-ID: <CAHp75Vc+fubwb0PGqVyDs5Np10ZW06F2REVKK=G26zOKT8gvFQ@mail.gmail.com>
Subject: Re: [PATCH] hv_netvsc: Fix potential dereference of NULL pointer
To:     Yongzhi Liu <lyz_cs@pku.edu.cn>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        "Ivan T. Ivanov" <iivanov@mm-sol.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        fuyq@stu.pku.edu.cn
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 6:27 AM Yongzhi Liu <lyz_cs@pku.edu.cn> wrote:
>
> The return value of netvsc_devinfo_get()
> needs to be checked to avoid use of NULL
> pointer in case of an allocation failure.

> Fixes: 0efeea5fb ("hv_netvsc: Add the support of hibernation")
>
> Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>

For the future independently of the subsystem or mailing list, the tag
block (above) mustn't have lank lines.

-- 
With Best Regards,
Andy Shevchenko
