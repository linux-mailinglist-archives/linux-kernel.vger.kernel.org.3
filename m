Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B4150716F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353636AbiDSPLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353594AbiDSPLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:11:50 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6E33A722
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:09:08 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 21so21727676edv.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Sw3xaIXVD9K4dmPddjbpkY8Pi6fTtwE00qd0a/j+D0=;
        b=CzHxjtaaWAFaLWoVi3b04VYyYmpovTWRCaHDe6W52KYKDqqL+Rj1gAzF4Ebfel0jeF
         V2l6RGwn7SFkFeeB2mbGO8+y8kRMRaYH/W9OGE+oUcCIH2fzVtmFdN/wDL3dmY8ZPB2O
         FF2F6dn/b707Yobl0zaJLZ0jcpgR2p9+1DqIJxxqMS5ZhXqbjPIbY0KjGcn8ic4Ps2RC
         ZZLG68goBSwO4yTUNmEGgsVJKXSzJojVVf9zHzstuwVaZ9LHg5wuQUbcYowdpAKZEkeK
         ph9w6QHEpbVVz34z8VnGrfQk13BTAv0JmRm7E7ugYMfoAwHsrXqJR/KdI5V9Z9dQjw7Q
         ox+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Sw3xaIXVD9K4dmPddjbpkY8Pi6fTtwE00qd0a/j+D0=;
        b=7xG9hG/uFvzpUpShcK6aBy9HJFC33Sy6Ue+sVRdtT/ozN//bCXrYEjTM9scmlCqwkI
         4wd3Mqwp3UGeMyf51LLrpngrUKPTChd246k0Ncv2pNat826QqvQavoOT3zHyvsu60Xn4
         PdtixM/GucZ/AqbuwC1JqQgFojP5aOcrHySv3Y/KGxi76Jtfh39toxMK4LWrc5xzyKWV
         OvX6lM+zNHcd635pXygoXkV27PUMdQuX9S1SQe+quOILTdZflw7MYfPsb8KuDXCbRLig
         1KaYFUZzz5qjSLKaT/0Aax5C8Mwkbh0nOpczcMAdhmW64gLEhWInbuVCDcMvorhc/2RJ
         M0vg==
X-Gm-Message-State: AOAM5336ywqghhwmvzQBCBz4qdkcLgiefBZQF4KA7aAa6pJoKDG40nfK
        1rVugZb4ltY8LADPffItvoA=
X-Google-Smtp-Source: ABdhPJxlocry7ehXB6chhIw0Ntoy5MXjSbBbl8uD0jlOHJ39N7FW2jt65XGYn8jbHUb6OIiz3zfNdg==
X-Received: by 2002:a50:c316:0:b0:41d:6fdb:f3db with SMTP id a22-20020a50c316000000b0041d6fdbf3dbmr18263003edb.315.1650380946445;
        Tue, 19 Apr 2022 08:09:06 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id g24-20020a1709063b1800b006e8cf786ee8sm5574032ejf.21.2022.04.19.08.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 08:09:05 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v2] mm/highmem: Fix kernel-doc warnings in highmem*.h
Date:   Tue, 19 Apr 2022 17:09:04 +0200
Message-ID: <6767543.18pcnM708K@leap>
In-Reply-To: <Yl7MpmsXtzOfztHu@iweiny-desk3>
References: <20220418175638.30018-1-fmdefrancesco@gmail.com> <4058661.1IzOArtZ34@leap> <Yl7MpmsXtzOfztHu@iweiny-desk3>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On marted=C3=AC 19 aprile 2022 16:52:22 CEST Ira Weiny wrote:
> On Tue, Apr 19, 2022 at 03:25:16PM +0200, Fabio M. De Francesco wrote:
>
> [snip]
>=20
> I think you should gather all these patches together into a series and=20
submit.
> If I am following correctly there are at least 4 patches now?  But I'm=20
unsure
> of which ones are stand alone.
>=20
> It would be easier to see what changes are being made along the way as=20
well as
> the final result of the fixes.
>=20
> Ira

Yes, this is perfectly reasonable. There are only three patches (this patch=
=20
plus two more in a series). Since they are all related in some way, it is=20
best to bring them together into one series which I will rework taking into=
=20
account both yours and Matthew's suggestions.

Thanks,

=46abio


