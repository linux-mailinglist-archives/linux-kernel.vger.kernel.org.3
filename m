Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9C647F89C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 20:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhLZTuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 14:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhLZTuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 14:50:39 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27276C06173E;
        Sun, 26 Dec 2021 11:50:39 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id i14so16001436ioj.12;
        Sun, 26 Dec 2021 11:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1iV08djqYBf0KDJhh8GS9yfRSldLgz9adD2OEzLo4wM=;
        b=OSHwkQXdx79Y0k/mateEF3KT5DcTf58+BDbKr3IoEkm3VPlqUhKiDRp60HdRfXkDKy
         rYevhlrmUSNd87AMmRwJfsPH1ct86OaWr51z1F/BAZmqxcnsbVvBEtMZaJhEe6UE/zli
         5Sp1q4p9FTzW7cdh1pjY4r4/rnbTylOtRMkN3EAjmhDGZnPfdGdXtPyBVOxgBswb+45b
         thMKnqdiPHzkyrsXMyhblf2gShtf7UyM6NGBTTxJjIdxmFN9o+pcLNJKXiEjPFBARArD
         YLLPPaSk494IF2kdweivA4lxWWF5Dr7nhI+RnoKuJAne8jPXOAMuLOXk68fUceJgIJFI
         IGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1iV08djqYBf0KDJhh8GS9yfRSldLgz9adD2OEzLo4wM=;
        b=grA3YIHYFfHeZ0Ok03AKHTqbtNvdFTgSe0+3USqD2UdEmrFxR1lV42gtoZc56IjEM0
         c7plb3ja/6DTX1dub5NNGld/1+NSzSopQN5sHFwlGSaZLIIPgnSm6rwN0NkZENDBAzZN
         U5YG4v1DA+va0CZpva+jEwAFbYLZhq4t5/m8D/xdybhjmDI5B3oY3Q6Grp3vMrXP9vO0
         sI+WUwpEyXc/5j2+7bZ1q7Rnk0opzK/+cqgjz1xn5h6Gx7AFEEkE7goxIzvS0BzK0Nce
         14PCbvzap4dsjczWhxgd8ezpBVDX9ufdL+C8LWqonTVjF6lcC2/OoPLGKpEtOM+NnztA
         7Vlg==
X-Gm-Message-State: AOAM531Uy7Dk33+HsJrWatLGujCRbrLWWjepqjHsbwJ2MZNfJF+YMi2i
        yQUhsDYmRRdny1sptDx/2jIr402kncq2aSNcuNRzmm+i
X-Google-Smtp-Source: ABdhPJzhBbBJL4RjNRvtp7AVX5rd4edc2B91QwulI1HelFNk4pOHgHRRLRJPAuhqm1lNW4ZJqESciKkROIYyof8iCtM=
X-Received: by 2002:a5d:8999:: with SMTP id m25mr6042423iol.185.1640548238497;
 Sun, 26 Dec 2021 11:50:38 -0800 (PST)
MIME-Version: 1.0
References: <20211122050509.5979-1-quic_hyiwei@quicinc.com> <20211122050509.5979-2-quic_hyiwei@quicinc.com>
In-Reply-To: <20211122050509.5979-2-quic_hyiwei@quicinc.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Sun, 26 Dec 2021 13:50:27 -0600
Message-ID: <CABb+yY3jnUcwuaF2xeTTMYZ5-rRiUPVzkZZgS46Y+H00S5BCaQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] mailbox: qcom-ipcc: Dynamic alloc for channel arrangement
To:     Huang Yiwei <quic_hyiwei@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        quic_psodagud@quicinc.com, quic_tsoni@quicinc.com,
        quic_aiquny@quicinc.com, quic_eberman@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2021 at 11:06 PM Huang Yiwei <quic_hyiwei@quicinc.com> wrote:
>
> Dynamic alloc for channel arrangement instead of static alloced
> array, it is more flexible and can reduce memory usage.
>
Since this is a popular platform, can we arrange for some Tested-by
and Reviewed-by ?

-Jassi
