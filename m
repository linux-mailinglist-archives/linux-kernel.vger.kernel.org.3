Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1955D4A76DF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244998AbiBBRat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:30:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343570AbiBBRaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643823046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ARK8JuI2/Z9yWWBIIvnvP+Vpd7t0FPVLNXUAPYXWbuU=;
        b=hFeVprcL/10GhwCpsDvDePSHjS98W7gkt7GiE4sXiD6QRtVcvjB59aubVfC4F5NrkITOzy
        V6e2W+9YHU3J/TSddKlD/h9LH6rsgXmCsTm6ILeF7hVbZpXK4haVfTMlhpMzTnKRGHtlb6
        j7haFdjDNMlrlyK9XcFNOXbFHcgdhME=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-x0j8HlfxMw-pwVcyrAE2FQ-1; Wed, 02 Feb 2022 12:30:45 -0500
X-MC-Unique: x0j8HlfxMw-pwVcyrAE2FQ-1
Received: by mail-ot1-f70.google.com with SMTP id q4-20020a056830018400b0059eb82177ceso69132ota.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 09:30:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ARK8JuI2/Z9yWWBIIvnvP+Vpd7t0FPVLNXUAPYXWbuU=;
        b=XWOqxNM64feUwyX3GT6BHA8u7AmGaMi8H9PSaLUY3VTaGSX3areOG3JntdPdY8Saqo
         FKznGQ/0nY2q0gdgzI216c8GPR9uQu1fzScR5MH1OYCvoKaHJdJLqj4TJH9Af8vhqG8J
         0r6niFktlsaAmfmWDi8M0dWjiB43qg54m422sV7+wTBToyAkw3YCsTJZ/FSD26bzzlai
         eYJDCfr+CNl20A8Z2m5xsQWsQFeb+XEKE7b8DNmWJeUTbQBsezvAqAOs7Hf85hYSgEnM
         X5pIXVvbSc+kwOZASczNPwilVqMkjtYmXcBHYxp/gHkFlIa3vKjH5H71FesSbSIhWAJw
         /dqA==
X-Gm-Message-State: AOAM5311vu+ffqP6nlIJJWQQ+nKwlmRLb8S6CsH5Q7fS0Io3F/hZP+Gf
        SKuSg7WiS/rCZ/+soT6q05xIp6w+BqNVmsKpYuuhmRTU1W5IVGXEmvGJ8gMefB2Y7y1J639mmcP
        Bg9KJWO+4B5JRxT2taD3TUyzu
X-Received: by 2002:a9d:226b:: with SMTP id o98mr17394664ota.125.1643823043029;
        Wed, 02 Feb 2022 09:30:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxa1ulr875j7x7Dy544lRgUzL/mvKbrd24FxjT+1UwW5AH4hYjxYo2X7ptav2DX65k3R2wHSA==
X-Received: by 2002:a9d:226b:: with SMTP id o98mr17394656ota.125.1643823042832;
        Wed, 02 Feb 2022 09:30:42 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id 6sm19835290oig.29.2022.02.02.09.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 09:30:42 -0800 (PST)
Date:   Wed, 2 Feb 2022 10:30:41 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "mgurtovoy@nvidia.com" <mgurtovoy@nvidia.com>,
        Linuxarm <linuxarm@huawei.com>,
        liulongfang <liulongfang@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        yuzenghui <yuzenghui@huawei.com>,
        "Jonathan Cameron" <jonathan.cameron@huawei.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>
Subject: Re: [RFC v2 0/4] vfio/hisilicon: add acc live migration driver
Message-ID: <20220202103041.2b404d13.alex.williamson@redhat.com>
In-Reply-To: <a29ae3ea51344e18b9659424772a4b42@huawei.com>
References: <20210702095849.1610-1-shameerali.kolothum.thodi@huawei.com>
        <20220202131448.GA2538420@nvidia.com>
        <a29ae3ea51344e18b9659424772a4b42@huawei.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2022 14:34:52 +0000
Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:

> > -----Original Message-----
> > From: Jason Gunthorpe [mailto:jgg@nvidia.com]
> 
> > 
> >    I see pf_qm_state_pre_save() but didn't understand why it wanted to
> >    send the first 32 bytes in the PRECOPY mode? It is fine, but it
> >    will add some complexity to continue to do this.  
> 
> That was mainly to do a quick verification between src and dst compatibility
> before we start saving the state. I think probably we can delay that check
> for later.

In the v1 migration scheme, this was considered good practice.  It
shouldn't be limited to PRECOPY, as there's no requirement to use
PRECOPY, but the earlier in the migration process that we can trigger a
device or data stream compatibility fault, the better.  TBH, even in
the case where a device doesn't support live dirty tracking for a
PRECOPY phase, using it for compatibility testing continues to seem
like good practice.  Thanks,

Alex

