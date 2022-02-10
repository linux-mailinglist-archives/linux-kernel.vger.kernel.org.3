Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633904B141B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245166AbiBJRXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:23:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245154AbiBJRXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:23:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0765EC2C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644513784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ynVF8sk+blUB4Pf3mmCXTcuxk0sjOGV7wHhHJzKIAWU=;
        b=bA09OraWQlbTbUT6kLkCZgILK6omYpw2Aj4PnSFAxfn019d4Oa1F7RkWP+nDmaAG50EElP
        uYHjDzzjEbva9uAPOvoJp4j8GYrKXC9JXBvEAq1mIPpxS84GmNU7UiE6Q3Uj5d+Kah6MVq
        2ppzFPZXd1kegMynU07cfTvaIX3RPTU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-35-UmdPqNjOM2OLGUuGDExJlw-1; Thu, 10 Feb 2022 12:23:02 -0500
X-MC-Unique: UmdPqNjOM2OLGUuGDExJlw-1
Received: by mail-lj1-f200.google.com with SMTP id u18-20020a2ea172000000b002393f377a13so2844408ljl.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:23:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ynVF8sk+blUB4Pf3mmCXTcuxk0sjOGV7wHhHJzKIAWU=;
        b=sDP/LHylDVS6toESj6J5LYp3LBqZ25QvHbqd6x1VLmvqIRkisjbh1aLlcqJMYIVatu
         5HgFI8C244NW4BUyfR2whQbaVR81jSwAR91Klf43Yfg9DBZ78lWM1D94UOQiQfaPSlNf
         F+k6KqcJBAerrR1CGp8rSYEbRx1w/wtbZeRqzH0odqvROl3AfrA/IrcONfWb2hErZH96
         0aPmTr+ZmC4h0i9Jbhl2PhDpAOaeHQ0j+Ym78w5IN6ZvrsTNDBh99x7PrRSxrUJoBJCp
         arUqbreehrdb+jYgUHYEJhNueKKbfWIkr2zyQB3llPZD2sATfD4t1FtpbbJz9+JG0r5p
         1t/w==
X-Gm-Message-State: AOAM531sZBd/sqSmq7Lx5UC3wNdWgN21j+uHOn8Ktrx4hpLtQxacL23K
        d9h5wkQ6TwkCVL75EtzAE9uX89N28cDSdgRRaR/P1SUW1R2b1DLZ8SzgVizB37U+ppmtsnfMkT9
        Yh2dQSXWrAmYfaYyHSMyaIpesvh0qwk8Dk4HZAk0=
X-Received: by 2002:ac2:4f03:: with SMTP id k3mr5947154lfr.163.1644513781183;
        Thu, 10 Feb 2022 09:23:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzPurdZCWhcjjdeAf5612b8cWLNqPESaOHdxPEE20Dxz4GIR53J+a3BP/HcMeMBWYo4B10uWd7TQRzczUyBK0U=
X-Received: by 2002:ac2:4f03:: with SMTP id k3mr5947139lfr.163.1644513781032;
 Thu, 10 Feb 2022 09:23:01 -0800 (PST)
MIME-Version: 1.0
References: <20220209170358.3266629-1-atomlin@redhat.com> <20220209170358.3266629-2-atomlin@redhat.com>
 <a22eb1b0-3fb5-a70e-cf6f-022571538efb@csgroup.eu> <CANfR36jh3yg9nqXkpCUWPeHV+sSD6yne9j1=uA5vyUpYOC8t9g@mail.gmail.com>
 <926e5c35d50ec5f6d7e789831be96744ca8d6423.camel@perches.com>
In-Reply-To: <926e5c35d50ec5f6d7e789831be96744ca8d6423.camel@perches.com>
From:   Aaron Tomlin <atomlin@redhat.com>
Date:   Thu, 10 Feb 2022 17:22:50 +0000
Message-ID: <CANfR36gxWAPHN+ruFifaJ+j2Nppw+Xocd4iyWYzw0LFD=WxUTg@mail.gmail.com>
Subject: Re: [PATCH v5 01/13] module: Move all into module/
To:     Joe Perches <joe@perches.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "cl@linux.com" <cl@linux.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "ghalat@redhat.com" <ghalat@redhat.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "void@manifault.com" <void@manifault.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-02-10 09:02 -0800, Joe Perches wrote:
> On Thu, 2022-02-10 at 14:45 +0000, Aaron Tomlin wrote:
> Better would be:
>
> F:    kernel/module/
>
> in case it ever gets subdirectories too.

Agreed.

-- 
Aaron Tomlin

