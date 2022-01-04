Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4482E484AB3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 23:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbiADW0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 17:26:09 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:39592 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbiADW0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 17:26:07 -0500
Received: by mail-oi1-f172.google.com with SMTP id x10so56652903oix.6;
        Tue, 04 Jan 2022 14:26:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JnOadLKUCLxTeQKKTc3saQOhwTodIVbhHkqdpkUyL30=;
        b=WFYzZklu7ExpTwNpAloUxXp5mKb1feZSZPj1q4u3uuJGeMK9gsGAnMt6ITs56VOUlW
         saDzVyarRYzoO8PnQ//4fbdkJ3gEw2se3vDBTlg8yiGE4dd9lAVdaRuLdIrLh7hGHl+l
         cd9h9eDQJ7P+lLIz3AFLy53HnEY8Mma2yE20MxfY7xm5Gu5Rz1xCBd23QofbBRipVL0j
         h1nq8HHtFw57vLv9UwZYNmOZIzUDnLHTt5sunAmVaOZSQ8uNv80en5OGozxWrokrCYyZ
         cOPt/2uY6NW2hFr4g71FQzZN4jsauSM1CX10Zu+z0F3RsvDqXcJAHRKikHPi4/u+1DGE
         Bqsg==
X-Gm-Message-State: AOAM530QuBof6LR5xclmSiuhFuuSODYCV9QMi54uu1X2n6pTu0shnD2p
        IZbZ2fOhCdNxn4AI5w+AKA==
X-Google-Smtp-Source: ABdhPJxfmZnICaR0AFOGdWsnbelA0aJZsRc1Kgnndk6DcVeWC0CYljTp86RqQf43B5yP69zwu5wQGg==
X-Received: by 2002:a05:6808:10d1:: with SMTP id s17mr395747ois.26.1641335166437;
        Tue, 04 Jan 2022 14:26:06 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c139sm7472227oob.31.2022.01.04.14.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 14:26:05 -0800 (PST)
Received: (nullmailer pid 1557364 invoked by uid 1000);
        Tue, 04 Jan 2022 22:26:04 -0000
Date:   Tue, 4 Jan 2022 16:26:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     David Heidelberg <david@ixit.cz>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <mkrishn@codeaurora.org>,
        ~okias/devicetree@lists.sr.ht, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Discussion: dt-bindings: display: msm:
 dsi-controller-main: fix the binding
Message-ID: <YdTJfMXYXjavr8cZ@robh.at.kernel.org>
References: <20211225205352.76827-1-david@ixit.cz>
 <CAA8EJpoVuNDS2uD2g8W_40XVO2jS=6GtRQFxAnyPpd_QuHim8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpoVuNDS2uD2g8W_40XVO2jS=6GtRQFxAnyPpd_QuHim8g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2021 at 02:34:08AM +0300, Dmitry Baryshkov wrote:
> Hi,
> 
> On Sat, 25 Dec 2021 at 23:54, David Heidelberg <david@ixit.cz> wrote:
> >
> > This binding is not much validating the old DSI v2.
> >
> > Currently we don't differentiate old v2 from new versions,
> > so we need to figure out how to validate them.
> >
> > I propose specific compatible depending on mdss version, but I would be
> > glad, if someone with deeper knowledge proposed the names.
> >
> > I'm willing to implement it then and back from autodetection.
> 
> I'd suggest to use hardware-specific compatible for apq8064 (and maybe
> other v2 hosts if somebody adds support). For example
> "qcom,apq8064-dsi-ctrl" or "qcom,dsi-ctrl-apq8064" (no strong
> preference here).

The former.

> For 6G hosts it will probably make sense to use IP versions instead
> ("qcom-dsi-ctrl-6g-v2.4.1").

Humm, we went down the path of version numbers for QCom blocks, but the 
result was not much reuse of same version on more than 2-3 parts if 
that. So stick with SoCs for naming unless there's a strong case that 
version numbers to SoC parts is 1 to many.

Rob
